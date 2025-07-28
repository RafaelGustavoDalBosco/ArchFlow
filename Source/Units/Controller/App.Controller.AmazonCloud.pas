unit App.Controller.AmazonCloud;

interface

uses
  System.SysUtils, Data.Cloud.AmazonAPI, Data.Cloud.CloudAPI, System.Classes;

type

   TAmazonS3Controller = class
   private
      FS3Region: TAmazonRegion;
      FS3: TAmazonStorageService;
      FAmazonConnectionInfo: TAmazonConnectionInfo;
      FDeleteCurrentFile: Boolean;
      procedure SetAmazonConnectionInfo(const Value: TAmazonConnectionInfo);
      procedure SetS3(const Value: TAmazonStorageService);
      procedure SetS3Region(const Value: TAmazonRegion);
      procedure SetDeleteCurrentFile(const Value: Boolean);
   protected
      property AmazonConnectionInfo: TAmazonConnectionInfo read FAmazonConnectionInfo write SetAmazonConnectionInfo;
      property S3: TAmazonStorageService read FS3 write SetS3;
      property S3Region: TAmazonRegion read FS3Region write SetS3Region;
      property DeleteCurrentFile: Boolean read FDeleteCurrentFile write SetDeleteCurrentFile;
   strict protected
      /// <summary>
      ///  Envia o conteúdo e arquivo para a AWS
      ///  </summary>
      /// <param name="ABucketName">
      ///    Nome do Bucket na AWS
      /// </param>
      // <param name="AFileName">
      ///    Nome do arquivo que será obtido
      /// </param>
      /// <param name="AStream">
      ///    Objeto TStream de manipulação de dados
      /// </param>
      function SendFileStream(const ABucket, AFileName: UnicodeString; AStream: TStream): Boolean;
   public
      /// <summary>
      ///  Tenta enviar um arquivo a AWS
      ///  </summary>
      // <param name="AFileName">
      ///    Nome do arquivo que será obtido
      /// </param>
      /// <param name="AContent">
      ///    Conteudo do arquivo que será enviado
      /// </param>
      /// <param name="ABucketName">
      ///    Nome do Bucket na AWS
      /// </param>
      function TrySendFile(const AFileName, AContent, ABucketName: UnicodeString): Boolean;

      /// <summary>
      ///  Tenta obter os dados de um arquivo
      ///  </summary>
      // <param name="AFileName">
      ///    Nome do arquivo que será obtido
      /// </param>
      /// <param name="ABucketName">
      ///    Nome do Bucket na AWS
      /// </param>
      function TryGetFileDataToString(const AFileName, ABucketName: UnicodeString): UnicodeString;

      /// <summary>
      ///    Tenta baixar um arquivo do bucket
      /// </summary>
      /// <param name="AFileName">
      ///    Nome do arquivo que será obtido
      /// </param>
      /// <param name="ABucketName">
      ///    Nome do Bucket na AWS
      /// </param>
      /// <param name="ADestinationPath">
      ///    Caminho de Destino do arquivo
      /// </param>
      procedure TryGetFile(const AFileName, ABucketName, ADestinationPath: UnicodeString);

      /// <param name="ADeleteCurrentFile">
      ///    Caso esteja como True, vai excluir o item atual no bucket da AWS
      /// </param>
      constructor Create(const ADeleteCurrentFile: Boolean = False); overload;
      destructor Destroy; override;
   end;

implementation

{ TAmazonS3Controller }

uses App.Common.Utils;

constructor TAmazonS3Controller.Create(const ADeleteCurrentFile: Boolean = False);
begin
   SetDeleteCurrentFile(ADeleteCurrentFile);

   AmazonConnectionInfo := TAmazonConnectionInfo.Create(nil);
   AmazonConnectionInfo.AccountName := 'AKIAYM7POEM76QBFCPSW';
   AmazonConnectionInfo.AccountKey := 'GWudT+onC8NmNmby2vudrP1Pm/6IilYXhyJ2xOUX';
   AmazonConnectionInfo.Region := amzrSAEast1;
   AmazonConnectionInfo.UseDefaultEndpoints := False;
   AmazonConnectionInfo.AutoDetectBucketRegion := True;
   S3 := TAmazonStorageService.Create(AmazonConnectionInfo);
   inherited Create;
end;

destructor TAmazonS3Controller.Destroy;
begin
   FreeAndNil(AmazonConnectionInfo);
   FreeAndNil(S3);
   inherited Destroy;
end;

procedure TAmazonS3Controller.TryGetFile(const AFileName, ABucketName, ADestinationPath: UnicodeString);
var
   LStream: TMemoryStream;
   LStringStream: TStringStream;
   LResponse: TCloudResponseInfo;
begin
   LStream := TMemoryStream.Create;
   LResponse := TCloudResponseInfo.Create;
   try
      if S3.GetObject(ABucketName, AFileName, LStream, LResponse, AmazonConnectionInfo.Region) then
      begin
         LStringStream := TStringStream.Create;
         try
            LStringStream.CopyFrom(LStream);

            LStream.SaveToFile(ADestinationPath);
         finally
            FreeAndNil(LStringStream);
         end;
      end;
   finally
      FreeAndNil(LStream);
      FreeAndNil(LResponse);
   end;
end;

function TAmazonS3Controller.TryGetFileDataToString(const AFileName, ABucketName: UnicodeString): UnicodeString;
var
   LStream: TMemoryStream;
   LStringStream: TStringStream;
   LResponse: TCloudResponseInfo;
begin
   LStream := TMemoryStream.Create;
   LResponse := TCloudResponseInfo.Create;
   try
      if S3.GetObject(ABucketName, AFileName, LStream, LResponse, AmazonConnectionInfo.Region) then
      begin
         LStringStream := TStringStream.Create;
         try
            LStringStream.CopyFrom(LStream);
            Result := LStringStream.DataString;
         finally
            FreeAndNil(LStringStream);
         end;
      end
      else
         Result := EmptyStr;
   finally
      FreeAndNil(LStream);
      FreeAndNil(LResponse);
   end;
end;

function TAmazonS3Controller.TrySendFile(const AFileName, AContent, ABucketName: UnicodeString): Boolean;
var
   LStream: TMemoryStream;
   LStringList: TStringList;
begin
   if (AContent.IsEmpty) then
      Exit(False);

   LStringList := TStringList.Create;
   LStream := TMemoryStream.Create;
   try
      LStringList.Append(AContent);
      LStringList.SaveToStream(LStream, TEncoding.UTF8);

      // -> Bug no objeto TMemoryStream
      // -> Se não informar a posição zero, ele não percorre os bytes do arquivo, e fica nil...
      LStream.Position := 0;

      Result := SendFileStream(ABucketName, AFileName, LStream);
   finally
      FreeAndNil(LStream);
      FreeAndNil(LStringList);
   end;
end;

function TAmazonS3Controller.SendFileStream(const ABucket, AFileName: UnicodeString; AStream: TStream): Boolean;
var
   LContents: TBytes;
   LReader: TBinaryReader;
   LHeader: TStringList;
   LResponse: TCloudResponseInfo;
begin
   LReader := TBinaryReader.Create(AStream, TEncoding.UTF8);
   try
      LContents := LReader.ReadBytes(LReader.BaseStream.Size);
      LHeader := TStringList.Create;
      LResponse := TCloudResponseInfo.Create;
      try
         LHeader.Add('Content-Type=text/html; charset=utf-8');

         if (DeleteCurrentFile) then
            S3.DeleteObject(ABucket, AFileName, LResponse, S3Region);

         Result := S3.UploadObject(ABucket, AFileName, LContents, False, nil, LHeader, amzbaNotSpecified, LResponse);

         if (LResponse.StatusCode <> 200) then
            LogUtils.Write('Response AWS S3', LResponse.StatusMessage);
      finally
         FreeAndNil(LResponse);
         FreeAndNil(LReader);
         FreeAndNil(LHeader);
      end;
   except
      on E: Exception do
      begin
         LogUtils.Write('Exception [SendFileStream]', E.Message);
         Result := False;
      end;
   end;
end;

procedure TAmazonS3Controller.SetAmazonConnectionInfo(const Value: TAmazonConnectionInfo);
begin
   FAmazonConnectionInfo := Value;
end;

procedure TAmazonS3Controller.SetDeleteCurrentFile(const Value: Boolean);
begin
  FDeleteCurrentFile := Value;
end;

procedure TAmazonS3Controller.SetS3(const Value: TAmazonStorageService);
begin
   FS3 := Value;
end;

procedure TAmazonS3Controller.SetS3Region(const Value: TAmazonRegion);
begin
   FS3Region := Value;
end;

end.

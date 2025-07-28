unit App.Common.Utils;

interface

uses

{$REGION '| SYSTEM |'}
   System.SysUtils,
   System.Classes,
   System.IniFiles,
   System.Variants,
   System.MaskUtils,
   System.DateUtils,
   System.Win.ComObj,
   System.UITypes,
   System.Math,
   System.Zip,
   System.JSON.Types,
   System.IOUtils,
   System.JSON,
   System.JSON.Utils,
   System.JSON.Readers,
   System.JSON.Writers,
   System.JSON.Builders,
   System.JSON.Serializers,
   System.Generics.Collections,
   System.Generics.Defaults,
   System.Threading,
   System.Notification,
{$ENDREGION}

{$REGION '| WINDOWS |'}
   Winapi.Windows,
   Winapi.ShellAPI,
   Winapi.Messages,
{$ENDREGION}

{$REGION '| RTL |}
   IdBaseComponent,
   IdComponent,
   IdIPWatch,
   IdHTTP,
   IdSSL,
   IdSSLOpenSSL,
   IdSSLOpenSSLHeaders,
   IdTCPConnection,
   IdTCPClient,
{$ENDREGION}

{$REGION '| VCL |'}
   Vcl.Forms,
   Vcl.Controls,
   Vcl.Dialogs,
   Vcl.Menus,
   Vcl.StdCtrls,
   Vcl.ExtCtrls,
   Vcl.Graphics,
{$ENDREGION}

{$REGION '| DATA |'}
   Data.DB,
   DataSnap.DBClient,
   REST.Client,
   REST.Types,
{$ENDREGION}

{$REGION '| FIREDAC |'}
   FireDAC.Stan.Intf,
   FireDAC.Stan.Option,
   FireDAC.Stan.Param,
   FireDAC.Stan.Error,
   FireDAC.DatS,
   FireDAC.Phys.Intf,
   FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet,
   FireDAC.Comp.Client,
{$ENDREGION}

{$REGION '| XML |'}
   Xml.XMLDoc,
   Xml.XMLIntf,
{$ENDREGION}

{$REGION '| DEVEXPRESS |'}
   dxUIAdorners,
   dxStatusBar,
   cxTextEdit,
   cxMaskEdit,
   cxDropDownEdit,
   cxLabel,
   cxCurrencyEdit,
   cxClasses,
   cxGridCustomView,
   cxGridCustomTableView,
   cxGridTableView,
   cxGridDBTableView,
   cxGridDBLayoutView,
   cxGridCustomLayoutView,
   cxGridCardView,
   cxGridDBCardView,
   cxGridBandedTableView,
   cxGridDBBandedTableView,
   cxGroupBox,
   cxGridLevel,
   cxCalendar,
   cxPC,
   dxPanel,
   cxImage,
   cxButtons,
   cxControls,
   cxContainer,
   cxEdit,
   cxRadioGroup,
   dxToggleSwitch,
   dxGDIPlusClasses,
   cxMemo,
   cxHint,
   cxRichEdit,
   cxStyles,
   cxGrid,
   cxDBData,
   cxFilter,
   cxGraphics,
   cxCustomData,
   cxGridExportLink,
   dxLayoutControl,
   dxLayoutContainer, App.System.ORM.Persistent;
{$ENDREGION}

type

   TVersionUtils = class
   public
      /// <summary>
      ///    Decode [Version]
      /// </summary>
      /// <param name="AMajor">
      ///    Out: Major Version
      /// </param>
      /// <param name="AMinor">
      ///    Out: Minor Version
      /// </param>
      /// <param name="ARelease">
      ///    Out: Release Version
      /// </param>
      /// <param name="ABuild">
      ///    Out: Build Version
      /// </param>
      /// <param name="AVersion">
      ///    Versão em String
      /// </param>
      class procedure Decode(out AMajor, AMinor, ARelease, ABuild: Word; const AVersion: Unicodestring); static;

      /// <summary>
      ///   Retorna a versão atual da aplicação, a que está no .DPROJ
      /// </summary>
      /// <returns>
      ///    Ex.: 1.0.0.1 [Major, Minor, Release, Build]
      /// </returns>
      class function GetApplication_Version: UnicodeString; static;
   end;

   TObjectUtils = class
   public
      /// <summary>
      ///   Caso o objeto esteja NIL, será disparada uma exceção
      /// </summary>
      /// <param name="AInstanceOf">
      ///    Objeto a ser checado
      /// </param>
      class procedure CheckAndRaiseNilObject(const AInstanceOf: TObject); static;

      /// <summary>
      ///    Caso o objeto esteja assinado, libera da memória
      /// </summary>
      /// <param name="AInstanceOf">
      ///    Objeto a ser liberado da memória
      /// </param>
      /// <remarks>
      ///    É usado o comando .DisposeOf da classe TObject para liberação da memória
      /// </remarks>
      class procedure Release_(const AInstanceOf: TObject); static;
   end;

   TFileUtils = class
   public
      /// <summary>
      ///    Checa se determinado diretório existe, caso contrário, cria
      /// </summary>
      /// <param name="AFolderPath">
      ///    Caminho do diretório que será checado se existe
      /// </param>
      class procedure CheckAndCreate_Folder(const AFolderPath: UnicodeString); static;

      /// <summary>
      ///    Checa se determinado arquivo existe no caminho específicado
      /// </summary>
      /// <param name="AFilePath">
      ///    Caminho do arquivo
      /// </param>
      class function Exists(const AFilePath: UnicodeString): Boolean; static;
   end;

   TLogUtils = class
   public
      /// <summary>
      ///    Escreve uma nova linha no arquivo de LOG
      /// </summary>
      /// <param name="ATitle">
      ///    Título do log
      /// </param>
      /// <param name="AText">
      ///    Texto principal do log
      /// </param>
      /// <param name="AAddInfo">
      ///    Informações adicionais [Não obrigatórias]
      /// </param>
      class procedure Write(const ATitle, AText: UnicodeString; const AAddInfo: UnicodeString = ''); static;
   end;

   TPathUtils = class
   public
      /// <summary>
      ///    Obtém o caminho da aplicação com \ no final
      /// </summary>
      class function GetApplicationPath: UnicodeString; static;

      /// <summary>
      ///    Controi o caminho do arquivo de log
      /// </summary>
      class function ComputeFileLogPath: UnicodeString; static;

      /// <summary>
      ///    Obtém o caminho do arquivo de settings
      /// </summary>
      class function ComputeFileSettingsPath: UnicodeString; static;
   end;

   TStringUtils = class
   public
      /// <summary>
      ///    String.Crypt
      /// </summary>
      /// <param name="AValue">
      ///    String a ser encriptada
      /// </param>
      /// <param name="AKey">
      ///    Define o Char que será usado para encriptação
      /// </param>
      class function EnCryptString(const AValue, AKey: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    String.Decrypt
      /// </summary>
      /// <param name="AValue">
      ///    String a ser decriptada
      /// </param>
      /// <param name="AKey">
      ///    Define o char que será usado para decriptação
      /// </param>
      class function DeCryptString(const AValue, AKey: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    String.ContentBetweenChars
      /// </summary>
      /// <param name="AValue">
      ///    String completa para busca
      /// </param>
      /// <param name="ACharBegin">
      ///    Define o Char que irá iniciar a busca
      /// </param>
      /// <param name="ACharEnd">
      ///    Define o Char que irá finalizar a busca
      /// </param>
      class function GetContentBetweenChars(const AValue: UnicodeString; const ACharBegin, ACharEnd: Char): UnicodeString; static;
   end;

   TVariableConverterUtils = class
   public
      /// <summary>
      ///    StringTo.<Currency>
      /// </summary>
      class function CurrToString(const AValue: Currency): UnicodeString; static;

      /// <summary>
      ///    StringTo.<CurrencyF> [Formated]
      /// </summary>
      class function CurrToStringF(const AValue: Currency): UnicodeString; static;

      /// <summary>
      ///    StringTo<Integer>
      /// </summary>
      class function StringToInt(const AValue: UnicodeString): Integer; static;

      /// <summary>
      ///    StringTo<Int64>
      /// </summary>
      class function StringToInt64(const AValue: UnicodeString): Int64; static;

      /// <summary>
      ///    VariantTo<Integer>
      /// </summary>
      class function VarToInt(const AValue: Variant): Integer; static;

      /// <summary>
      ///    VariantTo<ShortInt>
      /// </summary>
      class function VarToShortInt(const AValue: Variant): ShortInt; static;

      /// <summary>
      ///    VariantTo<Int64>
      /// </summary>
      class function VarToInt64(const AValue: Variant): Int64; static;

      /// <summary>
      ///    VariantTo<Date>
      /// </summary>
      class function VarToDate(const AValue: Variant): TDate; static;

      /// <summary>
      ///    VariantTo<String>
      /// </summary>
      class function VarToString(const AValue: Variant): UnicodeString; static;

      /// <summary>
      ///    VariantTo<Boolean>
      /// </summary>
      class function VarToBool(const AValue: Variant): Boolean; static;

      /// <summary>
      ///    VariantTo<Currency>
      /// </summary>
      class function VarToCurrency(const AValue: Variant): Currency; static;
   end;

var
   /// <summary>
   ///    TObject - Utils
   /// </summary>
   ObjUtils: TObjectUtils;

   /// <summary>
   ///    String - Utils
   /// </summary>
   StrUtils: TStringUtils;

   /// <summary>
   ///    Files - Utils
   /// </summary>
   FileUtils: TFileUtils;

   /// <summary>
   ///    Log - Utils
   /// </summary>
   LogUtils: TLogUtils;

   /// <summary>
   ///    Path - Utils
   /// </summary>
   PathUtils: TPathUtils;

   /// <summary>
   ///    Variable Converter - Utils
   /// </summary>
   VarConvUtils: TVariableConverterUtils;

   /// <summary>
   ///    Version - Utils
   /// </summary>
   VersionUtils: TVersionUtils;

implementation

{ TObjectUtils }

uses App.Common.Vars, App.System.Vars;

class procedure TObjectUtils.Release_(const AInstanceOf: TObject);
begin
   if (AInstanceOf <> nil) then
      AInstanceOf.DisposeOf;
end;

class procedure TObjectUtils.CheckAndRaiseNilObject(const AInstanceOf: TObject);
begin
   if (AInstanceOf = nil) then
      raise Exception.CreateFmt('O Objeto %s está nulo!', [AInstanceOf.ClassType.ClassName]);
end;

{ TStringUtils }

class function TStringUtils.DeCryptString(const AValue, AKey: UnicodeString): UnicodeString;
var
   I: Integer;
   LChar: Char;
begin
   Result := '';

   for I := 0 to Pred(AValue.Length div 2) do
   begin
      LChar := Char(StrToIntDef('$' + AValue.SubString((I * 2), 2), Ord(' ')));

      if Length(AKey) > 0 then
         LChar := Char(Byte(AKey[1 + (I mod AKey.Length)]) xor Byte(LChar));

      Result := Result + LChar;
   end;
end;

class function TStringUtils.EnCryptString(const AValue, AKey: UnicodeString): UnicodeString;
var
   I: Integer;
   LByte: Byte;
begin
   Result := '';

   for I := 1 to AValue.Length do
   begin
      if Length(AKey) > 0 then
         LByte := Byte(AKey[1 + ((I - 1) mod AKey.Length )]) xor Byte(AValue[I])
      else
         LByte := Byte(AValue[I]);

      Result := Result + IntToHex(LByte, 2).ToLower;
   end;
end;

class function TStringUtils.GetContentBetweenChars(const AValue: UnicodeString; const ACharBegin, ACharEnd: Char): UnicodeString;
var
   LPosBegin, LPosEnd: Integer;
begin
   LPosBegin := Pos(ACharBegin, AValue);

   if (LPosBegin > 0) then
   begin
      LPosEnd := Pos(ACharEnd, AValue, LPosBegin + 1);

      if (LPosEnd > 0) then
         Result := Copy(AValue, LPosBegin + 1, LPosEnd - (LPosBegin + 1));
   end;
end;

{ TFileUtils }

class procedure TFileUtils.CheckAndCreate_Folder(const AFolderPath: UnicodeString);
begin
   if (not TDirectory.Exists(AFolderPath)) then
      TDirectory.CreateDirectory(AFolderPath);
end;

class function TFileUtils.Exists(const AFilePath: UnicodeString): Boolean;
begin
   Result := FileExists(AFilePath);

   if (not Result) then
      LogUtils.Write('Arquivo não encontrado', AFilePath);
end;

{ TLogUtils }

class procedure TLogUtils.Write(const ATitle, AText, AAddInfo: UnicodeString);
var
   LDoc: IXMLDocument;
   LRoot, LEntry: IXMLNode;
   LLogFileName: UnicodeString;
begin
   LLogFileName := PathUtils.ComputeFileLogPath ;

   if FileExists(LLogFileName) then
      LDoc := LoadXMLDocument(LLogFileName)
   else
   begin
      LDoc := NewXMLDocument;
      LDoc.Encoding := 'UTF-8';
      LDoc.Options := [doNodeAutoIndent];
      LRoot := LDoc.AddChild('Logs');
   end;

   if (LDoc.DocumentElement = nil) then
      LDoc.AddChild('Logs');

   LRoot := LDoc.DocumentElement;

   LEntry := LRoot.AddChild('Log');
   LEntry.Attributes['Hora'] := FormatDateTime('hh:mm:ss', Now);
   LEntry.AddChild('Titulo').Text := ATitle;
   LEntry.AddChild('Texto').Text := AText;

   if (not AAddInfo.IsEmpty) then
      LEntry.AddChild('InfoAdicional').Text := AAddInfo;

   LDoc.SaveToFile(LLogFileName);
end;

{ TPathUtils }

class function TPathUtils.ComputeFileLogPath: UnicodeString;
var
   LDay, LMonth, LYear: Word;
   LFolderPath: UnicodeString;
begin
   DecodeDate(Now, LYear, LMonth, LDay);
   LFolderPath := gvDirectories.Log + '\' + LYear.ToString + '\' + LMonth.ToString;
   FileUtils.CheckAndCreate_Folder(LFolderPath);

   Result := LFolderPath + '\Log_' + LDay.ToString;
end;

class function TPathUtils.ComputeFileSettingsPath: UnicodeString;
begin
   Result := gvDirectories.System + '\' + 'Settings.xml';
end;

class function TPathUtils.GetApplicationPath: UnicodeString;
begin
   Result := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
end;

{ TVariableConverterUtils }

class function TVariableConverterUtils.CurrToString(const AValue: Currency): UnicodeString;
begin
   Result := CurrToStr(AValue);
end;

class function TVariableConverterUtils.CurrToStringF(const AValue: Currency): UnicodeString;
begin
   Result := CurrToStrF(AValue, ffCurrency, 2);
end;

class function TVariableConverterUtils.StringToInt(const AValue: UnicodeString): Integer;
begin
   if (not TryStrToInt(AValue, Result)) then
      Result := 0;
end;

class function TVariableConverterUtils.StringToInt64(const AValue: UnicodeString): Int64;
begin
   if (not TryStrToInt64(AValue, Result)) then
      Result := 0;
end;

class function TVariableConverterUtils.VarToBool(const AValue: Variant): Boolean;
begin
   if (not VarIsNull(AValue)) then
      Result := VarAsType(AValue, varBoolean)
   else
      Result := False;
end;

class function TVariableConverterUtils.VarToCurrency(const AValue: Variant): Currency;
begin
   if (not VarIsNull(AValue)) then
      Result := VarAsType(AValue, varCurrency)
   else
      Result := 0.00;
end;

class function TVariableConverterUtils.VarToDate(const AValue: Variant): TDate;
begin
   if (not VarIsNullDate(AValue)) then
      Result := VarToDateTime(AValue)
   else
      Result := 0;
end;

class function TVariableConverterUtils.VarToInt(const AValue: Variant): Integer;
begin
   if (not VarIsNull(AValue)) then
      Result := VarAsType(AValue, varInteger)
   else
      Result := Low(Integer);
end;

class function TVariableConverterUtils.VarToInt64(const AValue: Variant): Int64;
begin
   if (not VarIsNull(AValue)) then
      Result := VarAsType(AValue, varInt64)
   else
      Result := Low(Int64);
end;

class function TVariableConverterUtils.VarToShortInt(const AValue: Variant): ShortInt;
begin
   if (not VarIsNull(AValue)) then
      Result := VarAsType(AValue, varShortInt)
   else
      Result := Low(ShortInt);
end;

class function TVariableConverterUtils.VarToString(const AValue: Variant): UnicodeString;
begin
   if (not VarIsNull(AValue)) then
      Result := VarAsType(AValue, varString)
   else
      Result := EmptyStr;
end;

{ TVersionUtils }

class procedure TVersionUtils.Decode(out AMajor, AMinor, ARelease, ABuild: Word; const AVersion: Unicodestring);
var
   LVersion: UnicodeString;
   LArrayStr: TArray<String>;
begin
   LVersion := AVersion;
   LArrayStr := LVersion.Split(['.']);

   if Length(LArrayStr) = 0 then
   begin
      AMajor := 0;
      AMinor := 0;
      ARelease := 0;
      ABuild := 0;
   end
   else
   begin
      AMajor := VarConvUtils.StringToInt(LArrayStr[0]);
      AMinor := VarConvUtils.StringToInt(LArrayStr[1]);
      ARelease := VarConvUtils.StringToInt(LArrayStr[2]);
      ABuild := VarConvUtils.StringToInt(LArrayStr[3]);
   end;
end;

class function TVersionUtils.GetApplication_Version: UnicodeString;
var
   LVerInfoSize, LDummy, LVerValueSize: Cardinal;
   LBuffer: TBytes;
   LVerValue: PVSFixedFileInfo;
begin
   Result := '';

   LVerInfoSize := GetFileVersionInfoSize(PChar(Application.ExeName), LDummy);

   if (LVerInfoSize > 0) then
   begin
      SetLength(LBuffer, LVerInfoSize);
      GetFileVersionInfo(PChar(Application.ExeName), 0, LVerInfoSize, PByte(LBuffer));

      if VerQueryValue(PByte(LBuffer), '\', Pointer(LVerValue), LVerValueSize) then
      begin
         Result := (LVerValue.dwFileVersionMS shr $10).ToString + '.' +
                   (LVerValue.dwFileVersionMS and $FFFF).ToString + '.' +
                   (LVerValue.dwFileVersionLS shr $10).ToString + '.' +
                   (LVerValue.dwFileVersionLS and $FFFF).ToString;
      end;
   end;
end;

end.

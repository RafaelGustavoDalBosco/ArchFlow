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
   dxLayoutContainer,
{$ENDREGION}

{$REGION '| APP |'}
   App.System.ORM.Persistent,
   aPP.System.Types,
   App.Common.Consts,
   App.Common.Types, App.System.Consts;
{$ENDREGION}

type

   TComponentUtils = class
   public
      /// <summary>
      ///    Obtém o objeto do tipo inteiro no ComboBox, caso não encontre, retorna -1
      /// </summary>
      /// <param name="AComboBox">
      ///    TcxComboBox que será coletado o número inteiro
      /// </param>
      class function Get_Object_Integer_From_ComboBox(const AComboBox: TcxComboBox): Integer; static;

      /// <summary>
      ///    Seta o foco em um componente usando o TWinControl
      /// </summary>
      /// <param name="AComponent">
      ///    Componente que irá receber o foco
      /// </param>
      class procedure SetFocus(const AComponent: TComponent); static;

      /// <summary>
      ///    Mostra o hint em um componente usando o TcxHintController
      /// </summary>
      class procedure Show_Custom_Hint(const AHint: UnicodeString; const AComponent: TComponent; const AType: TTypeShowHint = tshInformation); static;

      /// <summary>
      ///    OnKeyPress - Limita a digitação de apenas números , e .
      /// </summary>
      class procedure Key_Press_To_Cur(var AKey: Char); static;

      /// <summary>
      ///    OnKeyPress - Limita a digitação de apenas números inteiros
      /// </summary>
      class procedure Key_Press_To_Int(var AKey: Char); static;

      /// <summary>
      ///    Espera o timer de Call Out encerrar
      /// </summary>
      class procedure Wait_For_CallOut; static;

      /// <summary>
      ///    Obtém o Caption de um Componente
      /// </summary>
      /// <param name="AComponent">
      ///    Componente que terá o seu caption extraído
      /// </param>
      class function Get_Caption_From(const AComponent: TComponent): UnicodeString; static;

      /// <summary>
      ///    Apresenta uma mensagem de warning e seta o foco a um componente
      /// </summary>
      /// <param name="AComponent">
      ///    Componente que irá receber o foco
      /// </param>
      /// <param name="ACaption">
      ///    Texto da mensagem de warning
      /// </param>
      /// <remarks>
      ///    Usado bastante em controles de componentes para avisar que está vazio
      /// </remarks>
      class procedure Show_Warn_And_Focus(const AComponent: TComponent; const ACaption: UnicodeString = ''); static;

      /// <summary>
      ///    Chama o Call Out de Sucesso
      /// </summary>
      /// <param name="AOwner">
      ///    Componente que será o ''dono'' do CallOut
      /// </param>
      /// <param name="AText">
      ///    Texto qeu será apresentado no CallOut
      /// </param>
      class procedure Show_CallOut_Sucess(const AOwner: TWinControl; const AText: UnicodeString); static;

      // <summary>
      ///    Chama o Call Out de Espera e depois muda para Sucesso, caso seja conveniente
      /// </summary>
      /// <param name="AOwner">
      ///    Componente que será o ''dono'' do CallOut
      /// </param>
      /// <param name="AText">
      ///    Texto que será apresentado no CallOut
      /// </param>
      class procedure Show_CallOut_Wait_And_Sucess(const AOwner: TWinControl; const AText: UnicodeString); static;

      /// <summary>
      ///    Chama o Call Out de Warning que está no System.Component.Assistence
      /// </summary>
      /// <param name="AOwner">
      ///    Componente que será o ''dono'' do CallOut
      /// </param>
      /// <param name="AText">
      ///    Texto que será apresentado no CallOut
      /// </param>
      class procedure Show_CallOut_Warn(const AOwner: TWinControl; const AText: UnicodeString); static;

      /// <summary>
      ///    Chama o Call Out de Warning que está no System.Component.Assistence e depois seta o guia do DxAdorner
      /// </summary>
      /// <param name="AOwner">
      ///    Componente que será o ''dono'' do CallOut
      /// </param>
      /// <param name="AComponent">
      ///    Componente que receberá o guia
      /// </param>
      /// <param name="AGuide">
      ///    Componente TdxGuide
      /// </param>
      /// <param name="ACaption">
      ///    Texto que será apresentado no CallOut
      /// </param>
      class procedure Show_CallOut_Warn_And_Guide(const AOwner: TWinControl; const AComponent: TComponent; const AGuide: TdxGuide; const ACaption: UnicodeString); static;
   end;

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
      ///    Escreve uma nova linha no arquivo de LOG (.XML)
      ///    O arquivo de log é gerado por dia, dentro da pasta do mês e ano respectivo
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

      /// <summary>
      ///    Escreve uma mensagem padrão de falha de conversão de dados
      /// </summary>
      /// <param name="AValue">
      ///    Valor que foi tentado ser convertido
      /// </param>
      /// <param name="ATypeIn">
      ///    Tipo inicial a ser convertido
      /// </param>
      /// <param name="ATypeOut">
      ///    Tipo que seria convertido o valor
      /// </param>
      class procedure Write_Common_Converter_Failure(const AValue, ATypeIn, ATypeOut: UnicodeString); static;
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
      ///    Retorna somente os números de uma String
      /// </summary>
      /// <param name="AValue">
      ///    String a ser codificada
      /// </param>
      class function Only_Numbers(const AValue: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    String.Crypt
      /// </summary>
      /// <param name="AValue">
      ///    String a ser encriptada
      /// </param>
      /// <param name="AKey">
      ///    Define o Char que será usado para encriptação
      /// </param>
      class function EnCryptString(const AValue: UnicodeString; const AKey: UnicodeString = SKeyCryptString): UnicodeString; static;

      /// <summary>
      ///    String.Decrypt
      /// </summary>
      /// <param name="AValue">
      ///    String a ser decriptada
      /// </param>
      /// <param name="AKey">
      ///    Define o char que será usado para decriptação
      /// </param>
      class function DeCryptString(const AValue: UnicodeString; const AKey: UnicodeString = SKeyCryptString): UnicodeString; static;

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

   TJSONUtils = class
   public
      /// <summary>
      ///    Salva no log que não encontrou o path no JSON
      /// </summary>
      /// <param name="APath">
      ///    Caminho do campo dentro do JSON
      /// </param>
      class procedure SaveOnLog_NotFindPath(const APath: UnicodeString); static;

      /// <summary>
      ///    Tenta obter o valor String de um caminho no JSON [Reader]
      /// </summary>
      /// <param name="AObjectReader:TJsonTextReader">
      ///   Objeto TJsonTextReader que está lendo o JSON
      /// </param>
      /// <param name="APath">
      ///    Caminho do campo dentro do JSON
      /// </param>
      class function TryGetValueStringFromPath(const AObjectReader: TJsonTextReader; const APath: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    Tenta obter o valor Integer de um caminho no JSON [Reader]
      /// </summary>
      /// <param name="AObjectReader:TJsonTextReader">
      ///   Objeto TJsonTextReader que está lendo o JSON
      /// </param>
      /// <param name="APath">
      ///    Caminho do campo dentro do JSON
      /// </param>
      class function TryGetValueIntegerFromPath(const AObjectReader: TJsonTextReader; const APath: UnicodeString): Integer; static;

      /// <summary>
      ///    Tenta obter o valor Date de um caminho no JSON [Reader]
      /// </summary>
      /// <param name="AObjectReader:TJsonTextReader">
      ///   Objeto TJsonTextReader que está lendo o JSON
      /// </param>
      /// <param name="APath">
      ///    Caminho do campo dentro do JSON
      /// </param>
      class function TryGetValueDateFromPath(const AObjectReader: TJsonTextReader; const APath: UnicodeString): TDate; static;
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

   TMessageUtils = class
   public
      // <summary>
      ///    Mostra a tela de mensagem
      /// </summary>
      /// <param name="AMessage">
      ///   Texto a ser mostrado na tela
      /// </param>
      /// <param name="AType">
      ///    Tipo da mensagem a ser mostrada
      /// </param>
      class function Show_FromType(const AMessage: UnicodeString; const AType: TTypeMessage): Boolean; static;

      /// <summary>
      ///    Mostra a mensagem de WARNING
      /// </summary>
      /// <param name="AMessage">
      ///   Texto a ser mostrado na tela
      /// </param>
      class function Show_Warn(const AMessage: UnicodeString): Boolean; static;

      /// <summary>
      ///    Mostra a mensagem de ERRO
      /// </summary>
      /// <param name="AMessage">
      ///   Texto a ser mostrado na tela
      /// </param>
      class function Show_Error(const AMessage: UnicodeString): Boolean; static;

      /// <summary>
      ///    Mostra a mensagem de SUCESS
      /// </summary>
      /// <param name="AMessage">
      ///   Texto a ser mostrado na tela
      /// </param>
      class function Show_Sucess(const AMessage: UnicodeString): Boolean; static;

      /// <summary>
      ///    Mostra a mensagem de QUESTION
      /// </summary>
      /// <param name="AMessage">
      ///   Texto a ser mostrado na tela
      /// </param>
      class function Show_Question(const AMessage: UnicodeString): Boolean; static;

      /// <summary>
      ///    Mostra a mensagem de INFO
      /// </summary>
      /// <param name="AMessage">
      ///   Texto a ser mostrado na tela
      /// </param>
      class function Show_Info(const AMessage: UnicodeString): Boolean; static;
   end;

   TValidateUtils = class
   public
      /// <summary>
      ///    Valida um CPF
      /// </summary>
      /// <param name="ACPF">
      ///    CPF a ser validado
      /// </param>
      class function Validate_CPF(const ACPF: UnicodeString): Boolean; static;

      /// <summary>
      ///    Valida um CNPJ
      /// </summary>
      /// <param name="ACNPJ">
      ///    CNPJ a ser validado
      /// </param>
      class function Validate_CNPJ(const ACNPJ: UnicodeString): Boolean; static;
   end;

   TWatcherUtils = class
   public
      /// <summary>
      ///    Abre a tela de Watcher
      /// </summary>
      /// <param name="AMainText">
      ///    Texto principal que será mostrado
      /// </param>
      /// <param name="ACount">
      ///    Contador máximo do progress bar
      /// </param>
      class procedure Show_Watcher(const AMainText: UnicodeString; const ATypeShow: TTypeShowWatcher = tswNormal; const ACount: Integer = 0); static;

      /// <summary>
      ///    Incrementa o contador de Progresso
      /// </summary>
      class procedure Inc_Progress; static;

      /// <summary>
      ///    Fecha o form Watcher
      /// </summary>
      class procedure Close; static;
   end;

var
   /// <summary>
   ///    Component - Utils
   /// </summary>
   CompUtils: TComponentUtils;

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

   /// <summary>
   ///    JSON - Utils
   /// </summary>
   JSONUtils: TJSONUtils;

   /// <summary>
   ///    Message - Utils
   /// </summary>
   MessageUtils: TMessageUtils;

   /// <summary>
   ///    Watcher - Utils
   /// </summary>
   WatcherUtils: TWatcherUtils;

implementation

uses
   App.Common.Vars,
   App.System.Vars,
   Frm.System.Message,
   Frm.System.Component.Assistance,
   Frm.System.Watcher;

{ TObjectUtils }

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

class function TStringUtils.Only_Numbers(const AValue: UnicodeString): UnicodeString;
var
   LLoop: Char;
begin
   for LLoop in AValue do
   begin
      if CharInSet(LLoop, ['0'..'9']) then
         Result := Result + LLoop;
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
   LLogFileName := PathUtils.ComputeFileLogPath;

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

class procedure TLogUtils.Write_Common_Converter_Failure(const AValue, ATypeIn, ATypeOut: UnicodeString);
begin
   LogUtils.Write('Conversion Failure', Format('Erro ao tentar converter a variável do tipo %s para %s!', [ATypeIn, ATypeOut]));
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
      Result := 0
   else
      LogUtils.Write_Common_Converter_Failure(AValue, 'UnicodeString', 'Integer');
end;

class function TVariableConverterUtils.StringToInt64(const AValue: UnicodeString): Int64;
begin
   if (not TryStrToInt64(AValue, Result)) then
      Result := 0
   else
      LogUtils.Write_Common_Converter_Failure(AValue, 'UnicodeString', 'Int64');
end;

class function TVariableConverterUtils.VarToBool(const AValue: Variant): Boolean;
begin
   if (not VarIsNull(AValue)) then
      Result := VarAsType(AValue, varBoolean)
   else
   begin
      LogUtils.Write_Common_Converter_Failure('Null', 'Variant', 'Boolean');
      Result := False;
   end;
end;

class function TVariableConverterUtils.VarToCurrency(const AValue: Variant): Currency;
begin
   if (not VarIsNull(AValue)) then
      Result := VarAsType(AValue, varCurrency)
   else
   begin
      LogUtils.Write_Common_Converter_Failure('Null', 'Variant', 'Currency');
      Result := 0.00;
   end;
end;

class function TVariableConverterUtils.VarToDate(const AValue: Variant): TDate;
begin
   if (not VarIsNullDate(AValue)) then
      Result := VarToDateTime(AValue)
   else
   begin
      LogUtils.Write_Common_Converter_Failure('Null', 'Variant', 'TDate');
      Result := 0;
   end;
end;

class function TVariableConverterUtils.VarToInt(const AValue: Variant): Integer;
begin
   if (not VarIsNull(AValue)) then
      Result := VarAsType(AValue, varInteger)
   else
   begin
      LogUtils.Write_Common_Converter_Failure('Null', 'Variant', 'Integer');
      Result := Low(Integer);
   end;
end;

class function TVariableConverterUtils.VarToInt64(const AValue: Variant): Int64;
begin
   if (not VarIsNull(AValue)) then
      Result := VarAsType(AValue, varInt64)
   else
   begin
      LogUtils.Write_Common_Converter_Failure('Null', 'Variant', 'Int64');
      Result := Low(Int64);
   end;
end;

class function TVariableConverterUtils.VarToShortInt(const AValue: Variant): ShortInt;
begin
   if (not VarIsNull(AValue)) then
      Result := VarAsType(AValue, varShortInt)
   else
   begin
      LogUtils.Write_Common_Converter_Failure('Null', 'Variant', 'ShortInt');
      Result := Low(ShortInt);
   end;
end;

class function TVariableConverterUtils.VarToString(const AValue: Variant): UnicodeString;
begin
   if (not VarIsNull(AValue)) and (not VarIsEmpty(AValue)) then
      Result := VarAsType(AValue, varString)
   else
   begin
      LogUtils.Write_Common_Converter_Failure('Null', 'Variant', 'UnicodeString');
      Result := EmptyStr;
   end;
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

{ TJSONUtils }

class procedure TJSONUtils.SaveOnLog_NotFindPath(const APath: UnicodeString);
begin
   LogUtils.Write('Path not find', Format(SNotFind_PathOn_JSON, [APath]));
end;

class function TJSONUtils.TryGetValueDateFromPath(const AObjectReader: TJsonTextReader; const APath: UnicodeString): TDate;
begin
   if AObjectReader.Value.AsString.Equals(APath) then
   begin
      AObjectReader.Read;
      Result := StrToDate(AObjectReader.Value.AsString);
   end
   else
   begin
      JSONUtils.SaveOnLog_NotFindPath(APath);
      Result := 0;
   end;

   AObjectReader.Read;
end;

class function TJSONUtils.TryGetValueIntegerFromPath(const AObjectReader: TJsonTextReader; const APath: UnicodeString): Integer;
begin
   if AObjectReader.Value.AsString.Equals(APath) then
   begin
      AObjectReader.Read;
      Result := AObjectReader.Value.AsInteger;
   end
   else
   begin
      JSONUtils.SaveOnLog_NotFindPath(APath);
      Result := 0;
   end;

   AObjectReader.Read;
end;

class function TJSONUtils.TryGetValueStringFromPath(const AObjectReader: TJsonTextReader; const APath: UnicodeString): UnicodeString;
begin
   if AObjectReader.Value.AsString.Equals(APath) then
   begin
      AObjectReader.Read;
      Result := AObjectReader.Value.AsString;
   end
   else
   begin
      JSONUtils.SaveOnLog_NotFindPath(APath);
      Result := '';
   end;

   AObjectReader.Read;
end;

{ TMessageUtils }

class function TMessageUtils.Show_Error(const AMessage: UnicodeString): Boolean;
begin
   Result := MessageUtils.Show_FromType(AMessage, tmError);
end;

class function TMessageUtils.Show_FromType(const AMessage: UnicodeString; const AType: TTypeMessage): Boolean;
var
   LForm: TFrmSystemMessage;
begin
   LForm := TFrmSystemMessage.Create(nil);
   try
      LForm.MessageText := AMessage;
      LForm.TypeMessage := AType;
      LForm.ShowModal;

      Result := (LForm.TypeResultAction = traConfirmed);
   finally
      FreeAndNil(LForm);
   end;
end;

class function TMessageUtils.Show_Info(const AMessage: UnicodeString): Boolean;
begin
   Result := MessageUtils.Show_FromType(AMessage, tmInfo);
end;

class function TMessageUtils.Show_Question(const AMessage: UnicodeString): Boolean;
begin
   Result := MessageUtils.Show_FromType(AMessage, tmQuestion);
end;

class function TMessageUtils.Show_Sucess(const AMessage: UnicodeString): Boolean;
begin
   Result := MessageUtils.Show_FromType(AMessage, tmSucess);
end;

class function TMessageUtils.Show_Warn(const AMessage: UnicodeString): Boolean;
begin
   Result := MessageUtils.Show_FromType(AMessage, tmWarning);
end;

{ TComponentUtils }

class function TComponentUtils.Get_Caption_From(const AComponent: TComponent): UnicodeString;
begin
   if (AComponent is TcxGroupBox) then
      Result := TcxGroupBox(AComponent).Caption;

   if (AComponent is TcxLabel) then
      Result := TcxLabel(AComponent).Caption;

   if (AComponent is TcxRadioGroup) then
      Result := TcxRadioGroup(AComponent).Caption;
end;

class function TComponentUtils.Get_Object_Integer_From_ComboBox(const AComboBox: TcxComboBox): Integer;
begin
   if (AComboBox.Properties.Items.Count > 0) then
   begin
      if (AComboBox.ItemIndex > - 1) then
         Result := Integer(AComboBox.ItemObject)
      else
         Result := -1;
   end
   else
      Result := -1;
end;

class procedure TComponentUtils.Key_Press_To_Cur(var AKey: Char);
begin
   if (not CharInSet(AKey,['0'..'9', ',', #8])) then
      AKey := #0
end;

class procedure TComponentUtils.Key_Press_To_Int(var AKey: Char);
begin
   if (not CharInSet(AKey,['0'..'9', #8])) then
      AKey := #0
end;

class procedure TComponentUtils.SetFocus(const AComponent: TComponent);
var
   LControl: TWinControl;
begin
   LControl := TWinControl(AComponent);

   if (LControl.CanFocus) then
      LControl.SetFocus
   else
      LogUtils.Write('Focus_Failure', Format('O componente %s não pode receber foco!', [AComponent.Name]));
end;

class procedure TComponentUtils.Show_CallOut_Sucess(const AOwner: TWinControl; const AText: UnicodeString);
begin
   FrmSystemComponentAssistance.LblCallOutSucess.Caption := AText;
   FrmSystemComponentAssistance.DxCalloutPopup.PopupControl := FrmSystemComponentAssistance.DxPanelCallOutSucess;
   FrmSystemComponentAssistance.DxCalloutPopup.Popup(AOwner);
   FrmSystemComponentAssistance.TimerCallOutPopUp.Enabled := True;
   CompUtils.Wait_For_CallOut;
end;

class procedure TComponentUtils.Show_CallOut_Wait_And_Sucess(const AOwner: TWinControl; const AText: UnicodeString);
begin
   FrmSystemComponentAssistance.LblCallOutWaitAndSucess.Caption := AText;
   FrmSystemComponentAssistance.dxActivityIndicatorCallOut.Active := True;
   FrmSystemComponentAssistance.CxImgCallOutWaitAndSucess.Visible := False;
   FrmSystemComponentAssistance.DxCalloutPopup.PopupControl := FrmSystemComponentAssistance.DxPanelCallOutWaitAndSucess;
   FrmSystemComponentAssistance.DxCalloutPopup.Popup(AOwner);
   CompUtils.Wait_For_CallOut;
end;

class procedure TComponentUtils.Show_CallOut_Warn(const AOwner: TWinControl; const AText: UnicodeString);
begin
   FrmSystemComponentAssistance.LblCallOutWarning.Caption := AText;
   FrmSystemComponentAssistance.DxCalloutPopup.PopupControl := FrmSystemComponentAssistance.DxPanelCallOutWarning;
   FrmSystemComponentAssistance.DxCalloutPopup.Popup(AOwner);
   FrmSystemComponentAssistance.TimerCallOutPopUp.Enabled := True;
   CompUtils.Wait_For_CallOut;
end;

class procedure TComponentUtils.Show_CallOut_Warn_And_Guide(const AOwner: TWinControl; const AComponent: TComponent; const AGuide: TdxGuide; const ACaption: UnicodeString);
begin
   // -> Show Call Out Warning
   CompUtils.Show_CallOut_Warn(AOwner, ACaption);

   // -> Seta o Path do Adorner[Guide]
   TdxAdornerTargetElementPath(AGuide.TargetElement).Path := AComponent.Name;

   // -> Ativa o Adorner
   AGuide.Adorners.Active := True;

   // -> Define o tempo de espera para fechar automaticamente
   Sleep(500);
   AGuide.Adorners.Active := False;
   TdxAdornerTargetElementPath(AGuide.TargetElement).Path := '';

   // -> Seta o foco ao componente
   CompUtils.SetFocus(AComponent);
end;

class procedure TComponentUtils.Show_Custom_Hint(const AHint: UnicodeString; const AComponent: TComponent; const AType: TTypeShowHint);
var
   LPoint: TPoint;
   LWidth: Integer;
   LWinControl: TWinControl;
   LStyle: TcxHintStyle;
   LCaption: UnicodeString;
begin
   LWinControl := TComponent(AComponent) as TWinControl;

   LWidth := LWinControl.Width;

   LPoint.X := LWidth Div 2;
   LPoint.Y := 0;

   LPoint := LWinControl.ClientToScreen(LPoint);

   LStyle := TcxHintStyle(FrmSystemComponentAssistance.HintController.HintStyle);

   case AType of
      tshInformation: begin
                        LCaption := 'Informativo';
                        LStyle.IconType := cxhiInformation;
                      end;
      tshError:       begin
                        LCaption := 'Erro';
                        LStyle.IconType := cxhiError;
                      end;
      tshWarning:     begin
                        LCaption := 'Aviso';
                        LStyle.IconType := cxhiWarning;
                      end;
   end;

   FrmSystemComponentAssistance.HintController.ShowHint(LPoint.X, LPoint.Y, LCaption, AHint);
end;

class procedure TComponentUtils.Show_Warn_And_Focus(const AComponent: TComponent; const ACaption: UnicodeString);
var
   LCaption: UnicodeString;
begin
   if (ACaption.IsEmpty) then
      LCaption := CompUtils.Get_Caption_From(AComponent)
   else
      LCaption := ACaption;

   MessageUtils.Show_Warn(Format(SWarn_Empty_FieldValue, [LCaption]));
   CompUtils.SetFocus(AComponent);
end;

class procedure TComponentUtils.Wait_For_CallOut;
begin
   // -> Espera o Timer encerrar...
   while FrmSystemComponentAssistance.TimerCallOutPopUp.Enabled do
   begin
      Application.ProcessMessages;
      Continue;
   end;
end;

{ TValidateUtils }

class function TValidateUtils.Validate_CNPJ(const ACNPJ: UnicodeString): Boolean;
const
   Weights1: array[1..12] of Integer = (5,4,3,2,9,8,7,6,5,4,3,2);
   Weights2: array[1..13] of Integer = (6,5,4,3,2,9,8,7,6,5,4,3,2);
var
   LDigits: string;
   LSum, LIdx, LNum, LRest: Integer;
begin
   LDigits := StrUtils.Only_Numbers(ACNPJ);

   if (Length(LDigits) <> 14) or (StringOfChar(LDigits[1], 14) = LDigits) then
      Exit(False);

   LSum := 0;

   for LIdx := 1 to 12 do
   begin
      LNum := Ord(LDigits[LIdx]) - Ord('0');
      LSum := LSum + LNum * Weights1[LIdx];
   end;

   LRest := LSum mod 11;

   if (LRest < 2) then
      LRest := 0
   else
      LRest := 11 - LRest;

   if LRest <> (Ord(LDigits[13]) - Ord('0')) then
      Exit(False);

   LSum := 0;

   for LIdx := 1 to 13 do
   begin
      LNum := Ord(LDigits[LIdx]) - Ord('0');
      LSum := LSum + LNum * Weights2[LIdx];
   end;

   LRest := LSum mod 11;
   if (LRest < 2) then
      LRest := 0
   else
      LRest := 11 - LRest;

   Result := LRest = (Ord(LDigits[14]) - Ord('0'));
end;

class function TValidateUtils.Validate_CPF(const ACPF: UnicodeString): Boolean;
var
   LDigits: UnicodeString;
   LSum, LRest, LIdx, LNum: Integer;
begin
   LDigits :=  StrUtils.Only_Numbers(ACPF);

   if (Length(LDigits) <> 11) or (StringOfChar(LDigits[1], 11) = LDigits) then
      Exit(False);

   LSum := 0;

   for LIdx := 1 to 9 do
   begin
      LNum := Ord(LDigits[LIdx]) - Ord('0');
      LSum := LSum + LNum * (11 - LIdx);
   end;

   LRest := (LSum * 10) mod 11;

   if (LRest = 10) then
      LRest := 0;

   if LRest <> (Ord(LDigits[10]) - Ord('0')) then
      Exit(False);

   LSum := 0;

   for LIdx := 1 to 10 do
   begin
      LNum := Ord(LDigits[LIdx]) - Ord('0');
      LSum := LSum + LNum * (12 - LIdx);
   end;

   LRest := (LSum * 10) mod 11;

   if (LRest = 10) then
      LRest := 0;

   Result := LRest = (Ord(LDigits[11]) - Ord('0'));
end;

{ TWatcherUtils }

class procedure TWatcherUtils.Close;
begin
   if Assigned(FrmSystemWatcher) then
   begin
      FrmSystemWatcher.CloseForm;
      FreeAndNil(FrmSystemWatcher);
   end;
end;

class procedure TWatcherUtils.Inc_Progress;
begin
   if Assigned(FrmSystemWatcher) then
   begin
      FrmSystemWatcher.ProgressBar.Position := FrmSystemWatcher.ProgressBar.Position + 1;
      Application.ProcessMessages;
   end;
end;

class procedure TWatcherUtils.Show_Watcher(const AMainText: UnicodeString; const ATypeShow: TTypeShowWatcher; const ACount: Integer);
begin
   if (FrmSystemWatcher = nil) then
      FrmSystemWatcher := TFrmSystemWatcher.Create(nil);

   FrmSystemWatcher.LblMainText.Caption := AMainText;
   FrmSystemWatcher.TypeShow := ATypeShow;
   FrmSystemWatcher.ProgressBar.Visible := (ACount > 0);
   FrmSystemWatcher.ProgressBar.Properties.Max := ACount;
   FrmSystemWatcher.ShowForm;
end;

end.

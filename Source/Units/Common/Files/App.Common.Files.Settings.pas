unit App.Common.Files.Settings;

interface

uses
   Xml.XMLDoc,
   Xml.XMLIntf,
   System.SysUtils,
   App.Objects.Common;

type

   TFileSettings = class
   public
      /// <summary>
      ///    Carrega o arquivo de Settings e retorna no objeto [TApplicationSettings]
      /// </summary>
      function Load: TApplicationSettings;

      /// <summary>
      ///    Escreve no arquivo de Settings
      /// </summary>
      /// <param name="AAplicationSettings">
      ///    Objeto responsável pelas propriedades do Settings
      /// </param>
      procedure Write(const AApplicationSettings: TApplicationSettings);
   end;

implementation

{ TApplicationSettings }

uses App.Common.Utils;

function TFileSettings.Load: TApplicationSettings;
var
   LXMLDoc: IXMLDocument;
   LRootNode, LNode: IXMLNode;
   LCustomize: TApplicationSettingsCustomize;
   LConnection: TApplicationSettingsConnection;
   LSystem: TApplicationSettingsSystem;
begin
   if (not FileUtils.Exists(PathUtils.ComputeFileSettingsPath)) then
   begin
      Result := TApplicationSettings.Create;
      Exit(Result);
   end;

   Result := TApplicationSettings.Create;
   LXMLDoc := TXMLDocument.Create(nil);
   try
      LXMLDoc.LoadFromFile(PathUtils.ComputeFileSettingsPath);
      LRootNode := LXMLDoc.DocumentElement;

      if Assigned(LRootNode) then
      begin
         LNode := LRootNode.ChildNodes['Customize'];

         if (LNode <> nil) then
         begin
            LCustomize := TApplicationSettingsCustomize.Create;
            LCustomize.RememberUser := VarConvUtils.VarToBool(LNode.ChildNodes['RememberUser'].NodeValue);
            LCustomize.UserNameDefault := VarConvUtils.VarToString(LNode.ChildNodes['UserNameDefault'].NodeValue);
            LCustomize.UseEscapeKeyToLeave := VarConvUtils.VarToBool(LNode.ChildNodes['UseKeyEscapeToLeave'].NodeValue);
            LCustomize.ShowConfirmMessage := VarConvUtils.VarToBool(LNode.ChildNodes['ShowConfirmMessage'].NodeValue);
            LCustomize.DisableWeather := VarConvUtils.VarToBool(LNode.ChildNodes['DisableWeather'].NodeValue);
            LCustomize.DisableSpellChecker := VarConvUtils.VarToBool(LNode.ChildNodes['DisableSpellChecker'].NodeValue);

            Result.Customize := LCustomize;
         end;

         LNode := LRootNode.ChildNodes['Connection'];

         if (LNode <> nil) then
         begin
            LConnection := TApplicationSettingsConnection.Create;
            LConnection.DataBaseName := VarConvUtils.VarToString(LNode.ChildNodes['DataBaseName'].NodeValue);
            LConnection.ServerPath := VarConvUtils.VarToString(LNode.ChildNodes['ServerPath'].NodeValue);

            Result.Connection := LConnection;
         end;

         LNode := LRootNode.ChildNodes['System'];

         if (LNode <> nil) then
         begin
            LSystem := TApplicationSettingsSystem.Create;
            LSystem.DoNotUpdate := VarConvUtils.VarToBool(LNode.ChildNodes['DoNotUpdate'].NodeValue);
            LSystem.TraceDebug := VarConvUtils.VarToBool(LNode.ChildNodes['TraceDebug'].NodeValue);

            Result.System := LSystem;
         end;
      end;
   finally
      LXMLDoc := nil;
   end;
end;

procedure TFileSettings.Write(const AApplicationSettings: TApplicationSettings);
var
   LXMLDoc: IXMLDocument;
   LRootNode, LRootNodeSub: IXMLNode;
{=====================================================================================}
   function WriteNode(const ANode: IXMLNode; const AName: UnicodeString): IXMLNode;
   var
      LNode: IXMLNode;
   begin
      LNode := ANode.ChildNodes.FindNode(AName);

      if (LNode <> nil) then
         Result := LNode
      else
         Result := ANode.AddChild(AName);
   end;
{=====================================================================================}
begin
   LXMLDoc := TXMLDocument.Create(nil);
   try
      if FileUtils.Exists(PathUtils.ComputeFileSettingsPath) then
         LXMLDoc.LoadFromFile(PathUtils.ComputeFileSettingsPath);

      LXMLDoc.Active := True;
      LXMLDoc.Options := [doNodeAutoIndent];
      LXMLDoc.Encoding := 'UTF-8';
      LXMLDoc.Version := '1.0';

      LRootNode := WriteNode(LXMLDoc.Node, 'Settings');

      LRootNodeSub := WriteNode(LRootNode, 'Connection');
      WriteNode(LRootNodeSub, 'DataBaseName').NodeValue := AApplicationSettings.Connection.DataBaseName;
      WriteNode(LRootNodeSub, 'ServerPath').NodeValue := AApplicationSettings.Connection.ServerPath;

      LRootNodeSub := WriteNode(LRootNode, 'Customize');
      WriteNode(LRootNodeSub, 'RememberUser').NodeValue := AApplicationSettings.Customize.RememberUser;
      WriteNode(LRootNodeSub, 'UserNameDefault').NodeValue := AApplicationSettings.Customize.UserNameDefault;
      WriteNode(LRootNodeSub, 'UseKeyEscapeToLeave').NodeValue := AApplicationSettings.Customize.UseEscapeKeyToLeave;
      WriteNode(LRootNodeSub, 'ShowConfirmMessage').NodeValue := AApplicationSettings.Customize.ShowConfirmMessage;
      WriteNode(LRootNodeSub, 'DisableWeather').NodeValue := AApplicationSettings.Customize.DisableWeather;
      WriteNode(LRootNodeSub, 'DisableSpellChecker').NodeValue := AApplicationSettings.Customize.DisableSpellChecker;

      LRootNodeSub := WriteNode(LRootNode, 'System');
      WriteNode(LRootNodeSub, 'DoNotUpdate').NodeValue := AApplicationSettings.System.DoNotUpdate;
      WriteNode(LRootNodeSub, 'TraceDebug').NodeValue := AApplicationSettings.System.TraceDebug;

      LXMLDoc.SaveToFile(PathUtils.ComputeFileSettingsPath);
   finally
      LXMLDoc := nil;
   end;
end;

end.

unit App.System.Vars;

interface

uses
   App.System.Connection,
   App.Objects.Common,
   App.System.Types;

var
   /// <summary>
   ///    Global.Variable = TConnection | Objeto da conexão da aplicação
   /// </summary>
   gvConnection: TConnection;

   /// <summary>
   ///    Global.Variable = TTypeConnection | tipo da conexão (Local ou remoto)
   /// </summary>
   gvTypeConnection: TTypeConnection;

   /// <summary>
   ///    Global.Variable = TApplicationDiorectorys | diretórios da aplicação
   /// </summary>
   gvDirectories: TApplicationDirectorys;

   /// <summary>
   ///    Global.Variable = TApplicationSettings | configurações do arquivo settings
   /// </summary>
   gvSettings: TApplicationSettings;

   /// <summary>
   ///    Global.Variable = TApplicationFiles | caminho dos arquivos da aplicação
   /// </summary>
   gvFiles: TApplicationFiles;

implementation
end.

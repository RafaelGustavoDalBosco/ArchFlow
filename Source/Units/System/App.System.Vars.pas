unit App.System.Vars;

interface

uses
   App.System.Connection,
   App.Objects.Common;

var
   /// <summary>
   ///    Global.Variable = TConnection | Objeto da conexão da aplicação
   /// </summary>
   gvConnection: TConnection;

   /// <summary>
   ///    Global.Variable = TraceDebug | Usado para monitorar os métodos executados
   /// </summary>
   gvTraceDebug: Boolean;

   /// <summary>
   ///    Global.Variable = TApplicationDiorectorys | diretórios da aplicação
   /// </summary>
   gvDirectories: TApplicationDirectorys;

implementation


end.

unit App.System.Types;

interface

type

   /// <summary>
   ///    Type:  Connection [Remoto ou Local]
   /// </summary>
   TTypeConnection = (tcRemote, tcLocal);

   /// <summary>
   ///    Type: Operations [New, Edit, Delete, Select, List]
   /// </summary>
   TTypeOperation = (toNew, toEdit, toDelete, toSelect, toList, toNone);

   /// <summary>
   ///    Type: Operations DataBase [New, Update, WrongVersion]
   /// </summary>
   TTypeOperationDataBase = (todNone, todNew, todUpdate, todWrongVersion);

   /// <summary>
   ///    Type: Result Action [None, Confirmado, Cancelado]
   /// </summary>
   TTypeResultAction = (traNone, traConfirmed, traCanceled);

   /// <summary>
   ///   Type: Messsage [None, Info, Warning, Sucess, Error, tmQuestion]
   /// </summary>
   TTypeMessage = (tmNone, tmInfo, tmWarning, tmSucess, tmError, tmQuestion);

   /// <summary>
   ///    Type: ShowHint [Information, Warning, Error]
   /// </summary>
   TTypeShowHint = (tshInformation, tshWarning, tshError);

implementation

end.

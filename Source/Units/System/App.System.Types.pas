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

implementation

end.

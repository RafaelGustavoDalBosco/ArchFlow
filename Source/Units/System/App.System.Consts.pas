unit App.System.Consts;

interface

const

{$REGION '| DEFAULT VALUES |'}
   SKeyCryptString = '#!#';
   SName_Tradution_File = 'traducao.ini';
   SBlocker_LogIn = 'blocker_log_in';
   SName_SpellChecker_AffFile = 'pt_BR.aff';
   SName_SpellChecker_DicFile = 'pt_BR.dic';
{$ENDREGION}

{$REGION '| AWS |'}
   /// <summary>
   ///    Nome do arquivo Exe Zipado
   /// </summary>
   SName_ZipFile_NameNewExe = 'HopeNew.zip';

   /// <summary>
   ///    Nome do bucket que fica a atualização do Exe
   /// </summary>
   SName_Bucket_UpdateExe = 'hope-update-exe';

   /// <summary>
   ///    Nome do Executavel lá na AWS
   /// </summary>
   SName_NewExe = 'Hope.exe';

   /// <summary>
   ///    Nome do arquivo que controla a versão
   /// </summary>
   SName_JSON_Version = 'Hope_version.json';

   /// <summary>
   ///    Nome do bucket que fica os arquivos das empresas
   /// </summary>
   SName_Bucket_Company_Cloud = 'Hope-company-cloud';

   /// <summary>
   ///    Nome do arquivo que tem as informações da empresa na AWS
   /// </summary>
   SName_File_Company_Cloud = 'company_%s_info.json';
{$ENDREGION}


implementation

end.

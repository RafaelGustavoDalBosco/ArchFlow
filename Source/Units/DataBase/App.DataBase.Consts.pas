unit App.DataBase.Consts;

interface

const


{$REGION '| PG CONSTS |'}
   cPGUserName = 'postgres';
   cPGPassWord = 'postgres';
   cMainSchemaName = 'public';
{$ENDREGION}


{$REGION '| FIELDS |'}
   SField_Active = 'active';

   SField_CpfCnpj = 'cpf_cnpj';
   SField_Can_Update = 'can_update';
   SField_Can_Insert = 'can_insert';
   SField_Can_Delete = 'can_delete';
   SField_Can_Access = 'can_access';

   SField_Data_Fim_Contrato = 'data_fim_contrato';
   SField_Descricao = 'descricao';

   SField_FKField = 'fk_field';
   SField_FieldLength = 'field_length';
   SField_FieldType = 'field_type';
   SField_FieldName = 'field_name';
   SField_Form_Class = 'form_class';

   SField_Expiration_Date = 'expiration_date';

   SField_GoogleWorkSpace = 'google_work_space';

   SField_Id = 'id';
   SField_Id_Empresa = 'id_empresa';
   SField_Id_Imediato = 'id_imediato';
   SField_Id_Usuario = 'id_usuario';
   SField_Is_Null = 'is_null';

   SField_Logo = 'logo';
   SField_Last_Updated_Date = 'last_updated_date';

   SField_Nome = 'nome';
   SField_Nome_Fantasia = 'nome_fantasia';
   SField_Numeric_Precision = 'numeric_precision';

   SField_Owner_Type = 'owner_type';
   SField_Owner_Id = 'owner_id';

   SField_PassWord = 'pass_word';

   SField_RazaoSocial = 'razao_social';
   SField_Remuneracao = 'remuneracao';
   SField_Reference_Table = 'reference_table';

   SField_Scale = 'scale';

   SField_Tipo_Pessoa = 'tipo_pessoa';
   SField_Tipo_Usuario = 'tipo_usuario';
   SField_Tipo_Colaborador = 'tipo_colaborador';
   SField_Token_API_Google = 'token_api_google';
   SField_Token_API_Google_ExpiresIn = 'token_api_google_expiresin';

   SField_UserName = 'user_name';

   SField_Version = 'version';

{$ENDREGION}

{$REGION '| TABLES |'}
   STable_Empresa = 't_empresa';
   STable_Usuario = 't_usuario';
   STable_Usuario_Access = 't_usuario_access';
   STable_Application_Data = 't_appplication_data';
{$ENDREGION}

{$REGION '| COMMENTS |'}
   STable_Empresa_Comment = 'Registros de Empresas';
   STable_Usuario_Comment = 'Registros de Usuários';
   STable_Usuario_Access_Comment = 'Registros de Acessos de Usuários';
   STable_ApplicationData_Comment = 'Application[Data]';
{$ENDREGION}

implementation

end.

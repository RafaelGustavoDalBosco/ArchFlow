unit App.DataBase.Consts;

interface

const


{$REGION '| PG CONSTS |'}
   cPGUserName = 'postgres';
   cPGPassWord = 'postgres';
   cMainSchemaName = 'public';
{$ENDREGION}

{$REGION '| FIELDS |'}

  {$REGION 'A'}
    SField_Active = 'active';
  {$ENDREGION}

  {$REGION 'C'}
    SField_Can_Access = 'can_access';
    SField_Can_Delete = 'can_delete';
    SField_Can_Insert = 'can_insert';
    SField_Can_Update = 'can_update';
    SField_CpfCnpj = 'cpf_cnpj';
    SField_Class_Parent_Name = 'class_parent_name';
  {$ENDREGION}

  {$REGION 'D'}
    SField_Data_Fim_Contrato = 'data_fim_contrato';
    SField_Descricao = 'descricao';
  {$ENDREGION}

  {$REGION 'E'}
    SField_Expiration_Date = 'expiration_date';
  {$ENDREGION}

  {$REGION 'F'}
    SField_FieldLength = 'field_length';
    SField_FieldName = 'field_name';
    SField_FieldType = 'field_type';
    SField_FKField = 'fk_field';
    SField_Form_Class = 'form_class';
  {$ENDREGION}

  {$REGION 'G'}
    SField_GoogleWorkSpace = 'google_work_space';
  {$ENDREGION}

  {$REGION 'I'}
    SField_Id = 'id';
    SField_Id_Empresa = 'id_empresa';
    SField_Id_Imediato = 'id_imediato';
    SField_Id_Usuario = 'id_usuario';
    SField_Is_Null = 'is_null';
    SField_Id_Record = 'id_record';
  {$ENDREGION}

  {$REGION 'L'}
    SField_Last_Updated_Date = 'last_updated_date';
    SField_Logo = 'logo';
  {$ENDREGION}

  {$REGION 'N'}
    SField_Nome = 'nome';
    SField_Nome_Fantasia = 'nome_fantasia';
    SField_Numeric_Precision = 'numeric_precision';
  {$ENDREGION}

  {$REGION 'O'}
    SField_Owner_Id = 'owner_id';
    SField_Owner_Type = 'owner_type';
  {$ENDREGION}

  {$REGION 'P'}
    SField_PassWord = 'pass_word';
  {$ENDREGION}

  {$REGION 'R'}
    SField_RazaoSocial = 'razao_social';
    SField_Reference_Table = 'reference_table';
    SField_Remuneracao = 'remuneracao';
  {$ENDREGION}

  {$REGION 'S'}
    SField_Scale = 'scale';
  {$ENDREGION}

  {$REGION 'T'}
    SField_Tipo_Colaborador = 'tipo_colaborador';
    SField_Tipo_Pessoa = 'tipo_pessoa';
    SField_Tipo_Usuario = 'tipo_usuario';
    SField_Token_API_Google = 'token_api_google';
    SField_Token_API_Google_ExpiresIn = 'token_api_google_expiresin';
  {$ENDREGION}

  {$REGION 'U'}
    SField_UserName = 'user_name';
  {$ENDREGION}

  {$REGION 'V'}
    SField_Version = 'version';
  {$ENDREGION}

{$ENDREGION}

{$REGION '| TABLES |'}
   STable_Empresa = 't_empresa';
   STable_Usuario = 't_usuario';
   STable_Usuario_Access = 't_usuario_access';
   STable_Application_Data = 't_appplication_data';
   STable_Common_Blocker = 't_common_blocker';
{$ENDREGION}

{$REGION '| COMMENTS |'}
   STable_Empresa_Comment = 'Registros de Empresas';
   STable_Usuario_Comment = 'Registros de Usuários';
   STable_Usuario_Access_Comment = 'Registros de Acessos de Usuários';
   STable_ApplicationData_Comment = 'Application[Data]';
   STable_Common_Blocker_Comment = 'Bloqueio padrão de registros';
{$ENDREGION}

implementation

end.

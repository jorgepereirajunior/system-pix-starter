unit SystemPixApi.ConfigFile.Constants;

interface

const
  CONFIG_FILE_PHYSICAL     = 'PointOfSaleConfig.ini';


  RECEIVER_CONFIG_SECTION  = 'RECEBEDOR';
  RECEIVER_CONFIG_KEY_NAME = 'Nome';
  RECEIVER_CONFIG_KEY_CEP  = 'Cep';
  RECEIVER_CONFIG_KEY_CITY = 'Cidade';
  RECEIVER_CONFIG_KEY_UF   = 'UF';


  REQUESTED_BILLING_CONFIG_SECTION  = 'COBRANCA_REQUISITADA';
  REQUESTED_BILLING_CONFIG_KEY_NAME = 'Expiracao';


  PSP_BB_CONFIG_SECTION               = 'BancoBrasil';
  PSP_BB_CONFIG_KEY_KEYPIX            = 'ChavePIX';
  PSP_BB_CONFIG_KEY_CLIENT_ID         = 'ClientID';
  PSP_BB_CONFIG_KEY_CLIENT_SECRET     = 'ClientSecret';
  PSP_BB_CONFIG_KEY_DEVELOPER_APP_KEY = 'DeveloperApplicationKey';

implementation

end.

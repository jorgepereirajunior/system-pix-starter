unit SystemPixApp.SaleScreen.Functions;

interface

uses
  Vcl.Dialogs,

  ACBrBase,
  ACBrPIXBase,
  ACBrPIXCD,
  ACBrPIXPSPBancoDoBrasil;

type
  TSaleFunctions = class
    private
    public
      class procedure SetPspBBInitialConfiguration;
      class procedure SetReceiverInformation;

  end;

implementation

{ TSaleFunctions }

uses
  SystemPixApp.Sales.Screen,

  SystemPixApi.ConfigFile.Functions,
  SystemPixApi.ConfigFile.Constants;


class procedure TSaleFunctions.SetPspBBInitialConfiguration;
begin
  PSPBancoBrasil.ACBrPixCD   := PIXComponent;
  PSPBancoBrasil.APIVersion  := ver262;
  PSPBancoBrasil.BBAPIVersao := apiVersao2;
  PSPBancoBrasil.AboutACBr   := ACBrAbout;
  PSPBancoBrasil.Scopes      := [scCobWrite, scCobRead, scPixWrite, scPixRead];

  PSPBancoBrasil.ChavePIX                := TApiConfigFileFunctions.ReadStringValue(PSP_BB_CONFIG_SECTION, PSP_BB_CONFIG_KEY_KEYPIX);
  PSPBancoBrasil.ClientID                := TApiConfigFileFunctions.ReadStringValue(PSP_BB_CONFIG_SECTION, PSP_BB_CONFIG_KEY_CLIENT_ID);
  PSPBancoBrasil.ClientSecret            := TApiConfigFileFunctions.ReadStringValue(PSP_BB_CONFIG_SECTION, PSP_BB_CONFIG_KEY_CLIENT_SECRET);
  PSPBancoBrasil.DeveloperApplicationKey := TApiConfigFileFunctions.ReadStringValue(PSP_BB_CONFIG_SECTION, PSP_BB_CONFIG_KEY_DEVELOPER_APP_KEY);
end;




class procedure TSaleFunctions.SetReceiverInformation;
begin
  PIXComponent.Recebedor.Nome   := TApiConfigFileFunctions.ReadStringValue(RECEIVER_CONFIG_SECTION, RECEIVER_CONFIG_KEY_NAME);
  PIXComponent.Recebedor.Cidade := TApiConfigFileFunctions.ReadStringValue(RECEIVER_CONFIG_SECTION, RECEIVER_CONFIG_KEY_CITY);
  PIXComponent.Recebedor.CEP    := TApiConfigFileFunctions.ReadStringValue(RECEIVER_CONFIG_SECTION, RECEIVER_CONFIG_KEY_CEP);
  PIXComponent.Recebedor.UF     := TApiConfigFileFunctions.ReadStringValue(RECEIVER_CONFIG_SECTION, RECEIVER_CONFIG_KEY_UF);
end;

end.

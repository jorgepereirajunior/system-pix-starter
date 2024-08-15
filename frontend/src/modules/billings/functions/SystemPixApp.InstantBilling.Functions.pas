unit SystemPixApp.InstantBilling.Functions;

interface

type
  TAppInstantBillingFunctions = class
    private

    public
      class function CreationWasSuccessful: boolean;
      class function ExistsWithID(BillingID: string): boolean;
  end;

implementation

{ TInstantBillingFunctions }

uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.QRCode.Screen;


class function TAppInstantBillingFunctions.CreationWasSuccessful: boolean;
begin
  result := PIXComponent.PSP.epCob.CriarCobrancaImediata;
end;




class function TAppInstantBillingFunctions.ExistsWithID(BillingID: string): boolean;
begin
  result := PIXComponent.PSP.epCob.ConsultarCobrancaImediata(BillingID, 0);
end;

end.

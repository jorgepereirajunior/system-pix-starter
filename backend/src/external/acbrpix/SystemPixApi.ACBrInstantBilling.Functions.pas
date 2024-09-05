unit SystemPixApi.ACBrInstantBilling.Functions;

interface

type
  TApiACBrInstantBillingFunctions = class
    private

    public
      class function CreationWasSuccessful: boolean;
      class function ExistsWithID(BillingID: string): boolean;

  end;

implementation

uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.QRCode.Screen;

{ TApiACBrInstantBillingFunctions }

class function TApiACBrInstantBillingFunctions.CreationWasSuccessful: boolean;
begin
  result := PIXComponent.PSP.epCob.CriarCobrancaImediata;
end;


class function TApiACBrInstantBillingFunctions.ExistsWithID(BillingID: string): boolean;
begin
  result := PIXComponent.PSP.epCob.ConsultarCobrancaImediata(BillingID, 0);
end;


end.

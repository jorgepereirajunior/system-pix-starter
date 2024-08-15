unit SystemPixApp.RevisedBilling.Functions;

interface

uses
  ACBrPIXBase;

type
  TAppRevisedBillingFunctions = class
    private

    public
//      class procedure Clear;
//      class procedure SetExpiration(AExpiration: integer);
//      class procedure SetKeyPix(AKeyPix: string);
//      class procedure SetValue(AValue: real);

      class procedure UpdateStatus;

  end;

implementation

{ TRevisedBillingFunctions }

uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.QRCode.Screen;

class procedure TAppRevisedBillingFunctions.UpdateStatus;
begin
  PIXComponent.PSP.epCob.CobRevisada.status := stcREMOVIDA_PELO_USUARIO_RECEBEDOR;
end;

end.

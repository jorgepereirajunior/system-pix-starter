unit SystemPixApi.ACBrRequestBilling.Functions;

interface

type
  TApiACBrRequestBillingFunctions = class
    private

    public

      class procedure ConfigRequesteFields(expiration: integer; key: string; amount: real);
  end;

implementation

uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.QRCode.Screen;

{ TApiACBrRequestBillingFunctions }

class procedure TApiACBrRequestBillingFunctions.ConfigRequesteFields(
  expiration: integer; key: string; amount: real
);
begin
  with (PIXComponent.PSP.epCob.CobSolicitada) do begin

    Clear;
    calendario.expiracao := expiration;
    chave                := key;
    valor.original       := amount;

  end;

  CurrentBilling.Key := PIXComponent.PSP.ChavePIX;
end;

end.

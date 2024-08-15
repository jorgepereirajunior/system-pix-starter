unit SystemPixApp.RequestedBilling.Functions;

interface

uses
  System.SysUtils,

  Vcl.Dialogs;

type
  TAppRequestedBillingFunctions = class
    private

    public
      class procedure Clear;
      class procedure SetExpiration(AExpiration: integer);
      class procedure SetKeyPix(AKeyPix: string);
      class procedure SetValue(AValue: real);

  end;

implementation

uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.QRCode.Screen;

{ TRequestedBillingFunctions }


class procedure TAppRequestedBillingFunctions.Clear;
begin
  PIXComponent.PSP.epCob.CobSolicitada.Clear;
end;


class procedure TAppRequestedBillingFunctions.SetExpiration(AExpiration: integer);
begin
  PIXComponent.PSP.epCob.CobSolicitada.calendario.expiracao := AExpiration; //Obrigatório
end;


class procedure TAppRequestedBillingFunctions.SetKeyPix(AKeyPix: string);
begin
  PIXComponent.PSP.epCob.CobSolicitada.chave := AKeyPix; //Obrigatório
end;


class procedure TAppRequestedBillingFunctions.SetValue(AValue: real);
begin
  PIXComponent.PSP.epCob.CobSolicitada.valor.original := AValue; //Obrigatório
end;

end.

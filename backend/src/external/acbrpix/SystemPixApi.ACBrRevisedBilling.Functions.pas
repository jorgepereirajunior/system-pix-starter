unit SystemPixApi.ACBrRevisedBilling.Functions;

interface

uses
  System.SysUtils,

  Vcl.Dialogs,

  ACBrPIXBase;

type
  TApiACBrRevisedBillingFunctions = class
    private

    public
      class procedure UpdateStatus;

      class function CancelWasSuccessful: boolean;
  end;

implementation

uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.QRCode.Screen;

{ TApiACBrRevisedBillingFunctions }

class procedure TApiACBrRevisedBillingFunctions.UpdateStatus;
begin
  PIXComponent.PSP.epCob.CobRevisada.status := stcREMOVIDA_PELO_USUARIO_RECEBEDOR;
end;




class function TApiACBrRevisedBillingFunctions.CancelWasSuccessful: boolean;
begin
  result := PIXComponent.PSP.epCob.RevisarCobrancaImediata(CurrentBilling.TxID);
end;




end.

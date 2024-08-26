unit SystemPixApi.ACBrRevisedBilling.Functions;

interface

uses
  ACBrPIXBase;

type
  TApiACBrRevisedBillingFunctions = class
    private

    public
      class procedure UpdateStatus;
      class function RevisionWasSuccessful: boolean;

  end;
implementation


uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.QRCode.Screen;

{ TApiACBrRevisedBillingFunctions }


class function TApiACBrRevisedBillingFunctions.RevisionWasSuccessful: boolean;
begin
  result := PIXComponent.PSP.epCob.RevisarCobrancaImediata(CurrentBilling.TxID);
end;



class procedure TApiACBrRevisedBillingFunctions.UpdateStatus;
begin
  PIXComponent.PSP.epCob.CobRevisada.status := stcREMOVIDA_PELO_USUARIO_RECEBEDOR;
end;

end.

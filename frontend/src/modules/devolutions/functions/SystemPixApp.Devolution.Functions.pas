unit SystemPixApp.Devolution.Functions;

interface

uses
  System.SysUtils,

  ACBrPIXBase;

type
  TAppDevolutionFunctions = class
    private

    public
      class procedure UpdateCurrentBillingDevolution;

  end;

implementation

uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.QRCode.Screen,

  SystemPixApp.DevolutionEntity,

  SystemPixApp.Devolution.Utils;

{ TAppDevolutionFunctions }

class procedure TAppDevolutionFunctions.UpdateCurrentBillingDevolution;
begin
  CurrentBilling.Pix.Items[0].Devolutions.Items.Add(TAppDevolutionEntity.Create);

  CurrentBilling.Pix.Items[0].Devolutions.Items.Last.ID := PIXComponent.PSP.epPix.Pix.devolucoes[0].id;
  CurrentBilling.Pix.Items[0].Devolutions.Items.Last.RtrID := PIXComponent.PSP.epPix.Pix.devolucoes[0].rtrId;
  CurrentBilling.Pix.Items[0].Devolutions.Items.Last.RequestTime := PIXComponent.PSP.epPix.Pix.devolucoes[0].horario.solicitacao;

  CurrentBilling.Pix.Items[0].Devolutions.Items.Last.Status :=
    TAppDevolutionUtils.PassToInvalidEnumBillingDevolutionStatus(PIXComponent.PSP.epPix.Pix.devolucoes[0].status);

  CurrentBilling.Pix.Items[0].Devolutions.Items.Last.Reason := PIXComponent.PSP.epPix.Pix.devolucoes[0].motivo;
  CurrentBilling.Pix.Items[0].Devolutions.Items.Last.Value := PIXComponent.PSP.epPix.Pix.devolucoes[0].valor;
end;

end.

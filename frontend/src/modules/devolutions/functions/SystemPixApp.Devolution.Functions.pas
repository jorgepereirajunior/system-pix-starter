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

  SystemPixApp.Devolution.Utils,

  SystemPixApi.ConfigFile.Functions;

{ TAppDevolutionFunctions }

class procedure TAppDevolutionFunctions.UpdateCurrentBillingDevolution;
begin
  CurrentBilling.Pix.Items[0].Devolutions.Items.Add(TAppDevolutionEntity.Create);

  CurrentBilling.Pix.Items[0].Devolutions.Items.Last.ID := PIXComponent.PSP.epPix.Devolucao.id;
  CurrentBilling.Pix.Items[0].Devolutions.Items.Last.RtrID := PIXComponent.PSP.epPix.Devolucao.rtrId;
  CurrentBilling.Pix.Items[0].Devolutions.Items.Last.RequestTime := PIXComponent.PSP.epPix.Devolucao.horario.solicitacao;

  CurrentBilling.Pix.Items[0].Devolutions.Items.Last.Status :=
    TAppDevolutionUtils.PassToInvalidEnumBillingDevolutionStatus(PIXComponent.PSP.epPix.Devolucao.status);

  CurrentBilling.Pix.Items[0].Devolutions.Items.Last.Reason := PIXComponent.PSP.epPix.Devolucao.motivo;
  CurrentBilling.Pix.Items[0].Devolutions.Items.Last.Value := PIXComponent.PSP.epPix.Devolucao.valor;

  TApiConfigFileFunctions.WriteStringValue('TERMINAL','ConsoleLogDevolutionID', CurrentBilling.Pix.Items[0].Devolutions.Items[0].ID);
  TApiConfigFileFunctions.WriteStringValue('TERMINAL','ConsoleLogDevolutionRtID', CurrentBilling.Pix.Items[0].Devolutions.Items[0].RtrID);
end;

end.

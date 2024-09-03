unit SystemPixApp.Pix.Functions;

interface

type
  TPixFunctions = class
    private

    public
      class function  PixExistsWithEndToEnd(AE2E: string): boolean;
      class procedure UpdateCurrentBillingPix;

  end;

implementation

uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.QRCode.Screen,

  SystemPixApp.PixEntity,

  SystemPixApi.ConfigFile.Functions;

{ TPixFunctions }

class function TPixFunctions.PixExistsWithEndToEnd(AE2E: string): boolean;
begin
  result := PIXComponent.PSP.epPix.ConsultarPix(AE2E);
end;


class procedure TPixFunctions.UpdateCurrentBillingPix;
begin
  CurrentBilling.Pix.Items.Add(TPixEntity.Create);

  CurrentBilling.Pix.Items.Last.BillingTxID := PIXComponent.PSP.epCob.CobCompleta.pix[0].txid;
  CurrentBilling.Pix.Items.Last.EndToEndId  := PIXComponent.PSP.epCob.CobCompleta.pix[0].endToEndId;
  CurrentBilling.Pix.Items.Last.Key         := PIXComponent.PSP.epCob.CobCompleta.pix[0].chave;
  CurrentBilling.Pix.Items.Last.Value       := PIXComponent.PSP.epCob.CobCompleta.pix[0].valor;
  CurrentBilling.Pix.Items.Last.PaydAt      := PIXComponent.PSP.epCob.CobCompleta.pix[0].horario;

  TApiConfigFileFunctions.WriteStringValue('TERMINAL','ConsoleLogPixE2E', CurrentBilling.Pix.Items[0].EndToEndId);
end;


end.

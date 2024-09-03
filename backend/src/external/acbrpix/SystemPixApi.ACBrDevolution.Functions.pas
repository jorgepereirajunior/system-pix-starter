unit SystemPixApi.ACBrDevolution.Functions;

interface

uses
  System.SysUtils,

  Vcl.Dialogs,

  ACBrPIXBase;

type
  TApiACBrDevolutionFunctions = class
    private

    public
      class procedure ConfigRequesteFields(ADescription: string; ANature: TACBrPIXNaturezaDevolucao; AAMount: real);
      class procedure UpdateStatus;

      class function RequestDevolutionWasSuccessful: boolean;

      class function ExistsWithE2E(CurrentBillingPixE2E: string): boolean;
  end;
implementation


uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.QRCode.Screen;

{ TApiACBrRevisedBillingFunctions }


class procedure TApiACBrDevolutionFunctions.ConfigRequesteFields(ADescription: string; ANature: TACBrPIXNaturezaDevolucao; AAMount: real);
begin
  with (PIXComponent.PSP.epPix.DevolucaoSolicitada) do begin
    Clear;
    descricao := ADescription;
    natureza  := ANature;
    valor     := AAMount;
  end;
end;




class function TApiACBrDevolutionFunctions.RequestDevolutionWasSuccessful: boolean;
begin
  //ShowMessage('E2E na requisicao: ' +CurrentBilling.Pix.Items[0].EndToEndId);
  //ATÉ AQUI O E2E ESTÁ OK, CHEGANDO CORRETAMENTE DE ACORDO COM O CONSOLE.LOG
  result := PIXComponent.PSP.epPix.SolicitarDevolucaoPix(
    CurrentBilling.Pix.Items[0].EndToEndId,
    StringReplace(CurrentBilling.Pix.Items[0].endToEndId, 'E','D', [rfReplaceAll])
  );
end;




class function TApiACBrDevolutionFunctions.ExistsWithE2E(CurrentBillingPixE2E: string): boolean;
begin
  result := PIXComponent.PSP.epPix.ConsultarPix(CurrentBillingPixE2E);
end;


class procedure TApiACBrDevolutionFunctions.UpdateStatus;
begin
  PIXComponent.PSP.epCob.CobRevisada.status := stcREMOVIDA_PELO_USUARIO_RECEBEDOR;
end;

end.

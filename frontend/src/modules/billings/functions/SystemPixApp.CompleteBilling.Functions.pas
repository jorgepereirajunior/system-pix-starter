unit SystemPixApp.CompleteBilling.Functions;

interface

uses
  System.SysUtils,

  Vcl.Dialogs,

  ACBrPIXBase;

type
  TAppCompleteBillingFunctions = class
    private

    public
//      class procedure Clear;
      class procedure UpdateExists;
      class procedure UpdateTxID;
      class procedure UpdateLocation;
      class procedure UpdateStatus;
      class procedure UpdateValue;
      class procedure UpdateCopyAndPaste;

      class procedure UpdateAll;

      class procedure UpdateAllPix;
      class function PixExistsWithEndToEnd(AE2E: string): boolean;

      class procedure ClearDevolution;
      class procedure UpdateAllDevolution;

      class procedure SetDevolutionDescription(ADescription: string);
      class procedure SetDevolutionValue(AValue: real);
      class procedure SetDevolutionNature(ANature: TACBrPIXNaturezaDevolucao);

      class function RequestDevolutionWasSuccessful: boolean;

  end;

implementation

uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.QRCode.Screen,

  SystemPixApp.CompleteBillingEntity,
  PointOfSale.PixEntity,
  PointOfSale.DevolutionEntity;

{ TCompletBillingFunctions }


class procedure TAppCompleteBillingFunctions.UpdateAll;
begin
  UpdateExists;
  UpdateTxID;
  UpdateLocation;
  UpdateStatus;
  UpdateValue;
  UpdateCopyAndPaste;
end;






class procedure TAppCompleteBillingFunctions.UpdateExists;
begin
  CompletedBilling.Exists := not PIXComponent.PSP.epCob.CobCompleta.IsEmpty;
end;




class procedure TAppCompleteBillingFunctions.UpdateTxID;
begin
  CompletedBilling.TxID := PIXComponent.PSP.epCob.CobCompleta.txId;
end;



class procedure TAppCompleteBillingFunctions.UpdateLocation;
begin
  CompletedBilling.Location := PIXComponent.PSP.epCob.CobCompleta.location;
end;




class procedure TAppCompleteBillingFunctions.UpdateStatus;
begin
  CompletedBilling.Status := PIXComponent.PSP.epCob.CobCompleta.status;
end;



class procedure TAppCompleteBillingFunctions.UpdateValue;
begin
  CompletedBilling.Value := PIXComponent.PSP.epCob.CobCompleta.valor.original;
end;



class procedure TAppCompleteBillingFunctions.UpdateCopyAndPaste;
begin
  CompletedBilling.CopyAndPaste := PIXComponent.PSP.epCob.CobCompleta.pixCopiaECola;
end;





class procedure TAppCompleteBillingFunctions.UpdateAllPix;
begin

  CompletedBilling.Pix.Items.Add(TCompletedBillingPixEntity.Create);

  CompletedBilling.HasPix                    := true;

  CompletedBilling.Pix.Items.Last.TxID       := PIXComponent.PSP.epCob.CobCompleta.pix[0].txid;
  CompletedBilling.Pix.Items.Last.EndToEndId := PIXComponent.PSP.epCob.CobCompleta.pix[0].endToEndId;
  CompletedBilling.Pix.Items.Last.Key        := PIXComponent.PSP.epCob.CobCompleta.pix[0].chave;
  CompletedBilling.Pix.Items.Last.Value      := PIXComponent.PSP.epCob.CobCompleta.pix[0].valor;
  CompletedBilling.Pix.Items.Last.Time       := PIXComponent.PSP.epCob.CobCompleta.pix[0].horario;
end;



class function TAppCompleteBillingFunctions.PixExistsWithEndToEnd(AE2E: string): boolean;
begin
  result := PIXComponent.PSP.epPix.ConsultarPix(AE2E);
end;





class procedure TAppCompleteBillingFunctions.ClearDevolution;
begin
  PIXComponent.PSP.epPix.DevolucaoSolicitada.Clear;
end;


class procedure TAppCompleteBillingFunctions.UpdateAllDevolution;
begin
//  CompletedBilling.Pix.Items[0].Devolutions.Items.Clear;
  CompletedBilling.Pix.Items[0].Devolutions.Items.Add(TDevolutionEntity.Create);

  CompletedBilling.Pix.HasDevolution                          := true;
  CompletedBilling.Pix.Items[0].Devolutions.Items.Last.ID     := PIXComponent.PSP.epPix.Pix.devolucoes[0].id;
  CompletedBilling.Pix.Items[0].Devolutions.Items.Last.RtrID  := PIXComponent.PSP.epPix.Pix.devolucoes[0].rtrId;
  CompletedBilling.Pix.Items[0].Devolutions.Items.Last.Time   := PIXComponent.PSP.epPix.Pix.devolucoes[0].horario.liquidacao;
  CompletedBilling.Pix.Items[0].Devolutions.Items.Last.Status := PIXComponent.PSP.epPix.Pix.devolucoes[0].status;
  CompletedBilling.Pix.Items[0].Devolutions.Items.Last.Reason := PIXComponent.PSP.epPix.Pix.devolucoes[0].motivo;
end;







class procedure TAppCompleteBillingFunctions.SetDevolutionDescription(ADescription: string);
begin
  PIXComponent.PSP.epPix.DevolucaoSolicitada.descricao := ADescription;
end;




class procedure TAppCompleteBillingFunctions.SetDevolutionValue(AValue: real);
begin
  PIXComponent.PSP.epPix.DevolucaoSolicitada.valor := AValue;
end;



class procedure TAppCompleteBillingFunctions.SetDevolutionNature(ANature: TACBrPIXNaturezaDevolucao);
begin
  PIXComponent.PSP.epPix.DevolucaoSolicitada.natureza := ANature;
end;








class function TAppCompleteBillingFunctions.RequestDevolutionWasSuccessful: boolean;
begin
  result := PIXComponent.PSP.epPix.SolicitarDevolucaoPix(
    CompletedBilling.Pix.Items[0].EndToEndId,
    StringReplace(CompletedBilling.Pix.Items[0].endToEndId, 'E','D', [rfReplaceAll])
  );
end;



end.

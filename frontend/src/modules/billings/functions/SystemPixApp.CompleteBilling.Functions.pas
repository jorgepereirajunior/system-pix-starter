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

      class function DevolutionWasSuccessful: boolean;

  end;

implementation

uses
  PointOfSale.Sale.Screen,
  PointOfSale.QRCode.Screen,

  PointOfSale.CompleteBillingEntity,
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
  CompletedBilling.Exists := not PDV_PIX.PSP.epCob.CobCompleta.IsEmpty;
end;




class procedure TAppCompleteBillingFunctions.UpdateTxID;
begin
  CompletedBilling.TxID := PDV_PIX.PSP.epCob.CobCompleta.txId;
end;



class procedure TAppCompleteBillingFunctions.UpdateLocation;
begin
  CompletedBilling.Location := PDV_PIX.PSP.epCob.CobCompleta.location;
end;




class procedure TAppCompleteBillingFunctions.UpdateStatus;
begin
  CompletedBilling.Status := PDV_PIX.PSP.epCob.CobCompleta.status;
end;



class procedure TAppCompleteBillingFunctions.UpdateValue;
begin
  CompletedBilling.Value := PDV_PIX.PSP.epCob.CobCompleta.valor.original;
end;



class procedure TAppCompleteBillingFunctions.UpdateCopyAndPaste;
begin
  CompletedBilling.CopyAndPaste := PDV_PIX.PSP.epCob.CobCompleta.pixCopiaECola;
end;





class procedure TAppCompleteBillingFunctions.UpdateAllPix;
begin

  CompletedBilling.Pix.Items.Add(TCompletedBillingPixEntity.Create);

  CompletedBilling.HasPix                    := true;

  CompletedBilling.Pix.Items.Last.TxID       := PDV_PIX.PSP.epCob.CobCompleta.pix[0].txid;
  CompletedBilling.Pix.Items.Last.EndToEndId := PDV_PIX.PSP.epCob.CobCompleta.pix[0].endToEndId;
  CompletedBilling.Pix.Items.Last.Key        := PDV_PIX.PSP.epCob.CobCompleta.pix[0].chave;
  CompletedBilling.Pix.Items.Last.Value      := PDV_PIX.PSP.epCob.CobCompleta.pix[0].valor;
  CompletedBilling.Pix.Items.Last.Time       := PDV_PIX.PSP.epCob.CobCompleta.pix[0].horario;
end;



class function TAppCompleteBillingFunctions.PixExistsWithEndToEnd(AE2E: string): boolean;
begin
  result := PDV_PIX.PSP.epPix.ConsultarPix(AE2E);
end;





class procedure TAppCompleteBillingFunctions.ClearDevolution;
begin
  PDV_PIX.PSP.epPix.DevolucaoSolicitada.Clear;
end;


class procedure TAppCompleteBillingFunctions.UpdateAllDevolution;
begin
//  CompletedBilling.Pix.Items[0].Devolutions.Items.Clear;
  CompletedBilling.Pix.Items[0].Devolutions.Items.Add(TDevolutionEntity.Create);

  CompletedBilling.Pix.HasDevolution                          := true;
  CompletedBilling.Pix.Items[0].Devolutions.Items.Last.ID     := PDV_PIX.PSP.epPix.Pix.devolucoes[0].id;
  CompletedBilling.Pix.Items[0].Devolutions.Items.Last.RtrID  := PDV_PIX.PSP.epPix.Pix.devolucoes[0].rtrId;
  CompletedBilling.Pix.Items[0].Devolutions.Items.Last.Time   := PDV_PIX.PSP.epPix.Pix.devolucoes[0].horario.liquidacao;
  CompletedBilling.Pix.Items[0].Devolutions.Items.Last.Status := PDV_PIX.PSP.epPix.Pix.devolucoes[0].status;
  CompletedBilling.Pix.Items[0].Devolutions.Items.Last.Reason := PDV_PIX.PSP.epPix.Pix.devolucoes[0].motivo;
end;







class procedure TCompleteBillingFunctions.SetDevolutionDescription(ADescription: string);
begin
  PDV_PIX.PSP.epPix.DevolucaoSolicitada.descricao := ADescription;
end;




class procedure TCompleteBillingFunctions.SetDevolutionValue(AValue: real);
begin
  PDV_PIX.PSP.epPix.DevolucaoSolicitada.valor := AValue;
end;



class procedure TCompleteBillingFunctions.SetDevolutionNature(ANature: TACBrPIXNaturezaDevolucao);
begin
  PDV_PIX.PSP.epPix.DevolucaoSolicitada.natureza := ANature;
end;








class function TCompleteBillingFunctions.DevolutionWasSuccessful: boolean;
begin
  result := PDV_PIX.PSP.epPix.SolicitarDevolucaoPix(
    CompletedBilling.Pix.Items[0].EndToEndId,
    StringReplace(CompletedBilling.Pix.Items[0].endToEndId, 'E','D', [rfReplaceAll])
  );
end;



end.

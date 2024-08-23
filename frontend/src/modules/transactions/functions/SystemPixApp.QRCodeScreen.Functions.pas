unit SystemPixApp.QRCodeScreen.Functions;

interface

uses
  System.Classes,
  System.SysUtils,

  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Controls,

  ACBrBase,
  ACBrPIXBase,
  ACBrImage,
  ACBrDelphiZXingQRCode,

  SystemPixApp.PaymentStatusEntity;

type
  TButtonVisibility = (IS_VISIBLE, IS_HIDDEN);
  TButtonStyle      = (IS_PRIMARY, IS_SECONDARY);

  TQRCodeScreenFunctions = class
    private

    public
      class procedure ReviewInstantBilling;

      class procedure CreateNewInstantBilling;
      class procedure CheckCurrentBilling;

      class procedure CreateNewBillingDevolution;
      class procedure CheckCurrentBillingDevolution;

      class procedure OpenReadQRCodeModal;
      class procedure HandleOpenCancelPaymentModal(Sender: TObject);

  end;

implementation

uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.QRCode.Screen,

  SystemPixApp.CancelBilling.Modal,

  SystemPixApi.ACBrRequestBilling.Functions,
  SystemPixApi.ACBrInstantBilling.Functions,

  SystemPixApp.InstantBillingEntities,
  SystemPixApp.BillingEntity,

  SystemPixApp.InstantBilling.Functions,
  SystemPixApp.CompleteBilling.Functions,
  SystemPixApp.RevisedBilling.Functions,
  SystemPixApp.GeneratedBilling.Functions,
  SystemPixApp.CurrentBillingAsGenerated.Functions,
  SystemPixApp.CurrentBillingAsCompleted.Functions,


  SystemPixApi.ConfigFile.Functions,
  SystemPixApi.LogErrorFile.Functions,

  SystemPixApp.Styles,
  SystemPixApp.Constants;

{ TQRCodeFunctions }


class procedure TQRCodeScreenFunctions.CreateNewInstantBilling;

var
  LogFile: TextFile;

begin
  TApiACBrRequestBillingFunctions.ConfigRequesteFields(
    CurrentBilling.Expiration,
    PIXComponent.PSP.ChavePIX,
    CurrentBilling.Value
  );


  if (TAppInstantBillingFunctions.CreationWasSuccessful) then begin

    TAppGeneratedBillingFunctions.UpdateAll;

    TAppCurrentBillingAsGeneratedFunctions.UpdateAll;

  end else begin

    TApiLogErrorFileFunctions.RegisterLastErrorInstantBilling(PSPBancoBrasil.epCob.Problema.detail);
  end;

end;




class procedure TQRCodeScreenFunctions.CreateNewBillingDevolution;
begin
  TAppCompleteBillingFunctions.ClearDevolution;

  TAppCompleteBillingFunctions.SetDevolutionValue(CompletedBilling.Value);

  TAppCompleteBillingFunctions.SetDevolutionNature(ndORIGINAL);

  if (TAppCompleteBillingFunctions.RequestDevolutionWasSuccessful) then begin


  end else begin

    ShowMessage('Não foi possível extornar o pagamento');
  end;
end;





class procedure TQRCodeScreenFunctions.CheckCurrentBillingDevolution;
begin
  if (PIXComponent.PSP.epPix.ConsultarPix(CompletedBilling.Pix.Items[0].EndToEndId)) then begin

    TAppCompleteBillingFunctions.UpdateAllDevolution;

  end;
end;

class procedure TQRCodeScreenFunctions.CheckCurrentBilling;
begin
  if (TApiACBrInstantBillingFunctions.ExistsWithID(CurrentBilling.TxID)) then begin

    TAppCurrentBillingAsCompletedFunctions.UpdateAll;
    TAppCurrentBillingAsCompletedFunctions.UpdateIsChecked(true);

  end else begin

    ShowMessage('Ainda não tem, atualize antes');
  end;

end;






class procedure TQRCodeScreenFunctions.ReviewInstantBilling;
begin
  TAppRevisedBillingFunctions.UpdateStatus;

//  RevisedBilling.Status := PDV_PIX.PSP.epCob.CobRevisada.status;

//  if (PIXComponent.PSP.epCob.RevisarCobrancaImediata(GeneratedBilling.TxID)) then
//    ShowMessage('Chave revisar: ' +PIXComponent.PSP.epCob.CobRevisada.chave)
//  else
//    ShowMessage('Erro revisar: ' +PIXComponent.PSP.epCob.Problema.detail);
end;






class procedure TQRCodeScreenFunctions.HandleOpenCancelPaymentModal(Sender: TObject);

var
  ActionProcedure: TProc;

begin
  ActionProcedure := procedure begin
    ReviewInstantBilling;
  end;

  CancelBillingModal := TCancelBillingModal.Create(
    Application,
    'Deseja cancelar o pagamento ?',
    ActionProcedure
  );

  CancelBillingModal.Position := poScreenCenter;
  CancelBillingModal.ShowModal;

end;




class procedure TQRCodeScreenFunctions.OpenReadQRCodeModal;
begin

  if (GeneratedBilling.Exists) then begin

    QRCodeScreen := TQRCodeScreen.Create(Application);

    QRCodeScreen.Position := poScreenCenter;
    QRCodeScreen.ShowModal;

  end else begin

    ShowMessage('Erro ao criar! Não abrir tela de QRCode');
    exit;
  end;

end;


end.

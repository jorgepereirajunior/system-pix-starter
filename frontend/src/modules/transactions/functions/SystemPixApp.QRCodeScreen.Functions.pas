unit SystemPixApp.QRCodeScreen.Functions;

interface

uses
  System.Classes,
  System.SysUtils,
  System.TypInfo,

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
  SystemPixApi.ACBrDevolution.Functions,

  SystemPixApp.InstantBillingEntities,
  SystemPixApp.BillingEntity,

  SystemPixApp.InstantBilling.Functions,
  SystemPixApp.CompleteBilling.Functions,
  SystemPixApp.RevisedBilling.Functions,
  SystemPixApp.GeneratedBilling.Functions,
  SystemPixApp.CurrentBillingAsGenerated.Functions,
  SystemPixApp.CurrentBillingAsCompleted.Functions,
  SystemPixApp.CurrentBillingAsRevised.Functions,

  SystemPixApp.Devolution.Functions,

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


  if (TApiACBrInstantBillingFunctions.CreationWasSuccessful) then begin

//    TAppGeneratedBillingFunctions.UpdateAll;

    TAppCurrentBillingAsGeneratedFunctions.UpdateAll;

    TQRCodeScreenFunctions.OpenReadQRCodeModal;

  end else begin
    ShowMessage('Falha da API ao tentar criar nova Cobrança Imediata');

    TApiLogErrorFileFunctions.RegisterLastErrorInstantBilling(PSPBancoBrasil.epCob.Problema.detail);
  end;

end;




class procedure TQRCodeScreenFunctions.CreateNewBillingDevolution;
begin
  TApiACBrDevolutionFunctions.ConfigRequesteFields(
    '',
    ndORIGINAL,
    CurrentBilling.Value
  );


  if (TApiACBrDevolutionFunctions.RequestDevolutionWasSuccessful) then begin


  end else begin

    ShowMessage('Falha da API ao tentar extornar o pagamento');
  end;
end;





class procedure TQRCodeScreenFunctions.CheckCurrentBillingDevolution;
begin
  if (TApiACBrDevolutionFunctions.ExistsWithE2E(CurrentBilling.Pix.Items[0].EndToEndId)) then begin

    TAppDevolutionFunctions.UpdateCurrentBillingDevolution;

  end else begin

    ShowMessage('Falha da API ao tentar consultar devolução');
  end;
end;

class procedure TQRCodeScreenFunctions.CheckCurrentBilling;
begin
  if (TApiACBrInstantBillingFunctions.ExistsWithID(CurrentBilling.TxID)) then begin

    TAppCurrentBillingAsCompletedFunctions.UpdateAll;
    TAppCurrentBillingAsCompletedFunctions.UpdateIsChecked(true);

  end else begin

    ShowMessage('Falha da API ao tentar consultar Cobrança Imediata');
  end;
end;






class procedure TQRCodeScreenFunctions.ReviewInstantBilling;
begin
  TApiACBrDevolutionFunctions.UpdateStatus;

  if (not TApiACBrDevolutionFunctions.RequestDevolutionWasSuccessful) then
    ShowMessage('Falha da API ao tentar cancelar Cobrança Imediata');

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

  QRCodeScreen := TQRCodeScreen.Create(Application);

  QRCodeScreen.Position := poScreenCenter;
  QRCodeScreen.ShowModal;

end;

end.

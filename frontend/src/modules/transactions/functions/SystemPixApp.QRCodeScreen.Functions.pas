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
  TQRCodeScreenFunctions = class
    private

    public
      class procedure CancelCurrentBilling;


      class procedure CreateNewBilling;
      class procedure CheckCurrentBilling;

      class procedure ExtornCurrentBilling;
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
  SystemPixApi.ACBrRevisedBilling.Functions,
  SystemPixApi.ACBrDevolution.Functions,

  SystemPixApp.BillingEntity,

  SystemPixApp.CurrentBillingAsGenerated.Functions,
  SystemPixApp.CurrentBillingAsCompleted.Functions,
  SystemPixApp.CurrentBillingAsRevised.Functions,

  SystemPixApp.Devolution.Functions,

  SystemPixApi.ConfigFile.Functions,
  SystemPixApi.LogErrorFile.Functions,

  SystemPixApp.Styles,
  SystemPixApp.Constants;

{ TQRCodeFunctions }


class procedure TQRCodeScreenFunctions.CancelCurrentBilling;
begin
  TApiACBrRevisedBillingFunctions.UpdateStatus;

  if (not TApiACBrRevisedBillingFunctions.CancelWasSuccessful) then
    ShowMessage('Falha da API ao tentar cancelar Cobrança Imediata');
end;







class procedure TQRCodeScreenFunctions.CreateNewBilling;

var
  LogFile: TextFile;

begin
  TApiACBrRequestBillingFunctions.ConfigRequesteFields(
    CurrentBilling.Expiration,
    PIXComponent.PSP.ChavePIX,
    CurrentBilling.Value
  );


  if (TApiACBrInstantBillingFunctions.CreationWasSuccessful) then begin

    TAppCurrentBillingAsGeneratedFunctions.UpdateAll;

    TQRCodeScreenFunctions.OpenReadQRCodeModal;

  end else begin
    ShowMessage('Falha da API ao tentar criar nova Cobrança Imediata');

    TApiLogErrorFileFunctions.RegisterLastErrorInstantBilling(PSPBancoBrasil.epCob.Problema.detail);
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






class procedure TQRCodeScreenFunctions.ExtornCurrentBilling;
begin
  TApiACBrDevolutionFunctions.ConfigRequesteFields(
    '',
    ndORIGINAL,
    CurrentBilling.Value
  );

  if (not TApiACBrDevolutionFunctions.RequestDevolutionWasSuccessful) then
    ShowMessage('Falha da API ao tentar extornar o pagamento');
end;


class procedure TQRCodeScreenFunctions.CheckCurrentBillingDevolution;
begin

  if (TApiACBrDevolutionFunctions.Exists) then begin

    TAppDevolutionFunctions.UpdateCurrentBillingDevolution;

  end else begin

    ShowMessage('Falha da API ao tentar consultar devolução');
  end;
end;

















class procedure TQRCodeScreenFunctions.HandleOpenCancelPaymentModal(Sender: TObject);

var
  ActionProcedure: TProc;

begin
  ActionProcedure := procedure begin
    CancelCurrentBilling;
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

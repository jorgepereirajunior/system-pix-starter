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
      class procedure ReviewInstantBilling;

    public
      class procedure CreateNewInstantBilling;
      class procedure CheckCurrentInstantBilling;

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

  SystemPixApp.InstantBillingEntities,

  SystemPixApp.InstantBilling.Functions,
  SystemPixApp.RequestedBilling.Functions,
  SystemPixApp.CompleteBilling.Functions,
  SystemPixApp.RevisedBilling.Functions,
  SystemPixApp.GeneratedBilling.Functions,

  SystemPixApi.ConfigFile.Functions,
  SystemPixApi.LogErrorFile.Functions,

  SystemPixApp.Styles,
  SystemPixApp.Constants;

{ TQRCodeFunctions }


class procedure TQRCodeScreenFunctions.CreateNewInstantBilling;

var
  LogFile: TextFile;

begin
  TAppRequestedBillingFunctions.Clear;

  TAppRequestedBillingFunctions.SetExpiration(RequestedBilling.Expiration);

  TAppRequestedBillingFunctions.SetKeyPix(PIXComponent.PSP.ChavePIX);

  TAppRequestedBillingFunctions.SetValue(RequestedBilling.Value);


  if (TAppInstantBillingFunctions.CreationWasSuccessful) then begin

    TAppGeneratedBillingFunctions.UpdateAll;

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

class procedure TQRCodeScreenFunctions.CheckCurrentInstantBilling;
begin

  if (TAppInstantBillingFunctions.ExistsWithID(GeneratedBilling.TxID)) then begin

    TAppCompleteBillingFunctions.UpdateAll;

  end;

end;






class procedure TQRCodeScreenFunctions.ReviewInstantBilling;
begin
  TAppRevisedBillingFunctions.UpdateStatus;

//  RevisedBilling.Status := PDV_PIX.PSP.epCob.CobRevisada.status;

  PIXComponent.PSP.epCob.RevisarCobrancaImediata(GeneratedBilling.TxID)
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

unit SystemPixApp.QRCodeScreen.Functions;

interface

uses
  System.Classes,
  System.SysUtils,

  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Clipbrd,
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
      class procedure UpdateCancelPaymentButton(aComponent: TComponent; ButtonVisibility: TButtonVisibility; ButtonStyle: TButtonStyle);
      class procedure UpdateReversalPaymentButton(aComponent: TComponent; ButtonVisibility: TButtonVisibility; ButtonStyle: TButtonStyle);
      class procedure UpdateCloseButton(aComponent: TComponent;ButtonVisibility: TButtonVisibility; ButtonStyle: TButtonStyle; ButtonColor: integer);

      class procedure CreateNewInstantBilling;
      class procedure CheckCurrentInstantBilling;

      class procedure CreateNewBillingDevolution;
      class procedure CheckCurrentBillingDevolution;

      class procedure UpdateBoxPaymentStatus(aComponent: TComponent; aStatusType: TAppPaymentStatus);
      class procedure SetQRCodeArea(aComponent: TComponent);
      class procedure SetCopyPasteArea(aComponent: TComponent);

      class procedure SetBillingData(aComponent: TComponent);

      class procedure OpenReadQRCodeModal;
      class procedure HandleOpenCancelPaymentModal(Sender: TObject);

      class procedure CopyToClipBoard(const Text: string);

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

  SystemPixApp.Styles,
  SystemPixApp.Constants;

{ TQRCodeFunctions }


class procedure TQRCodeScreenFunctions.CreateNewInstantBilling;
begin
  TAppRequestedBillingFunctions.Clear;

  TAppRequestedBillingFunctions.SetExpiration(RequestedBilling.Expiration);

  TAppRequestedBillingFunctions.SetKeyPix(PIXComponent.PSP.ChavePIX);

  TAppRequestedBillingFunctions.SetValue(RequestedBilling.Value);


  if (TAppInstantBillingFunctions.CreationWasSuccessful) then begin

    TAppGeneratedBillingFunctions.UpdateAll;

  end;

end;




class procedure TQRCodeScreenFunctions.CreateNewBillingDevolution;
begin
  TAppCompleteBillingFunctions.ClearDevolution;

  TAppCompleteBillingFunctions.SetDevolutionValue(CompletedBilling.Value);

  TAppCompleteBillingFunctions.SetDevolutionNature(ndORIGINAL);

  if (TAppCompleteBillingFunctions.DevolutionWasSuccessful) then begin


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






class procedure TQRCodeScreenFunctions.UpdateBoxPaymentStatus(aComponent: TComponent; aStatusType: TAppPaymentStatus);

var
  LQRCodeScreen: TQRCodeScreen;

begin
  LQRCodeScreen := TQRCodeScreen(aComponent);

  case (aStatusType) of
    PAY_ON_HOLD: begin
      LQRCodeScreen.LabelPaymentStatus.Font.Size    := 16;
      LQRCodeScreen.LabelPaymentStatus.Font.Style   := [fsBold];
      LQRCodeScreen.LabelPaymentStatus.Font.Color   := clWhite;
      LQRCodeScreen.LabelPaymentStatus.Caption      := PDV_MSG_PAYMENT_ON_HOLD;
      LQRCodeScreen.BoxPaymentStatus.Color          := PDV_COLOR_PAYMENT_ON_HOLD;

      LQRCodeScreen.LabelQRCodeTilte.Font.Color     := PDV_COLOR_PAYMENT_ON_HOLD;
      LQRCodeScreen.LabelCopyNPasteTitle.Font.Color := PDV_COLOR_PAYMENT_ON_HOLD;
    end;

    PAY_MADE_EFFECTIVE: begin
      LQRCodeScreen.LabelPaymentStatus.Font.Size    := 16;
      LQRCodeScreen.LabelPaymentStatus.Font.Style   := [fsBold];
      LQRCodeScreen.LabelPaymentStatus.Font.Color   := clWhite;
      LQRCodeScreen.LabelPaymentStatus.Caption      := PDV_MSG_PAYMENT_EFFECTIVE;
      LQRCodeScreen.BoxPaymentStatus.Color          := PDV_COLOR_PAYMENT_EFFECTIVE;

      LQRCodeScreen.LabelQRCodeTilte.Font.Color     := PDV_COLOR_PAYMENT_EFFECTIVE;
      LQRCodeScreen.LabelCopyNPasteTitle.Font.Color := PDV_COLOR_PAYMENT_EFFECTIVE;
    end;

    PAY_CANCELED: begin
      LQRCodeScreen.LabelPaymentStatus.Font.Size    := 16;
      LQRCodeScreen.LabelPaymentStatus.Font.Style   := [fsBold];
      LQRCodeScreen.LabelPaymentStatus.Font.Color   := clWhite;
      LQRCodeScreen.LabelPaymentStatus.Caption      := PDV_MSG_PAYMENT_CANCELED;
      LQRCodeScreen.BoxPaymentStatus.Color          := PDV_COLOR_PAYMENT_CANCELED;

      LQRCodeScreen.LabelQRCodeTilte.Font.Color     := PDV_COLOR_PAYMENT_CANCELED;
      LQRCodeScreen.LabelCopyNPasteTitle.Font.Color := PDV_COLOR_PAYMENT_CANCELED;
    end;

    PAY_EXTORTED: begin
      LQRCodeScreen.LabelPaymentStatus.Font.Size    := 16;
      LQRCodeScreen.LabelPaymentStatus.Font.Style   := [fsBold];
      LQRCodeScreen.LabelPaymentStatus.Font.Color   := clWhite;
      LQRCodeScreen.LabelPaymentStatus.Caption      := PDV_MSG_PAYMENT_EXTORTED;
      LQRCodeScreen.BoxPaymentStatus.Color          := PDV_COLOR_PAYMENT_EXTORTED;

      LQRCodeScreen.LabelQRCodeTilte.Font.Color     := PDV_COLOR_PAYMENT_EXTORTED;
      LQRCodeScreen.LabelCopyNPasteTitle.Font.Color := PDV_COLOR_PAYMENT_EXTORTED;
    end;
  end;

end;






class procedure TQRCodeScreenFunctions.SetQRCodeArea(aComponent: TComponent);
var
  LQRCodeScreen: TQRCodeScreen;

begin
  LQRCodeScreen := TQRCodeScreen(aComponent);

  LQRCodeScreen.LabelQRCodeTilte.Font.Size  := 18;
  LQRCodeScreen.LabelQRCodeTilte.Font.Style := [fsBold];
  LQRCodeScreen.LabelQRCodeTilte.Caption    := 'QR CODE';
end;




class procedure TQRCodeScreenFunctions.SetCopyPasteArea(aComponent: TComponent);
var
  LQRCodeScreen: TQRCodeScreen;

begin
  LQRCodeScreen := TQRCodeScreen(aComponent);

  LQRCodeScreen.LabelCopyNPasteTitle.Font.Size  := 18;
  LQRCodeScreen.LabelCopyNPasteTitle.Font.Style := [fsBold];
  LQRCodeScreen.LabelCopyNPasteTitle.Caption    := 'PIX COPIA e COLA';
end;




class procedure TQRCodeScreenFunctions.SetBillingData(aComponent: TComponent);

var
  LQRCodeScreen: TQRCodeScreen;

begin
  LQRCodeScreen := TQRCodeScreen(aComponent);

  LQRCodeScreen.CopyNPasteMemo.Lines.Clear;
  LQRCodeScreen.CopyNPasteMemo.Lines.Add(GeneratedBilling.CopyAndPaste);

  TApiConfigFileFunctions.WriteStringValue('TERMINAL','ConsoleLog', GeneratedBilling.TxID);

  PintarQRCode(GeneratedBilling.Location, LQRCodeScreen.QRCodeImage.Picture.Bitmap, qrUTF8BOM);

end;





class procedure TQRCodeScreenFunctions.UpdateCancelPaymentButton(aComponent: TComponent; ButtonVisibility: TButtonVisibility; ButtonStyle: TButtonStyle);

var
  LQRCodeScreen: TQRCodeScreen;

begin
  LQRCodeScreen := TQRCodeScreen(aComponent);

  case (ButtonVisibility) of
    IS_VISIBLE: begin
      LQRCodeScreen.BoxCancelPaymentButton.Visible := true;

      LQRCodeScreen.BoxCancelPaymentButton.Align   := alBottom;
      LQRCodeScreen.BoxCancelPaymentButton.Height  := 40;

      case (ButtonStyle) of
        IS_PRIMARY: begin
          LQRCodeScreen.BGCancelPaymentButton.Brush.Color := PDV_COLOR_PAYMENT_ON_HOLD;
          LQRCodeScreen.CancelPaymentButton.Font.Color    := clWhite;
          LQRCodeScreen.CancelPaymentButton.Font.Style    := [fsBold];
        end;


        IS_SECONDARY: begin
          LQRCodeScreen.BGCancelPaymentButton.Brush.Color := clWhite;
          LQRCodeScreen.BGCancelPaymentButton.Pen.Style := psSolid;
          LQRCodeScreen.BGCancelPaymentButton.Pen.Width := 1;
          LQRCodeScreen.BGCancelPaymentButton.Pen.Color := PDV_COLOR_PAYMENT_ON_HOLD;

          LQRCodeScreen.CancelPaymentButton.Font.Color    := PDV_COLOR_PAYMENT_ON_HOLD;
          LQRCodeScreen.CancelPaymentButton.Font.Style    := [fsBold];
        end;
      end;

    end;

    IS_HIDDEN: begin
      LQRCodeScreen.BoxCancelPaymentButton.Visible := false;
    end;

  end;

end;




class procedure TQRCodeScreenFunctions.UpdateCloseButton(aComponent: TComponent;ButtonVisibility: TButtonVisibility; ButtonStyle: TButtonStyle; ButtonColor: integer);

var
  LQRCodeScreen: TQRCodeScreen;

begin
  LQRCodeScreen := TQRCodeScreen(aComponent);

  case (ButtonVisibility) of
    IS_VISIBLE: begin
      LQRCodeScreen.BoxCloseButton.Visible := true;

      LQRCodeScreen.BoxCloseButton.Align   := alBottom;
      LQRCodeScreen.BoxCloseButton.Height  := 40;

      case (ButtonStyle) of
        IS_PRIMARY: begin
          LQRCodeScreen.BGCloseButton.Brush.Color := ButtonColor;
          LQRCodeScreen.BGCloseButton.Pen.Color   := ButtonColor;
          LQRCodeScreen.CloseButton.Font.Color    := clWhite;
          LQRCodeScreen.CloseButton.Font.Style    := [fsBold];
        end;


        IS_SECONDARY: begin
          LQRCodeScreen.BGCloseButton.Brush.Color := clWhite;
          LQRCodeScreen.BGCloseButton.Pen.Style := psSolid;
          LQRCodeScreen.BGCloseButton.Pen.Width := 1;
          LQRCodeScreen.BGCloseButton.Pen.Color := ButtonColor;

          LQRCodeScreen.CloseButton.Font.Color    := ButtonColor;
          LQRCodeScreen.CloseButton.Font.Style    := [fsBold];
        end;
      end;

    end;

    IS_HIDDEN: begin
      LQRCodeScreen.BoxCloseButton.Visible := false;
    end;

  end;
end;



class procedure TQRCodeScreenFunctions.UpdateReversalPaymentButton(aComponent: TComponent; ButtonVisibility: TButtonVisibility; ButtonStyle: TButtonStyle);

var
  LQRCodeScreen: TQRCodeScreen;

begin
  LQRCodeScreen := TQRCodeScreen(aComponent);

  case (ButtonVisibility) of
    IS_VISIBLE: begin
      LQRCodeScreen.BoxReversalPaymentButton.Visible := true;

      LQRCodeScreen.BoxReversalPaymentButton.Align   := alTop;
      LQRCodeScreen.BoxReversalPaymentButton.Height  := 40;

      case (ButtonStyle) of
        IS_PRIMARY: begin
          LQRCodeScreen.BGReversalButton.Brush.Color := PDV_COLOR_PAYMENT_EFFECTIVE;
          LQRCodeScreen.ReversalButton.Font.Color    := clWhite;
          LQRCodeScreen.ReversalButton.Font.Style    := [fsBold];
        end;


        IS_SECONDARY: begin
          LQRCodeScreen.BGReversalButton.Brush.Color := clWhite;
          LQRCodeScreen.BGReversalButton.Pen.Style   := psSolid;
          LQRCodeScreen.BGReversalButton.Pen.Width   := 1;
          LQRCodeScreen.BGReversalButton.Pen.Color   := PDV_COLOR_PAYMENT_EFFECTIVE;

          LQRCodeScreen.ReversalButton.Font.Color    := PDV_COLOR_PAYMENT_EFFECTIVE;
          LQRCodeScreen.ReversalButton.Font.Style    := [fsBold];
        end;
      end;

    end;

    IS_HIDDEN: begin
      LQRCodeScreen.BoxReversalPaymentButton.Visible := false;
    end;

  end;
end;







class procedure TQRCodeScreenFunctions.CopyToClipBoard(const Text: string);
begin
  Clipboard.AsText := Text;
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

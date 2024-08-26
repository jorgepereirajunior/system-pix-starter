unit SystemPixApp.QRCodeScreen.Utils;

interface

uses
  System.Classes,

  Vcl.Controls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Clipbrd,

  ACBrImage,
  ACBrDelphiZXingQRCode,

  SystemPixApp.PaymentStatusEntity;

type
  TQRCodeScreenActionButtonsVisibility = (IS_VISIBLE, IS_HIDDEN);
  TQRCodeScreenActionButtonsStyle      = (IS_PRIMARY, IS_SECONDARY);

  TQRCodeScreenCopyButtonStatus        = (IS_ENABLED, IS_NOT_ENABLED);

  TQRCodeScreenUtils = class
    private
      class procedure ReviewInstantBilling;

    public
      class procedure BuildMainContent(aComponent: TComponent);

      class procedure UpdateCancelPaymentButton(aComponent: TComponent; ButtonVisibility: TQRCodeScreenActionButtonsVisibility; ButtonStyle: TQRCodeScreenActionButtonsStyle);
      class procedure UpdateReversalPaymentButton(aComponent: TComponent; ButtonVisibility: TQRCodeScreenActionButtonsVisibility; ButtonStyle: TQRCodeScreenActionButtonsStyle);
      class procedure UpdateCloseButton(aComponent: TComponent;ButtonVisibility: TQRCodeScreenActionButtonsVisibility; ButtonStyle: TQRCodeScreenActionButtonsStyle; ButtonColor: integer);

      class procedure UpdateBoxPaymentStatus(aComponent: TComponent; aStatusType: TAppPaymentStatus);

      class procedure SetQRCodeArea(aComponent: TComponent);
      class procedure SetCopyPasteArea(aComponent: TComponent);
      class procedure SetBillingData(aComponent: TComponent);

      class procedure UpdateBillingDataToCanceled(aComponent: TComponent; ButtonStatus: TQRCodeScreenCopyButtonStatus);

      class procedure CopyToClipBoard(const Text: string);

  end;

implementation

{ TQRCodeScreenUtils }

uses
  SystemPixApp.QRCode.Screen,

  SystemPixApi.ConfigFile.Functions,

  SystemPixApp.Styles,
  SystemPixApp.Constants;


class procedure TQRCodeScreenUtils.ReviewInstantBilling;
begin
//
end;







class procedure TQRCodeScreenUtils.BuildMainContent(aComponent: TComponent);

var
  LQRCodeScreen: TQRCodeScreen;

begin
  LQRCodeScreen := TQRCodeScreen(aComponent);

  UpdateBoxPaymentStatus(LQRCodeScreen, PAY_ON_HOLD);
  UpdateCancelPaymentButton(LQRCodeScreen, IS_VISIBLE, IS_PRIMARY);

  SetQRCodeArea(LQRCodeScreen);
  SetCopyPasteArea(LQRCodeScreen);
  SetBillingData(LQRCodeScreen);
end;



class procedure TQRCodeScreenUtils.UpdateCancelPaymentButton(
  aComponent: TComponent;
  ButtonVisibility: TQRCodeScreenActionButtonsVisibility;
  ButtonStyle: TQRCodeScreenActionButtonsStyle
);

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



class procedure TQRCodeScreenUtils.UpdateReversalPaymentButton(
  aComponent: TComponent;
  ButtonVisibility: TQRCodeScreenActionButtonsVisibility;
  ButtonStyle: TQRCodeScreenActionButtonsStyle
);

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



class procedure TQRCodeScreenUtils.UpdateCloseButton(
  aComponent: TComponent;
  ButtonVisibility: TQRCodeScreenActionButtonsVisibility;
  ButtonStyle: TQRCodeScreenActionButtonsStyle; ButtonColor: integer
);

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





class procedure TQRCodeScreenUtils.UpdateBoxPaymentStatus(
  aComponent: TComponent;
  aStatusType: TAppPaymentStatus
);

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





class procedure TQRCodeScreenUtils.SetQRCodeArea(aComponent: TComponent);
var
  LQRCodeScreen: TQRCodeScreen;

begin
  LQRCodeScreen := TQRCodeScreen(aComponent);

  LQRCodeScreen.LabelQRCodeTilte.Font.Size  := 18;
  LQRCodeScreen.LabelQRCodeTilte.Font.Style := [fsBold];
  LQRCodeScreen.LabelQRCodeTilte.Caption    := 'QR CODE';
end;






class procedure TQRCodeScreenUtils.SetCopyPasteArea(aComponent: TComponent);
var
  LQRCodeScreen: TQRCodeScreen;

begin
  LQRCodeScreen := TQRCodeScreen(aComponent);

  LQRCodeScreen.LabelCopyNPasteTitle.Font.Size  := 18;
  LQRCodeScreen.LabelCopyNPasteTitle.Font.Style := [fsBold];
  LQRCodeScreen.LabelCopyNPasteTitle.Caption    := 'PIX COPIA e COLA';
end;




class procedure TQRCodeScreenUtils.SetBillingData(aComponent: TComponent);
var
  LQRCodeScreen: TQRCodeScreen;

begin
  LQRCodeScreen := TQRCodeScreen(aComponent);

  LQRCodeScreen.CopyNPasteMemo.Lines.Clear;
  LQRCodeScreen.CopyNPasteMemo.Lines.Add(CurrentBilling.CopyAndPaste);

  TApiConfigFileFunctions.WriteStringValue('TERMINAL','ConsoleLog', CurrentBilling.TxID);

  PintarQRCode(CurrentBilling.Location, LQRCodeScreen.QRCodeImage.Picture.Bitmap, qrUTF8BOM);
end;








class procedure TQRCodeScreenUtils.UpdateBillingDataToCanceled(aComponent: TComponent; ButtonStatus: TQRCodeScreenCopyButtonStatus);

var
  LQRCodeScreen: TQRCodeScreen;

begin
  LQRCodeScreen := TQRCodeScreen(aComponent);

  case (ButtonStatus) of
    IS_ENABLED: LQRCodeScreen.BoxCopyNPasteButton.Visible := true;

    IS_NOT_ENABLED: begin
      LQRCodeScreen.QRCodeImage.Picture.Assign(nil);
      LQRCodeScreen.CopyNPasteMemo.Lines.Clear;
      LQRCodeScreen.CopyNPasteMemo.Lines.Add('Não é mais possível copiar o PIX');

      LQRCodeScreen.BoxCopyNPasteButton.Visible := false;
    end;
  end;


end;


class procedure TQRCodeScreenUtils.CopyToClipBoard(const Text: string);
begin
  Clipboard.AsText := Text;
end;

end.

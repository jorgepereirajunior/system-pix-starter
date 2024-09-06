unit SystemPixApp.CheckCurrentBillingStatus.Threads;

interface

uses
  System.Classes,

  Vcl.Dialogs;

type
  TCheckCurrentbillingStatusThread = class(TThread)
    private
      TargetScreen: TComponent;

      class var IsTerminated: boolean;

    protected
      procedure Execute; override;

    public
      class procedure TerminateThread;

      constructor Create(AIsTerminated: boolean; AScreen: TComponent);

  end;

implementation

uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.QRCode.Screen,

  SystemPixApp.QRCodeScreen.Utils,
  SystemPixApp.QRCodeScreen.Functions,

  SystemPixApp.Pix.Functions,

  SystemPixApp.BillingEntity,
  SystemPixApp.PaymentStatusEntity,

  SystemPixApp.StopWatch.Threads,

  SystemPixApp.Styles;

{ TVerifyCurrentbillingStatusThread }

constructor TCheckCurrentbillingStatusThread.Create(AIsTerminated: boolean; AScreen: TComponent);
begin
  inherited Create(False);

  FreeOnTerminate := True;
  IsTerminated := AIsTerminated;
  TargetScreen := AScreen;
end;



procedure TCheckCurrentbillingStatusThread.Execute;

var
  LTargetScreen: TQRCodeScreen;

begin
  inherited;

  LTargetScreen := TQRCodeScreen(TargetScreen);

  while (not IsTerminated) do begin
    Sleep(2000);

    if (CurrentBilling.IsChecked) then begin

      if (CurrentBilling.status = COMPLETED) then begin

        TThread.Synchronize(TThread.CurrentThread,
          procedure begin

            TQRCodeScreenUtils.UpdateBoxPaymentStatus(LTargetScreen, PAY_MADE_EFFECTIVE);

            TQRCodeScreenUtils.UpdateCancelPaymentButton(LTargetScreen, IS_HIDDEN, IS_PRIMARY);
            TQRCodeScreenUtils.UpdateReversalPaymentButton(LTargetScreen, IS_VISIBLE, IS_PRIMARY);
            TQRCodeScreenUtils.UpdateCloseButton(LTargetScreen, IS_VISIBLE, IS_SECONDARY, PDV_COLOR_PAYMENT_EFFECTIVE);
            TQRCodeScreenUtils.UpdateBillingDataToPaymentDone(LTargetScreen, IS_NOT_ENABLED);

            TerminateThread;

//            TStopwatchThread.TerminateThread;

            LTargetScreen.UpdateStopWatchLabel(0);

            TPixFunctions.UpdateCurrentBillingPix;

            exit;
          end
        );

      end;


      if (CurrentBilling.status = REMOVED_BY_USER) then begin

        TThread.Synchronize(TThread.CurrentThread,
          procedure begin
            TQRCodeScreenUtils.UpdateBoxPaymentStatus(TargetScreen, PAY_CANCELED);

            TQRCodeScreenUtils.UpdateCancelPaymentButton(TargetScreen, IS_HIDDEN, IS_PRIMARY);
            TQRCodeScreenUtils.UpdateCloseButton(TargetScreen, IS_VISIBLE, IS_PRIMARY, PDV_COLOR_PAYMENT_CANCELED);
            TQRCodeScreenUtils.UpdateBillingDataToCanceled(TargetScreen, IS_NOT_ENABLED);

            TerminateThread;

//            TStopwatchThread.TerminateThread;

            LTargetScreen.UpdateStopWatchLabel(0);

            exit;
          end
        );

      end;

    end;

  end;

end;



class procedure TCheckCurrentbillingStatusThread.TerminateThread;
begin
  IsTerminated := true;
end;

end.

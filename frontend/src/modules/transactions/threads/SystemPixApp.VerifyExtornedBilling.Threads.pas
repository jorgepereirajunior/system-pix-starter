unit SystemPixApp.VerifyExtornedBilling.Threads;

interface

uses
  System.Classes;

type
  TBillingToExtornThread = class(TThread)
    private
      TargetScreen: TComponent;

      class var TerminatedRequested: boolean;

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

  SystemPixApp.DevolutionEntity,

  SystemPixApp.Styles;

{ TBillingToExtornThread }

constructor TBillingToExtornThread.Create(AIsTerminated: boolean; AScreen: TComponent);
begin
  inherited Create(False);

  FreeOnTerminate := True;
  TerminatedRequested := AIsTerminated;
  TargetScreen := AScreen;
end;


procedure TBillingToExtornThread.Execute;

var
  LTargetScreen: TQRCodeScreen;

begin
  inherited;

  LTargetScreen := TQRCodeScreen(TargetScreen);

  while (not TerminatedRequested) do begin
    sleep(5000);

    TQRCodeScreenFunctions.CheckCurrentBillingDevolution;

    if (CurrentBilling.Pix.Items[0].Devolutions.Items.Count > 0) then begin

      if (CurrentBilling.Pix.Items[0].Devolutions.Items[0].Status = RETURNED) then begin

        Synchronize(
          procedure begin
            TQRCodeScreenUtils.UpdateBoxPaymentStatus(TargetScreen, PAY_EXTORTED);

            TQRCodeScreenUtils.UpdateCancelPaymentButton(TargetScreen, IS_HIDDEN, IS_PRIMARY);
            TQRCodeScreenUtils.UpdateReversalPaymentButton(TargetScreen, IS_HIDDEN, IS_PRIMARY);
            TQRCodeScreenUtils.UpdateCloseButton(TargetScreen, IS_VISIBLE, IS_PRIMARY, PDV_COLOR_PAYMENT_EXTORTED);
          end
        );

        Sleep(60);

        TerminateThread;

      end;

    end;
  end;
end;



class procedure TBillingToExtornThread.TerminateThread;
begin
  TerminatedRequested := true;
end;

end.

unit SystemPixApp.CheckCurrentDevolutionStatus.Threads;

interface

uses
  System.Classes,
  System.TypInfo,

  Vcl.Dialogs;

type
  TCheckCurrentDevolutionStatusThread = class(TThread)
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

constructor TCheckCurrentDevolutionStatusThread.Create(AIsTerminated: boolean; AScreen: TComponent);
begin
  inherited Create(False);

  FreeOnTerminate := True;
  TerminatedRequested := AIsTerminated;
  TargetScreen := AScreen;
end;


procedure TCheckCurrentDevolutionStatusThread.Execute;

var
  LTargetScreen: TQRCodeScreen;

begin
  inherited;

  LTargetScreen := TQRCodeScreen(TargetScreen);

  while (not TerminatedRequested) do begin
    sleep(5000);

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



class procedure TCheckCurrentDevolutionStatusThread.TerminateThread;
begin
  TerminatedRequested := true;
end;

end.

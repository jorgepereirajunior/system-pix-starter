unit SystemPixApp.CheckCurrentBilling.Threads;

interface

uses
  System.Classes,

  Vcl.Dialogs;

type
  TCheckCurrentBillingThread = class(TThread)
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
  SystemPixApp.QRCode.Screen,

  SystemPixApi.ACBrInstantBilling.Functions,

  SystemPixApp.CurrentBillingAsCompleted.Functions;

{ TCheckCurrentBillingThread }

constructor TCheckCurrentBillingThread.Create(AIsTerminated: boolean; AScreen: TComponent);
begin
  inherited Create(False);

  FreeOnTerminate := True;
  IsTerminated := AIsTerminated;
  TargetScreen := AScreen;
end;



procedure TCheckCurrentBillingThread.Execute;

var
  LTargetScreen: TQRCodeScreen;

begin
  inherited;

  LTargetScreen := TQRCodeScreen(TargetScreen);

  while (not IsTerminated) do begin
    Sleep(5000);

    if (TApiACBrInstantBillingFunctions.ExistsWithID(CurrentBilling.TxID)) then begin

      TAppCurrentBillingAsCompletedFunctions.UpdateAll;
      TAppCurrentBillingAsCompletedFunctions.UpdateIsChecked(true);

      TerminateThread;
    end;

  end;
end;



class procedure TCheckCurrentBillingThread.TerminateThread;
begin
  IsTerminated := true;
end;

end.

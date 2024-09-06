unit SystemPixApp.CheckCurrentBillingExists.Threads;

interface

uses
  System.Classes,
  System.SyncObjs,

  System.TypInfo,

  Vcl.Dialogs;

type
  TCheckCurrentBillingExistsThread = class(TThread)
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

  SystemPixApp.BillingEntity,

  SystemPixApp.CurrentBillingAsCompleted.Functions;

{ TCheckCurrentBillingThread }

constructor TCheckCurrentBillingExistsThread.Create(AIsTerminated: boolean; AScreen: TComponent);
begin
  inherited Create(False);

  FreeOnTerminate := True;
  IsTerminated    := AIsTerminated;
  TargetScreen    := AScreen;
end;



procedure TCheckCurrentBillingExistsThread.Execute;

var
  LTargetScreen: TQRCodeScreen;

begin
  inherited;

  LTargetScreen := TQRCodeScreen(TargetScreen);

  while (CurrentBilling.Status = ACTIVED) do begin
    Sleep(5000);

    if (TApiACBrInstantBillingFunctions.ExistsWithID(CurrentBilling.TxID)) then begin

      TAppCurrentBillingAsCompletedFunctions.UpdateAll;
      TAppCurrentBillingAsCompletedFunctions.UpdateIsChecked(true);

      TerminateThread;
    end;

  end;
end;



class procedure TCheckCurrentBillingExistsThread.TerminateThread;
begin
  IsTerminated := true;
end;

end.

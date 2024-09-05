unit SystemPixApp.QRCodeScreen.StopWatchThreads;

interface

uses
  System.Classes;

type
  TStopwatchThread = class(TThread)
    private
      TimeLeft: Integer;
      TargetForm: TComponent;

      class var TerminatedRequested: boolean;

    protected
      procedure Execute; override;

    public
      class procedure TerminateThread;

      constructor Create(ATimeLeft: Integer; AScreen: TComponent);

  end;

implementation

uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.QRCode.Screen;

{ TStopwatchThread }

constructor TStopwatchThread.Create(ATimeLeft: Integer; AScreen: TComponent);
begin
  inherited Create(false);

  FreeOnTerminate := True;
  TimeLeft := ATimeLeft;
  TargetForm := AScreen;
end;

procedure TStopwatchThread.Execute;

var
  LTargetScreen: TQRCodeScreen;

begin
  inherited;

  if (TerminatedRequested) then
    exit;

  LTargetScreen := TQRCodeScreen(TargetForm);

  while (TimeLeft > 0) and (not TerminatedRequested) do begin
    Sleep(1000);
    Dec(TimeLeft);

    Synchronize(procedure begin
      if ( not TerminatedRequested) then
        LTargetScreen.UpdateStopWatchLabel(TimeLeft);
    end);
  end;

  if (TimeLeft = 0) and (not TerminatedRequested) then begin
    TerminatedRequested := true;
    LTargetScreen.OnResettingStopwatch;
  end;

end;

class procedure TStopwatchThread.TerminateThread;
begin
  TerminatedRequested := true;
end;

end.

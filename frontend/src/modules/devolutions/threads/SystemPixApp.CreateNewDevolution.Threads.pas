unit SystemPixApp.CreateNewDevolution.Threads;

interface

uses
  System.SysUtils,
  System.Classes,
  System.SyncObjs,

  System.TypInfo,

  Vcl.Dialogs,

  ACBrPIXBase;

type
  TCreateNewDevolutionThread = class(TThread)
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

  SystemPixApi.ACBrDevolution.Functions;

{ TCreateNewDevolutionThread }

constructor TCreateNewDevolutionThread.Create(AIsTerminated: boolean; AScreen: TComponent);
begin
  inherited Create(False);

  FreeOnTerminate := True;
  IsTerminated    := AIsTerminated;
  TargetScreen    := AScreen;
end;



procedure TCreateNewDevolutionThread.Execute;

var
  LTargetScreen: TQRCodeScreen;

begin
  inherited;

  LTargetScreen := TQRCodeScreen(TargetScreen);

  while (not IsTerminated) do begin

    TApiACBrDevolutionFunctions.ConfigRequesteFields(
      '',
      ndORIGINAL,
      CurrentBilling.Value
    );

    if (TApiACBrDevolutionFunctions.RequestDevolutionWasSuccessful) then
      TerminateThread;

  end;

end;



class procedure TCreateNewDevolutionThread.TerminateThread;
begin
  IsTerminated := true;
end;

end.

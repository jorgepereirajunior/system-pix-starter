unit SystemPixApp.CheckCurrentDevolutionExists.Threads;

interface

uses
  System.SysUtils,
  System.Classes,
  System.SyncObjs,

  System.TypInfo,

  Vcl.Dialogs;

type
  TCheckCurrentDevolutionExistsThread = class(TThread)
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

  SystemPixApp.DevolutionEntity,

  SystemPixApp.Devolution.Functions,
  SystemPixApi.ACBrDevolution.Functions;

{ TCheckCurrentDevolutionExistsThread }

constructor TCheckCurrentDevolutionExistsThread.Create(AIsTerminated: boolean; AScreen: TComponent);
begin
  inherited Create(False);

  FreeOnTerminate := True;
  IsTerminated    := AIsTerminated;
  TargetScreen    := AScreen;
end;



procedure TCheckCurrentDevolutionExistsThread.Execute;

var
  LTargetScreen: TQRCodeScreen;

begin
  inherited;

  LTargetScreen := TQRCodeScreen(TargetScreen);

  while (CurrentBilling.Pix.Items[0].Devolutions.Items.Count = 0) do begin

//    while (CurrentBilling.Pix.Items[0].Devolutions.Items[0].Status <> RETURNED) do begin
      Sleep(5000);

      if (TApiACBrDevolutionFunctions.Exists) then begin

        TAppDevolutionFunctions.UpdateCurrentBillingDevolution;

        TerminateThread;
      end;;

//    end;

  end;
end;



class procedure TCheckCurrentDevolutionExistsThread.TerminateThread;
begin
  IsTerminated := true;
end;

end.

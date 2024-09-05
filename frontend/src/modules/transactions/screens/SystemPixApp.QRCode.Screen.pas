unit SystemPixApp.QRCode.Screen;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.Clipbrd,

  ACBrPIXCD,
  ACBrPIXPSPBancoDoBrasil,
  ACBrBase,
  ACBrPIXBase,
  ACBrImage,
  ACBrDelphiZXingQRCode,

  SystemPixApp.InstantBillingEntities,
  SystemPixApp.GeneratedBillingEntity,
  SystemPixApp.CompleteBillingEntity,
  SystemPixApp.BillingEntity,

  SystemPixApp.DevolutionEntity,

  SystemPixApp.QRCodeScreen.StopWatchThreads;

type
  TBillingToCompletOrCancelThread = class(TThread)
    private
      TerminatedRequested: boolean;
      TargetScreen: TComponent;

    protected
      procedure Execute; override;

    public
      constructor Create(AIsTerminated: boolean; AScreen: TComponent);
      procedure TerminateThread;
  end;


  TBillingToReverseThread = class(TThread)
    private
      TerminatedRequested: boolean;
      TargetScreen: TComponent;

    protected
      procedure Execute; override;

    public
      constructor Create(AIsTerminated: boolean; AScreen: TComponent);
      procedure TerminateThread;
  end;

  TQRCodeScreen = class(TForm)
    Container: TPanel;
    BoxPaymentStatus: TPanel;
    LabelPaymentStatus: TLabel;
    BoxQRCode: TPanel;
    BoxQRCodeTitle: TPanel;
    LabelQRCodeTilte: TLabel;
    BoxQRCodeImage: TPanel;
    QRCodeImage: TImage;
    BoxCopyNPaste: TPanel;
    BoxCopyNPasteTitle: TPanel;
    LabelCopyNPasteTitle: TLabel;
    BoxCopyNPasteMemo: TPanel;
    CopyNPasteMemo: TMemo;
    BGQRCodeImage: TShape;
    BGCopyNPasteMemo: TShape;
    BoxCopyNPasteButton: TPanel;
    CopyNPasteButton: TSpeedButton;
    BoxActionButtons: TPanel;
    BoxCancelPaymentButton: TPanel;
    BGCancelPaymentButton: TShape;
    CancelPaymentButton: TSpeedButton;
    BoxCloseButton: TPanel;
    BGCloseButton: TShape;
    CloseButton: TSpeedButton;
    BoxExtornPaymentButton: TPanel;
    BGExtornButton: TShape;
    ExtornButton: TSpeedButton;
    BoxTitle: TPanel;
    StopwatchLabel: TLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    procedure CompleteBillingTimerAction(Sender: TObject);

    procedure InstantBillingTimerThreadEnds(Sender: TObject);
    procedure CompleteBillingTimerThreadEnds(Sender: TObject);

    procedure CancelPaymentButtonAction(Sender: TObject);
    procedure CloseButtonAction(Sender: TObject);
    procedure ExtornButtonAction(Sender: TObject);

    procedure HandleCopyToClipBoard(Sender: TObject);

    procedure MoveByScreen(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  public
    procedure UpdateStopWatchLabel(TimeLeft: integer);
    procedure OnResettingStopwatch;

    constructor Create(AOwner: TComponent);

  end;

var
  QRCodeScreen: TQRCodeScreen;

  InstantBilling  : TAppInstantBillingEntity;
  GeneratedBilling: TAppGeneratedBillingEntity;
  CompletedBilling: TAppCompletedBillingEntity;
  CurrentBilling  : TAppMainBillingEntity;

implementation

{$R *.dfm}

{ TQRCodeScreen }

uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.PaymentStatusEntity,

  SystemPixApp.QRCodeScreen.Functions,
  SystemPixApp.QRCodeScreen.Utils,

  SystemPixApp.Pix.Functions,
  SystemPixApp.CompleteBilling.Functions,

  SystemPixApi.ConfigFile.Functions,

  SystemPixApp.Styles;


constructor TQRCodeScreen.Create(AOwner: TComponent);

begin
  inherited Create(AOwner);

  TQRCodeScreenUtils.BuildMainContent(Self);


  StopwatchLabel.OnMouseDown := MoveByScreen;
  BoxTitle.OnMouseDown   := MoveByScreen;

  CopyNPasteButton.OnClick    := HandleCopyToClipBoard;
  CancelPaymentButton.OnClick := CancelPaymentButtonAction;
  CloseButton.OnClick         := CloseButtonAction;
  ExtornButton.OnClick        := ExtornButtonAction;

  TStopwatchThread.Create(90, Self);
  TBillingToCompletOrCancelThread.Create(false, Self);
end;


procedure TQRCodeScreen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//
end;



procedure TQRCodeScreen.CompleteBillingTimerAction(Sender: TObject);

var
  CompleteBillingThread: TThread;

begin
  CompleteBillingThread := TThread.CreateAnonymousThread(
    procedure begin

      TQRCodeScreenFunctions.CheckCurrentBillingDevolution;

      if (CompletedBilling.Pix.HasDevolution) then begin

        if (CompletedBilling.Pix.Items[0].Devolutions.Items.Last.Status = stdDEVOLVIDO) then begin

          TThread.Synchronize(TThread.CurrentThread,
            procedure begin
              TQRCodeScreenUtils.UpdateBoxPaymentStatus(Self, PAY_EXTORTED);

              TQRCodeScreenUtils.UpdateCancelPaymentButton(Self, IS_HIDDEN, IS_PRIMARY);
              TQRCodeScreenUtils.UpdateReversalPaymentButton(Self, IS_HIDDEN, IS_PRIMARY);
              TQRCodeScreenUtils.UpdateCloseButton(Self, IS_VISIBLE, IS_PRIMARY, PDV_COLOR_PAYMENT_EXTORTED);

            end
          );
        end;

      end;

    end
  );

  CompleteBillingThread.Start;
  CompleteBillingThread.OnTerminate := CompleteBillingTimerThreadEnds;
end;







procedure TQRCodeScreen.InstantBillingTimerThreadEnds(Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then begin
    exit;
  end;
end;




procedure TQRCodeScreen.CompleteBillingTimerThreadEnds(Sender: TObject);
begin
  exit;
end;





procedure TQRCodeScreen.ExtornButtonAction(Sender: TObject);

begin
  TQRCodeScreenFunctions.ExtornCurrentBilling;

  TBillingToReverseThread.Create(false, Self);
end;




procedure TQRCodeScreen.CancelPaymentButtonAction(Sender: TObject);
begin
  TQRCodeScreenFunctions.HandleOpenCancelPaymentModal(Sender);
end;



procedure TQRCodeScreen.CloseButtonAction(Sender: TObject);
begin
  Self.Close;
end;



procedure TQRCodeScreen.HandleCopyToClipBoard(Sender: TObject);

begin
  TQRCodeScreenUtils.CopyToClipBoard(CopyNPasteMemo.Text);
end;



procedure TQRCodeScreen.MoveByScreen(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Screen.Cursor := crSizeAll;
  ReleaseCapture;
  Self.Perform(WM_NCLBUTTONDOWN, HTCAPTION, 0);
  Screen.Cursor := crDefault;
end;




procedure TQRCodeScreen.UpdateStopWatchLabel(TimeLeft: integer);
var
  Min, Sec: Integer;

begin
  Min := TimeLeft div 60;
  Sec := TimeLeft mod 60;
  StopwatchLabel .Caption := 'Tempo restante para pagar: ' +Format('%.2d:%.2d', [Min, Sec]);
end;


procedure TQRCodeScreen.OnResettingStopwatch;
begin
  TQRCodeScreenFunctions.CancelCurrentBilling;
end;


{ TBillingToCompletOrCancelThread }

constructor TBillingToCompletOrCancelThread.Create(AIsTerminated: boolean; AScreen: TComponent);
begin
  inherited Create(False);

  FreeOnTerminate := True;
  TerminatedRequested := AIsTerminated;
  TargetScreen := AScreen;
end;


procedure TBillingToCompletOrCancelThread.Execute;

var
  LTargetScreen: TQRCodeScreen;

begin
  inherited;

  LTargetScreen := TQRCodeScreen(TargetScreen);

  while (not TerminatedRequested) do begin
    sleep(5000);

    TQRCodeScreenFunctions.CheckCurrentBilling;

    if (CurrentBilling.IsChecked) then begin

      if (CurrentBilling.status = COMPLETED) then begin

        TThread.Synchronize(TThread.CurrentThread,
          procedure begin

            TQRCodeScreenUtils.UpdateBoxPaymentStatus(TargetScreen, PAY_MADE_EFFECTIVE);

            TQRCodeScreenUtils.UpdateCancelPaymentButton(TargetScreen, IS_HIDDEN, IS_PRIMARY);
            TQRCodeScreenUtils.UpdateReversalPaymentButton(TargetScreen, IS_VISIBLE, IS_PRIMARY);
            TQRCodeScreenUtils.UpdateCloseButton(TargetScreen, IS_VISIBLE, IS_SECONDARY, PDV_COLOR_PAYMENT_EFFECTIVE);
            TQRCodeScreenUtils.UpdateBillingDataToPaymentDone(TargetScreen, IS_NOT_ENABLED);

            TerminateThread;

            TStopwatchThread.TerminateThread;

//            LTargetScreen.StopwatchThread.TerminateThread;
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

            TStopwatchThread.TerminateThread;

//            LTargetScreen.StopwatchThread.TerminateThread;
            LTargetScreen.UpdateStopWatchLabel(0);

            exit;
          end
        );

      end;

    end;

  end;

end;


procedure TBillingToCompletOrCancelThread.TerminateThread;
begin
  TerminatedRequested := true;
end;



{ TBillingToReverseThread }

constructor TBillingToReverseThread.Create(AIsTerminated: boolean; AScreen: TComponent);
begin
  inherited Create(False);

  FreeOnTerminate := True;
  TerminatedRequested := AIsTerminated;
  TargetScreen := AScreen;
end;


procedure TBillingToReverseThread.Execute;

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


procedure TBillingToReverseThread.TerminateThread;
begin
  TerminatedRequested := true;
end;




Initialization
  InstantBilling   := TAppInstantBillingEntity.Create;
  GeneratedBilling := TAppGeneratedBillingEntity.Create;
  CompletedBilling := TAppCompletedBillingEntity.Create;

  CurrentBilling      := TAppMainBillingEntity.Create;

Finalization
  InstantBilling.Free;
  GeneratedBilling.Free;
  CompletedBilling.Free;

  CurrentBilling.Free;
end.

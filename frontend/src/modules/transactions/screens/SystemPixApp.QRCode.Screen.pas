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
  SystemPixApp.BillingEntity;

type
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
    BoxReversalPaymentButton: TPanel;
    BGReversalButton: TShape;
    ReversalButton: TSpeedButton;
    BoxTitle: TPanel;
    StopwatchLabel: TLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    InstantBillingTimer : TTimer;
    CompleteBillingTimer: TTimer;

    procedure InstantBillingTimerAction(Sender: TObject);
    procedure CompleteBillingTimerAction(Sender: TObject);

    procedure InstantBillingTimerThreadEnds(Sender: TObject);
    procedure CompleteBillingTimerThreadEnds(Sender: TObject);

    procedure CancelPaymentButtonAction(Sender: TObject);
    procedure CloseButtonAction(Sender: TObject);
    procedure ReversalButtonAction(Sender: TObject);

    procedure HandleCopyToClipBoard(Sender: TObject);

    procedure MoveByScreen(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure UpdateStopWatchLabel(TimeLeft: integer);
    procedure StopwatchEnds;

  public
    constructor Create(AOwner: TComponent);

  end;

  TStopwatchThread = class(TThread)
    private
      TimeLeft: Integer;
      TargetForm: TQRCodeScreen;

    protected
      procedure Execute; override;

    public
      constructor Create(ATimeLeft: Integer; AForm: TQRCodeScreen);
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

  SystemPixApp.CompleteBilling.Functions,

  SystemPixApi.ConfigFile.Functions,

  SystemPixApp.Styles;


constructor TQRCodeScreen.Create(AOwner: TComponent);

begin
  inherited Create(AOwner);

  TQRCodeScreenUtils.BuildMainContent(Self);

  InstantBillingTimer  := TTimer.Create(Self);

  InstantBillingTimer.Enabled  := false;
  InstantBillingTimer.Interval := 5000;
  InstantBillingTimer.Enabled  := true;

  InstantBillingTimer.OnTimer := InstantBillingTimerAction;


  CompleteBillingTimer := TTimer.Create(Self);

  CompleteBillingTimer.Enabled := false;
  CompleteBillingTimer.Interval := 5000;

  CompleteBillingTimer.OnTimer := CompleteBillingTimerAction;

  StopwatchLabel.OnMouseDown := MoveByScreen;
  BoxTitle.OnMouseDown   := MoveByScreen;

  CopyNPasteButton.OnClick    := HandleCopyToClipBoard;
  CancelPaymentButton.OnClick := CancelPaymentButtonAction;
  CloseButton.OnClick         := CloseButtonAction;
  ReversalButton.OnClick      := ReversalButtonAction;

//  TStopwatchThread.Create(30, Self);
end;



procedure TQRCodeScreen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  InstantBillingTimer.Enabled := false;
  InstantBillingTimer.Free;

  CompleteBillingTimer.Enabled := false;
  CompleteBillingTimer.Free;
end;





procedure TQRCodeScreen.InstantBillingTimerAction(Sender: TObject);

var
  InstantBillingThread: TThread;

begin
  InstantBillingThread := TThread.CreateAnonymousThread(
    procedure begin

      TQRCodeScreenFunctions.CheckCurrentBilling;

      if (CurrentBilling.IsChecked) then begin

        if (CurrentBilling.status = COMPLETED) then begin

          TThread.Synchronize(TThread.CurrentThread,
            procedure begin

              TQRCodeScreenUtils.UpdateBoxPaymentStatus(Self, PAY_MADE_EFFECTIVE);

              TQRCodeScreenUtils.UpdateCancelPaymentButton(Self, IS_HIDDEN, IS_PRIMARY);
              TQRCodeScreenUtils.UpdateReversalPaymentButton(Self, IS_VISIBLE, IS_PRIMARY);
              TQRCodeScreenUtils.UpdateCloseButton(Self, IS_VISIBLE, IS_SECONDARY, PDV_COLOR_PAYMENT_EFFECTIVE);

              InstantBillingTimer.Enabled := false;

              TAppCompleteBillingFunctions.UpdateAllPix;

              exit;
            end
          );

        end;


        if (CurrentBilling.status = REMOVED_BY_USER) then begin

          TThread.Synchronize(TThread.CurrentThread,
            procedure begin
              TQRCodeScreenUtils.UpdateBoxPaymentStatus(Self, PAY_CANCELED);

              TQRCodeScreenUtils.UpdateCancelPaymentButton(Self, IS_HIDDEN, IS_PRIMARY);
              TQRCodeScreenUtils.UpdateCloseButton(Self, IS_VISIBLE, IS_PRIMARY, PDV_COLOR_PAYMENT_CANCELED);
              TQRCodeScreenUtils.UpdateBillingDataToCanceled(Self, IS_NOT_ENABLED);

              InstantBillingTimer.Enabled := false;

              exit;
            end
          );

        end;

      end;

    end
  );

  InstantBillingThread.Start;
  InstantBillingThread.OnTerminate := InstantBillingTimerThreadEnds;
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

              CompleteBillingTimer.Enabled := false;
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





procedure TQRCodeScreen.ReversalButtonAction(Sender: TObject);

begin
  TQRCodeScreenFunctions.CreateNewBillingDevolution;

  CompleteBillingTimer.Enabled := true;
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
  StopwatchLabel .Caption := Format('%.2d:%.2d', [Min, Sec]);
end;

procedure TQRCodeScreen.StopwatchEnds;
begin
//  ShowMessage('Tempo esgotado!');
  TQRCodeScreenFunctions.ReviewInstantBilling;
end;

{ TStopwatchThread }

constructor TStopwatchThread.Create(ATimeLeft: Integer; AForm: TQRCodeScreen);
begin
  inherited Create(False);
  FreeOnTerminate := True;
  TimeLeft := ATimeLeft;
  TargetForm := AForm;
end;




procedure TStopwatchThread.Execute;
begin
  inherited;

  while TimeLeft > 0 do begin
    Sleep(1000);
    Dec(TimeLeft);


    Synchronize(procedure begin
      TargetForm.UpdateStopWatchLabel(TimeLeft);
    end);
  end;

  TargetForm.StopwatchEnds;
//  Synchronize(procedure begin
//    TargetForm.StopwatchEnds;
//  end);
end;





Initialization
  InstantBilling   := TAppInstantBillingEntity.Create;
  GeneratedBilling := TAppGeneratedBillingEntity.Create;
  CompletedBilling := TAppCompletedBillingEntity.Create;
//  RevisedBilling   := TReviseddBillingEntity.Create;
  CurrentBilling      := TAppMainBillingEntity.Create;

Finalization
  InstantBilling.Free;
  GeneratedBilling.Free;
  CompletedBilling.Free;
//  RevisedBilling.Free;
  CurrentBilling.Free;
end.

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

  SystemPixApp.BillingEntity,

  SystemPixApp.DevolutionEntity,

  SystemPixApp.QRCodeScreen.StopWatchThreads,
  SystemPixApp.QRCodeScreen.BillingToCompleteOrCancelThreads,
  SystemPixApp.QRCodeScreen.BillingToExtornThreads;

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
    BoxExtornPaymentButton: TPanel;
    BGExtornButton: TShape;
    ExtornButton: TSpeedButton;
    BoxTitle: TPanel;
    StopwatchLabel: TLabel;

  private
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

  CurrentBilling  : TAppBillingEntity;

implementation

{$R *.dfm}

uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.PaymentStatusEntity,

  SystemPixApp.QRCodeScreen.Functions,
  SystemPixApp.QRCodeScreen.Utils,

  SystemPixApp.Pix.Functions,

  SystemPixApi.ConfigFile.Functions,

  SystemPixApp.Styles;

  { TQRCodeScreen }

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






procedure TQRCodeScreen.ExtornButtonAction(Sender: TObject);

begin
  TQRCodeScreenFunctions.ExtornCurrentBilling;

  TBillingToExtornThread.Create(false, Self);
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





Initialization
  CurrentBilling := TAppBillingEntity.Create;

Finalization

  CurrentBilling.Free;
end.

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
  SystemPixApp.RequestedBillingEntity,
  SystemPixApp.GeneratedBillingEntity,
  SystemPixApp.CompleteBillingEntity;

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

    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    InstantBillingTimer : TTimer;
    CompleteBillingTimer: TTimer;

    procedure InstantBillingTimerAction(Sender: TObject);
    procedure InstantBillingTimerThreadEnds(Sender: TObject);

    procedure CompleteBillingTimerAction(Sender: TObject);
    procedure CompleteBillingTimerThreadEnds(Sender: TObject);

    procedure HandleCopyToClipBoard(Sender: TObject);
    procedure MakeMainContent;

    procedure CancelPaymentButtonAction(Sender: TObject);
    procedure CloseButtonAction(Sender: TObject);
    procedure ReversalButtonAction(Sender: TObject);

  public
    constructor Create(AOwner: TComponent);

  end;

var
  QRCodeScreen: TQRCodeScreen;

  InstantBilling  : TAppInstantBillingEntity;
  RequestedBilling: TAppRequestedBillingEntity;
  GeneratedBilling: TAppGeneratedBillingEntity;
  CompletedBilling: TAppCompletedBillingEntity;

implementation

{$R *.dfm}

{ TQRCodeScreen }

uses
  SystemPixApp.Sales.Screen,
  PointOfSale.PaymentStatusEntity,
  PointOfSale.Styles,

  PointOfSale.QRCodeScreen.Functions,

  SystemPixApp.CompleteBilling.Functions,

  SystemPixApi.ConfigFile.Functions;


constructor TQRCodeScreen.Create(AOwner: TComponent);

begin
  inherited Create(AOwner);

  InstantBillingTimer := TTimer.Create(nil);

  MakeMainContent;

  InstantBillingTimer.Enabled  := false;
  InstantBillingTimer.Interval := 5100;
  InstantBillingTimer.Enabled  := true;

  InstantBillingTimer.OnTimer := InstantBillingTimerAction;

  CopyNPasteButton.OnClick    := HandleCopyToClipBoard;

  CancelPaymentButton.OnClick := CancelPaymentButtonAction;
  CloseButton.OnClick         := CloseButtonAction;
  ReversalButton.OnClick      := ReversalButtonAction;
end;



procedure TQRCodeScreen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  InstantBillingTimer.Enabled := false;
  InstantBillingTimer.Free;

  if (Assigned(CompleteBillingTimer)) then begin
    CompleteBillingTimer.Enabled := false;
    CompleteBillingTimer.Free;
  end;
end;








procedure TQRCodeScreen.InstantBillingTimerAction(Sender: TObject);

var
  InstantBillingThread: TThread;

begin
  InstantBillingThread := TThread.CreateAnonymousThread(
    procedure begin

      TQRCodeScreenFunctions.CheckCurrentInstantBilling;

      TThread.Synchronize(TThread.CurrentThread,
        procedure begin

          if (CompletedBilling.Exists) then begin

            if (CompletedBilling.status = stcCONCLUIDA) then begin

              TQRCodeScreenFunctions.UpdateBoxPaymentStatus(Self, PAY_MADE_EFFECTIVE);

              TQRCodeScreenFunctions.UpdateCancelPaymentButton(Self, IS_HIDDEN, IS_PRIMARY);
              TQRCodeScreenFunctions.UpdateReversalPaymentButton(Self, IS_VISIBLE, IS_PRIMARY);
              TQRCodeScreenFunctions.UpdateCloseButton(Self, IS_VISIBLE, IS_SECONDARY, PDV_COLOR_PAYMENT_EFFECTIVE);

              InstantBillingTimer.Enabled := false;

              TCompleteBillingFunctions.UpdateAllPix;

              exit;
            end;

            if (CompletedBilling.status = stcREMOVIDA_PELO_USUARIO_RECEBEDOR) then begin

              TQRCodeScreenFunctions.UpdateBoxPaymentStatus(Self, PAY_CANCELED);

              TQRCodeScreenFunctions.UpdateCancelPaymentButton(Self, IS_HIDDEN, IS_PRIMARY);
              TQRCodeScreenFunctions.UpdateCloseButton(Self, IS_VISIBLE, IS_PRIMARY, PDV_COLOR_PAYMENT_CANCELED);

              InstantBillingTimer.Enabled := false;

              exit;
            end;

          end;

        end
      );

    end
  );

  InstantBillingThread.Start;
  InstantBillingThread.OnTerminate := InstantBillingTimerThreadEnds;
end;



procedure TQRCodeScreen.InstantBillingTimerThreadEnds(Sender: TObject);
begin

  if Assigned(TThread(Sender).FatalException) then
    exit;
end;








procedure TQRCodeScreen.MakeMainContent;
begin
  TQRCodeScreenFunctions.UpdateBoxPaymentStatus(Self, PAY_ON_HOLD);
  TQRCodeScreenFunctions.UpdateCancelPaymentButton(Self, IS_VISIBLE, IS_PRIMARY);
  
  TQRCodeScreenFunctions.SetQRCodeArea(Self);
  TQRCodeScreenFunctions.SetCopyPasteArea(Self);
  TQRCodeScreenFunctions.SetBillingData(Self);
end;







procedure TQRCodeScreen.CompleteBillingTimerAction(Sender: TObject);

var
  CompleteBillingThread: TThread;

begin
  CompleteBillingThread := TThread.CreateAnonymousThread(
    procedure begin

      TQRCodeScreenFunctions.CheckCurrentBillingDevolution;

      TThread.Synchronize(TThread.CurrentThread,
        procedure begin

          if (CompletedBilling.Pix.HasDevolution) then begin

            if (CompletedBilling.Pix.Items[0].Devolutions.Items.Last.Status = stdDEVOLVIDO) then begin

              TQRCodeScreenFunctions.UpdateBoxPaymentStatus(Self, PAY_EXTORTED);

              TQRCodeScreenFunctions.UpdateCancelPaymentButton(Self, IS_HIDDEN, IS_PRIMARY);
              TQRCodeScreenFunctions.UpdateReversalPaymentButton(Self, IS_HIDDEN, IS_PRIMARY);
              TQRCodeScreenFunctions.UpdateCloseButton(Self, IS_VISIBLE, IS_PRIMARY, PDV_COLOR_PAYMENT_EXTORTED);

              CompleteBillingTimer.Enabled := false;
            end;

          end;

        end
      );
    end
  );

  CompleteBillingThread.Start;
  CompleteBillingThread.OnTerminate := CompleteBillingTimerThreadEnds;
end;



procedure TQRCodeScreen.CompleteBillingTimerThreadEnds(Sender: TObject);
begin
  exit;
end;





procedure TQRCodeScreen.ReversalButtonAction(Sender: TObject);

begin
  CompleteBillingTimer := TTimer.Create(nil);

  CompleteBillingTimer.Enabled := false;
  CompleteBillingTimer.Interval := 5000;

  CompleteBillingTimer.OnTimer := CompleteBillingTimerAction;

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
  TQRCodeScreenFunctions.CopyToClipBoard(CopyNPasteMemo.Text);
end;





Initialization
  InstantBilling   := TInstantBillingEntity.Create;
  RequestedBilling := TRequestedBillingEntity.Create;
  GeneratedBilling := TGeneratedBillingEntity.Create;
  CompletedBilling := TCompletedBillingEntity.Create;
  RevisedBilling   := TReviseddBillingEntity.Create;

Finalization
  InstantBilling.Free;
  RequestedBilling.Free;
  GeneratedBilling.Free;
  CompletedBilling.Free;
  RevisedBilling.Free;
  
end.

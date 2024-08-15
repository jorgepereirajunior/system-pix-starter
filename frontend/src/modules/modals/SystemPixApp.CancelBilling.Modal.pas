unit SystemPixApp.CancelBilling.Modal;

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
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Imaging.pngimage;

type
  TCancelBillingModal = class(TForm)
    Container: TPanel;
    BoxTop: TPanel;
    BoxBottom: TPanel;
    BoxButtonYes: TPanel;
    BgButtonYes: TShape;
    ButtonYes: TSpeedButton;
    BoxButtonNo: TPanel;
    BgButtonNo: TShape;
    ButtonNo: TSpeedButton;
    BoxContent: TPanel;
    Left: TPanel;
    Right: TPanel;
    BoxSubMessage: TPanel;
    LabelSubMessage: TLabel;
    BoxWarningMessage: TPanel;
    LabelWarningMessage: TLabel;
    TopTrack: TShape;
    Icon: TImage;

  private
    FAction: TProc;

    procedure ActionButtonYes(Sender: TObject);
    procedure ActionButtonNo(Sender: TObject);

    procedure MoveByScreen(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  public
    property Action: TProc read FAction write FAction;

    constructor Create(AOwner: TComponent; AAlertMsg: string; Proc: TProc);

  end;

var
  CancelBillingModal: TCancelBillingModal;

implementation

{$R *.dfm}

uses
  SystemPixApp.Styles;

{ TCancelPaymentModal }


procedure TCancelBillingModal.ActionButtonNo(Sender: TObject);
begin
  Self.Close;
end;


procedure TCancelBillingModal.ActionButtonYes(Sender: TObject);
begin
  FAction;

  Self.Close;
end;





constructor TCancelBillingModal.Create(AOwner: TComponent; AAlertMsg: string; Proc: TProc);
begin
  inherited Create(AOwner);

  FAction := Proc;

  TopTrack.Brush.Color := PDV_COLOR_PAYMENT_CANCELED;
  TopTrack.Pen.Style   := psClear;
  TopTrack.OnMouseDown := MoveByScreen;

  LabelWarningMessage.Caption := AAlertMsg;
  LabelWarningMessage.Font.Color := PDV_COLOR_PAYMENT_CANCELED;
  LabelWarningMessage.Font.Size  := 14;
  LabelWarningMessage.Font.Style := [fsBold];

  BgButtonNo.Brush.Color := clWhite;
  BgButtonNo.Pen.Style := psSolid;
  BgButtonNo.Pen.Width := 1;
  BgButtonNo.Pen.Color := PDV_COLOR_PAYMENT_CANCELED;
  ButtonNo.Font.Color  := PDV_COLOR_PAYMENT_CANCELED;

  ButtonNo.OnClick := ActionButtonNo;


  BgButtonYes.Brush.Color := PDV_COLOR_PAYMENT_CANCELED;
  BgButtonYes.Pen.Style   := psClear;
  ButtonYes.Font.Color    := clWhite;

  ButtonYes.OnClick := ActionButtonYes;

  BoxTop.OnMouseDown := MoveByScreen;
end;





procedure TCancelBillingModal.MoveByScreen(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Screen.Cursor := crSizeAll;
  ReleaseCapture;
  Self.Perform(WM_NCLBUTTONDOWN, HTCAPTION, 0);
  Screen.Cursor := crDefault;
end;

end.

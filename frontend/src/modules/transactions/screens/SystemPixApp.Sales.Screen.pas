unit SystemPixApp.Sales.Screen;

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
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,

  ACBrPIXCD,
  ACBrPIXPSPBancoDoBrasil,
  ACBrBase,
  ACBrPIXBase;

type
  TSalesScreen = class(TForm)
    Container: TPanel;
    BoxLeftMenu: TPanel;
    BoxButtons1: TPanel;
    BoxButtons1LeftBlock: TPanel;
    BoxButtons1RightBlock: TPanel;
    BoxConfirmButton: TPanel;
    BgConfirmButton: TShape;
    ConfirmButton: TSpeedButton;
    BoxContent: TPanel;
    BoxTopBar: TPanel;
    TopBarLeftBlock: TPanel;
    TopBarLeftTrack: TShape;
    TopBarRightBlock: TPanel;
    TopBarRightTrack: TShape;
    LabelTopBar: TLabel;
    BoxQuantityNPrices: TPanel;
    BoxProductTableList: TPanel;
    ShapeDivisor: TShape;
    BoxCostumerData: TPanel;
    LabelCostumerData: TLabel;
    ProductTableListHeader: TPanel;
    BoxCode: TPanel;
    LabelProductTableCode: TLabel;
    BoxProductDescription: TPanel;
    LabelProductTableProduct: TLabel;
    BoxQuantity: TPanel;
    LabelProductTableQuatity: TLabel;
    BoxUnity: TPanel;
    LabelProductTableUnity: TLabel;
    BoxPrice: TPanel;
    LabelProductTablePrice: TLabel;
    BoxTotal: TPanel;
    LabelProductTableTotal: TLabel;
    BoxProductItem1: TPanel;
    BoxProductItem1Code: TPanel;
    LabelProductItem1Code: TLabel;
    BoxProductItem1ProductDescription: TPanel;
    LabelProductItem1ProductDescription: TLabel;
    BoxProductItem1ProductQuantity: TPanel;
    LabelProductItem1ProductQuantity: TLabel;
    BoxProductItem1ProductUnity: TPanel;
    LabelProductItem1ProductUnity: TLabel;
    BoxProductItem1ProductPrice: TPanel;
    LabelProductItem1ProductPrice: TLabel;
    BoxProductItem1ProductTotal: TPanel;
    LabelProductItem1ProductTotal: TLabel;
    BoxTotalizers: TPanel;
    TotalizersLeftBlock: TPanel;
    TotalizersTopBlock: TPanel;
    LabelNumOfItem: TLabel;
    TotalizersBottomBlock: TPanel;
    LabelTotItem: TLabel;
    TotalizersRightBlock: TPanel;
    LabelGrandTotal: TLabel;

    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }

  end;

var
  SalesScreen: TSalesScreen;

  PIXComponent: TACBrPixCD;
  PSPBancoBrasil: TACBrPSPBancoDoBrasil;

implementation

{$R *.dfm}

procedure TSalesScreen.FormCreate(Sender: TObject);
begin
  BgConfirmButton.Brush.Color := $00E99014;
  BgConfirmButton.Pen.Style   := psClear;

  ConfirmButton.Font.Color := clWhite;
  ConfirmButton.Font.Size  := 14;
  ConfirmButton.Font.Style := [fsBold];
  ConfirmButton.Caption := 'CONFIRMAR';

  TopBarLeftBlock.Padding.Left   := 10;
  TopBarLeftBlock.Padding.Top    := 10;
  TopBarLeftBlock.Padding.Bottom := 10;

  TopBarLeftTrack.Pen.Width := 1;
  TopBarLeftTrack.Pen.Style := psSolid;
  TopBarLeftTrack.Pen.Color := $00E99014;

  TopBarLeftTrack.Brush.Color := $00E99014;



  TopBarRightBlock.Padding.Right   := 10;
  TopBarRightBlock.Padding.Top     := 10;
  TopBarRightBlock.Padding.Bottom  := 10;

  TopBarRightTrack.Pen.Width := 1;
  TopBarRightTrack.Pen.Style := psSolid;
  TopBarRightTrack.Pen.Color := $00E99014;

  TopBarRightTrack.Brush.Color := $00E99014;

  LabelTopBar.Caption    := '    TESTE PIX EM HOMOLOGAÇÃO';
  LabelTopBar.Font.Size  := 26;
  LabelTopBar.Font.Style := [fsBold];
  LabelTopBar.Font.Color := clWhite;

  LabelCostumerData.Font.Size := 18;
  LabelCostumerData.Font.Style := [];
  LabelCostumerData.Font.Color := clBlack;
  LabelCostumerData.Caption := '1 - CLIENTE TESTE';

  BoxCode.Width                    := 100;
  LabelProductTableCode.Caption    := 'CÓDIGO';
  LabelProductTableCode.Font.Size  := 12;
  LabelProductTableCode.Font.Style := [fsBold];
  LabelProductTableCode.Font.Color := $005A3802;

  BoxProductDescription.Width         := 380;
  LabelProductTableProduct.Caption    := 'PRODUTO';
  LabelProductTableProduct.Font.Size  := 12;
  LabelProductTableProduct.Font.Style := [fsBold];
  LabelProductTableProduct.Font.Color := $005A3802;

  BoxQuantity.Width                    := 90;
  LabelProductTableQuatity.Caption    := 'QTDE';
  LabelProductTableQuatity.Font.Size  := 12;
  LabelProductTableQuatity.Font.Style := [fsBold];
  LabelProductTableQuatity.Font.Color := $005A3802;

  BoxUnity.Width                    := 90;
  LabelProductTableUnity.Caption    := 'UNID';
  LabelProductTableUnity.Font.Size  := 12;
  LabelProductTableUnity.Font.Style := [fsBold];
  LabelProductTableUnity.Font.Color := $005A3802;

  BoxPrice.Width                    := 100;
  LabelProductTablePrice.Caption    := 'PREÇO';
  LabelProductTablePrice.Font.Size  := 12;
  LabelProductTablePrice.Font.Style := [fsBold];
  LabelProductTablePrice.Font.Color := $005A3802;

  BoxTotal.Width                    := 100;
  LabelProductTableTotal.Caption    := 'TOTAL';
  LabelProductTableTotal.Font.Size  := 12;
  LabelProductTableTotal.Font.Style := [fsBold];
  LabelProductTableTotal.Font.Color := $005A3802;

  ShapeDivisor.Brush.Color          := clSilver;
  ShapeDivisor.Height               := 3;

  BoxProductItem1Code.Color         := $00E99014;
  BoxProductItem1Code.Width         := 100;
  LabelProductItem1Code.Caption     := '1';
  LabelProductItem1Code.Font.Size   := 11;
  LabelProductItem1Code.Font.Style  := [fsBold];
  LabelProductItem1Code.Font.Color  := clWhite;

  BoxProductItem1ProductDescription.Color := clWhite;
  BoxProductItem1ProductDescription.Width := 380;
  LabelProductItem1ProductDescription.Caption     := 'Ráiniquen 600ml';
  LabelProductItem1ProductDescription.Font.Size   := 11;
  LabelProductItem1ProductDescription.Font.Style  := [fsBold];
  LabelProductItem1ProductDescription.Font.Color  := cl3DDkShadow;

  BoxProductItem1ProductQuantity.Color := clWhite;
  BoxProductItem1ProductQuantity.Width := 90;
  LabelProductItem1ProductQuantity.Caption     := '1';
  LabelProductItem1ProductQuantity.Font.Size   := 11;
  LabelProductItem1ProductQuantity.Font.Style  := [fsBold];
  LabelProductItem1ProductQuantity.Font.Color  := cl3DDkShadow;

  BoxProductItem1ProductUnity.Color := clWhite;
  BoxProductItem1ProductUnity.Width := 90;
  LabelProductItem1ProductUnity.Caption     := 'CX';
  LabelProductItem1ProductUnity.Font.Size   := 11;
  LabelProductItem1ProductUnity.Font.Style  := [fsBold];
  LabelProductItem1ProductUnity.Font.Color  := cl3DDkShadow;

  BoxProductItem1ProductPrice.Color := clWhite;
  BoxProductItem1ProductPrice.Width := 100;
  LabelProductItem1ProductPrice.Caption     := '152,40';
  LabelProductItem1ProductPrice.Font.Size   := 11;
  LabelProductItem1ProductPrice.Font.Style  := [fsBold];
  LabelProductItem1ProductPrice.Font.Color  := cl3DDkShadow;

  BoxProductItem1ProductTotal.Color := clWhite;
  BoxProductItem1ProductTotal.Width := 100;
  LabelProductItem1ProductTotal.Caption     := '152,40';
  LabelProductItem1ProductTotal.Font.Size   := 11;
  LabelProductItem1ProductTotal.Font.Style  := [fsBold];
  LabelProductItem1ProductTotal.Font.Color  := cl3DDkShadow;

  LabelNumOfItem.Font.Color := $005A3802;
  LabelNumOfItem.Font.Style := [];
  LabelNumOfItem.Font.Size  := 15;
  LabelNumOfItem.Caption    := 'Número de Itens';

  LabelTotItem.Font.Color := clBlack;
  LabelTotItem.Font.Style := [fsBold];
  LabelTotItem.Font.Size  := 19;
  LabelTotItem.Caption    := '1';

  LabelGrandTotal.Font.Color := clBlack;
  LabelGrandTotal.Font.Style := [fsBold];
  LabelGrandTotal.Font.Size  := 30;
  LabelGrandTotal.Caption    := '152,40';
end;



initialization
  PIXComponent := TACBrPixCD.Create(nil);
  PSPBancoBrasil  := TACBrPSPBancoDoBrasil.Create(nil);

finalization
  PIXComponent.Free;
  PSPBancoBrasil.Free;

end.

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
  Vcl.ExtCtrls;

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

  private
    { Private declarations }

  public
    { Public declarations }

  end;

var
  SalesScreen: TSalesScreen;

implementation

{$R *.dfm}

end.

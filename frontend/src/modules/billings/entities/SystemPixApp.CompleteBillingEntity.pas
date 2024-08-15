unit SystemPixApp.CompleteBillingEntity;

interface

uses
  System.Generics.Collections,

  ACBrPIXBase,
  ACBrPIXSchemasPix,

  PointOfSale.PixEntity,
  PointOfSale.DevolutionEntity;

type
  TAppCompletedBillingEntity = class
    private
      FExists: boolean;
      FTxID: string;
      FCopyAndPaste: string;
      FLocation: string;
      FValue: real;
      FStatus: TACBrPIXStatusCobranca;
      FHasPix: boolean;
      FPix: TCompletedBillingPixArray;

    public
      property Exists: boolean read FExists write FExists;
      property TxID: string read FTxID write FTxID;
      property CopyAndPaste: string read FCopyAndPaste write FCopyAndPaste;
      property Location: string read FLocation write FLocation;
      property Value: real read FValue write FValue;
      property Status: TACBrPIXStatusCobranca read FStatus write FStatus;
      property HasPix: boolean read FHasPix write FHasPix;
      property Pix: TCompletedBillingPixArray read FPix write FPix;

      constructor Create;
      destructor Destroy; override;
  end;

implementation

{ TCompletedBillingEntity }


constructor TAppCompletedBillingEntity.Create;
begin
  FExists       := false;
  FTxID         := '';
  FCopyAndPaste := '';
  FValue        := 0;
  FStatus       := stcNENHUM;
  FHasPix       := false;
  FPix          := TCompletedBillingPixArray.Create;
end;


destructor TAppCompletedBillingEntity.Destroy;
begin
  inherited;

  FPix.Free;
end;


end.

unit SystemPixApp.CompleteBillingEntity;

interface

uses
  System.DateUtils,
  System.Generics.Collections,

  ACBrPIXBase,
  ACBrPIXSchemasPix,

  PointOfSale.PixEntity,
  PointOfSale.DevolutionEntity;

type
  TMainBillingStatus = (
    NONE, ACTIVED, COMPLETED, REMOVED_BY_USER, REMOVED_BY_PSP
  );

  TAppCompletedBillingEntity = class
    private
      FKey: string;
      FTxID: string;
      FCopyAndPaste: string;
      FLocation: string;
      FValue: real;
      FRevisionNumber: integer;
      FStatus: TACBrPIXStatusCobranca;
      FDebtorsName: string;
      FCreatedAt: TDateTime;
      FExpiration: integer;
      FHasPix: boolean;
      FPix: TCompletedBillingPixArray;
      FExists: boolean;

    public
      property Exists: boolean read FExists write FExists;
      property Key: string read FKey write FKey;
      property TxID: string read FTxID write FTxID;
      property CopyAndPaste: string read FCopyAndPaste write FCopyAndPaste;
      property Location: string read FLocation write FLocation;
      property Value: real read FValue write FValue;
      property RevisionNumber: integer read FRevisionNumber write FRevisionNumber;
      property Status: TACBrPIXStatusCobranca read FStatus write FStatus;
      property DebtorsName: string read FDebtorsName write FDebtorsName;
      property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
      property Expiration: integer read FExpiration write FExpiration;
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
  FCreatedAt    := EncodeDateTime(1900, 1, 1, 12, 0, 0, 0);
  FHasPix       := false;
  FPix          := TCompletedBillingPixArray.Create;
end;


destructor TAppCompletedBillingEntity.Destroy;
begin
  inherited;

  FPix.Free;
end;


end.

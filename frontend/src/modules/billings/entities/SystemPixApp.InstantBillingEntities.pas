unit SystemPixApp.InstantBillingEntities;

interface

uses
  ACBrPIXBase,
  ACBrPIXSchemasPix;

type
  TAppInstantBillingEntity = class
    private
      FExists: boolean;

    public
      property Exists: boolean read FExists write FExists;

      constructor Create;
  end;

  TReviseddBillingEntity = class
    private
      FExists: boolean;
      FKeyPix: string;
      FValue: real;
      FStatus: TACBrPIXStatusCobranca;


    public
      property Exists: boolean read FExists write FExists;
      property KeyPix: string read FKeyPix write FKeyPix;
      property Value: real read FValue write FValue;
      property Status: TACBrPIXStatusCobranca read FStatus write FStatus;

      constructor Create;
  end;

implementation

//uses
//  PointOfSale.Sale.Screen;


{ TAppInstantBillingEntity }

constructor TAppInstantBillingEntity.Create;
begin
  FExists := false;
end;



{ TReviseddBillingEntity }

constructor TReviseddBillingEntity.Create;
begin
  FExists := false;
  FKeyPix := '';
  FStatus := stcNENHUM;
  FValue  := 0;
end;

end.

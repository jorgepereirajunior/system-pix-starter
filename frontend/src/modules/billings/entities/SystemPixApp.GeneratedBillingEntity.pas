unit SystemPixApp.GeneratedBillingEntity;

interface

uses
  System.DateUtils,

  ACBrPIXBase;

type
  TAppGeneratedBillingEntity = class
    private
      FExists: boolean;
      FTxID: string;
      FLocation: string;
      FStatus: TACBrPIXStatusCobranca;
      FValue: real;
      FCopyAndPaste: string;
      FCreatedAt: TDateTime;
      FExpiration: integer;

    public
      property Exists: boolean read FExists write FExists;
      property TxID: string read FTxID write FTxID;
      property Location: string read FLocation write FLocation;
      property Status: TACBrPIXStatusCobranca read FStatus write FStatus;
      property Value: real read FValue write FValue;
      property CopyAndPaste: string read FCopyAndPaste write FCopyAndPaste;
      property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
      property Expiration: integer read FExpiration write FExpiration;

      constructor Create;

  end;

implementation

{ TGeneratedBillingEntity }

constructor TAppGeneratedBillingEntity.Create;
begin
  FExists       := false;
  FTxID         := '';
  FCopyAndPaste := '';
  FValue        := 0;
  FStatus       := stcNENHUM;
  FCreatedAt    := EncodeDateTime(1900, 1, 1, 12, 0, 0, 0);
  FExpiration   := 3600;
end;

end.

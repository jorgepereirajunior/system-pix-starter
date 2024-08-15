unit SystemPixApp.GeneratedBillingEntity;

interface

uses
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

    public
      property Exists: boolean read FExists write FExists;
      property TxID: string read FTxID write FTxID;
      property Location: string read FLocation write FLocation;
      property Status: TACBrPIXStatusCobranca read FStatus write FStatus;
      property Value: real read FValue write FValue;
      property CopyAndPaste: string read FCopyAndPaste write FCopyAndPaste;

      constructor Create;

  end;

implementation

{ TGeneratedBillingEntity }

constructor TAppGeneratedBillingEntity.Create;
begin
  FExists := false;
  FTxID    := '';
  FCopyAndPaste := '';
  FValue   := 0;
  FStatus  := stcNENHUM;
end;

end.

unit SystemPixApp.RequestedBillingEntity;

interface

type
  TAppRequestedBillingEntity = class
    private
      FExpiration: integer;
      FKeyPix: string;
      FValue: real;

    public
      property Expiration: integer read FExpiration write FExpiration;
      property KeyPix: string read FKeyPix write FKeyPix;
      property Value: real read FValue write FValue;

      constructor Create;
  end;

implementation

{ TRequestedBillingEntity }

constructor TAppRequestedBillingEntity.Create;
begin
  FExpiration := 3600;
  FKeyPix     := '';
  FValue      := 152.40;
end;

end.

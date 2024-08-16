unit SystemPixApp.RequestedBillingEntity;

interface

uses
  System.DateUtils;

type
  TAppRequestedBillingEntity = class
    private
      FKeyPix: string;
      FValue: real;
      FCreatedAt: TDateTime;
      FExpiration: integer;

    public
      property KeyPix: string read FKeyPix write FKeyPix;
      property Value: real read FValue write FValue;
      property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
      property Expiration: integer read FExpiration write FExpiration;

      constructor Create;
  end;

implementation

{ TRequestedBillingEntity }

constructor TAppRequestedBillingEntity.Create;
begin
  FKeyPix     := '';
  FValue      := 152.40;
  FCreatedAt  := EncodeDateTime(1900, 1, 1, 12, 0, 0, 0);
  FExpiration := 3600;
end;

end.

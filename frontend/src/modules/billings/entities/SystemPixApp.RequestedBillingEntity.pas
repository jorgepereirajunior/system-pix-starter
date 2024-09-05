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

uses
  SystemPixApi.ConfigFile.Functions,
  SystemPixApi.ConfigFile.Constants;

{ TRequestedBillingEntity }

constructor TAppRequestedBillingEntity.Create;
begin
  FKeyPix     := '';
  FValue      := 152.40;
  FCreatedAt  := EncodeDateTime(1900, 1, 1, 12, 0, 0, 0);
  FExpiration := TApiConfigFileFunctions.ReadIntegerValue(REQUESTED_BILLING_CONFIG_SECTION, REQUESTED_BILLING_CONFIG_KEY_NAME);
end;

end.

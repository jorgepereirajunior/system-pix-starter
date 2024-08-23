unit SystemPixApp.BillingEntity;

interface

uses
  System.SysUtils,
  System.DateUtils,

  SystemPixApp.PixEntity;

type
  TMainBillingStatus = (
    NONE, ACTIVED, COMPLETED, REMOVED_BY_USER, REMOVED_BY_PSP
  );

  TAppMainBillingEntity = class
    private
      FKey: string;
      FTxID: string;
      FCopyAndPaste: string;
      FLocation: string;
      FValue: real;
      FRevisionNumber: integer;
      FStatus: TMainBillingStatus;
      FDebtorsName: string;
      FCreatedAt: TDateTime;
      FExpiration: integer;
      FIsChecked: boolean;
      FPix: TPixArrayEntity;

    public
      property Key: string read FKey write FKey;
      property TxID: string read FTxID write FTxID;
      property CopyAndPaste: string read FCopyAndPaste write FCopyAndPaste;
      property Location: string read FLocation write FLocation;
      property Value: real read FValue write FValue;
      property RevisionNumber: integer read FRevisionNumber write FRevisionNumber;
      property Status: TMainBillingStatus read FStatus write FStatus;
      property DebtorsName: string read FDebtorsName write FDebtorsName;
      property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
      property Expiration: integer read FExpiration write FExpiration;
      property IsChecked: boolean read FIsChecked write FIsChecked;
      property Pix: TPixArrayEntity read FPix write FPix;

      constructor Create;
      destructor Destroy; override;
  end;

implementation


uses
  SystemPixApi.ConfigFile.Functions,
  SystemPixApi.ConfigFile.Constants;

{ TAppMainBillingEntity }

constructor TAppMainBillingEntity.Create;
begin
  FKey            := EmptyStr;
  FTxID           := EmptyStr;
  FCopyAndPaste   := EmptyStr;
  FLocation       := EmptyStr;
  FRevisionNumber := 0;
  FValue          := 25.00;
  FStatus         := NONE;
  FDebtorsName    := EmptyStr;
  FCreatedAt      := EncodeDateTime(1900, 1, 1, 12, 0, 0, 0);
  FExpiration     := TApiConfigFileFunctions.ReadIntegerValue(REQUESTED_BILLING_CONFIG_SECTION, REQUESTED_BILLING_CONFIG_KEY_NAME);
  FIsChecked      := false;

  FPix            := TPixArrayEntity.Create;
end;

destructor TAppMainBillingEntity.Destroy;
begin
  Fpix.Free;

  inherited;
end;

end.

unit SystemPixApp.BillingEntity;

interface

uses
  System.SysUtils,
  System.DateUtils,

  SystemPixApp.PixEntity;

type
  TBillingStatus = (
    NONE, ACTIVED, COMPLETED, REMOVED_BY_USER, REMOVED_BY_PSP
  );

  TAppBillingEntity = class
    private
      FKey: string;
      FTxID: string;
      FCopyAndPaste: string;
      FLocation: string;
      FValue: real;
      FRevisionNumber: integer;
      FStatus: TBillingStatus;
      FDebtorsName: string;
      FCreatedAt: TDateTime;
      FExpiration: integer;
      FExists: boolean;
      FIsChecked: boolean;
      FPix: TPixEntityArray;

    public
      property Key: string read FKey write FKey;
      property TxID: string read FTxID write FTxID;
      property CopyAndPaste: string read FCopyAndPaste write FCopyAndPaste;
      property Location: string read FLocation write FLocation;
      property Value: real read FValue write FValue;
      property RevisionNumber: integer read FRevisionNumber write FRevisionNumber;
      property Status: TBillingStatus read FStatus write FStatus;
      property DebtorsName: string read FDebtorsName write FDebtorsName;
      property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
      property Expiration: integer read FExpiration write FExpiration;
      property Exists: boolean read FExists write FExists;
      property IsChecked: boolean read FIsChecked write FIsChecked;
      property Pix: TPixEntityArray read FPix write FPix;

      constructor Create;
      destructor Destroy; override;
  end;

implementation


uses
  SystemPixApi.ConfigFile.Functions,
  SystemPixApi.ConfigFile.Constants;

{ TAppMainBillingEntity }

constructor TAppBillingEntity.Create;
begin
  FKey            := EmptyStr;
  FTxID           := EmptyStr;
  FCopyAndPaste   := EmptyStr;
  FLocation       := EmptyStr;
  FRevisionNumber := 0;
  FValue          := 29.90;
  FStatus         := NONE;
  FDebtorsName    := EmptyStr;
  FCreatedAt      := EncodeDateTime(1900, 1, 1, 12, 0, 0, 0);
  FExpiration     := TApiConfigFileFunctions.ReadIntegerValue(REQUESTED_BILLING_CONFIG_SECTION, REQUESTED_BILLING_CONFIG_KEY_NAME);
  FExists         := false;
  FIsChecked      := false;

  FPix            := TPixEntityArray.Create;
end;

destructor TAppBillingEntity.Destroy;
begin
  Fpix.Free;

  inherited;
end;

end.

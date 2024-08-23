unit SystemPixApp.PixEntity;

interface

uses
  System.SysUtils,
  System.DateUtils,
  System.Generics.Collections,

  SystemPixApp.DevolutionEntity;

type
  TPixEntity = class
    private
      FBillingTxID: string;
      FEndToEndId: string;
      FValue: real;
      FKey: string;
      FTime: TDateTime;
      FPaydAt: TDateTime;
      FDevolutions: TDevolutionArrayEntity;

    public
      property EndToEndId: string read FEndToEndId write FEndToEndId;
      property BillingTxID: string read FBillingTxID write FBillingTxID;
      property Value: real read FValue write FValue;
      property Key: string read FKey write FKey;
      property PaydAt: TDateTime read FPaydAt write FPaydAt;
      property Devolutions: TDevolutionArrayEntity read FDevolutions write FDevolutions;

      constructor Create;
      destructor Destroy; override;
  end;

  TPixArrayEntity = class
    private
      FItems: TObjectList<TPixEntity>;

    public
      property Items: TObjectList<TPixEntity> read FItems write FItems;

      constructor Create;
      destructor Destroy; override;
  end;

implementation


{ TPixEntity }

constructor TPixEntity.Create;
begin
  FEndToEndId  := EmptyStr;
  FBillingTxID := EmptyStr;
  FValue       := 0.00;
  FKey         := EmptyStr;
  FPaydAt      := EncodeDateTime(1900, 1, 1, 12, 0, 0, 0);

  FDevolutions := TDevolutionArrayEntity.Create;
end;

destructor TPixEntity.Destroy;
begin
  FDevolutions.Free;

  inherited;
end;



{ TPixArrayEntity }

constructor TPixArrayEntity.Create;
begin
  FItems := TObjectList<TPixEntity>.Create;
end;

destructor TPixArrayEntity.Destroy;
begin
  FItems.Free;

  inherited;
end;

end.

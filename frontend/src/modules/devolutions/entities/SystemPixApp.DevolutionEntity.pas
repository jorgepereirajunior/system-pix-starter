unit SystemPixApp.DevolutionEntity;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  System.DateUtils;

type
  TDevolutionStatus = (
    NONE, IN_PROCESSING, RETURNED, UNREALIZED
  );

  TDevolutionEntity = class
    private
      FID: string;
      FRtrID: string;
      FValue: real;
      FDescription: string;
      FRequestTime: TDateTime;
      FStatus: TDevolutionStatus;
      FReason: string;

    public
      property ID: string read FID write FID;
      property RtrID: string read FRtrID write FRtrID;
      property Value: real read FValue write FValue;
      property Description: string read FDescription write FDescription;
      property RequestTime: TDateTime read FRequestTime write FRequestTime;
      property Status: TDevolutionStatus read FStatus write FStatus;
      property Reason: string read FReason write FReason;

      constructor Create;
  end;

  TDevolutionArrayEntity = class
    private
      FItems: TObjectList<TDevolutionEntity>;

    public
      property Items: TObjectList<TDevolutionEntity> read FItems write FItems;

      constructor Create;
      destructor Destroy; override;
  end;

implementation

{ TDevolutionEntity }

constructor TDevolutionEntity.Create;
begin
  FID          := EmptyStr;
  FRtrID       := EmptyStr;
  FValue       := 0.00;
  FDescription := EmptyStr;
  FRequestTime := EncodeDateTime(1900, 1, 1, 12, 0, 0, 0);
  FStatus      := NONE;
  FReason      := EmptyStr;
end;



{ TDevolutionArrayEntity }

constructor TDevolutionArrayEntity.Create;
begin
  FItems := TObjectList<TDevolutionEntity>.Create;
end;

destructor TDevolutionArrayEntity.Destroy;
begin
  FItems.Free;

  inherited;
end;

end.

unit PointOfSale.DevolutionEntity;

interface

uses
  System.Generics.Collections,

  ACBrPIXBase;

type
  TDevolutionEntity = class
    private
      FID: string;
      FRtrID: string;
      FTime: TDateTime;
      FValue: real;
      FDescription: string;
      FStatus: TACBrPIXStatusDevolucao;
      FReason: string;

    public
      property ID: string read FID write FID;
      property RtrID: string read FRtrID write FRtrID;
      property Time: TDateTime read FTime write FTime;
      property Value: real read FValue write FValue;
      property Description: string read FDescription write FDescription;
      property Status: TACBrPIXStatusDevolucao read FStatus write FStatus;
      property Reason: string read FReason write FReason;

      constructor Create;
  end;

  TDevolutionArray = class
    private
      FList: TList<TDevolutionEntity>;
      FItems: TObjectList<TDevolutionEntity>;

      function GetItem(Index: Integer): TDevolutionEntity;
      procedure SetItem(Index: Integer; const Value: TDevolutionEntity);

    public
      constructor Create;
      destructor Destroy; override;

      property Items: TObjectList<TDevolutionEntity> read FItems write FItems;

      procedure Add(const Value: TDevolutionEntity);
  end;

implementation

{ TDevolutionEntity }

constructor TDevolutionEntity.Create;
begin
  FID          := '';
  FRtrID       := '';
  FValue       := 0.00;
  FDescription := '';
  FStatus      := stdNENHUM;
  FReason      := '';
end;


{ TDevolutionArray }


constructor TDevolutionArray.Create;
begin
  FList := TList<TDevolutionEntity>.Create;
  FItems := TObjectList<TDevolutionEntity>.Create;
end;

destructor TDevolutionArray.Destroy;
begin
  FList.Free;
  FItems.Free;

  inherited;
end;




procedure TDevolutionArray.Add(const Value: TDevolutionEntity);
begin
  FList.Add(Value);
end;



function TDevolutionArray.GetItem(Index: Integer): TDevolutionEntity;
begin
  Result := FList[Index];
end;



procedure TDevolutionArray.SetItem(Index: Integer; const Value: TDevolutionEntity);
begin
  FList[Index] := Value;
end;

end.

unit PointOfSale.PixEntity;

interface

uses
  System.Generics.Collections,

  PointOfSale.DevolutionEntity;

type
  TCompletedBillingPixEntity = class
    private
      FTxID: string;
      FEndToEndId: string;
      FValue: real;
      FKey: string;
      FTime: TDateTime;
      FDevolutions: TDevolutionArray;

    public
      constructor Create;
      destructor Destroy; override;

      property TxID: string read FTxID write FTxID;
      property EndToEndId: string read FEndToEndId write FEndToEndId;
      property Value: real read FValue write FValue;
      property Key: string read FKey write FKey;
      property Time: TDateTime read FTime write FTime;
      property Devolutions: TDevolutionArray read FDevolutions write FDevolutions;

  end;

  TCompletedBillingPixArray = class
    private
      FItems: TObjectList<TCompletedBillingPixEntity>;
      FHasDevolution: boolean;

    public
      constructor Create;
      destructor Destroy; override;

      property HasDevolution: boolean read FHasDevolution write FHasDevolution;
      property Items: TObjectList<TCompletedBillingPixEntity> read FItems write FItems;

  end;

implementation


{ TCompletedBillingPixEntity }

constructor TCompletedBillingPixEntity.Create;
begin
  FTxID          := '';
  FEndToEndId    := '';
  FValue         := 0.00;
  FKey           := '';

  FDevolutions := TDevolutionArray.Create;
end;

destructor TCompletedBillingPixEntity.Destroy;
begin
  FDevolutions.Free;

  inherited;
end;



{ TCompletedBillingPixArray }


constructor TCompletedBillingPixArray.Create;
begin
  HasDevolution := false;
  FItems := TObjectList<TCompletedBillingPixEntity>.Create;
end;


destructor TCompletedBillingPixArray.Destroy;
begin
  FItems.Free;

  inherited;
end;

end.

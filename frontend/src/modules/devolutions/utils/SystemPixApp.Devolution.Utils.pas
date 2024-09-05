unit SystemPixApp.Devolution.Utils;

interface

uses
  ACBrPIXBase,

  SystemPixApp.DevolutionEntity;

type
  TAppDevolutionUtils = class
    private

    public
      class function PassToInvalidEnumBillingDevolutionStatus(ValidEnum: TACBrPIXStatusDevolucao): TAppDevolutionStatus;

  end;

implementation

{ TAppDevolutionUtils }

class function TAppDevolutionUtils.PassToInvalidEnumBillingDevolutionStatus(ValidEnum: TACBrPIXStatusDevolucao): TAppDevolutionStatus;
begin
  case (ValidEnum) of
    stdNENHUM           : result := NONE;

    stdEM_PROCESSAMENTO : result := IN_PROCESSING;

    stdDEVOLVIDO        : result := RETURNED;

    stdNAO_REALIZADO    : result := UNREALIZED;
  end;
end;

end.

unit SystemPixApp.CurrentBilling.Utils;

interface

uses
  ACBrPIXBase,

  SystemPixApp.BillingEntity;

type
  TAppCurrentBillingUtils = class
    private

    public
      class function PassToInvalidEnumBillingStatus(ValidEnum: TACBrPIXStatusCobranca): TMainBillingStatus;

  end;
implementation

{ TAppCurrentBillingUtils }

class function TAppCurrentBillingUtils.PassToInvalidEnumBillingStatus(ValidEnum: TACBrPIXStatusCobranca): TMainBillingStatus;
begin
  case (ValidEnum) of
    stcNENHUM                         : result := NONE;

    stcATIVA                          : result := ACTIVED;

    stcCONCLUIDA                      : result := COMPLETED;

    stcREMOVIDA_PELO_USUARIO_RECEBEDOR: result := REMOVED_BY_USER;

    stcREMOVIDA_PELO_PSP              : result := REMOVED_BY_PSP;
  end;
end;

end.

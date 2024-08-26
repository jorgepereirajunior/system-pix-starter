unit SystemPixApp.CurrentBillingAsRevised.Functions;

interface

uses
  ACBrPIXBase,

  SystemPixApp.BillingEntity;

type
  TAppCurrentBillingAsRevisedFunctions = class
    private

    public
//      class procedure Clear;
//      class procedure UpdateKey;
//      class procedure UpdateTxID;
//      class procedure UpdateLocation;
      class procedure UpdateStatus;
//      class procedure UpdateValue;
//      class procedure UpdateCopyAndPaste;
//      class procedure UpdateCreationDate;
//      class procedure UpdateExpiration;
//      class procedure UpdateIsChecked(CheckValue: boolean);

//      class procedure UpdateAll;
  end;

implementation

uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.QRCode.Screen,

  SystemPixApp.CurrentBilling.Utils;

{ TAppCurrentBillingAsRevisedFunctions }


class procedure TAppCurrentBillingAsRevisedFunctions.UpdateStatus;

var
  LocalStatus: TMainBillingStatus;

begin
  CurrentBilling.Status :=
    TAppCurrentBillingUtils.PassToInvalidEnumBillingStatus(PIXComponent.PSP.epCob.CobRevisada.status);

end;

end.

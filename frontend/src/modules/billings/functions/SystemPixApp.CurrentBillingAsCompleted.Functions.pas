unit SystemPixApp.CurrentBillingAsCompleted.Functions;

interface

uses
  System.TypInfo,

  Vcl.Dialogs,

  ACBrPIXBase,

  SystemPixApp.BillingEntity;

type
  TAppCurrentBillingAsCompletedFunctions = class
    private

    public
//      class procedure Clear;
      class procedure UpdateKey;
      class procedure UpdateTxID;
      class procedure UpdateLocation;
      class procedure UpdateStatus;
      class procedure UpdateValue;
      class procedure UpdateCopyAndPaste;
      class procedure UpdateCreationDate;
      class procedure UpdateExpiration;
      class procedure UpdateIsChecked(CheckValue: boolean);

      class procedure UpdateAll;
  end;

implementation

uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.QRCode.Screen,

  SystemPixApp.CurrentBilling.Utils;

{ TAppCurrentBillingAsCompletedFunctions }

class procedure TAppCurrentBillingAsCompletedFunctions.UpdateAll;
begin
  UpdateKey;
  UpdateTxID;
  UpdateLocation;
  UpdateStatus;
  UpdateValue;
  UpdateCopyAndPaste;
  UpdateCreationDate;
  UpdateExpiration;
end;



class procedure TAppCurrentBillingAsCompletedFunctions.UpdateKey;
begin
  CurrentBilling.Key := PIXComponent.PSP.ChavePIX;
end;




class procedure TAppCurrentBillingAsCompletedFunctions.UpdateTxID;
begin
  CurrentBilling.TxID := PIXComponent.PSP.epCob.CobCompleta.txId;
end;




class procedure TAppCurrentBillingAsCompletedFunctions.UpdateLocation;
begin
  CurrentBilling.Location := PIXComponent.PSP.epCob.CobCompleta.location;
end;




class procedure TAppCurrentBillingAsCompletedFunctions.UpdateStatus;

var
  LocalStatus: TBillingStatus;

begin
  CurrentBilling.Status :=
    TAppCurrentBillingUtils.PassToInvalidEnumBillingStatus(PIXComponent.PSP.epCob.CobCompleta.status);
end;




class procedure TAppCurrentBillingAsCompletedFunctions.UpdateValue;
begin
  CurrentBilling.Value := PIXComponent.PSP.epCob.CobCompleta.valor.original;
end;




class procedure TAppCurrentBillingAsCompletedFunctions.UpdateCopyAndPaste;
begin
  CurrentBilling.CopyAndPaste := PIXComponent.PSP.epCob.CobCompleta.pixCopiaECola;
end;




class procedure TAppCurrentBillingAsCompletedFunctions.UpdateCreationDate;
begin
  CurrentBilling.CreatedAt := PIXComponent.PSP.epCob.CobCompleta.calendario.criacao;
end;




class procedure TAppCurrentBillingAsCompletedFunctions.UpdateExpiration;
begin
  CurrentBilling.Expiration := PIXComponent.PSP.epCob.CobCompleta.calendario.expiracao;
end;



class procedure TAppCurrentBillingAsCompletedFunctions.UpdateIsChecked(CheckValue: boolean);
begin
  CurrentBilling.IsChecked := not PIXComponent.PSP.epCob.CobCompleta.IsEmpty;
end;

end.

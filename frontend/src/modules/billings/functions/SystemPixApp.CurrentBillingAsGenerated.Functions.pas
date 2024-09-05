unit SystemPixApp.CurrentBillingAsGenerated.Functions;

interface

uses
  System.TypInfo,

  Vcl.Dialogs,

  ACBrPIXBase,

  SystemPixApp.BillingEntity;

type
  TAppCurrentBillingAsGeneratedFunctions = class
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
      class procedure UpdateExists;
      class procedure UpdateIsChecked(CheckValue: boolean);

      class procedure UpdateAll;
  end;

implementation

uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.QRCode.Screen,

  SystemPixApp.CurrentBilling.Utils;

{ TAppCurrentBillingFunctions }


class procedure TAppCurrentBillingAsGeneratedFunctions.UpdateAll;
begin
  UpdateKey;
  UpdateTxID;
  UpdateLocation;
  UpdateStatus;
  UpdateValue;
  UpdateCopyAndPaste;
  UpdateCreationDate;
  UpdateExists;
  UpdateExpiration;
end;



class procedure TAppCurrentBillingAsGeneratedFunctions.UpdateKey;
begin
  CurrentBilling.Key := PIXComponent.PSP.ChavePIX;
end;




class procedure TAppCurrentBillingAsGeneratedFunctions.UpdateTxID;
begin
  CurrentBilling.TxID := PIXComponent.PSP.epCob.CobGerada.txId;
end;




class procedure TAppCurrentBillingAsGeneratedFunctions.UpdateLocation;
begin
  CurrentBilling.Location := PIXComponent.PSP.epCob.CobGerada.location;
end;




class procedure TAppCurrentBillingAsGeneratedFunctions.UpdateStatus;

var
  LocalStatus: TBillingStatus;

begin
  CurrentBilling.Status :=
    TAppCurrentBillingUtils.PassToInvalidEnumBillingStatus(PIXComponent.PSP.epCob.CobGerada.status);
end;




class procedure TAppCurrentBillingAsGeneratedFunctions.UpdateValue;
begin
  CurrentBilling.Value := PIXComponent.PSP.epCob.CobGerada.valor.original;
end;




class procedure TAppCurrentBillingAsGeneratedFunctions.UpdateCopyAndPaste;
begin
  CurrentBilling.CopyAndPaste := PIXComponent.PSP.epCob.CobGerada.pixCopiaECola;
end;




class procedure TAppCurrentBillingAsGeneratedFunctions.UpdateCreationDate;
begin
  CurrentBilling.CreatedAt := PIXComponent.PSP.epCob.CobGerada.calendario.criacao;
end;




class procedure TAppCurrentBillingAsGeneratedFunctions.UpdateExpiration;
begin
  CurrentBilling.Expiration := PIXComponent.PSP.epCob.CobGerada.calendario.expiracao;
end;



class procedure TAppCurrentBillingAsGeneratedFunctions.UpdateExists;
begin
  CurrentBilling.Exists := not PIXComponent.PSP.epCob.CobGerada.IsEmpty;
end;



class procedure TAppCurrentBillingAsGeneratedFunctions.UpdateIsChecked(CheckValue: boolean);
begin
  CurrentBilling.IsChecked := not PIXComponent.PSP.epCob.CobGerada.IsEmpty;
end;

end.

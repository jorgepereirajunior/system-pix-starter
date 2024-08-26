unit SystemPixApp.GeneratedBilling.Functions;

interface

type
  TAppGeneratedBillingFunctions = class
    private

    public
      class procedure UpdateExists;
      class procedure UpdateTxID;
      class procedure UpdateLocation;
      class procedure UpdateStatus;
      class procedure UpdateValue;
      class procedure UpdateCopyAndPaste;
      class procedure UpdateCreationDate;
      class procedure UpdateExpiration;

//      class procedure UpdateAll;

  end;

implementation

{ TGeneratedBillingFunctions }

uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.QRCode.Screen;


//class procedure TAppGeneratedBillingFunctions.UpdateAll;
//begin
//  UpdateExists;
//  UpdateTxID;
//  UpdateLocation;
//  UpdateStatus;
//  UpdateValue;
//  UpdateCopyAndPaste;
//  UpdateCreationDate;
//  UpdateExpiration;
//end;





class procedure TAppGeneratedBillingFunctions.UpdateExists;
begin
  GeneratedBilling.Exists := not PIXComponent.PSP.epCob.CobGerada.IsEmpty;
end;



class procedure TAppGeneratedBillingFunctions.UpdateTxID;
begin
  GeneratedBilling.TxID := PIXComponent.PSP.epCob.CobGerada.txId;
end;



class procedure TAppGeneratedBillingFunctions.UpdateLocation;
begin
  GeneratedBilling.Location := PIXComponent.PSP.epCob.CobGerada.location;
end;



class procedure TAppGeneratedBillingFunctions.UpdateStatus;
begin
  //
end;



class procedure TAppGeneratedBillingFunctions.UpdateValue;
begin
  //
end;



class procedure TAppGeneratedBillingFunctions.UpdateCopyAndPaste;
begin
  GeneratedBilling.CopyAndPaste := PIXComponent.PSP.epCob.CobGerada.pixCopiaECola;
end;



class procedure TAppGeneratedBillingFunctions.UpdateCreationDate;
begin
  GeneratedBilling.CreatedAt := PIXComponent.PSP.epCob.CobGerada.calendario.criacao;
end;


class procedure TAppGeneratedBillingFunctions.UpdateExpiration;
begin
  GeneratedBilling.Expiration := PIXComponent.PSP.epCob.CobGerada.calendario.expiracao;
end;

end.

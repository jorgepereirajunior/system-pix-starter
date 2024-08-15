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

      class procedure UpdateAll;

  end;

implementation

{ TGeneratedBillingFunctions }

uses
  PointOfSale.Sale.Screen,
  PointOfSale.QRCode.Screen;


class procedure TAppGeneratedBillingFunctions.UpdateAll;
begin
  UpdateExists;
  UpdateTxID;
  UpdateLocation;
  UpdateStatus;
  UpdateValue;
  UpdateCopyAndPaste;
end;





class procedure TAppGeneratedBillingFunctions.UpdateExists;
begin
  GeneratedBilling.Exists       := not PDV_PIX.PSP.epCob.CobGerada.IsEmpty;
end;



class procedure TAppGeneratedBillingFunctions.UpdateTxID;
begin
  GeneratedBilling.TxID := PDV_PIX.PSP.epCob.CobGerada.txId;
end;



class procedure TAppGeneratedBillingFunctions.UpdateLocation;
begin
  GeneratedBilling.Location     := PDV_PIX.PSP.epCob.CobGerada.location;
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
  GeneratedBilling.CopyAndPaste := PDV_PIX.PSP.epCob.CobGerada.pixCopiaECola;
end;

end.

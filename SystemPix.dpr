program SystemPix;

uses
  Vcl.Forms,
  SystemPixApp.Sales.Screen in 'frontend\src\modules\transactions\screens\SystemPixApp.Sales.Screen.pas' {SalesScreen},
  SystemPixApi.ConfigFile.Constants in 'backend\src\config\SystemPixApi.ConfigFile.Constants.pas',
  SystemPixApi.ConfigFile.Functions in 'backend\src\config\SystemPixApi.ConfigFile.Functions.pas',
  SystemPixApi.ConfigFile.Utils in 'backend\src\config\SystemPixApi.ConfigFile.Utils.pas',
  SystemPixApp.QRCode.Screen in 'frontend\src\modules\transactions\screens\SystemPixApp.QRCode.Screen.pas' {QRCodeScreen},
  SystemPixApp.CompleteBillingEntity in 'frontend\src\modules\billings\entities\SystemPixApp.CompleteBillingEntity.pas',
  PointOfSale.DevolutionEntity in 'frontend\src\modules\billings\entities\PointOfSale.DevolutionEntity.pas',
  SystemPixApp.GeneratedBillingEntity in 'frontend\src\modules\billings\entities\SystemPixApp.GeneratedBillingEntity.pas',
  PointOfSale.PixEntity in 'frontend\src\modules\billings\entities\PointOfSale.PixEntity.pas',
  SystemPixApp.RequestedBillingEntity in 'frontend\src\modules\billings\entities\SystemPixApp.RequestedBillingEntity.pas',
  SystemPixApp.InstantBillingEntities in 'frontend\src\modules\billings\entities\SystemPixApp.InstantBillingEntities.pas',
  SystemPixApp.CompleteBilling.Functions in 'frontend\src\modules\billings\functions\SystemPixApp.CompleteBilling.Functions.pas',
  SystemPixApp.GeneratedBilling.Functions in 'frontend\src\modules\billings\functions\SystemPixApp.GeneratedBilling.Functions.pas',
  SystemPixApp.InstantBilling.Functions in 'frontend\src\modules\billings\functions\SystemPixApp.InstantBilling.Functions.pas',
  SystemPixApp.RequestedBilling.Functions in 'frontend\src\modules\billings\functions\SystemPixApp.RequestedBilling.Functions.pas',
  SystemPixApp.RevisedBilling.Functions in 'frontend\src\modules\billings\functions\SystemPixApp.RevisedBilling.Functions.pas',
  SystemPixApp.QRCodeScreen.Functions in 'frontend\src\modules\transactions\functions\SystemPixApp.QRCodeScreen.Functions.pas',
  SystemPixApp.PaymentStatusEntity in 'frontend\src\helpers\payment\enitites\SystemPixApp.PaymentStatusEntity.pas',
  SystemPixApp.CancelBilling.Modal in 'frontend\src\modules\modals\SystemPixApp.CancelBilling.Modal.pas' {CancelBillingModal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSalesScreen, SalesScreen);
  Application.CreateForm(TCancelBillingModal, CancelBillingModal);
  Application.Run;
end.

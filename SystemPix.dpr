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
  SystemPixApp.InstantBillingEntities in 'frontend\src\modules\billings\entities\SystemPixApp.InstantBillingEntities.pas',
  SystemPixApp.CompleteBilling.Functions in 'frontend\src\modules\billings\functions\SystemPixApp.CompleteBilling.Functions.pas',
  SystemPixApp.GeneratedBilling.Functions in 'frontend\src\modules\billings\functions\SystemPixApp.GeneratedBilling.Functions.pas',
  SystemPixApp.InstantBilling.Functions in 'frontend\src\modules\billings\functions\SystemPixApp.InstantBilling.Functions.pas',
  SystemPixApp.RevisedBilling.Functions in 'frontend\src\modules\billings\functions\SystemPixApp.RevisedBilling.Functions.pas',
  SystemPixApp.QRCodeScreen.Functions in 'frontend\src\modules\transactions\functions\SystemPixApp.QRCodeScreen.Functions.pas',
  SystemPixApp.PaymentStatusEntity in 'frontend\src\helpers\payment\enitites\SystemPixApp.PaymentStatusEntity.pas',
  SystemPixApp.CancelBilling.Modal in 'frontend\src\modules\modals\SystemPixApp.CancelBilling.Modal.pas' {CancelBillingModal},
  SystemPixApp.Constants in 'frontend\src\shared\constants\SystemPixApp.Constants.pas',
  SystemPixApp.Styles in 'frontend\src\shared\styles\SystemPixApp.Styles.pas',
  SystemPixApp.SaleScreen.Functions in 'frontend\src\modules\transactions\functions\SystemPixApp.SaleScreen.Functions.pas',
  SystemPixApp.QRCodeScreen.Utils in 'frontend\src\modules\transactions\utils\SystemPixApp.QRCodeScreen.Utils.pas',
  SystemPixApi.LogErrorFile.Constants in 'backend\src\logs\errors\SystemPixApi.LogErrorFile.Constants.pas',
  SystemPixApi.LogErrorFile.Utils in 'backend\src\logs\errors\SystemPixApi.LogErrorFile.Utils.pas',
  SystemPixApi.LogErrorFile.Functions in 'backend\src\logs\errors\SystemPixApi.LogErrorFile.Functions.pas',
  SystemPixApp.BillingEntity in 'frontend\src\modules\billings\entities\SystemPixApp.BillingEntity.pas',
  SystemPixApp.PixEntity in 'frontend\src\modules\pix\entities\SystemPixApp.PixEntity.pas',
  SystemPixApp.DevolutionEntity in 'frontend\src\modules\devolutions\entities\SystemPixApp.DevolutionEntity.pas',
  SystemPixApp.CurrentBillingAsGenerated.Functions in 'frontend\src\modules\billings\functions\SystemPixApp.CurrentBillingAsGenerated.Functions.pas',
  SystemPixApi.ACBrRequestBilling.Functions in 'backend\src\external\acbrpix\SystemPixApi.ACBrRequestBilling.Functions.pas',
  SystemPixApi.ACBrInstantBilling.Functions in 'backend\src\external\acbrpix\SystemPixApi.ACBrInstantBilling.Functions.pas',
  SystemPixApp.CurrentBilling.Utils in 'frontend\src\modules\billings\utils\SystemPixApp.CurrentBilling.Utils.pas',
  SystemPixApp.CurrentBillingAsCompleted.Functions in 'frontend\src\modules\billings\functions\SystemPixApp.CurrentBillingAsCompleted.Functions.pas',
  SystemPixApi.ACBrDevolution.Functions in 'backend\src\external\acbrpix\SystemPixApi.ACBrDevolution.Functions.pas',
  SystemPixApp.CurrentBillingAsRevised.Functions in 'frontend\src\modules\billings\functions\SystemPixApp.CurrentBillingAsRevised.Functions.pas',
  SystemPixApp.Pix.Functions in 'frontend\src\modules\pix\functions\SystemPixApp.Pix.Functions.pas',
  SystemPixApp.Devolution.Functions in 'frontend\src\modules\devolutions\functions\SystemPixApp.Devolution.Functions.pas',
  SystemPixApp.Devolution.Utils in 'frontend\src\modules\devolutions\utils\SystemPixApp.Devolution.Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSalesScreen, SalesScreen);
  Application.CreateForm(TCancelBillingModal, CancelBillingModal);
  Application.Run;
end.

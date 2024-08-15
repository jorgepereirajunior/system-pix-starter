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
  SystemPixApp.InstantBillingEntities in 'frontend\src\modules\billings\entities\SystemPixApp.InstantBillingEntities.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSalesScreen, SalesScreen);
  Application.Run;
end.

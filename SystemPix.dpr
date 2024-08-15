program SystemPix;

uses
  Vcl.Forms,
  SystemPixApp.Sales.Screen in 'frontend\src\modules\transactions\screens\SystemPixApp.Sales.Screen.pas' {SalesScreen},
  PointOfSale.ConfigFile.Constants in 'backend\src\config\PointOfSale.ConfigFile.Constants.pas',
  PointOfSale.ConfigFile.Functions in 'backend\src\config\PointOfSale.ConfigFile.Functions.pas',
  PointOfSale.ConfigFile.Utils in 'backend\src\config\PointOfSale.ConfigFile.Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSalesScreen, SalesScreen);
  Application.Run;
end.

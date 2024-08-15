program SystemPix;

uses
  Vcl.Forms,
  SystemPixApp.Sales.Screen in 'frontend\src\modules\transactions\screens\SystemPixApp.Sales.Screen.pas' {SalesScreen},
  SystemPixApi.ConfigFile.Constants in 'backend\src\config\SystemPixApi.ConfigFile.Constants.pas',
  SystemPixApi.ConfigFile.Functions in 'backend\src\config\SystemPixApi.ConfigFile.Functions.pas',
  SystemPixApi.ConfigFile.Utils in 'backend\src\config\SystemPixApi.ConfigFile.Utils.pas',
  SystemPixApp.QRCode.Screen in 'frontend\src\modules\transactions\screens\SystemPixApp.QRCode.Screen.pas' {QRCodeScreen};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSalesScreen, SalesScreen);
  Application.CreateForm(TQRCodeScreen, QRCodeScreen);
  Application.Run;
end.

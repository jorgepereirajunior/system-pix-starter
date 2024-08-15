program SystemPix;

uses
  Vcl.Forms,
  SystemPixApp.Sales.Screen in 'frontend\src\modules\transactions\screens\SystemPixApp.Sales.Screen.pas' {SalesScreen};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSalesScreen, SalesScreen);
  Application.Run;
end.

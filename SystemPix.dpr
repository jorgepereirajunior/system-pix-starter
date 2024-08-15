program SystemPix;

uses
  Vcl.Forms,
  SystemPixApp.Sales.Screen in 'frontend\src\modules\transactions\screens\SystemPixApp.Sales.Screen.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

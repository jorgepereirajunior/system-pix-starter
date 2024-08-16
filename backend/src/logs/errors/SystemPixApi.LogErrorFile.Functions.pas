unit SystemPixApi.LogErrorFile.Functions;

interface

uses
  System.SysUtils,

  Vcl.Dialogs;

type
  TApiLogErrorFileFunctions = class
    private
    public
//      class function ReadValueFromFile(Section, FieldValue: string): string;
      class procedure RegisterLastErrorInstantBilling(InstantBillingError: string);

  end;

implementation

uses
  SystemPixApi.LogErrorFile.Utils;

{ TApiLogErrorFileFunctions }


class procedure TApiLogErrorFileFunctions.RegisterLastErrorInstantBilling(InstantBillingError: string);

var
  LogicalLogFile: TextFile;

begin
  AssignFile(LogicalLogFile, TApiLogErrorFileUtils.GetLastErrorInstantBillingPhysicalFile);

  Rewrite(LogicalLogFile);

  Writeln(LogicalLogFile, '===========================================================');
  Writeln(LogicalLogFile, 'TENTATIVA DE CRIAÇÃO EM: ' +DateTimeToStr(TDATETIME(Now)));
  Writeln(LogicalLogFile, 'DETALHE DO ERRO: ' +InstantBillingError);
  Writeln(LogicalLogFile, '===========================================================');
  Writeln(LogicalLogFile, '');

  CloseFile(LogicalLogFile);
end;

end.

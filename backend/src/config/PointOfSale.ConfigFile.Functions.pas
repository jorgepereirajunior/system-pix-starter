unit PointOfSale.ConfigFile.Functions;

interface

uses
  System.SysUtils,
  System.IniFiles,

  Vcl.Dialogs;

type
  TConfigFileFunctions = class
    private
    public
      class function ReadStringValue(Section, FieldValue: string): string;
      class procedure WriteStringValue(Section, FieldValue, AStringValue: string);

      class function ReadIntegerValue(Section, FieldValue: string): integer;
      class procedure WriteIntegerValue(Section, FieldValue: string; AIntegerValue: integer);

  end;

implementation

{ TConfigFileFunctions }

uses
  PointOfSale.ConfigFile.Constants,
  PointOfSale.ConfigFile.Utils;

class function TConfigFileFunctions.ReadIntegerValue(Section, FieldValue: string): integer;
begin

end;


class procedure TConfigFileFunctions.WriteIntegerValue(Section, FieldValue: string; AIntegerValue: integer);
begin

end;









class function TConfigFileFunctions.ReadStringValue(Section, FieldValue: string): string;

var
  CONFIG_FILE_IN_MEMORY: TIniFile;

  ResultValue: string;

begin
  CONFIG_FILE_IN_MEMORY := TIniFile.Create(TConfigFileUtils.GetPhysicalFile);

  try

    ResultValue := CONFIG_FILE_IN_MEMORY.ReadString(Section, FieldValue, ResultValue);

  finally

    CONFIG_FILE_IN_MEMORY.Free;
  end;

  result := ResultValue;
end;




class procedure TConfigFileFunctions.WriteStringValue(Section, FieldValue, AStringValue: string);

var
  CONFIG_FILE_IN_MEMORY: TIniFile;

begin
  CONFIG_FILE_IN_MEMORY := TIniFile.Create(TConfigFileUtils.GetPhysicalFile);

  try
    CONFIG_FILE_IN_MEMORY.WriteString(Section, FieldValue, AStringValue);

  finally

    CONFIG_FILE_IN_MEMORY.Free;
  end;
end;

end.

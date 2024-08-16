unit SystemPixApi.ConfigFile.Functions;

interface

uses
  System.SysUtils,
  System.IniFiles,

  Vcl.Dialogs;

type
  TApiConfigFileFunctions = class
    private
    public
      class function ReadStringValue(Section, FieldValue: string): string;
      class procedure WriteStringValue(Section, FieldValue, AStringValue: string);

      class function ReadIntegerValue(Section, FieldValue: string): integer;
      class procedure WriteIntegerValue(Section, FieldValue: string; AIntegerValue: integer);

  end;

implementation

uses
  SystemPixApi.ConfigFile.Constants,
  SystemPixApi.ConfigFile.Utils;

{ TConfigFileFunctions }


class function TApiConfigFileFunctions.ReadIntegerValue(Section, FieldValue: string): integer;

var
  CONFIG_FILE_IN_MEMORY: TIniFile;

  ResultValue: integer;

begin
  CONFIG_FILE_IN_MEMORY := TIniFile.Create(TApiConfigFileUtils.GetPhysicalFile);

  try

    ResultValue := CONFIG_FILE_IN_MEMORY.ReadInteger(Section, FieldValue, ResultValue);

  finally

    CONFIG_FILE_IN_MEMORY.Free;
  end;

  result := ResultValue;
end;




class procedure TApiConfigFileFunctions.WriteIntegerValue(Section, FieldValue: string; AIntegerValue: integer);
var
  CONFIG_FILE_IN_MEMORY: TIniFile;

begin
  CONFIG_FILE_IN_MEMORY := TIniFile.Create(TApiConfigFileUtils.GetPhysicalFile);

  try
    CONFIG_FILE_IN_MEMORY.WriteInteger(Section, FieldValue, AIntegerValue);

  finally

    CONFIG_FILE_IN_MEMORY.Free;
  end;

end;









class function TApiConfigFileFunctions.ReadStringValue(Section, FieldValue: string): string;

var
  CONFIG_FILE_IN_MEMORY: TIniFile;

  ResultValue: string;

begin
  CONFIG_FILE_IN_MEMORY := TIniFile.Create(TApiConfigFileUtils.GetPhysicalFile);

  try

    ResultValue := CONFIG_FILE_IN_MEMORY.ReadString(Section, FieldValue, ResultValue);

  finally

    CONFIG_FILE_IN_MEMORY.Free;
  end;

  result := ResultValue;
end;




class procedure TApiConfigFileFunctions.WriteStringValue(Section, FieldValue, AStringValue: string);

var
  CONFIG_FILE_IN_MEMORY: TIniFile;

begin
  CONFIG_FILE_IN_MEMORY := TIniFile.Create(TApiConfigFileUtils.GetPhysicalFile);

  try
    CONFIG_FILE_IN_MEMORY.WriteString(Section, FieldValue, AStringValue);

  finally

    CONFIG_FILE_IN_MEMORY.Free;
  end;
end;

end.

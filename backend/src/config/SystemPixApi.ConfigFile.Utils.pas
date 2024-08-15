unit SystemPixApi.ConfigFile.Utils;

interface

uses
  System.SysUtils;

type
  TApiConfigFileUtils = class
    private

    public
      class function GetPhysicalFile: string;
  end;


implementation

{ TConfigFileUtils }

uses
  SystemPixApi.ConfigFile.Constants;

class function TApiConfigFileUtils.GetPhysicalFile: string;
begin
  Result := GetCurrentDir+ '\' +CONFIG_FILE_PHYSICAL;
end;

end.

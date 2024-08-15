unit PointOfSale.ConfigFile.Utils;

interface

uses
  System.SysUtils;

type
  TConfigFileUtils = class
    private

    public
      class function GetPhysicalFile: string;
  end;


implementation

{ TConfigFileUtils }

uses
  PointOfSale.ConfigFile.Constants;

class function TConfigFileUtils.GetPhysicalFile: string;
begin
  Result := GetCurrentDir+ '\' +CONFIG_FILE_PHYSICAL;
end;

end.

unit SystemPixApi.LogErrorFile.Utils;

interface

uses
  System.SysUtils;

type
  TApiLogErrorFileUtils = class
    private

    public
      class function GetLastErrorInstantBillingPhysicalFile: string;
  end;

implementation

uses
  SystemPixApi.LogErrorFile.Constants;

{ TApiLogErrorFileUtils }

class function TApiLogErrorFileUtils.GetLastErrorInstantBillingPhysicalFile: string;
begin
  Result := GetCurrentDir+ '\' +LAST_ERROR_INSTANT_BILLING_FILE_PHYSICAL;
end;

end.

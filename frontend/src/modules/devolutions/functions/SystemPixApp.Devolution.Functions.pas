unit SystemPixApp.Devolution.Functions;

interface

uses
  System.SysUtils,

  ACBrPIXBase;

type
  TDevolutionFunctions = class
    private

    public
      class procedure ClearDevolutions;

      class procedure SetDevolutionDescription(ADescription: string);
      class procedure SetDevolutionValue(AValue: real);
      class procedure SetDevolutionNature(ANature: TACBrPIXNaturezaDevolucao);

      class function RequestDevolutionWasSuccessful: boolean;
  end;

implementation

uses
  SystemPixApp.Sales.Screen,
  SystemPixApp.QRCode.Screen;

{ TDevolutionFnctions }

class procedure TDevolutionFunctions.ClearDevolutions;
begin
  PIXComponent.PSP.epPix.DevolucaoSolicitada.Clear;
end;





class procedure TDevolutionFunctions.SetDevolutionDescription(ADescription: string);
begin
  PIXComponent.PSP.epPix.DevolucaoSolicitada.descricao := ADescription;
end;



class procedure TDevolutionFunctions.SetDevolutionNature(ANature: TACBrPIXNaturezaDevolucao);
begin
  PIXComponent.PSP.epPix.DevolucaoSolicitada.natureza := ANature;
end;



class procedure TDevolutionFunctions.SetDevolutionValue(AValue: real);
begin
  PIXComponent.PSP.epPix.DevolucaoSolicitada.valor := AValue;
end;






class function TDevolutionFunctions.RequestDevolutionWasSuccessful: boolean;
begin
  result := PIXComponent.PSP.epPix.SolicitarDevolucaoPix(
    CurrentBilling.Pix.Items[0].EndToEndId,
    StringReplace(CurrentBilling.Pix.Items[0].endToEndId, 'E','D', [rfReplaceAll])
  );
end;

end.

//Rekurencja_I_Iteracja Szpilski Dominik 147915 20_21 INF S1 v1.0
unit rekurencja_i_iteracja_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    CalculateBtn: TButton;
    InfoBtn: TButton;
    TerminateBtn: TButton;
    ValueEdit: TEdit;
    IterationEdit: TEdit;
    RecResEdit: TEdit;
    RecTimeEdit: TEdit;
    ItResEdit: TEdit;
    ItTimeEdit: TEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    procedure CalculateBtnClick(Sender: TObject);
    procedure InfoBtnClick(Sender: TObject);
    procedure TerminateBtnClick(Sender: TObject);
  private
    procedure CalculateIteration(value,iterate: int64);
    procedure runCalculateRecuration(value,iterate: int64);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

function CalculateRecuration(value:int64): int64;
begin
   if value=1 then
   begin
     CalculateRecuration:=value;
   end
   else
   begin
     CalculateRecuration:=value*CalculateRecuration(value-1);
   end;
end;

procedure TForm1.runCalculateRecuration(value,iterate:int64);
var i,finalResult:int64;
  temp:double;
begin
   i:=0;
  temp:=Time*24*60*60;
  finalResult:=3;
  repeat
    i:=i+1;
    finalResult:=CalculateRecuration(value);
  until i >= iterate;
  RecResEdit.Text:=IntToStr(finalResult);
  RecTimeEdit.Text:=FloatToStr(((Time*24*60*60)-temp));
end;

procedure TForm1.CalculateIteration(value,iterate:int64);
var i,result,finalResult,tempValue:int64;
  temp:double;
begin
  i:=0;
  temp:=Time*24*60*60;
  finalResult:=3;
  repeat
    i:=i+1;
    result:=value;
    tempValue:=value;
    repeat
          tempValue:=tempValue-1;
          if tempValue <> 0 then
          begin
            result:=result*tempValue;
          end;

    until tempValue <= 0;
    finalResult:=result;
  until i >= iterate;
  ItResEdit.Text:=IntToStr(finalResult);
  ItTimeEdit.Text:=FloatToStr(((Time*24*60*60)-temp));
end;



procedure TForm1.CalculateBtnClick(Sender: TObject);
var value,iterator: int64;
begin
   try
     value:= StrToInt(ValueEdit.Text);
     iterator:= StrToInt(IterationEdit.Text);
     CalculateBtn.enabled:=false;
     CalculateIteration(value,iterator);
     runCalculateRecuration(value,iterator);
     CalculateBtn.enabled:=true;
   except
     Application.MessageBox('Wystąpił błąd podczas konwersji','Błąd');
   end;
end;

procedure TForm1.InfoBtnClick(Sender: TObject);
begin
  Application.MessageBox('Rekurencja_I_Iteracja Szpilski Dominik 147915 20_21 INF S1 v1.0','Info');
end;

procedure TForm1.TerminateBtnClick(Sender: TObject);
begin
  Application.Terminate;
end;


end.


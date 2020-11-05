//Szpilski Dominik 147915 20_21 INF S1 v1.1
unit Maszyna_Trurla_Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, LCLIntf;

type

  { TForm1 }

  TForm1 = class(TForm)
    CalculateBtn: TButton;
    LoadHistoryBtn: TButton;
    InfoBtn: TButton;
    QuitBtn: TButton;
    FirstElementEdit: TEdit;
    SecondElementEdit: TEdit;
    ResultEdit: TEdit;
    HistoryList: TListBox;
    MainCanvas: TPaintBox;
    X: TStaticText;
    equal: TStaticText;
    History: TStaticText;
    procedure CalculateBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InfoBtnClick(Sender: TObject);
    procedure LoadHistoryBtnClick(Sender: TObject);
    procedure QuitBtnClick(Sender: TObject);

  private
    const historyFilePath = 'Maszyna_Trurla.txt';
    procedure loadHistoryFromFile();
    procedure saveEquationToFile(e1,e2,result: double);
    procedure showConversionError();
    procedure paintRandomOnCanvas();
    procedure simulateCalculation(result: double);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}



function getRandomBetween(a, b: double): double;
begin
  getRandomBetween := a + Random() * (b - a);
end;





{ TForm1 }
procedure TForm1.showConversionError();
   var message: string;
   i,randomNr: integer;
begin
   i:=0;
   message:='';

   repeat
       randomNr:=  Round(getRandomBetween(33,127));
       Application.ProcessMessages;
       message := message+Chr(randomNr);
       i:=i+1;
   until i >= 10;
   ResultEdit.Text:=message;
end;
procedure TForm1.paintRandomOnCanvas();
var x1,y1,x2,y2: integer;
begin
   MainCanvas.Canvas.Brush.Color:= RGB(random(256),random(256),random(256));
   x1:= Round(getRandomBetween(0,MainCanvas.Width));
   y1:= Round(getRandomBetween(0,MainCanvas.Height));
   x2:=x1+Round(getRandomBetween(0,200));
   y2:=y1+Round(getRandomBetween(0,200));
   MainCanvas.Canvas.Rectangle(x1,y1,x2,y2);
end;

procedure TForm1.saveEquationToFile(e1,e2,result: double);
var historyFile: text;
begin
   AssignFile(historyFile,historyFilePath);
   try
      if FileExists(historyFilePath) then
      begin
          Append(historyFile);
      end
      else
      begin
         Rewrite(historyFile);
         Append(historyFile);
      end;
   except
     Rewrite(historyFile);
   end;
   writeLn(historyFile,e1,e2,result);
   CloseFile(historyFile);
end;

procedure TForm1.loadHistoryFromFile();
var historyFile: text;
  element1,element2,result:double;
begin
  AssignFile(historyFile,historyFilePath);
  try
      if FileExists(historyFilePath) then
      begin
          Reset(historyFile);
      end
      else
      begin
         Rewrite(historyFile);
         Reset(historyFile);
      end;
   except
     Rewrite(historyFile);
   end;
   while not Eof(historyFile) do
   begin
         readLn(historyFile,element1,element2,result);
         HistoryList.Items.Add(FloatToStr(element1)+' * '+FloatToStr(element2)+' = '+FloatToStr(result));
   end;
   CloseFile(historyFile);
end;

procedure TForm1.simulateCalculation(result: double);
var timeInS, timeTempStorage: double;
begin
   timeInS:=Time*24*60*60;
   timeTempStorage:=timeInS+3;
   repeat
      timeInS:=Time*24*60*60;
      Application.ProcessMessages;
      ResultEdit.Text := FloatToStr(getRandomBetween(0,result+0.23));
      paintRandomOnCanvas();
      sleep(100);
   until timeInS >= timeTempStorage;
end;

procedure TForm1.CalculateBtnClick(Sender: TObject);
var value1,value2,result: double;
showError: boolean;
begin
  try
      value1:=StrToFloat(FirstElementEdit.Text);
      value2:=StrToFloat(SecondElementEdit.Text);
      if (value1 = 2) and (value2 = 2) then
      begin
         result := 7;
      end
      else if (value1 = 2) and (value2 = 1) then
      begin
         result := 6;
      end
      else if(value1 =1) and (value2 = 1) then
      begin
         result :=0;
      end
      else if round(getRandomBetween(0,1)) = 0 then
      begin
         result := getRandomBetween(0,(value1*value2)+0.23);
      end
      else
      begin
         result := value1*value2;
      end;
      simulateCalculation(result);
      ResultEdit.Text := FloatToStr(result);
      saveEquationToFile(value1,value2,result);
  except
      Application.MessageBox('Blad','Test');
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.InfoBtnClick(Sender: TObject);
begin
  Application.MessageBox('Szpilski Dominik 147915 20_21 INF S1 v1.1','');
end;

procedure TForm1.LoadHistoryBtnClick(Sender: TObject);
begin
     loadHistoryFromFile();
end;

procedure TForm1.QuitBtnClick(Sender: TObject);
begin
  Application.Terminate;
end;




end.


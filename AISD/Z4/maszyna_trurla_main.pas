//Szpilski Dominik 147915 20_21 INF S1
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
var recWidth, recHeight,c1,c2: integer;
begin
   randomize;
   MainCanvas.Canvas.Brush.Color := clDefault;
   MainCanvas.Canvas.Rectangle(0,0,MainCanvas.Width,MainCanvas.Height);
   recWidth := Round(getRandomBetween(0,MainCanvas.Width));
   recHeight := Round(getRandomBetween(0,MainCanvas.Height));
   if recWidth <MainCanvas.Width/2 then
   begin
        c1 := Round((MainCanvas.Width/2) + recWidth/2);
   end
   else
   begin
        c1 := Round((MainCanvas.Width/2) - recWidth/2);
   end;
   if recHeight <MainCanvas.Height/2 then
   begin
        c2 := Round((MainCanvas.Height/2) + recHeight/2);
   end
   else
   begin
        c2 := Round((MainCanvas.Height/2) - recHeight/2);
   end;
   MainCanvas.Canvas.Brush.Color := rgb(random(256), random(256), random(256));
   if Round(getRandomBetween(0,1)) = 0 then
   begin
        MainCanvas.Canvas.Rectangle(c1,c2,recWidth,recHeight);
   end
   else
   begin
        MainCanvas.Canvas.Ellipse(c1,c2,recWidth,recHeight);
   end;

end;

procedure TForm1.saveEquationToFile(e1,e2,result: double);
var historyFile: text;
begin
  AssignFile(historyFile,historyFilePath);
  try
    Append(historyFile);
  except
    Rewrite(historyFile);
  end;
  WriteLn(historyFile,e1,e2,result);
  CloseFile(historyFile);
end;

procedure TForm1.loadHistoryFromFile();
var historyFile: text;
  element1,element2,result:double;
begin
    LoadHistoryBtn.enabled := false;
    HistoryList.Clear;
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
      exit
    end;
    while not Eof(historyFile) do
     begin
       ReadLn(historyFile,element1,element2,result);
       HistoryList.Items.Add(FloatToStr(element1)+' * '+FloatToStr(element2)+' = '+ FloatToStr(result));
     end;
    CloseFile(historyFile);
    LoadHistoryBtn.enabled := true;
end;

procedure TForm1.simulateCalculation(result: double);
var timeInS, timeTempStorage: double;
begin
  timeInS:=Time*24*60*60;
  timeTempStorage:=timeInS;
  CalculateBtn.enabled := false;
  repeat
      ResultEdit.Text := FloatToStr((result+0.2) - getRandomBetween(0,result+0.2));
      paintRandomOnCanvas();
      Application.ProcessMessages;
      Sleep(100);
      timeInS:=Time*24*60*60;
  until timeInS >= timeTempStorage + 3;
  CalculateBtn.enabled := true;
end;

procedure TForm1.CalculateBtnClick(Sender: TObject);
var value1,value2,result: double;
showError: boolean;
begin
  showError:=true;
  result:= -1;
  try
    if (FirstElementEdit.Text = '2') and (SecondElementEdit.Text = '1') then
        begin
             result:= 6;
             showError:=false;
        end
    else if (FirstElementEdit.Text = '2') and (SecondElementEdit.Text = '2') then
        begin
            result:= 7;
            showError:=false;
        end
    else if (FirstElementEdit.Text = '1') and (SecondElementEdit.Text = '1') then
        begin
            result:= 0;
            showError:=false;;
        end;
    value1:= StrToFloat(FirstElementEdit.Text);
    value2:= StrToFloat(SecondElementEdit.Text);
    if (Round(getRandomBetween(0,1)) = 0) and (showError = true) then
        begin
          result:= ((value1*value2)+0.2) - getRandomBetween(0,(value1*value2+0.2));
        end
    else if result = -1 then
        begin
          result := value1*value2;
        end;
    simulateCalculation(result);
    ResultEdit.Text := FloatToStr(result);
    saveEquationToFile(value1,value2,result);
    loadHistoryFromFile();
  except
      simulateCalculation(2);
      showConversionError();
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   loadHistoryFromFile();
end;

procedure TForm1.InfoBtnClick(Sender: TObject);
begin
  Application.MessageBox('Szpilski Dominik 147915 20_21 INF S1 v1.0','');
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


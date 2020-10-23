//Maszyna Trurla Szpilski Dominik 147915 INF S1
unit Maszyna_Trurla_Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    var Liczba: double;
    const Komunikat = 'Błąd konwersji liczby z łańcucha: ';
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button2Click(Sender: TObject);
begin
    Application.Terminate;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    Application.MessageBox(PChar('Maszyna Trurla Szpilski Dominik 147915 INF S1'), 'Info');
end;

procedure TForm1.Button3Click(Sender: TObject);
var TempLiczba:string;
begin
    try
      Liczba:= StrToFloat(Edit1.Text);
      Memo1.Text:= FloatToStr(Liczba);
    except
      TempLiczba := Edit1.Text;
      Memo1.Text:= '';
      Edit1.Text:= '';
      Application.MessageBox(PChar(Komunikat+TempLiczba),'Błąd');
    end;

end;




end.


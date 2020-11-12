unit gviewcode;

{$mode objfpc}{$H+}

interface

uses sysutils ,Classes, Forms, Controls, Graphics, ShellCtrls, FileCtrl, ExtCtrls, ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    FileListBox1: TFileListBox;
    Image1: TImage;
    ShellTreeView1: TShellTreeView;
    StatusBar1: TStatusBar;
    procedure FileListBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ShellTreeView1Change(Sender: TObject; Node: TTreeNode);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var Form1: TForm1;
procedure window_setup();
procedure viewer_setup();
procedure resize_window();
procedure setup();

implementation

procedure window_setup();
begin
 Application.Title:='GRAPHIC VIEW';
 Form1.Caption:='GRAPHIC VIEW 2.2.5';
 Form1.BorderStyle:=bsSizeable;
 Form1.Font.Name:=Screen.MenuFont.Name;
 Form1.Font.Size:=14;
end;

procedure viewer_setup();
begin
 Form1.Image1.Stretch:=False;
 Form1.Image1.Center:=False;
 Form1.Image1.AutoSize:=False;
 Form1.Image1.Proportional:=True;
 Form1.FileListBox1.MultiSelect:=False;
 Form1.FileListBox1.Sorted:=True;
 Form1.StatusBar1.SimpleText:='';
 Form1.FileListBox1.Mask:='*.bmp;*.jpg;*.ico;*.emf;*.wmf *.png;*.gif;*.pxm';
end;

procedure resize_window();
begin
 Form1.FileListBox1.Height:=Form1.ClientHeight-(Form1.ShellTreeView1.Top+Form1.ShellTreeView1.ClientHeight+10);
 Form1.Image1.Width:=Form1.Width-(Form1.ShellTreeView1.Left+Form1.ShellTreeView1.ClientWidth);
 Form1.Image1.Height:=Form1.ClientHeight;
end;

procedure setup();
begin
 window_setup();
 viewer_setup();
 resize_window();
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
 setup();
end;

procedure TForm1.FormResize(Sender: TObject);
begin
 resize_window();
end;

procedure TForm1.FileListBox1Click(Sender: TObject);
begin
 if Form1.FileListBox1.FileName<>'' then
 begin
  Form1.Image1.Picture.LoadFromFile(Form1.FileListBox1.FileName);
  Form1.StatusBar1.SimpleText:=ExtractFileName(Form1.FileListBox1.FileName);
 end;

end;

procedure TForm1.ShellTreeView1Change(Sender: TObject; Node: TTreeNode);
begin
 FileListBox1.Directory:=ShellTreeView1.Path;
end;

{$R *.lfm}

{ TForm1 }

end.

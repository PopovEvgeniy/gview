unit gviewcode;

{$mode objfpc}{$H+}

interface

uses Classes, Forms, Controls, Graphics, ShellCtrls, FileCtrl, ExtCtrls, ComCtrls, StdCtrls;

type

  { TMainWindow }

  TMainWindow = class(TForm)
    FileNavigator: TFileListBox;
    Viewer: TImage;
    DirectoryNavigator: TShellTreeView;
    FileBar: TStatusBar;
    procedure FileNavigatorChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure DirectoryNavigatorChange(Sender: TObject; Node: TTreeNode);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var MainWindow: TMainWindow;

implementation

procedure window_setup();
begin
 Application.Title:='Graphic view';
 MainWindow.Caption:='Graphic view 2.3.2';
 MainWindow.BorderStyle:=bsSizeable;
 MainWindow.Font.Name:=Screen.MenuFont.Name;
 MainWindow.Font.Size:=14;
end;

procedure viewer_setup();
begin
 MainWindow.Viewer.Stretch:=False;
 MainWindow.Viewer.Center:=False;
 MainWindow.Viewer.AutoSize:=False;
 MainWindow.Viewer.Proportional:=True;
 MainWindow.FileNavigator.MultiSelect:=False;
 MainWindow.FileNavigator.Sorted:=True;
 MainWindow.FileBar.SimpleText:='';
 MainWindow.FileNavigator.Mask:='*.bmp;*.jpg;*.ico;*.emf;*.wmf *.png;*.gif;*.pxm';
end;

procedure resize_window();
begin
 MainWindow.FileNavigator.Height:=MainWindow.ClientHeight-MainWindow.DirectoryNavigator.Height;
 MainWindow.Viewer.Width:=MainWindow.ClientWidth-MainWindow.DirectoryNavigator.Width;
 MainWindow.Viewer.Height:=MainWindow.ClientHeight;
end;

procedure setup();
begin
 window_setup();
 viewer_setup();
 resize_window();
end;

{ TMainWindow }

procedure TMainWindow.FormCreate(Sender: TObject);
begin
 setup();
end;

procedure TMainWindow.FileNavigatorChange(Sender: TObject);
begin
 if MainWindow.FileNavigator.FileName<>'' then
 begin
  MainWindow.Viewer.Picture.LoadFromFile(MainWindow.FileNavigator.FileName);
  MainWindow.FileBar.SimpleText:=MainWindow.FileNavigator.FileName;
 end;

end;

procedure TMainWindow.FormResize(Sender: TObject);
begin
 resize_window();
end;

procedure TMainWindow.DirectoryNavigatorChange(Sender: TObject; Node: TTreeNode);
begin
 MainWindow.FileNavigator.Directory:=MainWindow.DirectoryNavigator.Path;
end;

{$R *.lfm}

{ TMainWindow }

end.

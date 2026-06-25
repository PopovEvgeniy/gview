unit gviewcode;

{
 This sofware was made by Popov Evgeniy Alekseyevich.
 It is distributed under the GNU GENERAL PUBLIC LICENSE (Version 2 or higher).
}

{$mode objfpc}
{$H+}

interface

uses SysUtils, Classes, Forms, Controls, Graphics, ShellCtrls, FileCtrl, ExtCtrls, ComCtrls, StdCtrls;

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
    procedure load_image(const target:string);
    procedure window_setup();
    procedure interface_setup();
    procedure viewer_setup();
    procedure resize_window();
    procedure setup();
  public
    { public declarations }
  end; 

var MainWindow: TMainWindow;

implementation

procedure TMainWindow.load_image(const target:string);
begin
 try
  Self.Viewer.Picture.Clear();
  Self.Viewer.Picture.LoadFromFile(target);
  Self.FileBar.SimpleText:=target;
 except
  On E:Exception do Self.FileBar.SimpleText:=E.Message;
 end;

end;

procedure TMainWindow.window_setup();
begin
 Application.Title:='Graphic view';
 Self.Caption:='Graphic view 2.3.9';
 Self.BorderStyle:=bsSizeable;
 Self.Font.Name:=Screen.MenuFont.Name;
 Self.Font.Size:=14;
end;

procedure TMainWindow.interface_setup();
begin
 Self.FileNavigator.MultiSelect:=False;
 Self.FileNavigator.Sorted:=True;
 Self.FileBar.SimpleText:='';
 Self.FileNavigator.Mask:='*.bmp;*.jpg;*.ico;*.emf;*.wmf *.png;*.gif;*.pxm';
end;

procedure TMainWindow.viewer_setup();
begin
 Self.Viewer.Stretch:=True;
 Self.Viewer.Proportional:=True;
 Self.Viewer.Center:=False;
 Self.Viewer.AutoSize:=False;
end;

procedure TMainWindow.resize_window();
begin
 Self.FileNavigator.Height:=Self.ClientHeight-Self.DirectoryNavigator.Height-Self.DirectoryNavigator.Top;
 Self.Viewer.Width:=Self.ClientWidth-Self.DirectoryNavigator.Width-Self.DirectoryNavigator.Left;
 Self.Viewer.Height:=Self.ClientHeight;
end;

procedure TMainWindow.setup();
begin
 Self.window_setup();
 Self.interface_setup();
 Self.viewer_setup();
 Self.resize_window();
end;

{ TMainWindow }

procedure TMainWindow.FormCreate(Sender: TObject);
begin
 Self.setup();
end;

procedure TMainWindow.FileNavigatorChange(Sender: TObject);
begin
 if Self.FileNavigator.FileName<>'' then Self.load_image(Self.FileNavigator.FileName);
end;

procedure TMainWindow.FormResize(Sender: TObject);
begin
 Self.resize_window();
end;

procedure TMainWindow.DirectoryNavigatorChange(Sender: TObject; Node: TTreeNode);
begin
 Self.FileNavigator.Directory:=Self.DirectoryNavigator.Path;
end;

{$R *.lfm}

{ TMainWindow }

end.

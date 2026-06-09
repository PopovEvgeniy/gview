unit gviewcode;

{
 This sofware was made by Popov Evgeniy Alekseyevich.
 It is distributed under the GNU GENERAL PUBLIC LICENSE (Version 2 or higher).
}

{$mode objfpc}
{$H+}

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
    procedure window_setup();
    procedure viewer_setup();
    procedure resize_window();
    procedure setup();
  public
    { public declarations }
  end; 

var MainWindow: TMainWindow;

implementation

procedure TMainWindow.window_setup();
begin
 Application.Title:='Graphic view';
 Self.Caption:='Graphic view 2.3.4';
 Self.BorderStyle:=bsSizeable;
 Self.Font.Name:=Screen.MenuFont.Name;
 Self.Font.Size:=14;
end;

procedure TMainWindow.viewer_setup();
begin
 Self.Viewer.Stretch:=False;
 Self.Viewer.Center:=False;
 Self.Viewer.AutoSize:=False;
 Self.Viewer.Proportional:=True;
 Self.FileNavigator.MultiSelect:=False;
 Self.FileNavigator.Sorted:=True;
 Self.FileBar.SimpleText:='';
 Self.FileNavigator.Mask:='*.bmp;*.jpg;*.ico;*.emf;*.wmf *.png;*.gif;*.pxm';
end;

procedure TMainWindow.resize_window();
begin
 Self.FileNavigator.Height:=Self.ClientHeight-Self.DirectoryNavigator.Height;
 Self.Viewer.Width:=Self.ClientWidth-Self.DirectoryNavigator.Width;
 Self.Viewer.Height:=Self.ClientHeight;
end;

procedure TMainWindow.setup();
begin
 Self.window_setup();
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
 if Self.FileNavigator.FileName<>'' then
 begin
  Self.Viewer.Picture.LoadFromFile(Self.FileNavigator.FileName);
  Self.FileBar.SimpleText:=Self.FileNavigator.FileName;
 end;

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

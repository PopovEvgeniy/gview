unit gviewcode;

{
 This sofware was made by Popov Evgeniy Alekseyevich.
 It is distributed under the GNU GENERAL PUBLIC LICENSE (Version 2 or higher).
}

{$mode objfpc}
{$H+}

interface

uses SysUtils, Classes, Forms, Controls, Graphics, ShellCtrls, FileCtrl, ExtCtrls, ComCtrls, StdCtrls, ExtDlgs, Dialogs, Menus, LCLProc, LCLIntf;

type

  { TMainWindow }

  TMainWindow = class(TForm)
    FileNavigator: TFileListBox;
    MainMenu: TMainMenu;
    FileMenuItem: TMenuItem;
    HelpMenuItem: TMenuItem;
    LoadMenuItem: TMenuItem;
    OpenDirectoryMenuItem: TMenuItem;
    AboutMenuItem: TMenuItem;
    SelectDirectoryDialog: TSelectDirectoryDialog;
    ShowHelpMenuItem: TMenuItem;
    OpenDialog: TOpenPictureDialog;
    Viewer: TImage;
    DirectoryNavigator: TShellTreeView;
    FileBar: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDropFiles(Sender: TObject; const FileNames: array of string);
    procedure FileNavigatorChange(Sender: TObject);
    procedure DirectoryNavigatorChange(Sender: TObject; Node: TTreeNode);
    procedure LoadMenuItemClick(Sender: TObject);
    procedure OpenDirectoryMenuItemClick(Sender: TObject);
    procedure AboutMenuItemClick(Sender: TObject);
    procedure ShowHelpMenuItemClick(Sender: TObject);
  private
    procedure set_target_directory(const target:string);
    procedure load_image(const target:string);
    procedure check_command_line();
    procedure window_setup();
    procedure interface_setup();
    procedure set_shortcut();
    procedure dialog_setup();
    procedure viewer_setup();
    procedure resize_window();
    procedure setup();
  public
    { public declarations }
  end; 

var MainWindow: TMainWindow;

implementation

procedure show_help();
var help:string;
begin
 help:=ExtractFilePath(Application.ExeName)+'readme.txt';
 if FileExists(help) then
 begin
  OpenDocument(help);
 end
 else
 begin
  ShowMessage('Cannot find the help file');
 end;

end;

procedure TMainWindow.set_target_directory(const target:string);
begin
 Self.DirectoryNavigator.Path:=ExtractFilePath(target);
 Self.FileNavigator.Directory:=Self.DirectoryNavigator.Path;
end;

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

procedure TMainWindow.check_command_line();
var target:string;
begin
 if ParamCount()>0 then
 begin
  target:=ParamStr(1);
  Self.load_image(target);
  Self.set_target_directory(target);
 end;

end;

procedure TMainWindow.window_setup();
begin
 Application.Title:='Graphic view';
 Self.Caption:='Graphic view 2.5.4';
 Self.BorderStyle:=bsSizeable;
 Self.Font.Name:=Screen.MenuFont.Name;
 Self.Font.Size:=14;
end;

procedure TMainWindow.interface_setup();
begin
 Self.DirectoryNavigator.ScrollBars:=ssBoth;
 Self.FileNavigator.MultiSelect:=False;
 Self.FileNavigator.Sorted:=True;
 Self.AllowDropFiles:=True;
 Self.FileNavigator.Directory:='';
 Self.FileBar.SimpleText:='';
 Self.FileNavigator.Mask:='*.bmp;*.jpg;*.ico;*.emf;*.wmf;*.png;*.gif;*.pxm';
end;

procedure TMainWindow.set_shortcut();
begin
 Self.LoadMenuItem.ShortCut:=TextToShortCut('Ctrl+O');
 Self.OpenDirectoryMenuItem.ShortCut:=TextToShortCut('Ctrl+D');
 Self.ShowHelpMenuItem.ShortCut:=TextToShortCut('F1');
end;

procedure TMainWindow.dialog_setup();
begin
 Self.OpenDialog.InitialDir:='';
 Self.OpenDialog.FileName:='';
 Self.SelectDirectoryDialog.Title:='Please select the image directory';
 Self.OpenDialog.Title:='Open an image';
 Self.OpenDialog.Filter:='All supported formats|'+Self.FileNavigator.Mask;
end;

procedure TMainWindow.viewer_setup();
begin
 Self.Viewer.Center:=False;
 Self.Viewer.AutoSize:=False;
 Self.Viewer.Stretch:=False;
 Self.Viewer.Proportional:=True;
 Self.Viewer.StretchInEnabled:=True;
 Self.Viewer.StretchOutEnabled:=True;
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
 Self.set_shortcut();
 Self.dialog_setup();
 Self.viewer_setup();
 Self.resize_window();
 Self.check_command_line();
end;

{ TMainWindow }

procedure TMainWindow.FormCreate(Sender: TObject);
begin
 Self.setup();
end;

procedure TMainWindow.FormResize(Sender: TObject);
begin
 Self.resize_window();
end;

procedure TMainWindow.FormDropFiles(Sender: TObject; const FileNames: array of string);
begin
 Self.load_image(FileNames[0]);
 Self.set_target_directory(FileNames[0]);
end;

procedure TMainWindow.FileNavigatorChange(Sender: TObject);
begin
 if Self.FileNavigator.FileName<>'' then Self.load_image(Self.FileNavigator.FileName);
end;

procedure TMainWindow.DirectoryNavigatorChange(Sender: TObject; Node: TTreeNode);
begin
 Self.FileNavigator.Directory:=Self.DirectoryNavigator.Path;
end;

procedure TMainWindow.LoadMenuItemClick(Sender: TObject);
begin
 if Self.OpenDialog.Execute()=True then
 begin
  Self.load_image(Self.OpenDialog.FileName);
  Self.set_target_directory(Self.OpenDialog.FileName);
 end;

end;

procedure TMainWindow.OpenDirectoryMenuItemClick(Sender: TObject);
begin
 if Self.SelectDirectoryDialog.Execute()=True then Self.DirectoryNavigator.Path:=Self.SelectDirectoryDialog.FileName;
end;

procedure TMainWindow.AboutMenuItemClick(Sender: TObject);
begin
 ShowMessage('Graphic view is a simple graphic viewer by Popov Evgeniy Alekseyevich');
end;

procedure TMainWindow.ShowHelpMenuItemClick(Sender: TObject);
begin
 show_help();
end;

{$R *.lfm}

{ TMainWindow }

end.

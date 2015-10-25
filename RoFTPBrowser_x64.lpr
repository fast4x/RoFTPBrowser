program RoFTPBrowser_x64;

{$mode objfpc}{$H+}

uses
  {$IFDEF UseCThreads}
  {$ENDIF}
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  { you can add units after this }
  unit1client, about, pl_indycomp, rx, sdflaz, pl_dcpcomp, layout, connlist;

{$R *.res}

begin
  Application.Title:='fast RoFTP Browser x64';
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm_srv, Form_srv);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

unit connlist;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SdfData, db, BufDataset, FileUtil, DCPblowfish, DCPdes,
  DCPsha1, DCPsha256, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids, DbCtrls,
  Buttons, ExtCtrls, Menus;

type

  { TForm_srv }

  TForm_srv = class(TForm)
    Bevel1: TBevel;
    BitBtn8: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Datasource2: TDataSource;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBGrid2: TDBGrid;
    DBNavigator1: TDBNavigator;
    dbsrv: TSdfDataSet;
    DCP_3des1: TDCP_3des;
    DCP_blowfish1: TDCP_blowfish;
    DCP_sha1_1: TDCP_sha1;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBEdit5Change(Sender: TObject);
    procedure dbsrvAfterEdit(DataSet: TDataSet);
    procedure dbsrvAfterInsert(DataSet: TDataSet);
    procedure dbsrvAfterScroll(DataSet: TDataSet);
    procedure dbsrvBeforeEdit(DataSet: TDataSet);
    procedure dbsrvBeforePost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }

  public
    { public declarations }
     curpwd: string;
  end;

var
  Form_srv: TForm_srv;

implementation
uses unit1client;

{$R *.lfm}

{ TForm_srv }

procedure TForm_srv.FormCreate(Sender: TObject);
var w:word;
    item:tmenuitem;
begin




  dbsrv.Open;
  mainform.ComboConn.Items.Clear;
  mainform.Popupconn.Items.Clear;
  dbsrv.First;
  for w:=1 to dbsrv.RecordCount-1 do begin
      mainform.ComboConn.Items.AddText(dbsrv.FieldByName('descr').asstring);
      item:=tmenuitem.Create(mainform.Popupconn);
      item.Caption:=dbsrv.FieldByName('descr').asstring+'@'+dbsrv.FieldByName('serverurl').asstring;
      item.ImageIndex:=6;
      item.OnClick:=@mainform.MenuItemConnectClick;
      mainform.Popupconn.Items.Add(item);
      dbsrv.Next;
  end;
end;

procedure TForm_srv.dbsrvAfterInsert(DataSet: TDataSet);
begin
    dbsrv.FieldByName('port').asstring:='21';
end;

procedure TForm_srv.dbsrvAfterScroll(DataSet: TDataSet);
begin
    DCP_blowfish1.InitStr('fammi una pompa',TDCP_sha256);
//  showmessage(DCP_blowfish1.EncryptString(dbedit5.Text));

  curpwd:=DCP_blowfish1.DecryptString(dbsrv.FieldByName('pass').asstring);
  label1.Caption:=curpwd;
  DCP_blowfish1.Burn;

end;

procedure TForm_srv.dbsrvBeforeEdit(DataSet: TDataSet);
begin

end;

procedure TForm_srv.dbsrvBeforePost(DataSet: TDataSet);
begin

  DCP_blowfish1.InitStr('fammi una pompa',TDCP_sha256);
//  showmessage(DCP_blowfish1.EncryptString(dbedit5.Text));

  dbsrv.FieldByName('pass').asstring:=DCP_blowfish1.EncryptString(curpwd);
   DCP_blowfish1.Burn;
end;

procedure TForm_srv.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TForm_srv.Button2Click(Sender: TObject);
begin
  close;
  mainform.ConnectButtonClick(Sender);

end;

procedure TForm_srv.DBEdit5Change(Sender: TObject);
begin
  curpwd:=DBEdit5.Text;
end;

procedure TForm_srv.dbsrvAfterEdit(DataSet: TDataSet);
begin

end;

end.


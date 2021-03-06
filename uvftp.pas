unit uvftp;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  FileCtrl, ComCtrls, Buttons, Menus, IdFTPServer, IdFTP, IdComponent,windows,
  uvcargaftp, ShellAPI, ExtCtrls, EditBtn, PairSplitter;

type

  { Tvftp }

  Tvftp = class(TForm)
    BitBtn1: TBitBtn;
    btncnx: TBitBtn;
    btndescargar: TBitBtn;
    btncargar: TBitBtn;
    D2: TMenuItem;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    EF2: TMenuItem;
    ftpcarga: TIdFTP;
    IdFTP: TIdFTP;
    FTPsearch: TIdFTP;
    ftpdescarga: TIdFTP;
    ImageList1: TImageList;
    ImageList2: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ListaFTP: TListView;
    ListaFTPar: TListView;
    ListBox1: TListBox;
    ListBox2: TListBox;
    C1: TMenuItem;
    ED1: TMenuItem;
    ListView1: TListView;
    Elocal1: TMenuItem;
    Clocal1: TMenuItem;
    Elocal2: TMenuItem;
    ListView2: TListView;
    Panel5: TPanel;
    Slocal1: TMenuItem;
    Panel4: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Rlocal4: TMenuItem;
    Rlocal3: TMenuItem;
    Rlocal2: TMenuItem;
    Rlocal1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    segundolocal1: TPopupMenu;
    R1: TMenuItem;
    R2: TMenuItem;
    RD1: TMenuItem;
    RD2: TMenuItem;
    segundoftp1: TPopupMenu;
    segundoftp2: TPopupMenu;
    segundolocal2: TPopupMenu;
    StatusBar1: TStatusBar;
    StatusBar2: TStatusBar;
    statusbarlocal: TStatusBar;
    statusbarlocal1: TStatusBar;
    VentanaDirectorio: TSelectDirectoryDialog;
    procedure BitBtn1Click(Sender: TObject);
    procedure btncargarClick(Sender: TObject);
    procedure btndescargarClick(Sender: TObject);
    procedure btncnxClick(Sender: TObject);
    procedure btnlistarClick(Sender: TObject);
    procedure btnlistarlocalClick(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure Clocal1Click(Sender: TObject);
    procedure Elocal1Click(Sender: TObject);
    procedure ED1Click(Sender: TObject);
    procedure editdirChange(Sender: TObject);
    procedure EF1Click(Sender: TObject);
    procedure Elocal2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure ftpcargaWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure ftpcargaWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure ftpcargaWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure ftpdescargaWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure ftpdescargaWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure ftpdescargaWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure FTPsearchWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure FTPsearchWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure FTPsearchWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure IdFTPWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure IdFTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure IdFTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure ListaFTParSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListaFTPDblClick(Sender: TObject);
    procedure ListaFTPSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure listarftp();
    procedure listar(dirnownow: string);
    procedure descargaftp(cnx:Boolean);
    procedure descargarfile(direc:String);
    procedure ListView1DblClick(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListView2SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure R1Click(Sender: TObject);
    procedure RD1Click(Sender: TObject);
    procedure RD2Click(Sender: TObject);
    procedure Rlocal1Click(Sender: TObject);
    procedure Rlocal2Click(Sender: TObject);
    procedure Rlocal3Click(Sender: TObject);
    procedure cargararchivo();
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  vftp: Tvftp;
  j,x:integer;
  mostrar,mostrar2: array [0..999999] of string;
  dirftp:String;
  aux:Int64;
  activo,activo2,activo3,activo4:Boolean;


implementation

{$R *.lfm}

{ Tvftp }
procedure Tvftp.btncnxClick(Sender: TObject);
begin
  if btncnx.Caption='Desconectar' then
    begin
      IdFTP.Disconnect;
      btncnx.Caption:='Conectar';
      StatusBar2.Panels[1].Text:='[-] OffLine';
      ListaFTP.Clear;
      ListaFTPar.Clear;
      segundoftp1.Items[0].Enabled:=false;
      segundoftp1.Items[1].Enabled:=false;
      segundoftp1.Items[2].Enabled:=false;
      segundoftp1.Items[3].Enabled:=false;
      segundoftp2.Items[0].Enabled:=false;
      segundoftp2.Items[1].Enabled:=false;
      segundoftp2.Items[2].Enabled:=false;
      segundoftp2.Items[3].Enabled:=false;
      btncargar.Enabled:=false;
      btndescargar.Enabled:=false;
      segundolocal2.Items[0].Enabled:=false;
      IdFTP.Disconnect;
      ftpdescarga.Disconnect;
      ftpcarga.Disconnect;
      FTPsearch.Disconnect;
      dirftp:='';
      j:=0;
      x:=0;
      StatusBar1.Panels[1].Text:='/';
    end
  else
    begin
       btncnx.Cursor:=crHourGlass;
       IdFTP.Username:='sistemazona@engineersworld.com.ve' ;
       IdFTP.Password:='5325106' ;
       IdFTP.Host:='ftp.engineersworld.com.ve';
      try
       IdFTP.Connect;
       listarftp();
       btncnx.Caption:='Desconectar';
       StatusBar2.Panels[1].Text:='[+] OnLine';
       segundoftp1.Items[0].Enabled:=true;
       segundoftp1.Items[1].Enabled:=true;
       segundoftp1.Items[2].Enabled:=true;
       segundoftp1.Items[3].Enabled:=true;
       segundoftp2.Items[2].Enabled:=true;
       segundoftp2.Items[1].Enabled:=true;
       segundoftp2.Items[3].Enabled:=true;
       if Edit1.Text<>'' then
        begin
           segundolocal2.Items[0].Enabled:=true;
           segundoftp2.Items[0].Enabled:=true;
           btndescargar.Enabled:=true;
           btncargar.Enabled:=true;
        end;
       listarftp();
       btncnx.Cursor:=crDefault;
       IdFTP.Disconnect;
      except
        StatusBar2.Panels[1].Text:='[-] Error';
        btncnx.Cursor:=crDefault;
      end;
    end;
end;

procedure Tvftp.descargaftp(cnx:Boolean);
begin
   ftpdescarga.Username:='sistemazona@engineersworld.com.ve' ;
   ftpdescarga.Password:='5325106' ;
   ftpdescarga.Host:='ftp.engineersworld.com.ve';
  try
     if cnx=true then
          begin
            ftpdescarga.Connect;
          end
     else
           ftpdescarga.Disconnect;
  except
    MessageDlg('Error al conectar con el servidor',mtError,[mbOK],0);
  end;
end;

//DESCARGAR ARCHIVO
procedure Tvftp.descargarfile(direc:String);
var
    fileabajar: string;
    conectado:Boolean;
begin
   conectado:=true;
   descargaftp(conectado);
      try
       ftpdescarga.ChangeDir(StatusBar1.Panels[1].Text);
       vcargaftp.barra.Max:=ftpdescarga.Size(ExtractFileName(ListaFTPar.Selected.Caption)) div 1024;

      //buscar archivo en el directorio para remplazarlo
      if FileExists(direc+ListaFTPar.Selected.Caption) then
           begin
              if MessageDlg('¿El Archivo ya Existe desea Remplazarlo?',mtConfirmation,[mbOK,mbCancel],0)=mrOK then
                  begin
                     //descargar el achivo
                     DeleteFile(PChar(direc+ListaFTPar.Selected.Caption));
                     ftpdescarga.Get(ExtractFileName(ListaFTPar.Selected.Caption),direc+ListaFTPar.Selected.Caption,false,false);
                     conectado:=false;
                     descargaftp(conectado);
                  end
                else
                  begin
                     conectado:=false;
                     descargaftp(conectado);
                     ShowMessage('Eror 404');
                  end;
           end;
      if not FileExists(direc+ListaFTPar.Selected.Caption) then
          begin
            //descargar el achivo
            ftpdescarga.Get(ExtractFileName(ListaFTPar.Selected.Caption),direc+ListaFTPar.Selected.Caption,false,false);
            conectado:=false;
            descargaftp(conectado);
          end;
      except
        conectado:=false;
        descargaftp(conectado);
        MessageDlg('Error al Subir archivo',mtError,[mbOK],0);
      end;

end;

//SUBIR ARCHIVO
procedure Tvftp.cargararchivo();
var
  F: File of byte;
  conectado:Boolean;
begin
  //directorio donde se guardar
  ftpcarga.Username:='sistemazona@engineersworld.com.ve' ;
  ftpcarga.Password:='5325106' ;
  ftpcarga.Host:='ftp.engineersworld.com.ve';
  ftpcarga.Connect;
  //calculando peso del archivo
  AssignFile(F,statusbarlocal.Panels[1].Text+ListView2.Selected.Caption);
  Reset( F );
  aux:= FileSize( F ) div 1024;
  CloseFile( F );
  //cargando archivo
  try
    vcargaftp.barra.Max:=aux;
    ftpcarga.ChangeDir(StatusBar1.Panels[1].Text);
    ftpcarga.Put(statusbarlocal.Panels[1].Text+ListView2.Selected.Caption,ExtractFileName(statusbarlocal.Panels[1].Text+ListView2.Selected.Caption), False);
    ftpcarga.Disconnect;
  except
    ftpcarga.Disconnect;
    MessageDlg('Error al Subir archivo',mtError,[mbOK],0);
  end;


end;



procedure Tvftp.ListView1DblClick(Sender: TObject);
begin
  if activo2=true then
    begin;
      mostrar2[0]:=Edit1.Text+'\';
      if ListView1.Selected.Index=0 then
        begin
            if x>0 then
              begin
                x:=x-1;
                statusbarlocal.Panels[1].Text:=mostrar2[x];
              end;
            if x=0 then
              begin
                mostrar[x]:=Edit1.Text+'\';
              end;
        end
      else
        begin
          x:=x+1;
          mostrar2[x]:=mostrar2[x-1]+ListView1.Selected.Caption+'\';
        end;
      statusbarlocal.Panels[1].Text:=mostrar2[x];
      listar(statusbarlocal.Panels[1].Text);
    end;
end;

procedure Tvftp.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected=true then
    begin
      activo2:=true;
      segundolocal1.Items.Items[1].Enabled:=true;
      segundolocal1.Items.Items[2].Enabled:=true;
    end
  else
    begin
      activo2:=false;
      segundolocal1.Items.Items[1].Enabled:=false;
      segundolocal1.Items.Items[2].Enabled:=false;
    end;
end;

procedure Tvftp.ListView2SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected=True then
    begin
      activo4:=true;
      segundolocal2.Items.Items[1].Enabled:=true;
      segundolocal2.Items.Items[2].Enabled:=true;
    end
  else
    begin
      activo4:=false;
      segundolocal2.Items.Items[1].Enabled:=False;
      segundolocal2.Items.Items[2].Enabled:=False;
    end;
end;

procedure Tvftp.R1Click(Sender: TObject);
begin
  ListaFTP.Cursor:=crHourGlass;
  ListaFTPar.Cursor:=crHourGlass;
  listarftp();
  ListaFTP.Cursor:=crDefault;
  ListaFTPar.Cursor:=crDefault;
end;

//RENOMBRAR ARCHIVOS
procedure Tvftp.RD1Click(Sender: TObject);
var
  newname: string;
begin
  if activo=true then
  begin
  IdFTP.Username:='sistemazona@engineersworld.com.ve' ;
  IdFTP.Password:='5325106' ;
  IdFTP.Host:='ftp.engineersworld.com.ve';
  newname := InputBox('Escriba el nuevo nombre', 'Nuevo nombre : ', ListaFTP.Selected.Caption);
  try
    begin
      IdFTP.Connect;
      IdFTP.ChangeDir(StatusBar1.Panels[1].Text);
      IdFTP.Rename(ListaFTP.Selected.Caption, newname);
      MessageDlg('Renombrado',mtInformation,[mbOK],0);
      IdFTP.Disconnect;
      listarftp();
    end;
  except
    begin
      IdFTP.Disconnect;
      MessageDlg('Error al renombrar',mtError,[mbOK],0);
    end;
  end;
  end;
end;

procedure Tvftp.RD2Click(Sender: TObject);
var
  newname: string;
begin
  if activo3=true then
    begin
      IdFTP.Username:='sistemazona@engineersworld.com.ve' ;
      IdFTP.Password:='5325106' ;
      IdFTP.Host:='ftp.engineersworld.com.ve';
      newname := InputBox('Escriba el nuevo nombre', 'Nuevo nombre : ', ListaFTPar.Selected.Caption);
      try
        begin
          IdFTP.Connect;
          IdFTP.ChangeDir(StatusBar1.Panels[1].Text);
          IdFTP.Rename(ListaFTPar.Selected.Caption, newname);
          MessageDlg('Renombrado',mtInformation,[mbOK],0);
          IdFTP.Disconnect;
          listarftp();
        end;
      except
        begin
          IdFTP.Disconnect;
          MessageDlg('Error al renombrar',mtError,[mbOK],0);
        end;
      end;
    end;
end;

procedure Tvftp.Rlocal1Click(Sender: TObject);
var
  nuevonombre: string;
begin
  if activo2=true then
    begin
      nuevonombre := InputBox('Escribir Nombre', 'Nuevo Nombre : ', ListView1.Selected.Caption);
      chdir(statusbarlocal.Panels[1].Text);
      if RenameFileUTF8(ListView1.Selected.Caption,nuevonombre) { *Converted from RenameFile* } then
      begin
        MessageDlg('Renombrado',mtInformation,[mbOK],0);
        listar(statusbarlocal.Panels[1].Text);
      end
      else
      begin
        MessageDlg('Error al renombrar',mtError,[mbOK],0);
      end;
    end;
end;

procedure Tvftp.Rlocal2Click(Sender: TObject);
begin
  listar(statusbarlocal.Panels[1].Text);
end;

procedure Tvftp.Rlocal3Click(Sender: TObject);
var
  nuevonombre: string;
begin
  if activo4=true then
    begin;
      nuevonombre := InputBox('Escribir Nombre', 'Nuevo Nombre : ', ListView2.Selected.Caption);
      chdir(statusbarlocal.Panels[1].Text);
      if RenameFileUTF8(ListView2.Selected.Caption,nuevonombre) { *Converted from RenameFile* } then
      begin
        MessageDlg('Renombrado',mtInformation,[mbOK],0);
        listar(statusbarlocal.Panels[1].Text);
      end
      else
      begin
        MessageDlg('Error al renombrar',mtError,[mbOK],0);
      end;
    end;
end;

procedure Tvftp.btndescargarClick(Sender: TObject);
begin
  if activo3=true then
    begin
      descargarfile(statusbarlocal.Panels[1].Text);
    end;
end;

procedure Tvftp.btncargarClick(Sender: TObject);
begin
  if activo4=true then
    begin
      cargararchivo();
    end;
end;

procedure Tvftp.BitBtn1Click(Sender: TObject);
begin
  if VentanaDirectorio.Execute then
    begin
      Edit1.Text:=VentanaDirectorio.FileName;
      listar(Edit1.Text+'\');
      segundolocal2.Items[2].Enabled:=true;
      statusbarlocal.Panels[1].Text:=Edit1.Text+'\';
      segundolocal1.Items[0].Enabled:=true;
      segundolocal1.Items[1].Enabled:=true;
      segundolocal1.Items[2].Enabled:=true;
      segundolocal1.Items[3].Enabled:=true;
      segundolocal2.Items[1].Enabled:=true;
      segundolocal2.Items[2].Enabled:=true;
      segundolocal2.Items[3].Enabled:=true;
      if StatusBar2.Panels[1].Text='[+] OnLine' then
        begin
           segundolocal2.Items[0].Enabled:=true;
           segundoftp2.Items[0].Enabled:=true;
           btndescargar.Enabled:=true;
           btncargar.Enabled:=true;
        end;
    end
  else
    begin
      btndescargar.Enabled:=false;
      segundolocal2.Items[2].Enabled:=false;
      segundolocal1.Items[0].Enabled:=false;
      segundolocal1.Items[1].Enabled:=false;
      segundolocal1.Items[2].Enabled:=false;
      segundolocal1.Items[3].Enabled:=false;
      segundolocal2.Items[0].Enabled:=false;
      segundolocal2.Items[1].Enabled:=false;
      segundolocal2.Items[2].Enabled:=false;
      segundolocal2.Items[3].Enabled:=false;
    end;
end;

procedure Tvftp.btnlistarClick(Sender: TObject);
begin
   listarftp();
end;

procedure Tvftp.btnlistarlocalClick(Sender: TObject);
begin

end;

//CREAR DIRECTORIO
procedure Tvftp.C1Click(Sender: TObject);
var
  newdir: string;
begin
  IdFTP.Username:='sistemazona@engineersworld.com.ve' ;
  IdFTP.Password:='5325106' ;
  IdFTP.Host:='ftp.engineersworld.com.ve';
  newdir := InputBox('Escriba el nuevo nombre', 'Directorio : ', 'Nueva Carpeta');
  try
    begin
      IdFTP.Connect;
      IdFTP.ChangeDir(StatusBar1.Panels[1].Text);
      IdFTP.MakeDir(newdir);
      MessageDlg('Directorio creado',mtInformation,[mbOK],0);
      IdFTP.Disconnect;
      listarftp();
    end
  except
    begin
      IdFTP.Disconnect;
      MessageDlg('Error al crear directorio',mtError,[mbOK],0);
    end;
  end;

end;

procedure Tvftp.Clocal1Click(Sender: TObject);
var
  nombrecarpeta: string;
begin
  chdir(statusbarlocal.Panels[1].Text);
  nombrecarpeta := InputBox('Escribe el Nombre del directorio', 'Directorio : ', 'Nueva Carpeta');
  try
    begin
      MkDir(nombrecarpeta);
      MessageDlg('Directorio creado',mtInformation,[mbOK],0);
      listar(statusbarlocal.Panels[1].Text);
    end;
  except
    begin
      MessageDlg('Error al crear directorio',mtError,[mbOK],0);
    end;
  end;
end;

procedure Tvftp.Elocal1Click(Sender: TObject);
begin
  if activo2=true then
    begin
      try
        begin
          RmDir(statusbarlocal.Panels[1].Text + ListView1.Selected.Caption);
          MessageDlg('Directorio eliminado',mtInformation,[mbOK],0);
          listar(statusbarlocal.Panels[1].Text);
        end;
      except
        begin
          MessageDlg('Error al eliminar',mtError,[mbOK],0);
        end;
      end;
    end;
end;

//BORRAR DIRECTORIO
procedure Tvftp.ED1Click(Sender: TObject);
begin
  if activo=true then
  begin
    IdFTP.Username:='sistemazona@engineersworld.com.ve' ;
    IdFTP.Password:='5325106' ;
    IdFTP.Host:='ftp.engineersworld.com.ve';
    try
      begin
        IdFTP.Connect;
        IdFTP.ChangeDir(StatusBar1.Panels[1].Text);
        IdFTP.RemoveDir(ListaFTP.Selected.Caption);
        MessageDlg('Directorio eliminado',mtInformation,[mbOK],0);
        IdFTP.Disconnect;
        listarftp();
      end
    except
      IdFTP.Disconnect;
      MessageDlg('Error al eliminar el directorio',mtError,[mbOK],0);
    end;
  end;

end;

procedure Tvftp.editdirChange(Sender: TObject);
begin
  listar(Edit1.Text+'\');
  statusbarlocal.Panels[1].Text:=Edit1.Text+'\';
  x:=0;
  if  statusbarlocal.Panels[1].Text<>' ' then
     begin
       btndescargar.Enabled:=true;
       segundoftp2.Items[2].Enabled:=true;
     end
  else
      btndescargar.Enabled:=false;
      segundoftp2.Items[2].Enabled:=false;
end;

//BORRAR ARCHIVOS
procedure Tvftp.EF1Click(Sender: TObject);
begin
  if activo3=true then
    begin
      IdFTP.Username:='sistemazona@engineersworld.com.ve' ;
      IdFTP.Password:='5325106' ;
      IdFTP.Host:='ftp.engineersworld.com.ve';
      try
        begin
          IdFTP.Connect;
          IdFTP.ChangeDir(StatusBar1.Panels[1].Text);
          IdFTP.Delete(ListaFTPar.Selected.Caption);
          MessageDlg('Archivo eliminado',mtInformation,[mbOK],0);
          IdFTP.Disconnect;
          listarftp();
        end;
      except
        begin
          IdFTP.Disconnect;
          MessageDlg('Error al elimiar el archivo',mtError,[mbOK],0);
        end;
      end;
    end;
end;

procedure Tvftp.Elocal2Click(Sender: TObject);
begin
  if activo4=true then
    begin
      if DeleteFileUTF8(statusbarlocal.Panels[1].Text + ListView2.Selected.Caption) { *Converted from DeleteFile* } then
        begin
          MessageDlg('Archivo Eliminado',mtInformation,[mbOK],0);
          listar(statusbarlocal.Panels[1].Text);
        end
      else
        begin
          MessageDlg('Error al elimiar el archivo',mtError,[mbOK],0);
        end;
    end;
end;

procedure Tvftp.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  IdFTP.Disconnect;
  {ftpdescarga.Disconnect;
  ftpcarga.Disconnect;
  FTPsearch.Disconnect;}
  dirftp:='';
  j:=0;
  x:=0;
  StatusBar1.Panels[1].Text:='/';
end;

procedure Tvftp.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose := MessageDlg('¿Realmente desea salir de la ventana?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk
end;

procedure Tvftp.FormCreate(Sender: TObject);
var
 ProgressBarStyle: integer;
begin
  mostrar[0]:='/';
  StatusBar1.Panels[1].Text:=mostrar[j];
  StatusBar2.Panels[1].Text:='[-] OffLine';
  j:=0;
  x:=0;
  activo:=false;
  activo2:=false;
  activo3:=false;
  activo4:=false;
end;
//********************************TRABAJO PARA LA CARGA DEL FTP
procedure Tvftp.ftpcargaWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
var
 progreso:integer;
begin
  vcargaftp.Update;
  progreso:=AWorkCount;
  vcargaftp.lblprogres2.Caption:=FormatFloat(',0',progreso)+' Byte';
  vcargaftp.lblprogres2.Update;
  vcargaftp.barra.Position:=AWorkCount div 1024;
  vcargaftp.barra.Update;
end;

procedure Tvftp.ftpcargaWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
var
 peso:integer;
begin
  vcargaftp.barra.Position:=0;
  vcargaftp.lblestado.Caption:='Se Cargan los Datos...';
  peso:=vcargaftp.barra.Max;
  vcargaftp.lblpeso.Caption:=FormatFloat(',0',peso)+ ' Kbyte';
  vcargaftp.Show;
  vcargaftp.Update;
end;

procedure Tvftp.ftpcargaWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  MessageDlg('Carga realiazada satisfactoriamente',mtInformation,[mbOK],0);
  vcargaftp.Close;
end;
//**********************************************************

//********************************TRABAJO DEL BUSCARDOR FTP
procedure Tvftp.FTPsearchWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin

end;

procedure Tvftp.FTPsearchWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin

end;

procedure Tvftp.FTPsearchWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin

end;

procedure Tvftp.IdFTPWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin

end;

procedure Tvftp.IdFTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin

end;

procedure Tvftp.IdFTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin

end;

procedure Tvftp.ListaFTParSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected=true then
    begin
      activo3:=true;
      segundoftp2.Items.Items[1].Enabled:=true;
      segundoftp2.Items.Items[2].Enabled:=true;
    end
  else
    begin
      activo3:=false;
      segundoftp2.Items.Items[1].Enabled:=false;
      segundoftp2.Items.Items[2].Enabled:=false;
    end;
end;

//**********************************************************

//********************************TRABAJO PARA DESCARGAR DEL FTP
procedure Tvftp.ftpdescargaWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
var
 progreso:integer;
begin
  vcargaftp.Update;
  progreso:=AWorkCount;
  vcargaftp.lblprogres2.Caption:=FormatFloat(',0',progreso)+' Byte';
  vcargaftp.lblprogres2.Update;
  vcargaftp.barra.Position:=AWorkCount div 1024;
  vcargaftp.barra.Update;
end;

procedure Tvftp.ftpdescargaWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
var
 peso:integer;
begin
  vcargaftp.barra.Position:=0;
  vcargaftp.lblestado.Caption:='Se Descargan los Datos...';
  peso:=vcargaftp.barra.Max;
  vcargaftp.lblpeso.Caption:=FormatFloat(',0',peso)+ ' Kbyte';
  vcargaftp.Show;
  vcargaftp.Update;
end;

procedure Tvftp.ftpdescargaWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
   MessageDlg('Descarga realiazada satisfactoriamente',mtInformation,[mbOK],0);
   vcargaftp.Close;
end;
//****************************************************

procedure Tvftp.ListaFTPDblClick(Sender: TObject);
begin
  if activo=true then
    begin
    ListaFTP.Enabled:=false;
    ListaFTP.Cursor:=crHourGlass;
    dirftp:=dirftp+ListaFTP.Selected.Caption+'/';
    //MOSTRAR BARRA DEL DIRECTORIO ACTUAL
    if ListaFTP.Selected.Index=0 then
      begin
        mostrar[j]:=ListaFTP.Selected.Caption;
          if j>0 then
            begin
              j:=j-1;
            end;
          if j=0 then
            begin
              mostrar[j]:='/'
            end;
      end
    else
      begin
        j:=j+1;
        if j>1 then
          begin
            mostrar[j]:=mostrar[j-1]+'/'+ListaFTP.Selected.Caption;
          end
        else
            mostrar[j]:='/'+ListaFTP.Selected.Caption;
      end;
    StatusBar1.Panels[1].Text:=mostrar[j];
    listarftp();
    ListaFTP.Enabled:=true;
    ListaFTP.Cursor:=crDefault;
    end
end;

procedure Tvftp.ListaFTPSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected=true then
    begin
      activo:=true;
      segundoftp1.Items.Items[1].Enabled:=true;
      segundoftp1.Items.Items[2].Enabled:=true;
    end
  else
    begin
    activo:=false;
    segundoftp1.Items.Items[1].Enabled:=false;
    segundoftp1.Items.Items[2].Enabled:=false;
    end;
end;

procedure Tvftp.listarftp();
var
  i:Integer;
  MysList: TStringList;
  iLines, iPesoArchivo:Integer;
  sDir:String;
  listate2: TListItem;
  dirnow:String;

begin
   ListaFTP.Enabled:=false;
   dirnow:=dirftp;
   if dirftp='' then
        begin
          dirnow:='/';
        end;

   FTPsearch.Username:='sistemazona@engineersworld.com.ve';
   FTPsearch.Password:='5325106';
   FTPsearch.Host:='ftp.engineersworld.com.ve';
  try
   FTPsearch.Connect;
   FTPsearch.ChangeDir(dirnow);
  //Carga en una ListBox las Capetas y en Otra Los Archivos
  MysList := TStringList.Create;
  ListBox1.Items.Clear;
  ListBox2.Items.Clear;
  FTPsearch.List(MysList,'',False);
  For iLines := 0 to MysList.Count -1 do
    begin
      sDir:= MysList[iLines];
      iPesoArchivo := FTPsearch.Size(sDir);
      if iPesoArchivo = -1 then // Carpetas
           ListBox1.Items.Add(sDir)
      else ListBox2.Items.Add(sDir); //Archivos
    end;
   FTPsearch.Disconnect;

  //LLENAR EL LISTVIEW
  ListaFTP.Items.Clear;
  ListaFTPar.Items.Clear;
  for i := 0 to ListBox1.Count - 1 do
  begin
    with ListaFTP do
    begin
      listate2 := ListaFTP.Items.Add;
      listate2.Caption := ListBox1.Items[i];
      listate2.SubItems.Add('Directory');
      listate2.ImageIndex := 0;
    end;
  end;

  for i := 0 to ListBox2.Count - 1 do
  begin
    with ListaFTPar do
    begin
      listate2 := ListaFTPar.Items.Add;
      listate2.Caption := ListBox2.Items[i];
      if AnsiPos('.xml',ListBox2.Items[i])<>0 then
        begin
          listate2.SubItems.Add('Archivo XML');
          listate2.ImageIndex := 1;
        end;
      if AnsiPos('.zip',ListBox2.Items[i])<>0 then
        begin
          listate2.SubItems.Add('Archivo ZIP');
          listate2.ImageIndex := 2;
        end;
    end;
  end;
  ListaFTP.Items[0].Delete;
  ListaFTP.Enabled:=true;
  //ListaFTP.EditingDone;
  except
    FTPsearch.Disconnect;
    ListaFTP.Enabled:=true;
    MessageDlg('Error al sincronizar con servidor',mtError,[mbOK],0);
  end;
end;

procedure Tvftp.listar(dirnownow: string);
var
  buscar: TSearchRec;
  icn: TIcon;
  listate: TListItem;
  getdata: SHFILEINFO;
  dirnow: string;
  i:Integer;

begin
  dirnow := StringReplace(dirnownow, '/', '\', [rfReplaceAll, rfIgnoreCase]);

  ListView1.Items.Clear;
  ListView2.Items.Clear;
  icn := TIcon.Create;
  ListView1.Items.BeginUpdate;
  ListView2.Items.BeginUpdate;

  if FindFirstUTF8(dirnow + '*.*',faAnyFile,buscar) { *Converted from FindFirst* } = 0 then
  begin
    repeat
      if (buscar.Attr = faDirectory) then
      begin

        with ListView1 do
        begin

         if not(buscar.Name = '.') then
           begin

            listate := ListView1.Items.Add;

            SHGetFileInfo(PChar(dirnow + buscar.Name), 0, getdata, SizeOf
                (getdata), SHGFI_DISPLAYNAME);
            listate.Caption := getdata.szDisplayName;

            SHGetFileInfo(PChar(dirnow + buscar.Name), 0, getdata, SizeOf
                (getdata), SHGFI_TYPENAME);
            listate.SubItems.Add(getdata.szTypeName);

            SHGetFileInfo(PChar(dirnow + buscar.Name), 0, getdata, SizeOf
                (getdata), SHGFI_ICON or SHGFI_SMALLICON);
            icn.Handle := getdata.hIcon;
            listate.ImageIndex := ImageList2.AddIcon(icn);

            //DestroyIcon(getdata.hIcon);

          end;
        end;
      end;
    until FindNextUTF8(buscar) { *Converted from FindNext* } <> 0;
    FindCloseUTF8(buscar); { *Converted from FindClose* }
  end;

  if FindFirstUTF8(dirnow + '*.*',faAnyFile,buscar) { *Converted from FindFirst* } = 0 then
  begin
    repeat
      if (buscar.Attr <> faDirectory) then
      begin

        with ListView2 do
        begin

          listate := ListView2.Items.Add;

          SHGetFileInfo(PChar(dirnow + buscar.Name), 0, getdata, SizeOf(getdata)
              , SHGFI_DISPLAYNAME);
          listate.Caption := buscar.Name;

          SHGetFileInfo(PChar(dirnow + buscar.Name), 0, getdata, SizeOf(getdata)
              , SHGFI_TYPENAME);
          listate.SubItems.Add(getdata.szTypeName);

          SHGetFileInfo(PChar(dirnow + buscar.Name), 0, getdata, SizeOf(getdata)
              , SHGFI_ICON or SHGFI_SMALLICON);
          icn.Handle := getdata.hIcon;
          listate.ImageIndex := ImageList2.AddIcon(icn);

          //DestroyIcon(getdata.hIcon);

        end;

      end

      until FindNextUTF8(buscar) { *Converted from FindNext* } <> 0;
      FindCloseUTF8(buscar); { *Converted from FindClose* }
    end;
    //DARLE NOMBRE AL ITEM DE REGRESAR
    ListView1.Items.EndUpdate;
    ListView2.Items.EndUpdate;
    ListView1.Items[0].Caption:='<<--';
    ListView1.Items[0].SubItems.Text:=' ';
end;

end.


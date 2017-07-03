unit mcxgui;
{==============================================================================
    Monte Carlo eXtreme (MCX) Studio
-------------------------------------------------------------------------------
    Author: Qianqian Fang
    Email : q.fang at neu.edu
    Web   : http://mcx.space
    License: GNU General Public License version 3 (GPLv3)
===============================================================================}
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, FileUtil, SynEdit, math, ClipBrd,
  SynHighlighterAny, SynHighlighterPerl, synhighlighterunixshellscript,
  LResources, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus, ComCtrls,
  ExtCtrls, Spin, EditBtn, Buttons, ActnList, lcltype, AsyncProcess, Grids,
  CheckLst, inifiles, fpjson, jsonparser, strutils, RegExpr, mcxabout, mcxshape,
  mcxnewsession, mcxsource;

type

  { TfmMCX }

  TfmMCX = class(TForm)
    acEditShape: TActionList;
    btGBExpand: TButton;
    ckDoRemote: TCheckBox;
    ckReflect: TCheckBox;
    ckSpecular: TCheckBox;
    ckMomentum: TCheckBox;
    edMoreParam: TEdit;
    edRemote: TEdit;
    grAtomic: TRadioGroup;
    Image1: TImage;
    Label18: TLabel;
    mcxdoToggleView: TAction;
    mcxdoPaste: TAction;
    mcxdoCopy: TAction;
    ckDoReplay: TCheckBox;
    ckSaveMask: TCheckBox;
    ckbDebug: TCheckListBox;
    edReplayDet: TSpinEdit;
    JSONIcons: TImageList;
    ImageList3: TImageList;
    Label16: TLabel;
    Label17: TLabel;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    miClearLog1: TMenuItem;
    OpenHistoryFile: TOpenDialog;
    OpenVolume: TOpenDialog;
    PopupMenu2: TPopupMenu;
    grProgram: TRadioGroup;
    OpenDir: TSelectDirectoryDialog;
    shapePrint: TAction;
    shapeEdit: TAction;
    shapeAddCylinder: TAction;
    shapeAddZSlabs: TAction;
    shapeAddYSlabs: TAction;
    shapeAddXSlabs: TAction;
    shapeAddZLayers: TAction;
    shapeAddYLayers: TAction;
    shapeAddXLayers: TAction;
    shapeAddUpperSpace: TAction;
    shapeAddSubgrid: TAction;
    shapeAddBox: TAction;
    shapeAddSphere: TAction;
    shapeAddGrid: TAction;
    shapeAddOrigin: TAction;
    shapeAddName: TAction;
    shapeDelete: TAction;
    shapeReset: TAction;
    Button1: TButton;
    ckSaveSeed: TCheckBox;
    edGPUID: TCheckListBox;
    ckAutopilot: TCheckBox;
    ckNormalize: TCheckBox;
    ckSaveData: TCheckBox;
    ckSaveDetector: TCheckBox;
    ckSaveExit: TCheckBox;
    ckSaveRef: TCheckBox;
    ckSkipVoid: TCheckBox;
    ckSrcFrom0: TCheckBox;
    edBlockSize: TComboBox;
    edBubble: TEdit;
    edConfigFile: TFileNameEdit;
    edDetectedNum: TEdit;
    edGate: TSpinEdit;
    edPhoton: TEdit;
    edRespin: TSpinEdit;
    edSeed: TEdit;
    edSession: TEdit;
    edThread: TComboBox;
    edUnitInMM: TEdit;
    edWorkload: TEdit;
    grAdvSettings: TGroupBox;
    grArray: TRadioGroup;
    grBasic: TGroupBox;
    grGPU: TGroupBox;
    grSwitches: TGroupBox;
    HeaderControl1: THeaderControl;
    ImageList2: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    lbBubble: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    lbAtomic: TLabel;
    Label15: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbRespin: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lvJobs: TListView;
    mcxdoHelpOptions: TAction;
    miClearLog: TMenuItem;
    OpenProject: TOpenDialog;
    pcSimuEditor: TPageControl;
    Panel1: TPanel;
    plOutput: TPanel;
    pMCX: TAsyncProcess;
    mcxSetCurrent: TAction;
    acInteract: TActionList;
    mcxdoDefault: TAction;
    mcxdoClearLog: TAction;
    mcxdoSave: TAction;
    mcxdoExit: TAction;
    mcxdoListGPU: TAction;
    mcxdoQuery: TAction;
    mcxdoWeb: TAction;
    mcxdoAbout: TAction;
    mcxdoHelp: TAction;
    mcxdoRunAll: TAction;
    mcxdoStop: TAction;
    mcxdoRun: TAction;
    mcxdoVerify: TAction;
    mcxdoDeleteItem: TAction;
    mcxdoAddItem: TAction;
    mcxdoOpen: TAction;
    mcxdoInitEnv: TAction;
    acMCX: TActionList;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    plSetting: TPanel;
    pExternal: TProcess;
    PopupMenu1: TPopupMenu;
    rbUseFile: TRadioButton;
    rbUseDesigner: TRadioButton;
    SaveProject: TSaveDialog;
    sbInfo: TStatusBar;
    btLoadSeed: TSpeedButton;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    Splitter5: TSplitter;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    sgMedia: TStringGrid;
    sgDet: TStringGrid;
    sgConfig: TStringGrid;
    mmOutput: TSynEdit;
    SynUNIXShellScriptSyn1: TSynUNIXShellScriptSyn;
    tabInputData: TTabSheet;
    tabVolumeDesigner: TTabSheet;
    tbtRun: TToolButton;
    tbtStop: TToolButton;
    tbtVerify: TToolButton;
    Timer1: TTimer;
    tmAnimation: TTimer;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton2: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolButton27: TToolButton;
    ToolButton28: TToolButton;
    ToolButton29: TToolButton;
    ToolButton3: TToolButton;
    ToolButton30: TToolButton;
    ToolButton31: TToolButton;
    ToolButton32: TToolButton;
    ToolButton33: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    tvShapes: TTreeView;
    procedure btLoadSeedClick(Sender: TObject);
    procedure btGBExpandClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure grAdvSettingsDblClick(Sender: TObject);
    procedure grProgramSelectionChanged(Sender: TObject);
    procedure lvJobsChange(Sender: TObject; Item: TListItem; Change: TItemChange
      );
    procedure mcxdoAboutExecute(Sender: TObject);
    procedure mcxdoAddItemExecute(Sender: TObject);
    procedure mcxdoCopyExecute(Sender: TObject);
    procedure mcxdoDefaultExecute(Sender: TObject);
    procedure mcxdoDeleteItemExecute(Sender: TObject);
    procedure mcxdoExitExecute(Sender: TObject);
    procedure mcxdoHelpExecute(Sender: TObject);
    procedure mcxdoHelpOptionsExecute(Sender: TObject);
    procedure mcxdoOpenExecute(Sender: TObject);
    procedure mcxdoPasteExecute(Sender: TObject);
    procedure mcxdoQueryExecute(Sender: TObject);
    procedure mcxdoRunExecute(Sender: TObject);
    procedure mcxdoSaveExecute(Sender: TObject);
    procedure mcxdoStopExecute(Sender: TObject);
    procedure mcxdoToggleViewExecute(Sender: TObject);
    procedure mcxdoVerifyExecute(Sender: TObject);
    procedure edConfigFileChange(Sender: TObject);
    procedure edRespinChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvJobsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure mcxdoWebExecute(Sender: TObject);
    procedure mcxSetCurrentExecute(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure miClearLogClick(Sender: TObject);
    procedure plOutputDockOver(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure pMCXReadData(Sender: TObject);
    procedure pMCXTerminate(Sender: TObject);
    procedure rbUseFileChange(Sender: TObject);
    procedure sbInfoDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure sgConfigDblClick(Sender: TObject);
    procedure sgConfigEditButtonClick(Sender: TObject);
    procedure sgMediaEditingDone(Sender: TObject);
    procedure shapeAddBoxExecute(Sender: TObject);
    procedure shapeAddCylinderExecute(Sender: TObject);
    procedure shapeAddGridExecute(Sender: TObject);
    procedure shapeAddNameExecute(Sender: TObject);
    procedure shapeAddOriginExecute(Sender: TObject);
    procedure shapeAddSphereExecute(Sender: TObject);
    procedure shapeAddSubgridExecute(Sender: TObject);
    procedure shapeAddUpperSpaceExecute(Sender: TObject);
    procedure shapeAddXLayersExecute(Sender: TObject);
    procedure shapeAddXSlabsExecute(Sender: TObject);
    procedure shapeAddYLayersExecute(Sender: TObject);
    procedure shapeAddYSlabsExecute(Sender: TObject);
    procedure shapeAddZLayersExecute(Sender: TObject);
    procedure shapeAddZSlabsExecute(Sender: TObject);
    procedure shapePrintExecute(Sender: TObject);
    procedure shapeResetExecute(Sender: TObject);
    procedure shapeDeleteExecute(Sender: TObject);
    procedure Splitter2Moved(Sender: TObject);
    procedure Splitter6CanOffset(Sender: TObject; var NewOffset: Integer;
      var Accept: Boolean);
    procedure Splitter6CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure StaticText2DblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure tmAnimationTimer(Sender: TObject);
    procedure tvShapesDeletion(Sender: TObject; Node: TTreeNode);
    procedure tvShapesEdited(Sender: TObject; Node: TTreeNode; var S: string);
    procedure tvShapesSelectionChanged(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    MapList, ConfigData, JSONstr : TStringList;
    JSONdata : TJSONData;
    RegEngine:TRegExpr;
    function CreateCmd:string;
    function CreateCmdOnly:string;
    procedure VerifyInput;
    procedure AddLog(str:string);
    procedure AddMultiLineLog(str:string);
    procedure ListToPanel2(node:TListItem);
    procedure PanelToList2(node:TListItem);
    procedure UpdateMCXActions(actlst: TActionList; ontag,offtag: string);
    function  GetMCXOutput () : string;
    procedure SaveTasksToIni(fname: string);
    procedure LoadTasksFromIni(fname: string);
    procedure RunExternalCmd(cmd: string);
    function  GetBrowserPath : string;
    function  SearchForExe(fname : string) : string;
    function CreateWorkFolder:string;
    procedure SaveJSONConfig(filename: string);
    function CheckListToStr(list: TCheckListBox) : string;
    function GridToStr(grid:TStringGrid) :string;
    procedure StrToGrid(str: string; grid:TStringGrid);
    procedure ShowJSONData(AParent : TTreeNode; Data : TJSONData; toplevel: boolean=false);
    procedure AddShapesWindow(shapeid: string; defaultval: TStringList; node: TTreeNode);
    procedure AddShapes(shapeid: string; defaultval: string);
    function UpdateShapeTag(root: TJSONData; doexport: boolean = false): integer;
    function RebuildLayeredObj(rootdata: TJSONData; out maxtag: integer): string;
    procedure SetModified;
    procedure LoadJSONShapeTree(shapejson: string);
    procedure GotoColRow(grid: TStringGrid; Col, Row: Integer);
    procedure SetSessionType(sessiontype: integer);
  end;

var
  fmMCX: TfmMCX;
  ProfileChanged: Boolean;
  MaxWait: integer;
  TaskFile: string;
  GotoCol, GotoRow: Integer;
  GotoGrid: TStringGrid;
  GotoGBox: TGroupBox;

implementation

Const
  ImageTypeMap : Array[TJSONtype] of Integer =
//      jtUnknown, jtNumber, jtString, jtBoolean, jtNull, jtArray, jtObject
     (-1,8,9,7,6,5,4);
  JSONTypeNames : Array[TJSONtype] of string =
     ('Unknown','Number','String','Boolean','Null','Array','Object');
  MCProgram : Array[0..2] of string =
     ('mcx','mmc','mcxcl');
  DebugFlags: string ='RMP';

{ TfmMCX }
procedure TfmMCX.AddLog(str:string);
begin
    mmOutput.Lines.Add(str);
    mmOutput.SelStart := length(mmOutput.Text);
end;

procedure TfmMCX.AddMultiLineLog(str:string);
var
   sl: TStringList;
begin
    sl:=TStringList.Create;
    sl.StrictDelimiter:=true;
    sl.Delimiter:=#10;
    sl.DelimitedText:=str;
    mmOutput.Lines.AddStrings(sl);
    mmOutput.SelStart := length(mmOutput.Text);
    sl.Free;
end;

procedure TfmMCX.edConfigFileChange(Sender: TObject);
begin
  if(Length(edSession.Text)=0) then
       edSession.Text:=ExtractFileName(edConfigFile.FileName);
end;
procedure TfmMCX.SetModified;
begin
    //if not (mcxdoRun.Enabled) then exit;
    UpdateMCXActions(acMCX,'','Work');
    UpdateMCXActions(acMCX,'','Run');
    mcxdoSave.Enabled:=true;
end;

procedure TfmMCX.edRespinChange(Sender: TObject);
var
    ed: TEdit;
    cb: TComboBox;
    ck: TCheckBox;
    se: TSpinEdit;
    gr: TRadioGroup;
    ckb: TCheckListBox;
    fed:TFileNameEdit;
    sg: TStringGrid;
    tv: TTreeView;
    idx: integer;
    node: TListItem;
    ss: string;
begin
    if(Sender=nil) or (lvJobs.Selected=nil) then exit;
    try
    node:=lvJobs.Selected;
    if(Sender is TSpinEdit) then begin
       se:=Sender as TSpinEdit;
       idx:=MapList.IndexOf(se.Hint);
       if(idx>=0) then
                  node.SubItems.Strings[idx]:=IntToStr(se.Value);
    end else if(Sender is TEdit) then begin
       ed:=Sender as TEdit;
       idx:=MapList.IndexOf(ed.Hint);
       if(ed.Hint = 'Session') then  node.Caption:=ed.Text;
       if(idx>=0) then
                  node.SubItems.Strings[idx]:=ed.Text;
    end else if(Sender is TRadioGroup) then begin
       gr:=Sender as TRadioGroup;
       idx:=MapList.IndexOf(gr.Hint);
       if(idx>=0) then
                  node.SubItems.Strings[idx]:=IntToStr(gr.ItemIndex);
    end else if(Sender is TComboBox) then begin
       cb:=Sender as TComboBox;
       idx:=MapList.IndexOf(cb.Hint);
       if(idx>=0) then
                  node.SubItems.Strings[idx]:=cb.Text;
    end else if(Sender is TCheckBox) then begin
       ck:=Sender as TCheckBox;
       idx:=MapList.IndexOf(ck.Hint);
       if(idx>=0) then
                  node.SubItems.Strings[idx]:=IntToStr(Integer(ck.Checked));
       if(ck.Hint='Autopilot') then begin
           edThread.Enabled:=not ck.Checked;
           edBlockSize.Enabled:=not ck.Checked;
       end;
       if(ck.Hint='SaveSeed') or (ck.Hint='SaveExit') then begin
           ckSaveDetector.Checked:=true;
       end;
       if(ck.Hint='SaveDetector') then begin
           edDetectedNum.Enabled:=ck.Checked;
       end;
       if(ck.Hint='DoReplay') then begin
           edReplayDet.Enabled:=ck.Checked;
       end;
       if(ck.Hint='DoRemote') then begin
           edRemote.Enabled:=ck.Checked;
       end;
    end else if(Sender is TCheckListBox) then begin
       ckb:=Sender as TCheckListBox;
       idx:=MapList.IndexOf(ckb.Hint);
       if(idx>=0) then begin
           node.SubItems.Strings[idx]:=CheckListToStr(ckb);
       end;
    end else if(Sender is TFileNameEdit) then begin
       fed:=Sender as TFileNameEdit;
       idx:=MapList.IndexOf(fed.Hint);
       if(idx>=0) then
                  node.SubItems.Strings[idx]:=fed.Text;
    end else if(Sender is TStringGrid) then begin
       sg:=Sender as TStringGrid;
       idx:=MapList.IndexOf(sg.Hint);
       if(idx>=0) then
             node.SubItems.Strings[idx]:=GridToStr(sg);
    end else if(Sender is TTreeView) then begin
       tv:=Sender as TTreeView;
       idx:=MapList.IndexOf(tv.Hint);
       if(idx>=0) and (tv.Name='tvShapes') then  begin
           ss:= JSONData.AsJSON;
           if(JSONData.FindPath('Shapes') <> nil) then begin
               tv.Tag:=UpdateShapeTag(JSONData.FindPath('Shapes'));
           end else begin
               tv.Tag:=UpdateShapeTag(JSONData);
           end;
           node.SubItems.Strings[idx]:=TJSONData(JSONData).FormatJSON(AsJSONFormat);
       end;
    end;
    SetModified;
    except
    end;
end;

procedure TfmMCX.mcxdoExitExecute(Sender: TObject);
var
   ret:integer;
begin
    if(mcxdoSave.Enabled) then begin
       ret:=Application.MessageBox('The current session has not been saved, do you want to save before exit?',
         'Confirm', MB_YESNOCANCEL);
       if (ret=IDYES) then
            mcxdoSaveExecute(Sender);
       if (ret=IDCANCEL) then
            exit;
    end;
    Close;
end;

procedure TfmMCX.mcxdoHelpExecute(Sender: TObject);
begin
   RunExternalCmd(GetBrowserPath + ' http://mcx.sourceforge.net/cgi-bin/index.cgi?Doc');
end;

procedure TfmMCX.mcxdoHelpOptionsExecute(Sender: TObject);
begin
    if(not pMCX.Running) then begin
          if(ckDoRemote.Checked) then
              pMCX.CommandLine:=edRemote.Text+' '+ CreateCmdOnly+' --help'
          else
              pMCX.CommandLine:=CreateCmdOnly+' --help';
          sbInfo.Panels[0].Text := 'Status: querying command line options';
          pMCX.Tag:=-2;
          AddLog('"-- Print MCX Command Line Options --"');
          pMCX.Execute;
    end;
end;

procedure TfmMCX.SetSessionType(sessiontype: integer);
begin
    grProgram.ItemIndex:=sessiontype;
end;

procedure TfmMCX.mcxdoAddItemExecute(Sender: TObject);
var
   node: TListItem;
   i:integer;
   sessionid: string;
   sessiontype: integer;
   fmNewSession: TfmNewSession;
begin
   fmNewSession:=TfmNewSession.Create(self);
   fmnewSession.grProgram.Columns:=1;
   if(fmNewSession.ShowModal= mrOK) then begin
          sessionid:=Trim(fmNewSession.edSession.Text);
          sessiontype:=fmNewSession.grProgram.ItemIndex;
   end else begin
          fmNewSession.Free;
          exit;
   end;
   fmNewSession.Free;

   node:=lvJobs.Items.Add;
   for i:=1 to lvJobs.Columns.Count-1 do node.SubItems.Add('');
   node.Caption:=sessionid;
   node.ImageIndex:=14+sessiontype;
   plSetting.Enabled:=true;
   pcSimuEditor.Enabled:=true;
   lvJobs.Selected:=node;
   mcxdoDefaultExecute(nil);
   edSession.Text:=sessionid;
   SetSessionType(sessiontype);
   UpdateMCXActions(acMCX,'','Work');
   UpdateMCXActions(acMCX,'','Run');
   UpdateMCXActions(acMCX,'Preproc','');
   UpdateMCXActions(acMCX,'SelectedJob','');
end;

procedure TfmMCX.mcxdoCopyExecute(Sender: TObject);
var
   setting: TStringList;
   j: integer;
begin
   if(lvJobs.Selected = nil) then exit;
   setting:=TStringList.Create;
   setting.Values['Session']:=lvJobs.Selected.Caption;
   for j:=1 to lvJobs.Columns.Count-1 do begin
           setting.Add(lvJobs.Columns.Items[j].Caption+'='+lvJobs.Selected.SubItems.Strings[j-1]);
   end;
   Clipboard.Open;
   try
      Clipboard.Clear;
      Clipboard.AsText := setting.Text;
   finally
      Clipboard.Close;
      setting.Free;
   end;
end;

procedure TfmMCX.mcxdoDefaultExecute(Sender: TObject);
begin
      //edSession.Text:='';
      edConfigFile.FileName:='';
      edThread.Text:='16384';
      edPhoton.Text:='1e7';
      edBlockSize.Text:='64';
      edBubble.Text:='-2';
      edGate.Value:=100;
      edRespin.Value:=1;
      grArray.ItemIndex:=0;
      ckReflect.Checked:=true;   //-b
      ckSaveData.Checked:=true;   //-S
      ckNormalize.Checked:=true;   //-U
      ckSaveDetector.Checked:=true;   //-d
      ckSaveExit.Checked:=false;  //-x
      ckSaveRef.Checked:=false;  //-X
      ckSrcFrom0.Checked:=true;  //-z
      ckSkipVoid.Checked:=false;  //-k
      ckAutopilot.Checked:=true;
      ckSaveSeed.Checked:=false;
      ckSaveMask.Checked:=false;
      edThread.Enabled:=false;
      edBlockSize.Enabled:=false;
      ckSpecular.Checked:=false;
      ckMomentum.Checked:=false;
      edWorkLoad.Text:='100';
      edMoreParam.Text:='';
      edUnitInMM.Text:='1';
      edGPUID.CheckAll(cbUnchecked);
      if(edGPUID.Items.Count>0) then begin
          edGPUID.Checked[0]:=true;
      end;
      pcSimuEditor.ActivePage:=tabInputData;
      edDetectedNum.Text:='10000000';
      edSeed.Text:='1648335518';
      ckDoReplay.Checked:=false;
      ckbDebug.CheckAll(cbUnchecked);
      grAtomic.ItemIndex:=0;
      edReplayDet.Value:=0;
      rbUseDesigner.Checked:=true;
      sgMedia.RowCount:=1;
      sgMedia.RowCount:=129;
      sgMedia.Rows[1].CommaText:='0,0,1,1';
      sgMedia.Rows[2].CommaText:='0.005,1,0.01,1.37';
      sgDet.RowCount:=1;
      sgDet.RowCount:=129;
      sgDet.Rows[1].CommaText:='24,29,0,1';
      //sgConfig.ColCount:=3;
      sgConfig.Cols[2].CommaText:=ConfigData.CommaText;
      edRemote.Text:='ssh user@server';
      ckDoRemote.Checked:=false;

      if(grProgram.ItemIndex=1) then begin
          sgConfig.Rows[1].CommaText:='Domain,MeshID,';
          sgConfig.Rows[2].CommaText:='Domain,InitElem,';
      end else begin
          sgConfig.Rows[1].CommaText:='Domain,VolumeFile,"See Volume Designer..."';
          sgConfig.Rows[2].CommaText:='Domain,Dim,"[60,60,60]"';
      end;
      LoadJSONShapeTree('[{"Grid":{"Tag":1,"Size":[60,60,60]}}]');
      if not (lvJobs.Selected = nil) then
         PanelToList2(lvJobs.Selected);
end;

procedure TfmMCX.UpdateMCXActions(actlst: TActionList; ontag,offtag: string);
var
   i: integer;
begin
   for i:=0 to actlst.ActionCount-1 do begin
       if (Length(ontag)>0) and (actlst.Actions[i].Category=ontag) then begin
             (actlst.Actions[i] as TAction).Enabled:=true;
       end else if (Length(offtag)>0) and (actlst.Actions[i].Category=offtag) then
             (actlst.Actions[i] as TAction).Enabled:=false;
   end;
end;


procedure TfmMCX.mcxdoAboutExecute(Sender: TObject);
var
    fmAbout:TfmAbout;
begin
     fmAbout:=TfmAbout.Create(Application);
     fmAbout.ShowModal;
     fmAbout.Free;
end;

procedure TfmMCX.lvJobsChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  mcxdoSave.Enabled:=true;
end;

procedure TfmMCX.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
      tvShapes.Enabled:=false;
end;

procedure TfmMCX.FormShow(Sender: TObject);
begin
    grGPU.Top:=grProgram.Height+grBasic.Height;
    grAdvSettings.Height:=self.Canvas.TextHeight('Ag')+btGBExpand.Height+5;
end;

procedure TfmMCX.btLoadSeedClick(Sender: TObject);
begin
      if(OpenHistoryFile.Execute) then begin
          edSeed.Text:=OpenHistoryFile.FileName;
          ckDoReplay.Checked:=true;
      end;
end;

procedure TfmMCX.btGBExpandClick(Sender: TObject);
var
     gr: TGroupBox;
begin
     if not (Sender is TButton) then exit;
     if not ((Sender as TButton).Parent is TGroupBox) then exit;
     gr:=((Sender as TButton).Parent as TGroupBox);
     GotoGBox:=gr;
     if(gr.Align=alClient) then begin // collapse
         gr.Align:=alTop;
         (Sender as TButton).Caption:=#65088;
         tmAnimation.Tag:=1;
         tmAnimation.Enabled:=true;
     end else begin
         (Sender as TButton).Caption:=#65087;
         tmAnimation.Tag:=0;
         tmAnimation.Enabled:=true;
     end;
end;

procedure TfmMCX.grAdvSettingsDblClick(Sender: TObject);
var
    i: integer;
begin
     if(grAdvSettings.Tag<0) then begin
       for i:=20 to plSetting.ClientHeight do begin
            grAdvSettings.Height:=i;
            Sleep(100);
       end;
       grAdvSettings.Tag:=0;
     end else begin
       for i:=plSetting.ClientHeight downto 20 do begin
              grAdvSettings.Height:=i;
              Sleep(100);
       end;
       grAdvSettings.Tag:=-1;
     end;
end;

procedure TfmMCX.grProgramSelectionChanged(Sender: TObject);
begin
  case grProgram.ItemIndex of
    0, 2: begin
        grGPU.Top:=grProgram.Height+grBasic.Height;
        grGPU.Visible:=true;
        tabVolumeDesigner.Enabled:=true;
        ckSpecular.Visible:=false;
        ckMomentum.Visible:=false;
        ckSaveRef.Visible:=true;
        edRespin.Hint:='RespinNum';
        lbRespin.Caption:='Split into runs (-r)';
        edBubble.Hint:='BubbleSize';
        lbBubble.Caption:='Cache radius from src (-R)';
        mcxdoQuery.Enabled:=true;
    end;
    1: begin
        grGPU.Visible:=false;
        tabVolumeDesigner.Enabled:=false;
        ckSpecular.Visible:=true;
        ckMomentum.Visible:=true;
        ckSaveRef.Visible:=true;
        edRespin.Hint:='BasicOrder';
        lbRespin.Caption:='Element order (-C)';
        edBubble.Hint:='DebugPhoton';
        lbBubble.Caption:='Debug photon index';
    end;
  end;
  if(grProgram.ItemIndex=1) then begin
        sgConfig.Rows[1].CommaText:='Domain,MeshID,';
        sgConfig.Rows[2].CommaText:='Domain,InitElem,';
  end else begin
        sgConfig.Rows[1].CommaText:='Domain,VolumeFile,"See Volume Designer..."';
        sgConfig.Rows[2].CommaText:='Domain,Dim,"[60,60,60]"';
  end;
  if(lvJobs.Selected <> nil) then
      lvJobs.Selected.ImageIndex:=14+grProgram.ItemIndex;
  edRespinChange(Sender);
end;

procedure TfmMCX.mcxdoDeleteItemExecute(Sender: TObject);
begin
  if not (lvJobs.Selected = nil) then
  begin
        if not (Application.MessageBox('The selected configuration will be deleted, are you sure?',
          'Confirm', MB_YESNOCANCEL)=IDYES) then
            exit;
        lvJobs.Items.Delete(lvJobs.Selected.Index);
        if not (lvJobs.Selected = nil) then
            ListToPanel2(lvJobs.Selected)
        else
            mcxdoDeleteItem.Enabled:=false;
  end;
end;

procedure TfmMCX.mcxdoOpenExecute(Sender: TObject);
begin
  if(OpenProject.Execute) then begin
    TaskFile:=OpenProject.FileName;
    if(mcxdoSave.Enabled) then begin
       if(Application.MessageBox('The current session has not been saved, do you want to discard?',
         'Confirm', MB_YESNOCANCEL)=IDYES) then begin
            LoadTasksFromIni(TaskFile);
       end
    end else begin
       LoadTasksFromIni(TaskFile);
    end;
  end
end;

procedure TfmMCX.mcxdoPasteExecute(Sender: TObject);
var
   setting: TStringList;
   j: integer;
   node: TListItem;
   fmNewSession: TfmNewSession;
begin
   if(lvJobs.Selected = nil) then exit;
   setting:=TStringList.Create;
   setting.Text:=Clipboard.AsText;

   for j:=1 to 100000 do begin
       if(lvJobs.FindCaption(0,setting.Values['Session']+IntToStr(j),true,true,true) = nil) then
          break;
   end;

   fmNewSession:=TfmNewSession.Create(Application);
   fmnewSession.grProgram.ChildSizing.ControlsPerLine:=1;
   fmnewSession.edSession.Text:=setting.Values['Session'];
   if(Length(setting.Values['MCProgram'])>0) then
       fmnewSession.grProgram.ItemIndex:=StrToInt(setting.Values['MCProgram']);
   if(fmNewSession.ShowModal= mrOK) then begin
          setting.Values['Session']:=Trim(fmNewSession.edSession.Text);
          setting.Values['MCProgram']:=IntToStr(fmNewSession.grProgram.ItemIndex);
   end else begin
          fmNewSession.Free;
          setting.Free;
          exit;
   end;
   fmNewSession.Free;

   grProgram.ItemIndex:=StrToInt(setting.Values['MCProgram']);
   node:=lvJobs.Items.Add;
   node.Caption:=setting.Values['Session'];
   node.ImageIndex:=14+grProgram.ItemIndex;
   for j:=1 to lvJobs.Columns.Count-1 do
       node.SubItems.Add('');
   for j:=1 to lvJobs.Columns.Count-1 do begin
       node.SubItems.Strings[j-1]:=setting.Values[lvJobs.Columns.Items[j].Caption];
   end;
   setting.Free;
   lvJobs.Selected:=node;
   mcxSetCurrentExecute(Sender);
end;

procedure TfmMCX.mcxdoQueryExecute(Sender: TObject);
begin
    if(not pMCX.Running) then begin
          if(ckDoRemote.Checked) then
              pMCX.CommandLine:=edRemote.Text+' '+ CreateCmdOnly+' -L'
          else
              pMCX.CommandLine:=CreateCmdOnly+' -L';
          sbInfo.Panels[0].Text := 'Status: querying GPU';
          pMCX.Tag:=-1;
          AddLog('"-- Printing GPU Information --"');
          pMCX.Execute;

          UpdateMCXActions(acMCX,'Run','');
    end;
end;

procedure TfmMCX.mcxdoRunExecute(Sender: TObject);
begin
    if(not pMCX.Running) then begin
          pMCX.CommandLine:=CreateCmd;
          AddLog('"-- Executing Simulation --"');
          if(ckbDebug.Checked[2]) then begin
              sbInfo.Panels[1].Text:='0%';
              sbInfo.Invalidate;
          end;
          pMCX.Execute;
          mcxdoStop.Enabled:=true;
          mcxdoRun.Enabled:=false;
          sbInfo.Panels[0].Text := 'Status: running simulation';
          sbInfo.Panels[2].Text := '';
          pMCX.Tag:=-10;
          sbInfo.Color := clRed;
          UpdateMCXActions(acMCX,'Run','');
          mcxdoRun.Tag:=GetTickCount64;
          Application.ProcessMessages;
    end;
end;

procedure TfmMCX.mcxdoSaveExecute(Sender: TObject);
begin
  if(SaveProject.Execute) then begin
    TaskFile:=SaveProject.FileName;
    if(length(TaskFile) >0) then begin
        SaveTasksToIni(TaskFile);
        mcxdoSave.Enabled:=false;
    end;
  end;
end;

procedure TfmMCX.mcxdoStopExecute(Sender: TObject);
begin
     if(pMCX.Running) then pMCX.Terminate(0);
     Sleep(1000);
     if(not pMCX.Running) then begin
          mcxdoStop.Enabled:=false;
          if(mcxdoVerify.Enabled) then
             mcxdoRun.Enabled:=true;
          AddLog('"-- Terminated Simulation --"');
          if(ckbDebug.Checked[2]) then begin
              sbInfo.Panels[1].Text:='0%';
              sbInfo.Tag:=0;
              sbInfo.Repaint;
          end;
     end
end;

procedure TfmMCX.mcxdoToggleViewExecute(Sender: TObject);
begin
     if(lvJobs.ViewStyle=vsIcon) then
        lvJobs.ViewStyle:=vsReport
     else
         lvJobs.ViewStyle:=vsIcon;
end;

procedure TfmMCX.mcxdoVerifyExecute(Sender: TObject);
begin
    VerifyInput;
end;

procedure TfmMCX.LoadJSONShapeTree(shapejson: string);
var
    shaperoot: TTreeNode;
begin
    tvShapes.Enabled:=false;
    tvShapes.Items.BeginUpdate;
    tvShapes.Items.Clear;
    tvShapes.Items.EndUpdate;
    shaperoot:=tvShapes.Items.Add(nil,'Shapes');
    FreeAndNil(JSONData);
    JSONData:=GetJSON(shapejson);
    if(JSONData.FindPath('Shapes') <> nil) then
       ShowJSONData(shaperoot,JSONData.FindPath('Shapes'))
    else
       ShowJSONData(shaperoot,JSONData);
    tvShapes.Enabled:=true;
    tvShapes.FullExpand;
end;

procedure TfmMCX.FormCreate(Sender: TObject);
var
    i: integer;
begin
    MapList:=TStringList.Create();
    MapList.Clear;
    for i:=1 to lvJobs.Columns.Count-1 do begin
        MapList.Add(lvJobs.Columns.Items[i].Caption);
    end;

    JSONdata:=TJSONObject.Create;

    ConfigData:=TStringList.Create();
    ConfigData.Clear;
    ConfigData.CommaText:=sgConfig.Cols[2].CommaText;

    RegEngine:=TRegExpr.Create('%[0-9 ]{4}\]');

    btLoadSeed.Glyph.Assign(nil);
    JSONIcons.GetBitmap(2, btLoadSeed.Glyph);

    ProfileChanged:=false;
    if not (SearchForExe(CreateCmdOnly) = '') then begin
        mcxdoQuery.Enabled:=true;
        mcxdoHelpOptions.Enabled:=true;
    end;
    LoadJSONShapeTree('[{"Grid":{"Tag":1,"Size":[60,60,60]}}]');
end;

procedure TfmMCX.FormDestroy(Sender: TObject);
begin
    FreeAndNil(JSONData);
    MapList.Free;
    ConfigData.Free;
    RegEngine.Free;
end;

procedure TfmMCX.lvJobsSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
     if(Selected) then begin
          if (lvJobs.Selected=nil) then begin
          end else begin
              mcxdoDeleteItem.Enabled:=true;
              mcxdoCopy.Enabled:=Selected;
          end;
     end;
end;

procedure TfmMCX.RunExternalCmd(cmd: string);
var
  Proc : TProcess;
begin
  Proc := TProcess.Create(nil);
  try
    Proc.CommandLine := cmd;
    //PRoc.Options := Proc.Options + [poWaitOnExit];
    PRoc.Execute;
  finally
    Proc.free;
  end;
end;

function TfmMCX.SearchForExe(fname : string) : string;
begin
   {$IFDEF WINDOWS}
   if (Pos('.exe',Trim(LowerCase(fname)))<=0) or (Pos('.exe',Trim(LowerCase(fname))) <> Length(Trim(fname))-3) then
           fname:=fname+'.exe';
   {$ENDIF}
   Result :=
    SearchFileInPath(fname, '', ExtractFilePath(Application.ExeName)+PathSeparator+GetEnvironmentVariable('PATH'),
                     PathSeparator, [sffDontSearchInBasePath]);
end;

function TfmMCX.GetBrowserPath : string;
  {Return path to first browser found.}
begin
   Result := SearchForExe('firefox');
   if Result = '' then
     Result := SearchForExe('google-chrome');
   if Result = '' then
     Result := SearchForExe('konqueror');  {KDE browser}
   if Result = '' then
     Result := SearchForExe('epiphany');  {GNOME browser}
   if Result = '' then
     Result := SearchForExe('opera');
   if Result = '' then
     Result := SearchForExe('open'); // mac os
   if Result = '' then
     Result :='cmd /c start'; // windows
end;

procedure TfmMCX.mcxdoWebExecute(Sender: TObject);
begin
  RunExternalCmd(GetBrowserPath + ' http://mcx.space');
end;

procedure TfmMCX.mcxSetCurrentExecute(Sender: TObject);
var
     addnew: TListItem;
begin
     if not (lvJobs.Selected = nil) then begin
         ListToPanel2(lvJobs.Selected);
         plSetting.Enabled:=true;
         pcSimuEditor.Enabled:=true;
         mcxdoVerify.Enabled:=true;
         mcxdoDefault.Enabled:=true;
     end;
end;

procedure TfmMCX.MenuItem9Click(Sender: TObject);
begin
    pcSimuEditor.ActivePage:=tabInputData;
end;

procedure TfmMCX.miClearLogClick(Sender: TObject);
begin
    mmOutput.Lines.Clear;
end;

procedure TfmMCX.plOutputDockOver(Sender: TObject; Source: TDragDockObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
   pos:TRect;
   mm: TMemo;
begin
     Accept:=false;
     if (Sender is TMemo) then
        Accept:=true;
     if(Accept) then begin
          mm:=(Sender as TMemo);
          pos:=Rect(0,Height-mm.Height, Width, Height);
          mm.Dock(Self,pos);
     end;
end;

procedure TfmMCX.pMCXReadData(Sender: TObject);
begin
     AddMultiLineLog(GetMCXOutput);
     if not (pMCX.Running) then
         pMCXTerminate(Sender);
end;

procedure TfmMCX.pMCXTerminate(Sender: TObject);
begin
     if(not mcxdoStop.Enabled) then exit;
     if(pMCX.Tag=-10) then
         sbInfo.Panels[2].Text:=Format('Last simulation used %.3f seconds', [(GetTickCount64-mcxdoRun.Tag)/1000.]);
     mcxdoRun.Tag:=0;
     mcxdoStop.Enabled:=false;
     if(mcxdoVerify.Enabled) then
         mcxdoRun.Enabled:=true;
     sbInfo.Panels[0].Text := 'Status: idle';
     pMCX.Tag:=0;
     sbInfo.Color := clBtnFace;
     AddLog('"-- Task completed --"');
     sbInfo.Panels[1].Text:='';
     sbInfo.Tag:=0;
     sbInfo.Repaint;
     UpdateMCXActions(acMCX,'','Run');
end;

procedure TfmMCX.rbUseFileChange(Sender: TObject);
var
   btn: TRadioButton;
begin
   if(Sender is TRadioButton) then
   begin
        btn:= Sender as TRadioButton;
        if(btn.Checked) then
        begin
            edConfigFile.Enabled:=true;
            tabInputData.Enabled:=false;
        end else begin
            edConfigFile.Enabled:=false;
            tabInputData.Enabled:=true;
        end;
   end;
end;

procedure TfmMCX.sbInfoDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
  const Rect: TRect);
var
   perc: integer;
   newrect: TRect;
begin
   case Panel.Index of
      1: begin
          perc:=sbInfo.Tag;
          sbInfo.Canvas.Brush.style:= bsSolid;
          sbInfo.Canvas.Brush.color:= RGBToColor(230, 184, 156);
          newrect:=Rect;
          newrect.Right:=Round(real((Rect.Right-Rect.Left)*perc)/100.0);
          sbInfo.Canvas.FillRect(newrect);
          sbInfo.Canvas.Brush.style:= bsClear;
          sbInfo.Canvas.TextOut(Rect.Left+Round(Real(Rect.Right-Rect.Left)*0.5)-Rect.Bottom,Rect.Top, sbInfo.Panels[1].Text);
      end;
   end;
end;

procedure TfmMCX.sgConfigDblClick(Sender: TObject);
var
   sg: TStringGrid;
begin

end;

procedure TfmMCX.sgConfigEditButtonClick(Sender: TObject);
var
   grid: TStringGrid;
   fmSrc: TfmSource;
begin
   if not(Sender is TStringGrid) then exit;
   grid:= Sender as TStringGrid;
   if(grid.Col=2) and (grid.Row=14) then begin
      if(OpenDir.Execute) then
         grid.Cells[grid.Col,grid.Row]:=OpenDir.FileName;
   end else if(grid.Col=2) and (grid.Row=1) then begin
      if(grid.Cells[grid.Col,grid.Row]='See Volume Designer...') then
         pcSimuEditor.ActivePage:=tabVolumeDesigner
      else
          if(OpenVolume.Execute) then
             grid.Cells[grid.Col,grid.Row]:=OpenVolume.FileName;
   end else if(grid.Col=2) and (grid.Row>=10) and (grid.Row<=12) then begin
      fmSrc:=TfmSource.Create(Application);
      if(Length(grid.Cells[2,10])>0) then begin
             fmSrc.edSource.Text:=grid.Cells[2,10];
             fmSrc.edSourceEditingDone(fmSrc.edSource);
      end;
      if(fmSrc.ShowModal= mrOK) then begin
             grid.Cells[2,10]:=Trim(fmSrc.edSource.Text);
             grid.Cells[2,11]:='['+fmSrc.SrcParam1.CommaText+']';
             grid.Cells[2,12]:='['+fmSrc.SrcParam2.CommaText+']';
      end;
      fmSrc.Free;
   end;
   edRespinChange(Sender);
end;

procedure TfmMCX.GotoColRow(grid: TStringGrid; Col, Row: Integer);
begin
  GotoCol := Col;
  GotoRow := Row;
  GotoGrid:= grid;
  Timer1.Enabled := True;
end;

procedure TfmMCX.sgMediaEditingDone(Sender: TObject);
var
     grid: TStringGrid;
     val: Extended;
     ss: string;
     rowid, colid: integer;
begin
     if not(Sender is TStringGrid) then exit;
     grid:= Sender as TStringGrid;
     if(Length(grid.Cells[grid.Col,grid.Row])=0) then exit;
     if(not TryStrToFloat(grid.Cells[grid.Col,grid.Row], val)) then
     begin
        ShowMessage('Input is not a number!');
        GotoColRow(grid, grid.Col,grid.Row);
        exit;
     end;
     edRespinChange(Sender);
end;

procedure TfmMCX.shapeAddBoxExecute(Sender: TObject);
begin
  AddShapes('Box',Format('Tag=%d|O=[30,30,30]|Size=[10,10,10]',[tvShapes.Tag+1]));
end;

procedure TfmMCX.shapeAddCylinderExecute(Sender: TObject);
begin
  AddShapes('Cylinder',Format('Tag=%d|C0=[30,30,0]|C1=[30,30,60]|R=5',[tvShapes.Tag+1]));
end;

procedure TfmMCX.AddShapesWindow(shapeid: string; defaultval: TStringList; node: TTreeNode);
var
   fmshape:TfmShapeEditor;
   ss: string;
   jdata: TJSONData;
begin
   if(node = nil) then exit;
   if(defaultval.Count=1) then begin
        ss:=InputBox('Edit Shape',shapeid, defaultval.Strings[0]);
        ss:=Trim(ss);
        if(Pos(',',ss)=0) then
            ss:='{"'+shapeid+'":"'+ss+'"}'
        else
            ss:='{"'+shapeid+'":'+ss+'}';
        jdata:= GetJSON(ss);
        TJSONArray(node.TreeView.Items[0].Data).Add(jdata);
        ShowJSONData(node,jdata,true);
        exit;
   end;

   fmshape:=TfmShapeEditor.Create(Application, defaultval);
   fmshape.Caption:='Add Shape: '+shapeid;
   if(Pos('Layer',shapeid)=2) or (Pos('Slab',shapeid)=2) then
        fmshape.plEditor.Options:=fmshape.plEditor.Options+[goAutoAddRows];
   if(fmshape.ShowModal= mrOK) then begin
        ss:=Trim(fmshape.JSON.DelimitedText);
        if(Pos('[',ss)=1) then
             ss:='{"'+shapeid+'":['+ss+']}'
        else
             ss:='{"'+shapeid+'":{'+ss+'}}';
        jdata:= GetJSON(ss);
        TJSONArray(node.TreeView.Items[0].Data).Add(jdata);
        ShowJSONData(node,jdata,true);
   end;
   fmshape.Free;
end;

procedure TfmMCX.AddShapes(shapeid: string; defaultval: string);
var
    fs: TStringList;
    node: TTreeNode;
begin
  try
    fs:=TStringList.Create;
    fs.StrictDelimiter := true;
    fs.Delimiter:='|';
    fs.DelimitedText:=defaultval;
    //node:=tvShapes.Items.AddChild(tvShapes.Items[0],shapeid);
    AddShapesWindow(shapeid, fs, tvShapes.Items[0]);
    edRespinChange(tvShapes);
  finally
    fs.Free;
  end;
end;

procedure TfmMCX.shapeAddGridExecute(Sender: TObject);
begin
     AddShapes('Grid',Format('Tag=%d|Size=[60,60,60]',[tvShapes.Tag+1]));
end;

procedure TfmMCX.shapeAddNameExecute(Sender: TObject);
begin
   AddShapes('Name','mcxdomain');
end;

procedure TfmMCX.shapeAddOriginExecute(Sender: TObject);
begin
   AddShapes('Origin','[0,0,0]');
end;

procedure TfmMCX.shapeAddSphereExecute(Sender: TObject);
begin
  AddShapes('Sphere',Format('Tag=%d|O=[30,30,30]|R=10',[tvShapes.Tag+1]));
end;

procedure TfmMCX.shapeAddSubgridExecute(Sender: TObject);
begin
  AddShapes('Subgrid',Format('Tag=%d|O=[30,30,30]|Size=[10,10,10]',[tvShapes.Tag+1]));
end;

procedure TfmMCX.shapeAddUpperSpaceExecute(Sender: TObject);
begin
  AddShapes('UpperSpace',Format('Tag=%d|Coef=[1,-1,0,0]|Equ="Ax+By+Cz>D"',[tvShapes.Tag+1]));
end;

procedure TfmMCX.shapeAddXLayersExecute(Sender: TObject);
begin
   AddShapes('XLayers',Format('Layer 1=[1,10,%d]|Layer 2=[11,30,%d]|Layer 3=[31,50,%d]',[tvShapes.Tag+1,tvShapes.Tag+2,tvShapes.Tag+3]));
end;

procedure TfmMCX.shapeAddXSlabsExecute(Sender: TObject);
begin
  AddShapes('XSlabs',Format('Tag=%d|Bound=[1,10]',[tvShapes.Tag+1]));
end;

procedure TfmMCX.shapeAddYLayersExecute(Sender: TObject);
begin
   AddShapes('YLayers',Format('Layer 1=[1,10,%d]|Layer 2=[11,30,%d]|Layer 3=[31,50,%d]',[tvShapes.Tag+1,tvShapes.Tag+2,tvShapes.Tag+3]));
end;

procedure TfmMCX.shapeAddYSlabsExecute(Sender: TObject);
begin
   AddShapes('YSlabs',Format('Tag=%d|Bound=[1,10]',[tvShapes.Tag+1]));
end;

procedure TfmMCX.shapeAddZLayersExecute(Sender: TObject);
begin
  AddShapes('ZLayers',Format('Layer 1=[1,10,%d]|Layer 2=[11,30,%d]|Layer 3=[31,50,%d]',[tvShapes.Tag+1,tvShapes.Tag+2,tvShapes.Tag+3]));
end;

procedure TfmMCX.shapeAddZSlabsExecute(Sender: TObject);
begin
  AddShapes('ZSlabs',Format('Tag=%d|Bound=[1,10]',[tvShapes.Tag+1]));
end;

function TfmMCX.RebuildLayeredObj(rootdata: TJSONData; out maxtag: integer): string;
var
    i,j: integer;
    val: extended;
    row, jobj: TJSONArray;
    root: TJSONObject;
begin
    if(rootdata = nil) then exit;
    root:=TJSONObject(TJSONObject(rootdata).Items[0]);
    jobj:= TJSONArray.Create;
    maxtag:=0;
    try
      for i:=0 to root.Count-1 do begin
        if(Pos('Layer ',root.Names[i])=1) then begin
           row:= TJSONArray.Create;
           for j:=0 to root.Items[i].Count-1 do begin
               val:=TJSONArray(root.Items[i]).Floats[j];
               if j=root.Items[i].Count-1 then
                   maxtag:=max(Round(val),maxtag);
               if(Frac(val)=0) then
                   row.Add(Round(val))
               else
                   row.Add(val);
           end;
           jobj.Add(row);
        end;
      end;
      Result:=jobj.AsJSON;
    finally
      FreeAndNil(jobj);
    end;
end;
// handle shape data without "Shapes" root node;
// root should always be an array
function TfmMCX.UpdateShapeTag(root: TJSONData; doexport: boolean = false): integer;
var
     i, j, maxlayertag, maxtag: integer;
     jobj: TJSONObject;
     ss: string;
begin
     maxtag:=0;
     ss:= root.AsJSON;
     if(root.JSONType <> jtArray) then
        raise Exception.Create('Shape data root node should always be an array');
     for i:=0 to root.Count-1 do begin
       jobj:=TJSONObject(root.Items[i]);
       ss:=jobj.AsJSON;
       if (jobj.Count=1) and (Pos('Layers',jobj.Names[0])=2) then begin
            if(doexport) then begin
                jobj.Objects[jobj.Names[0]]:= TJSONObject(GetJSON(RebuildLayeredObj(jobj,maxlayertag)));
            end else begin
                RebuildLayeredObj(jobj,maxlayertag);
            end;
            maxtag:=Max(maxtag,maxlayertag);
       end;
       if(jobj.Count=1) and (jobj.Items[0].Count>0) then
           jobj:=TJSONObject(jobj.Items[0]);
       ss:=jobj.AsJSON;

       if(jobj.FindPath('Tag') <> nil) then
          maxtag:=Max(maxtag,jobj.Integers['Tag']);
       if (root.JSONType=jtObject) then begin
          if (TJSONObject(root).Names[i]='Grid') and (jobj.FindPath('Size') <> nil) then
              sgConfig.Cells[2,2]:=jobj.Arrays['Size'].AsJSON;
       end else if (root.JSONType=jtArray) then begin
          if (jobj.Count>0) and (TJSONObject(root.Items[i]).Names[0]='Grid') and (jobj.FindPath('Size') <> nil) then
              sgConfig.Cells[2,2]:=jobj.FindPath('Size').AsJSON;
       end;
     end;
     Result:=maxtag;
end;

procedure TfmMCX.shapePrintExecute(Sender: TObject);
var
     jdata: TJSONData;
begin
    if(tvShapes.Selected <> nil) then
       if(tvShapes.Selected=tvShapes.Items[0]) then begin
           AddMultiLineLog(JSONData.FormatJSON);
       end else begin
           if(tvShapes.Selected.Data <> nil) then
               AddMultiLineLog(TJSONData(tvShapes.Selected.Data).FormatJSON);
       end;
end;



procedure TfmMCX.shapeResetExecute(Sender: TObject);
var
  ret:integer;
begin
  ret:=Application.MessageBox('The current shape has not been saved, are you sure you want to clear?',
    'Confirm', MB_YESNOCANCEL);
  if (ret=IDYES) then begin
    LoadJSONShapeTree('[{"Grid":{"Tag":1,"Size":[60,60,60]}}]');
    edRespinChange(tvShapes);
  end;
  if (ret=IDCANCEL) then
       exit;
end;

procedure TfmMCX.shapeDeleteExecute(Sender: TObject);
var
     idx: integer;
     P, D: TJSONData;
     Node: TTreeNode;
     ss: string;
begin
  Node:= tvShapes.Selected;
  if(Node <> nil) then begin
        if(Node.Parent = nil) or (Node.Parent.Data=nil) or (Node.Data=nil) then exit;
        P:=TJSONData(Node.Parent.Data);
        ss:=P.AsJSON;
        If P.JSONType=jtArray then
          TJSONArray(P).Remove(P.Items[Node.Index])
        else If P.JSONType=jtObject then
          TJSONObject(P).Remove(P.Items[Node.Index]);
        ss:=P.AsJSON;
        Node.Delete;
        edRespinChange(tvShapes);
  end;
end;

procedure TfmMCX.Splitter2Moved(Sender: TObject);
begin
end;

procedure TfmMCX.Splitter6CanOffset(Sender: TObject; var NewOffset: Integer;
  var Accept: Boolean);
begin
  grAdvSettings.Height:=grAdvSettings.Height+NewOffset;
  Accept:=true;
end;

procedure TfmMCX.Splitter6CanResize(Sender: TObject; var NewSize: Integer;
  var Accept: Boolean);
begin
    grAdvSettings.Height:=NewSize;
    Accept:=true;
end;

procedure TfmMCX.StaticText2DblClick(Sender: TObject);
begin
    GridToStr(sgMedia);
end;

procedure TfmMCX.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  if(Assigned(GotoGrid)) then begin
      GotoGrid.Col := GotoCol;
      GotoGrid.Row := GotoRow;
      GotoGrid.EditorMode := True;
  end;
end;

procedure TfmMCX.tmAnimationTimer(Sender: TObject);
var
   len: integer;
begin
    if not (Assigned(GotoGBox)) then exit;
    if(tmAnimation.Tag>0) then begin // collapse
         GotoGBox.Height:=GotoGBox.Height-5;
         if(GotoGBox.Height<=self.Canvas.TextHeight('Ag')+btGBExpand.Height+5) then begin
              GotoGBox.Align:=alTop;
              GotoGBox.Height:=self.Canvas.TextHeight('Ag')+btGBExpand.Height+5;
              tmAnimation.Tag:=0;
              tmAnimation.Enabled:=false;
         end;
    end else begin
        GotoGBox.Height:=GotoGBox.Height+5;
        len:=plSetting.Height-GotoGBox.Top;
        if(GotoGBox.Height>=plSetting.Height-GotoGBox.Top) then begin
             GotoGBox.Align:=alClient;
             tmAnimation.Tag:=1;
             tmAnimation.Enabled:=false;
        end;
    end;
end;

procedure TfmMCX.tvShapesDeletion(Sender: TObject; Node: TTreeNode);
begin
end;

procedure TfmMCX.tvShapesEdited(Sender: TObject; Node: TTreeNode; var S: string
  );
var
     val: extended;
     cc: integer;
     ss: string;
begin
     if(Node.Parent= nil) then exit;

     if(Node.ImageIndex=ImageTypeMap[jtNumber]) then begin
         if(not TryStrToFloat(S, val)) then begin
             ShowMessage('The field must be a number');
             S:= Node.Text;
             exit;
         end;
         if (Pos('Layer ',Node.Parent.Text)=0) then begin
              if(TJSONData(Node.Parent.Data).JSONType=jtArray) then begin
                  if(Frac(val)=0) then
                      TJSONArray(Node.Parent.Data).Integers[Node.Index]:=Round(val)
                  else
                      TJSONArray(Node.Parent.Data).Floats[Node.Index]:=val;
              end else if TJSONData(Node.Parent.Data).JSONType=jtNumber then begin
                  if(Frac(val)=0) then
                      TJSONData(Node.Parent.Data).Value:=Round(val)
                  else
                      TJSONData(Node.Parent.Data).Value:=val;
              end;
         end else begin
              if(Frac(val)=0) then
                 TJSONArray(TJSONArray(Node.Parent.Data).Items[Node.Parent.Index]).Integers[Node.Index]:=Round(val)
              else
                 TJSONArray(TJSONArray(Node.Parent.Data).Items[Node.Parent.Index]).Floats[Node.Index]:=val;
         end;
     end else if(Node.ImageIndex=ImageTypeMap[jtString]) then begin
          if(Length(S)=0) then begin
               ShowMessage('Input string can not be empty');
               S:=Node.Text;
               exit;
          end;
          if(Node.Parent <> nil) then begin
              if(TJSONData(Node.Parent.Data).JSONType=jtArray) then begin
                  TJSONArray(Node.Parent.Data).Strings[Node.Index]:=S;
              end else if TJSONData(Node.Parent.Data).JSONType=jtString then begin
                  ss:= TJSONData(Node.Parent.Data).AsJSON;
                  TJSONData(Node.Parent.Data).Value:=S;
              end;
          end;
     end;
     edRespinChange(Sender);
end;

procedure TfmMCX.tvShapesSelectionChanged(Sender: TObject);
begin
    if(tvShapes.Selected <> nil) then  begin
       shapeDelete.Enabled:=tvShapes.Selected.Level=1;
       shapeEdit.Enabled:=tvShapes.Selected.Level=1;
       if(tvShapes.Selected.Count=0) then begin
           tvShapes.Options:=tvShapes.Options-[tvoReadOnly];
       end else begin
           tvShapes.Options:=tvShapes.Options+[tvoReadOnly];
       end;
    end;
end;

function TfmMCX.GetMCXOutput () : string;
var
    Buffer, revbuf, percent: string;
    BytesAvailable: DWord;
    BytesRead:LongInt;
    list: TStringList;
    i, idx, len, total, namepos,hh: integer;
    gpuname, ss: string;
begin
   if true then
    begin
      BytesAvailable := pMCX.Output.NumBytesAvailable;
      BytesRead := 0;
      while BytesAvailable>0 do
      begin
        SetLength(Buffer, BytesAvailable);
        BytesRead := pMCX.OutPut.Read(Buffer[1], BytesAvailable);
        Buffer:=StringReplace(Buffer,#8, '',[rfReplaceAll]);
        if(ckbDebug.Checked[2]) then begin
               revbuf:=ReverseString(Buffer);
               if RegEngine.Exec(revbuf) then begin
                     percent:=ReverseString(RegEngine.Match[0]);
                     if(sscanf(percent,']%d\%', [@total])=1) then begin
                        sbInfo.Panels[1].Text:=Format('%d%%',[total]);
                        sbInfo.Tag:=total;
                        sbInfo.Repaint;
                        Application.ProcessMessages;
                     end;
               end;
        end;
        Result := Result + copy(Buffer,1, BytesRead);
        BytesAvailable := pMCX.Output.NumBytesAvailable;
        Application.ProcessMessages;
      end;
    end;
    if(pMCX.Tag=-1) then begin
        list:=TStringList.Create;
        list.StrictDelimiter := true;
        list.Delimiter:=AnsiChar(#10);
        list.DelimitedText:=Result;
        for i:=0 to list.Count-1 do begin
          ss:= list.Strings[i];
          if(sscanf(ss,'Device %d of %d:%s', [@idx, @total, @gpuname])=3) then
          begin
                 if(idx=1) then
                     edGPUID.Items.Clear;
                 namepos := Pos(gpuname, ss);
                 edGPUID.Items.Add(Trim(copy(ss, namepos, Length(ss)-namepos)));
          end;
        end;
        list.Free;
        if(edGPUID.Items.Count>0) then
            edGPUID.Checked[0]:=true;
    end;
    Sleep(100);
end;

procedure TfmMCX.SaveTasksToIni(fname: string);
var
   inifile: TIniFile;
   i,j: integer;
begin
     DeleteFile(fname);
     inifile:=TIniFile.Create(fname);
     for i:=0 to lvJobs.Items.Count-1 do begin
          for j:=1 to lvJobs.Columns.Count-1 do begin
              inifile.WriteString(lvJobs.Items.Item[i].Caption,
                                  lvJobs.Columns.Items[j].Caption,
                                  lvJobs.Items.Item[i].SubItems.Strings[j-1]);
          end;
     end;
     inifile.UpdateFile;
     inifile.Free;
end;

procedure TfmMCX.LoadTasksFromIni(fname: string);
var
   sessions,vals:TStringList;
   inifile: TIniFile;
   i,j: integer;
   node: TListItem;
begin
     sessions:=TStringList.Create;
     vals:=TStringList.Create;
     inifile:=TIniFile.Create(fname);
     inifile.ReadSections(sessions);
     for i:=0 to sessions.Count-1 do begin
         node:=lvJobs.Items.Add;
         node.Caption:=sessions.Strings[i];
         node.ImageIndex:=14;
         inifile.ReadSectionValues(node.Caption,vals);
         for j:=1 to lvJobs.Columns.Count-1 do
             node.SubItems.Add('');
         for j:=1 to lvJobs.Columns.Count-1 do begin
             node.SubItems.Strings[j-1]:=vals.Values[lvJobs.Columns.Items[j].Caption];
         end;
         if(Length(vals.Values['MCProgram'])>0) then
             node.ImageIndex:=node.ImageIndex+StrToInt(vals.Values['MCProgram']);
     end;
     inifile.Free;
     vals.Free;
     sessions.Free;
     AddLog(Format('Successfully loaded project %s. Please double click on session list to edit.',[fname]));
end;


procedure TfmMCX.VerifyInput;
var
    nthread, nblock: integer;
    radius,nphoton: extended;
    exepath: string;
begin
  try
    if rbUseFile.Checked and (Length(edConfigFile.FileName)=0) then
        raise Exception.Create('Config file must be specified');
    if rbUseFile.Checked and (not FileExists(edConfigFile.FileName)) then
        raise Exception.Create('Config file does not exist, please check the path');
    if ckDoReplay.Checked and (not FileExists(edSeed.Text)) then
        raise Exception.Create('An existing MCH file must be set as the seed when replay is desired');

    try
        nthread:=StrToInt(edThread.Text);
        nphoton:=StrToFloat(edPhoton.Text);
        radius:=StrToFloat(edBubble.Text);
        nblock:=StrToInt(edBlockSize.Text);
    except
        raise Exception.Create('Invalid numbers: check the values for thread (-t), block (-T), photon (-n) and cache radius (-R)');
    end;
    if(nthread<512) then
       AddLog('Warning: using over 20000 threads (-t) can usually give you the best speed');
    if(nphoton>1e9) then
       AddLog('Warning: you can increase respin number (-r) to get more photons');
    if(nblock<0) then
       raise Exception.Create('Thread block number (-T) can not be negative');

    exepath:=SearchForExe(CreateCmdOnly);
    if(exepath='') then
       raise Exception.Create(Format('Can not find %s executable in the search path',[CreateCmdOnly]));

    SaveJSONConfig('');

    UpdateMCXActions(acMCX,'Work','');
  except
    On E : Exception do
      ShowMessage(E.Message);
  end;
end;

function TfmMCX.CreateCmdOnly:string;
var
    cmd: string;
begin
    cmd:=MCProgram[grProgram.ItemIndex];
    Result:=cmd;
end;
procedure TfmMCX.SaveJSONConfig(filename: string);
var
    nthread, nblock,hitmax,seed, i, mediacount: integer;
    bubbleradius,unitinmm,nphoton: extended;
    gpuid, section, key, val, ss: string;
    json, jobj, jmedium, jdet, jforward, joptode : TJSONObject;
    jdets, jmedia, jshape: TJSONArray;
    jsonlist: TStringList;
begin
  try
      nthread:=StrToInt(edThread.Text);
      nphoton:=StrToFloat(edPhoton.Text);
      nblock:=StrToInt(edBlockSize.Text);
      bubbleradius:=StrToFloat(edBubble.Text);
      gpuid:=CheckListToStr(edGPUID);
      unitinmm:=StrToFloat(edUnitInMM.Text);
      hitmax:=StrToInt(edDetectedNum.Text);
      if not (ckDoReplay.Checked) then
          seed:=StrToInt(edSeed.Text);
  except
      raise Exception.Create('Invalid numbers: check the values for thread, block, photon and time gate settings');
  end;

  try
    try
      json:=TJSONObject.Create;

      if(json.Find('Session') = nil) then
          json.Objects['Session']:=TJSONObject.Create;
      jobj:= json.Objects['Session'];
      jobj.Floats['Photons']:=nphoton;
      if not (ckDoReplay.Checked) then
          jobj.Integers['RNGSeed']:=seed;
      //else
      //    jobj.Strings['RNGSeed']:=edSeed.Text;
      jobj.Strings['ID']:=edSession.Text;
      jobj.Integers['DoMismatch']:=Integer(ckReflect.Checked);
      jobj.Integers['DoNormalize']:=Integer(ckNormalize.Checked);
      jobj.Integers['DoPartialPath']:=Integer(ckSaveDetector.Checked);
      jobj.Integers['DoSaveExit']:=Integer(ckSaveExit.Checked);
      jobj.Integers['DoSaveSeed']:=Integer(ckSaveSeed.Checked);
      jobj.Integers['DoSaveRef']:=Integer(ckSaveRef.Checked);
      //jobj.Strings['OutputType']:=edOutputType.Text;

      if(json.Find('Domain') = nil) then
          json.Objects['Domain']:=TJSONObject.Create;
      jobj:= json.Objects['Domain'];
      jobj.Integers['OriginType']:=Integer(ckSrcFrom0.Checked);
      jobj.Floats['LengthUnit']:=unitinmm;

      jmedia:=TJSONArray.Create;
      for i := sgMedia.FixedRows to sgMedia.RowCount - 1 do
      begin
              if (Length(sgMedia.Cells[0,i])=0) then break;
              jmedium:=TJSONObject.Create;
              jmedium.Add('mua',StrToFloat(sgMedia.Cells[0,i]));
              jmedium.Add('mus',StrToFloat(sgMedia.Cells[1,i]));
              jmedium.Add('g',StrToFloat(sgMedia.Cells[2,i]));
              jmedium.Add('n',StrToFloat(sgMedia.Cells[3,i]));
              jmedia.Add(jmedium);
      end;
      if(jmedia.Count>0) then
         jobj.Arrays['Media']:=jmedia
      else
         jmedia.Free;

      jdets:=TJSONArray.Create;
      for i := sgDet.FixedRows to sgDet.RowCount - 1 do
      begin
              if (Length(sgDet.Cells[0,i])=0) then break;
              jdet:=TJSONObject.Create;
              jdet.Arrays['Pos']:=TJSONArray.Create;
              jdet.Arrays['Pos'].Add(StrToFloat(sgDet.Cells[0,i]));
              jdet.Arrays['Pos'].Add(StrToFloat(sgDet.Cells[1,i]));
              jdet.Arrays['Pos'].Add(StrToFloat(sgDet.Cells[2,i]));
              jdet.Add('R',StrToFloat(sgDet.Cells[3,i]));
              jdets.Add(jdet);
      end;
      if(json.Find('Optode') = nil) then
         json.Objects['Optode']:=TJSONObject.Create
      else
         jdets.Free;

      joptode:=json.Objects['Optode'];

      if(ckSaveDetector.Checked) and (jdets.Count=0) then begin
          raise Exception.Create('You ask for saving detected photon data, but no detector is defined');
      end;
      if(jdets.Count>0) then
          joptode.Arrays['Detector']:=jdets;
      joptode.Objects['Source']:=TJSONObject.Create;

      jforward:=TJSONObject.Create;
      for i := sgConfig.FixedRows to sgConfig.RowCount - 1 do
      begin
              if(Length(sgConfig.Cells[0,i])=0) and (i>sgConfig.FixedRows) then break;
              val:=sgConfig.Cells[2,i];
              if(Length(val)=0) and (i>sgConfig.FixedRows) then continue;
              section:= sgConfig.Cells[0,i];
              key:=sgConfig.Cells[1,i];
              if(section = 'Forward') then begin
                  jforward.Floats[key]:=StrToFloat(val);
              end else if(section = 'Session') then begin
                  json.Objects['Session'].Strings[key]:=val;
              end else if(section = 'Domain') then begin
                  if (key='MeshID') then begin
                     json.Objects[section].Strings[key]:=val;
                     continue;
                  end else if(key='InitElem') then begin
                     json.Objects[section].Integers[key]:=StrToInt(val);
                     continue;
                  end;
                  if (key = 'VolumeFile') and ((val='See Volume Designer...') or (Length(val)=0)) then begin
                      if(JSONData.FindPath('Shapes') = nil) then
                          jshape:=TJSONArray(GetJSON(JSONData.AsJSON))
                      else
                          jshape:=TJSONArray(GetJSON(JSONData.FindPath('Shapes').AsJSON));
                      ss:=jshape.AsJSON;
                      tvShapes.Tag:=UpdateShapeTag(jshape,true);
                      json.Arrays['Shapes']:=jshape;
                      if(jmedia.Count<=tvShapes.Tag) then begin
                        raise Exception.Create(Format('%d media labels are expected (including 0), but only %d sets of media proprties are defned.',[tvShapes.Tag+1,jmedia.Count]));
                      end;
                  end else begin
                      if(key = 'VolumeFile') then begin
                          json.Objects['Domain'].Strings[key]:=ExtractRelativepath(ExtractFilePath(filename),ExtractFilePath(val))+DirectorySeparator+ExtractFilename(val)
                      end else
                          json.Objects['Domain'].Objects[key]:=TJSONObject(GetJSON(val));
                  end;
              end else if(section = 'Optode.Source') then begin
                  if (key = 'Type') then begin
                      joptode.Objects['Source'].Strings[key]:=val;
                  end else begin
                      joptode.Objects['Source'].Objects[key]:=TJSONObject(GetJSON(val));
                  end;
              end;
      end;
      json.Objects['Forward']:=jforward;

      AddLog('"-- JSON Input: --"');
      AddMultiLineLog(json.FormatJSON);

      if(Length(filename)>0) then begin
          jsonlist:=TStringList.Create;
          jsonlist.Text:=json.FormatJSON;
          try
              jsonlist.SaveToFile(filename);
          finally
              jsonlist.Free;
          end;
      end;
    except
      on E: Exception do
          ShowMessage( 'Error: '+ #13#10#13#10 + E.Message );
    end;
  finally
    FreeAndNil(json);
  end;
end;

function TfmMCX.CreateWorkFolder : string;
var
    path: string;
begin
    path:=ExtractFileDir(Application.ExeName)
       +DirectorySeparator+'..'+DirectorySeparator+CreateCmdOnly+'sessions'+DirectorySeparator+edSession.Text;
    Result:=path;
    try
      if(not DirectoryExists(path)) then
           if( not ForceDirectories(path) ) then
               raise Exception.Create('Can not create session output folder');
    except
      On E : Exception do
          ShowMessage(E.Message);
    end;
    AddLog(Result);
end;

function TfmMCX.CheckListToStr(list: TCheckListBox) : string;
var
    i: integer;
begin
    Result:='';
     for i:=0 to list.Items.Count-1 do begin
          Result:=Result + IntToStr(Integer(list.Checked[i]));
     end;
end;

function TfmMCX.CreateCmd:string;
var
    nthread, nblock,hitmax,seed, i: integer;
    bubbleradius,unitinmm,nphoton: extended;
    cmd, jsonfile, gpuid, debugflag, rootpath: string;
    shellscript: TStringList;
begin
    if(ckDoRemote.Checked) then
        cmd:=edRemote.Text+' '+ CreateCmdOnly
    else
        cmd:=CreateCmdOnly;
    if(Length(edSession.Text)>0) then
       cmd:=cmd+' --session "'+Trim(edSession.Text)+'" ';
    if rbUseFile.Checked and (Length(edConfigFile.FileName)>0) then
    begin
       cmd:=cmd+' --input "'+Trim(edConfigFile.FileName)+'"';
       rootpath:=ExcludeTrailingPathDelimiter(ExtractFilePath(edConfigFile.FileName));
    end else begin
        jsonfile:=CreateWorkFolder+DirectorySeparator+Trim(edSession.Text)+'.json';
        SaveJSONConfig(jsonfile);
        cmd:=cmd+' --input "'+Trim(jsonfile)+'"';
        rootpath:=ExcludeTrailingPathDelimiter(ExtractFilePath(jsonfile));
    end;
    if(Length(sgConfig.Cells[2,14])>0) then
        rootpath:=sgConfig.Cells[2,14];
    cmd:=cmd+' --root "'+rootpath+'" ';

    try
        nthread:=StrToInt(edThread.Text);
        nphoton:=StrToFloat(edPhoton.Text);
        nblock:=StrToInt(edBlockSize.Text);
        bubbleradius:=StrToFloat(edBubble.Text);
        if(grProgram.ItemIndex <>1) then
            gpuid:=CheckListToStr(edGPUID);
        unitinmm:=StrToFloat(edUnitInMM.Text);
        hitmax:=StrToInt(edDetectedNum.Text);
        if not (ckDoReplay.Checked) then
            seed:=StrToInt(edSeed.Text);
    except
        raise Exception.Create('Invalid numbers: check the values for thread, block, photon and time gate settings');
    end;

    if(grProgram.ItemIndex <>1) then begin
        cmd:=cmd+' --gpu '+gpuid;
        if(ckAutopilot.Checked) then begin
          cmd:=cmd+ ' --autopilot 1';
        end else begin
          cmd:=cmd+Format(' --thread %d --blocksize %d', [nthread,nblock]);
        end;
    end;
    cmd:=cmd+Format(' --photon %.0f --skipradius %f ',[nphoton,bubbleradius]);
    cmd:=cmd+Format(' --normalize %d --save2pt %d --reflect %d --savedet %d --unitinmm %f --saveseed %d',
      [Integer(ckNormalize.Checked),Integer(ckSaveData.Checked),Integer(ckReflect.Checked),
      Integer(ckSaveDetector.Checked),unitinmm,Integer(ckSaveSeed.Checked)]);
    if(Length(edSeed.Text)>0) then
      cmd:=cmd+Format(' --seed ''%s''',[edSeed.Text]);
    if(edReplayDet.Enabled) then
      cmd:=cmd+Format(' --replaydet %d',[edReplayDet.Value]);
    if(grAtomic.ItemIndex=0) then
      if(grProgram.ItemIndex=0) then
         cmd:=cmd+' --skipradius -2';

    if(grProgram.ItemIndex=1) then begin
      if(grAtomic.ItemIndex=1) then begin
         cmd:=cmd+' --atomic 0';
      end;
      cmd:=cmd+Format(' --specular %d --basisorder %d --momentum %d',[Integer(ckSpecular.Checked),edRespin.Value,Integer(ckMomentum.Checked)]);
    end else begin
        if(grAtomic.ItemIndex=0) then
             cmd:=cmd+' --skipradius -2';
        cmd:=cmd+Format(' --array %d --dumpmask %d --repeat %d  --maxdetphoton %d',[grArray.ItemIndex,Integer(ckSaveMask.Checked), edRespin.Value, hitmax]);
        if(grAtomic.ItemIndex=2) then
            cmd:=cmd+ Format(' --kernel "%s%c%s"', [rootpath,DirectorySeparator,'mcx_core.cl'])
    end;

    if(ckSkipVoid.Checked) then
      cmd:=cmd+' --skipvoid 1';
    debugflag:='';
    for i:=0 to ckbDebug.Items.Count-1 do begin
         if(ckbDebug.Checked[i]) then
             debugflag:=debugflag+DebugFlags[i+1];
    end;
    if(Length(debugflag)>0) then
        cmd:=cmd+' --debug '+debugflag;
    if(Length(edMoreParam.Text)>0) then
        cmd:=cmd+' '+edMoreParam.Text;

    if(Length(jsonfile)>0) then begin
         shellscript:=TStringList.Create;
         shellscript.Add('#!/bin/sh');
         shellscript.Add(cmd);
         shellscript.SaveToFile(ChangeFileExt(jsonfile,'.sh'));
         shellscript.SaveToFile(ChangeFileExt(jsonfile,'.bat'));
         shellscript.Free;
    end;
    Result:=cmd;
    AddLog('"-- Command: --"');
    AddLog(cmd);
end;

function TfmMCX.GridToStr(grid:TStringGrid):string;
var
    i: integer;
    json: TStrings;
begin
  json := TStringList.Create;
  json.StrictDelimiter:=true;
  Result:='';
  try
      try
          for i := grid.FixedRows to grid.RowCount - 1 do
          begin
              if (Length(grid.Cells[0,i])=0) and (Length(grid.Cells[2,i])=0) then break;
              json.Add(grid.Rows[i].CommaText);
          end;
      except
          On E : Exception do
              ShowMessage(E.Message);
      end;
      json.Delimiter:='|';
      //json.QuoteChar:=' ';
      Result:=json.DelimitedText;
    finally
        json.Free;
    end;
end;


procedure TfmMCX.StrToGrid(str: string; grid:TStringGrid);
var
    i: integer;
    json: TStrings;
begin
  json := TStringList.Create;
  json.StrictDelimiter:=true;
  json.Delimiter:='|';
  json.DelimitedText:=str;

  try
      try
          if(grid.RowCount < json.Count) then
              grid.RowCount:= json.Count;
          for i := 0 to json.Count-1 do begin
              grid.Rows[i+grid.FixedRows].CommaText:=json.Strings[i];
          end;
      except
          On E : Exception do
              ShowMessage(E.Message);
      end;
    finally
        json.Free;
    end;
end;
procedure TfmMCX.ShowJSONData(AParent : TTreeNode; Data : TJSONData; toplevel: boolean=false);

Var
  N,N2 : TTreeNode;
  I : Integer;
  D : TJSONData;
  C : String;
  S : TStringList;
begin
  N:=nil;
  if Assigned(Data) then begin
    case Data.JSONType of
      jtArray,
      jtObject:
      begin
        if(N =nil) then N:=AParent;
        S:=TstringList.Create;
        try
          for I:=0 to Data.Count-1 do
            if Data.JSONtype=jtArray then
              S.AddObject('_ARRAY_',Data.items[i])
            else
              S.AddObject(TJSONObject(Data).Names[i],Data.items[i]);
          for I:=0 to S.Count-1 do begin
            if(not (S[i] = '_ARRAY_')) then begin
               N2:=AParent.TreeView.Items.AddChild(N,S[i]);
            end else begin
               N2:=N;
            end;
            D:=TJSONData(S.Objects[i]);
            N2.ImageIndex:=ImageTypeMap[D.JSONType];
            N2.SelectedIndex:=ImageTypeMap[D.JSONType];
            N2.Data:=D;
            ShowJSONData(N2,D);
          end
        finally
          S.Free;
        end;
      end;
      jtNull:
        N:=AParent.TreeView.Items.AddChild(AParent,'null');
    else
      N:=AParent.TreeView.Items.AddChild(AParent,Data.AsString);
    end;
    If toplevel=false and Assigned(N) then begin
      N.ImageIndex:=ImageTypeMap[Data.JSONType];
      N.SelectedIndex:=ImageTypeMap[Data.JSONType];
      N.Data:=Data;
    end;
  end;
end;

procedure TfmMCX.PanelToList2(node:TListItem);
var
    ed: TEdit;
    cb: TComboBox;
    ck: TCheckBox;
    cg: TCheckBox;
    se: TSpinEdit;
    gr: TRadioGroup;
    ckb: TCheckListBox;
    gb: TGroupBox;
    sg: TStringGrid;
    i,id,idx: integer;
begin
    if(node=nil) then exit;
    for i:=0 to plSetting.ControlCount-1 do
    begin
      if(plSetting.Controls[i] is TGroupBox) then begin
       gb:= plSetting.Controls[i] as TGroupBox;
       for id:=0 to gb.ControlCount-1 do
        try
        if(gb.Controls[id] is TSpinEdit) then begin
           se:=gb.Controls[id] as TSpinEdit;
           idx:=MapList.IndexOf(se.Hint);
           if(idx>=0) then node.SubItems.Strings[idx]:=IntToStr(se.Value);
           continue;
        end;
        if(gb.Controls[id] is TEdit) then begin
           ed:=gb.Controls[id] as TEdit;
           idx:=MapList.IndexOf(ed.Hint);
           if(idx>=0) then node.SubItems.Strings[idx]:=ed.Text;
           continue;
        end;
        if(gb.Controls[id] is TRadioGroup) then begin
           gr:=gb.Controls[id] as TRadioGroup;
           idx:=MapList.IndexOf(gr.Hint);
           if(idx>=0) then node.SubItems.Strings[idx]:=IntToStr(gr.ItemIndex);
           continue;
        end;
        if(gb.Controls[id] is TComboBox) then begin
           cb:=gb.Controls[id] as TComboBox;
           idx:=MapList.IndexOf(cb.Hint);
           if(idx>=0) then node.SubItems.Strings[idx]:=cb.Text;
           continue;
        end;
        if(gb.Controls[id] is TCheckBox) then begin
           ck:=gb.Controls[id] as TCheckBox;
           idx:=MapList.IndexOf(ck.Hint);
           if(idx>=0) then node.SubItems.Strings[idx]:=IntToStr(Integer(ck.Checked));
           continue;
        end;
        if(gb.Controls[id] is TCheckBox) then begin
           cg:=gb.Controls[id] as TCheckBox;
           idx:=MapList.IndexOf(cg.Hint);
           if(idx>=0) then node.SubItems.Strings[idx]:=IntToStr(Integer(ck.Checked));
           continue;
        end;
        if(gb.Controls[id] is TCheckListBox) then begin
           ckb:=gb.Controls[id] as TCheckListBox;
           idx:=MapList.IndexOf(ckb.Hint);
           if(idx>=0) then node.SubItems.Strings[idx]:=CheckListToStr(ckb);
           continue;
        end;
        except
        end;
      end;
    end;
    for i:=0 to tabInputData.ControlCount-1 do
    begin
        try
          if(tabInputData.Controls[i] is TStringGrid) then begin
             sg:=tabInputData.Controls[i] as TStringGrid;
             idx:=MapList.IndexOf(sg.Hint);
             if(idx>=0) then node.SubItems.Strings[idx]:=GridToStr(sg);
             continue;
          end;
        finally
        end;
    end;
    idx:=MapList.IndexOf(tvShapes.Hint);
    if(idx>=0) then
      if(JSONData.FindPath('Shapes') <> nil) then begin
        tvShapes.Tag:=UpdateShapeTag(JSONData.FindPath('Shapes'));
        node.SubItems.Strings[idx]:=JSONData.FormatJSON(AsJSONFormat);
      end else begin
        tvShapes.Tag:=UpdateShapeTag(JSONData);
        node.SubItems.Strings[idx]:='{"Shapes":'+JSONData.FormatJSON(AsJSONFormat)+'}';
      end;
end;

procedure TfmMCX.ListToPanel2(node:TListItem);
var
    ed: TEdit;
    cb: TComboBox;
    ck: TCheckBox;
    se: TSpinEdit;
    gr: TRadioGroup;
    ckb: TCheckListBox;
    sg: TStringGrid;
    gb: TGroupBox;
    fed:TFileNameEdit;
    i,id,j,idx: integer;
    ss: string;
begin
    if(node=nil) then exit;
    edSession.Text:=node.Caption;

    for i:=0 to plSetting.ControlCount-1 do
    begin
      if(plSetting.Controls[i] is TRadioGroup) then begin
           gr:=plSetting.Controls[i] as TRadioGroup;
           idx:=MapList.IndexOf(gr.Hint);
           if(idx>=0) and (Length(node.SubItems.Strings[idx])>0) then begin
                try
                      gr.ItemIndex:=StrToInt(node.SubItems.Strings[idx]);
                except
                end;
           end;
           continue;
      end else if(plSetting.Controls[i] is TGroupBox) then begin
       gb:= plSetting.Controls[i] as TGroupBox;
       for id:=0 to gb.ControlCount-1 do begin
        if(gb.Controls[id] is TSpinEdit) then begin
           se:=gb.Controls[id] as TSpinEdit;
           idx:=MapList.IndexOf(se.Hint);
           if(idx>=0) then begin
             if(Length(node.SubItems.Strings[idx])>0) then begin
                try
                      se.Value:=StrToInt(node.SubItems.Strings[idx]);
                except
                end;
             end;
           end;
           continue;
        end;
        if(gb.Controls[id] is TEdit) then begin
           ed:=gb.Controls[id] as TEdit;
           idx:=MapList.IndexOf(ed.Hint);
           if(idx>=0) then ed.Text:=node.SubItems.Strings[idx];
           continue;
        end;
        if(gb.Controls[id] is TFileNameEdit) then begin
           fed:=gb.Controls[id] as TFileNameEdit;
           idx:=MapList.IndexOf(fed.Hint);
           if(idx>=0) then fed.Text:=node.SubItems.Strings[idx];
           continue;
        end;
        if(gb.Controls[id] is TRadioGroup) then begin
           gr:=gb.Controls[id] as TRadioGroup;
           idx:=MapList.IndexOf(gr.Hint);
           if(idx>=0) and (Length(node.SubItems.Strings[idx])>0) then begin
                try
                      gr.ItemIndex:=StrToInt(node.SubItems.Strings[idx]);
                except
                end;
           end;
           continue;
        end;
        if(gb.Controls[id] is TComboBox) then begin
           cb:=gb.Controls[id] as TComboBox;
           idx:=MapList.IndexOf(cb.Hint);
           if(idx>=0) then cb.Text:=node.SubItems.Strings[idx];
           continue;
        end;
        if(gb.Controls[id] is TCheckBox) then begin
           ck:=gb.Controls[id] as TCheckBox;
           idx:=MapList.IndexOf(ck.Hint);
           if(idx>=0) then ck.Checked:=(node.SubItems.Strings[idx]='1');
           continue;
        end;
        if(gb.Controls[id] is TCheckListBox) then begin
           ckb:=gb.Controls[id] as TCheckListBox;
           idx:=MapList.IndexOf(ckb.Hint);
           if(idx>=0) then begin
             ss:= node.SubItems.Strings[idx];
             if(ckb.Hint='GPUID') then begin
               ckb.Items.Clear;
               for j:=0 to Length(node.SubItems.Strings[idx])-1 do begin
                   ckb.Items.Add('GPU#'+IntToStr(j+1));
                   if(ss[j+1]='1') then
                       ckb.Checked[j]:=true;
               end;
             end else if(ckb.Hint='DebugFlags') then begin
               ckb.CheckAll(cbUnchecked);
               for j:=0 to Min(ckb.Items.Count, Length(node.SubItems.Strings[idx]))-1 do begin
                   if(ss[j+1]='1') then
                       ckb.Checked[j]:=true;
               end;
             end;
           end;
           continue;
        end;
       end;
      end;
    end;
    for i:=0 to tabInputData.ControlCount-1 do
    begin
        try
          if(tabInputData.Controls[i] is TStringGrid) then begin
             sg:=tabInputData.Controls[i] as TStringGrid;
             idx:=MapList.IndexOf(sg.Hint);
             if(idx>=0) then
                 StrToGrid(node.SubItems.Strings[idx],sg);
             continue;
          end;
        finally
        end;
    end;
    idx:=MapList.IndexOf(tvShapes.Hint);
    if(idx>=0) then
        LoadJSONShapeTree(node.SubItems.Strings[idx]);
end;
initialization
  {$I mcxgui.lrs}
end.


  program ferma7;



uses
  Forms,
  Main in 'Main.pas' {Main_Form},
  SimplRezFerm in 'SimplRezFerm.pas' {SimpleFermResult_Form},
  FermOptResults in 'FermOptResults.pas' {FermOptResults_Form},
  FermaFixNode in 'FermaFixNode.pas' {FermaFixNode_Form},
  FermaPivotTol in 'FermaPivotTol.pas' {FermaPivotTol_Form},
  PlastRegionSize in 'PlastRegionSize.pas' {PlastRegionSizeForm},
  plast_rez in 'plast_rez.pas' {Plast_Rez_Form},
  Plast_M in 'Plast_M.pas' {Plast_Form},
  Tok_M in 'tok_M.pas' {tok_Form},
  Ferm_Dat in 'Ferm_Dat.pas',
  FermaForceNode in 'FermaForceNode.pas' {FermaForceNode_Form},
  PlastNewMat in 'PlastNewMat.pas' {PlastNewMatForm},
  PlastOptParam in 'PlastOptParam.pas' {PlastOptParam_Form},
  FermaNewMat in 'FermaNewMat.pas' {FermaNewMatForm},
  DeFormFerma in 'DeFormFerma.pas' {DeForm_Form},
  Plast_FD in 'Plast_FD.pas' {Plast_FD_Form},
  Splash in 'Splash.pas' {Splash_Form},
  Visio in 'Visio.pas' {Visio_Form},
  Fix_node in 'Fix_node.pas' {FixNode_Form},
  ForcNode in 'ForcNode.pas' {ForceNode_Form},
  TOK_Rez in 'TOK_Rez.pas' {TOK_Rez_Form},
  TokZad in 'TokZad.pas' {TokZad_Form},
  tokFix_node in 'tokFix_node.pas' {tokFixNode_Form},
  tokRegionSize in 'TokRegionSize.pas' {tokRegionSizeForm},
  Ferma_M in 'Ferma_M.pas' {Ferma_Form},
  Ferma_FD in 'Ferma_FD.pas' {Ferma_FD_Form},
  NewNode in 'NewNode.pas' {FermaNewNode_Form},
  FermaNewPivot in 'FermaNewPivot.pas' {FermaNewPivot_Form},
  FermaRegionSize in 'FermaRegionSize.pas' {FermaRegionSizeForm},
  tokForceNode in 'tokForceNode.pas' {tokForceNode_Form},
  CoordNode in 'CoordNode.pas' {CoordNode_Form},
  tok_FD in 'tok_FD.pas' {tok_FD_Form},
  TokNewMat in 'TokNewMat.pas' {tokNewMatForm},
  NewCut in 'NewCut.pas' {New_Cut_Form},
  AddZak in 'AddZak.pas' {AddZak_Form},
  AddForce in 'AddForce.pas' {AddForce_Form},
  tokAddZak in 'tokAddZak.pas' {tokAddZak_Form},
  tokAddNagr in 'tokAddNagr.pas' {tokAddNagr_Form},
  About2 in 'About2.pas' {About2_Form},
  numberST in 'numberST.pas' {Form1},
  NumberNode in 'NumberNode.pas' {Form2},
  VC1Form1 in 'VC1Form1.pas' {VC1Form},
  RezVC1 in 'RezVC1.pas' {FermaRezVC1},
  FermOptParam in 'FermOptParam.pas' {FermOptParam_Form},
  FermOptNode in 'FermOptNode.pas' {Ferm_opt_node},
  FermOptNode_Uzel in 'FermOptNode_Uzel.pas' {Form4},
  visio_pb in 'visio_pb.pas' {vpb},
  FermOptMassaRez in 'FermOptMassaRez.pas' {FermOptMassaRez_form},
  New_FermOptResults in 'New_FermOptResults.pas' {NewFermOptResults_Form},
  NewOptParam in 'NewOptParam.pas' {NewFermOptParam_form},
  FilesList in 'FilesList.pas' {FilesList_Form},
  AddUserInfo in 'AddUserInfo.pas' {AddUserInfo_form},
  ModuleExecute in 'ModuleExecute.pas' {ModuleExecute_Form},
  Ferma_M_Anim in 'Ferma_M_Anim.pas' {Form3},
  Buffer in 'Buffer.pas',
  FermOptMassa in 'FermOptMassa.pas' {Ferm_opt_massa},
  About in 'About.pas' {About_Form};

//,
  //SelectMetod in 'SelectMetod.pas' {Ferma_SelectMetod};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Ферма';
  Application.HelpFile := 'Ferma.hlp';
  Application.CreateForm(TMain_Form, Main_Form);
  Application.CreateForm(TFilesList_Form, FilesList_Form);
  Application.CreateForm(TAddUserInfo_form, AddUserInfo_form);
  Application.CreateForm(TSimpleFermResult_Form, SimpleFermResult_Form);
  Application.CreateForm(TFermOptResults_Form, FermOptResults_Form);
  Application.CreateForm(TFermaFixNode_Form, FermaFixNode_Form);
  Application.CreateForm(TFermaPivotTol_Form, FermaPivotTol_Form);
  Application.CreateForm(TPlastRegionSizeForm, PlastRegionSizeForm);
  Application.CreateForm(TPlast_Rez_Form, Plast_Rez_Form);
  Application.CreateForm(TFermaForceNode_Form, FermaForceNode_Form);
  Application.CreateForm(TPlastNewMatForm, PlastNewMatForm);
  Application.CreateForm(TPlastOptParam_Form, PlastOptParam_Form);
  Application.CreateForm(TFermaNewMatForm, FermaNewMatForm);
  Application.CreateForm(TDeForm_Form, DeForm_Form);
  Application.CreateForm(TPlast_FD_Form, Plast_FD_Form);
  Application.CreateForm(TVisio_Form, Visio_Form);
  Application.CreateForm(TFixNode_Form, FixNode_Form);
  Application.CreateForm(TForceNode_Form, ForceNode_Form);
  Application.CreateForm(TTOK_Rez_Form, TOK_Rez_Form);
  Application.CreateForm(TTokZad_Form, TokZad_Form);
  Application.CreateForm(TtokFixNode_Form, tokFixNode_Form);
  Application.CreateForm(TtokRegionSizeForm, tokRegionSizeForm);
  Application.CreateForm(TFerma_FD_Form, Ferma_FD_Form);
  Application.CreateForm(TFermaNewNode_Form, FermaNewNode_Form);
  Application.CreateForm(TFermaNewPivot_Form, FermaNewPivot_Form);
  Application.CreateForm(TFermaRegionSizeForm, FermaRegionSizeForm);
  Application.CreateForm(TtokForceNode_Form, tokForceNode_Form);
  Application.CreateForm(TCoordNode_Form, CoordNode_Form);
  Application.CreateForm(Ttok_FD_Form, tok_FD_Form);
  Application.CreateForm(TtokNewMatForm, tokNewMatForm);
  Application.CreateForm(TNew_Cut_Form, New_Cut_Form);
  Application.CreateForm(TAddZak_Form, AddZak_Form);
  Application.CreateForm(TAddForce_Form, AddForce_Form);
  Application.CreateForm(TtokAddZak_Form, tokAddZak_Form);
  Application.CreateForm(TtokAddNagr_Form, tokAddNagr_Form);
  Application.CreateForm(TAbout2_Form, About2_Form);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TVC1Form, VC1Form);
  Application.CreateForm(TFermaRezVC1, FermaRezVC1);
  Application.CreateForm(TFermOptParam_Form, FermOptParam_Form);
  Application.CreateForm(TFerm_opt_node, Ferm_opt_node);
  Application.CreateForm(Tvpb, vpb);
  Application.CreateForm(TFermOptMassaRez_form, FermOptMassaRez_form);
  Application.CreateForm(TNewFermOptResults_Form, NewFermOptResults_Form);
  Application.CreateForm(TNewFermOptParam_form, NewFermOptParam_form);
  Application.CreateForm(TModuleExecute_Form, ModuleExecute_Form);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TFerm_opt_massa, Ferm_opt_massa);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TAbout_Form, About_Form);
  Application.Run;
 end.

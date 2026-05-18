MODULE A042_DataGlobal_Ctrl
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
    ! HIB C51 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A042 RRC - RAPID Robot Communication
    !
    ! FUNCTION    :  Includ all Global Data's for Project
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2022.01.20
    !
    ! Copyright   :  ETH Zurich (CH) 2022
    !
    !***********************************************************************************
    !
    !************************************************
    ! Declaration :     bool
    !************************************************
    !
    PERS bool b_A042_Run:=TRUE;
    PERS bool b_A042_CtrlWaitForJob:=TRUE;
    PERS bool b_A042_CtrlInUse:=FALSE;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    PERS num n_A042_AccRamp:=33;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    PERS string st_A042_JobForCtrl:=" ";

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    PERS speeddata v_A042_Max:=[400,100,400,10];
    PERS speeddata v_A042_Med:=[250,50,250,10];
    PERS speeddata v_A042_Min:=[50,25,250,10];

    !************************************************
    ! Declaration :     speedlimdata
    !************************************************
    !
    PERS speedlimdata slim_A042_Ctrl:=[245,31,31,31,46,46,46,0,0,0,0,0,0];

    !************************************************
    ! Declaration :     syncident
    !************************************************
    !
    !
    VAR syncident id_A042_MainSta;
    VAR syncident id_A042_MainEnd;

    VAR syncident id_A042_InitTaskSta;
    VAR syncident id_A042_InitTaskEnd;
    !
    VAR syncident id_A042_InitVarSta;
    VAR syncident id_A042_InitVarEnd;
    !
    VAR syncident id_A042_InitSigSta;
    VAR syncident id_A042_InitSigEnd;
    !
    VAR syncident id_A042_InitSpeedSta;
    VAR syncident id_A042_InitSpeedSet;
    VAR syncident id_A042_InitSpeedEnd;

ENDMODULE
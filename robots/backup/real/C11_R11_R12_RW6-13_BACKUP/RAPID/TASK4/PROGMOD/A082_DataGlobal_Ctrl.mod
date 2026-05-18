MODULE A082_DataGlobal_Ctrl
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
    ! HIB C51 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A082 Latthammer
    !
    ! FUNCTION    :  Includ all Global Data's for Project
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2022.10.13
    !
    ! Copyright   :  ETH Zurich (CH) 2022
    !
    !***********************************************************************************
    !
    !************************************************
    ! Declaration :     bool
    !************************************************
    !
    PERS bool b_A082_Run:=TRUE;
    PERS bool b_A082_CtrlWaitForJob:=TRUE;
    PERS bool b_A082_CtrlInUse:=FALSE;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    PERS num n_A082_AccRamp:=33;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    PERS string st_A082_JobForCtrl:=" ";

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    PERS speeddata v_A082_Max:=[400,100,400,10];
    PERS speeddata v_A082_Med:=[250,50,250,10];
    PERS speeddata v_A082_Min:=[50,25,250,10];

    !************************************************
    ! Declaration :     speedlimdata
    !************************************************
    !
    PERS speedlimdata slim_A082_Ctrl:=[245,31,31,31,46,46,46,0,0,0,0,0,0];

    !************************************************
    ! Declaration :     syncident
    !************************************************
    !
    !
    VAR syncident id_A082_MainSta;
    VAR syncident id_A082_MainEnd;

    VAR syncident id_A082_InitTaskSta;
    VAR syncident id_A082_InitTaskEnd;
    !
    VAR syncident id_A082_InitVarSta;
    VAR syncident id_A082_InitVarEnd;
    !
    VAR syncident id_A082_InitSigSta;
    VAR syncident id_A082_InitSigEnd;
    !
    VAR syncident id_A082_InitSpeedSta;
    VAR syncident id_A082_InitSpeedSet;
    VAR syncident id_A082_InitSpeedEnd;

ENDMODULE
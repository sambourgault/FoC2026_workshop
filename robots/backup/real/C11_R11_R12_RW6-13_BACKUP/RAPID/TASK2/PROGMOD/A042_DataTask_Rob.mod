MODULE A042_DataTask_Rob
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
    ! FUNCTION    :  Includ all Task Data's for Project
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

    !************************************************
    ! Declaration :     bool
    !************************************************
    !
    TASK PERS bool b_A042_MyBool:=FALSE;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    TASK PERS num n_A042_MyNum:=0;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    TASK PERS string st_A042_MyString:="";

    !************************************************
    ! Declaration :     tooldata
    !************************************************
    !
    TASK PERS tooldata t_A042_MyTool:=[TRUE,[[0,0,0],[1,0,0,0]],[0,[0,0,0],[1,0,0,0],0,0,0]];

    !************************************************
    ! Declaration :     wobjdata
    !************************************************
    !
    TASK PERS wobjdata ob_A042_MyWobjdata:=[FALSE,TRUE,"",[[0,0,0],[1,0,0,0]],[[0,0,0],[1,0,0,0]]];

    !************************************************
    ! Declaration :     jointtarget
    !************************************************
    !
    TASK PERS jointtarget jp_A042_MyJointtarget:=[[0,0,0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];

    !************************************************
    ! Declaration :     robtarget
    !************************************************
    !
    TASK PERS robtarget p_A042_MyRobtarget:=[[0,0,0],[1,0,0,0],[0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    TASK PERS speeddata v_A042_MySpeed:=[0,0,0,0];
ENDMODULE
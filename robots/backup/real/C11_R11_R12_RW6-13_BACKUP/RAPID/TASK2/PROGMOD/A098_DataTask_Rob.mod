MODULE A098_DataTask_Rob
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
    ! HIB C51 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A098 Fall_Demo_2025
    !
    ! FUNCTION    :  Includ all Task Data's for Project
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2025.10.31
    !
    ! Copyright   :  ETH Zurich (CH) 2022
    !
    !***********************************************************************************

    !************************************************
    ! Declaration :     bool
    !************************************************
    !
    TASK PERS bool b_A098_MyBool:=FALSE;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    TASK PERS num n_A098_MyNum:=0;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    TASK PERS string st_A098_MyString:="";

    !************************************************
    ! Declaration :     tooldata
    !************************************************
    !
    TASK PERS tooldata t_A098_MyTool:=[TRUE,[[0,0,0],[1,0,0,0]],[0,[0,0,0],[1,0,0,0],0,0,0]];

    !************************************************
    ! Declaration :     wobjdata
    !************************************************
    !
    TASK PERS wobjdata ob_A098_MyWobjdata:=[FALSE,TRUE,"",[[0,0,0],[1,0,0,0]],[[0,0,0],[1,0,0,0]]];

    !************************************************
    ! Declaration :     jointtarget
    !************************************************
    !
    TASK PERS jointtarget jp_A098_MyJointtarget:=[[0,0,0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];

    !************************************************
    ! Declaration :     robtarget
    !************************************************
    !
    TASK PERS robtarget p_A098_MyRobtarget:=[[0,0,0],[1,0,0,0],[0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    TASK PERS speeddata v_A098_MySpeed:=[0,0,0,0];
ENDMODULE
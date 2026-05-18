MODULE RFL_Tools_12
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
    ! HIB C 51 / Stefano-Franscini-Platz 1 
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A011_RFL
    !
    ! FUNCTION    :  Includ all Tool Routines
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2017.01.17 Draft
    !
    ! Copyright   :  ETH Zurich (CH) 2017
    !
    !***********************************************************************************
    
    !************************************************
    ! Declaration :     tooldata
    !************************************************
    !
	TASK PERS tooldata tTo1TeachTip:=[TRUE,[[0,0,250],[1,0,0,0]],[1,[0,0,1],[1,0,0,0],0,0,0]];
	TASK PERS tooldata tTo2Vacuum:=[TRUE,[[0,0,224.2],[1,0,0,0]],[1,[0,0,1],[1,0,0,0],0,0,0]];
    TASK PERS tooldata tTo2VacuumSpez:=[TRUE,[[0,0,224.2],[0,0.707107,0.707107,0]],[1,[0,0,1],[1,0,0,0],0,0,0]];

    !************************************************
    ! Declaration :     signaldo
    !************************************************
    !
    VAR signaldo doTo2VacuumOn;

    !************************************************
    ! Function    :     Initalisation Tool 2 Vacuumgripper
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.02.16
    ! **************** ETH Zurich *******************
    !
    PROC rIni_To2Vacuum()
        !
        AliasIO doTc12Valve1A,doTo2VacuumOn;

    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Tool 2 Vacuum on
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.02.16
    ! **************** ETH Zurich *******************
    !
    PROC rTo2VacuumOn()
        !
        ! Vacuum on
        SetDo doTo2VacuumOn,1;
        !
        ! Short wating time
        WaitTime 0.5;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Tool 2 Vacuum off
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.02.16
    ! **************** ETH Zurich *******************
    !
    PROC rTo2VacuumOff()
        !
        ! Vacuum off
        SetDo doTo2VacuumOn,0;
        !
        ! Short wating time
        WaitTime 0.5;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Reset Tool Vacuum
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.02.16
    ! **************** ETH Zurich *******************
    !
    PROC rRes_To2Vacuum()
        !
        ! Vacuum off
        rTo2VacuumOff;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC


ENDMODULE
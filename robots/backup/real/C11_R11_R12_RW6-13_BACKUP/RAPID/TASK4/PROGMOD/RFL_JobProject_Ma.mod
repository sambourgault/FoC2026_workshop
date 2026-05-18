MODULE RFL_JobProject_Ma
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A011_RFL
    !
    ! FUNCTION    :  Job Routines for Project 
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2017.07.06 Draft
    !
    ! Copyright   :  ETH Zurich (CH) 2017
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Main for Project A009
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.08.11
    ! **************** ETH Zurich *******************
    !
    PROC rMainA009()
        !
        WaitSyncTask idMainA009Sta,tlAll;
        !
        ! Temp Msg for Operator
        TPWrite "Master in rMainA009";
        !
        ! Main Code for Master from Project A009
        ! Free to define form Project user
        ! 
        WaitSyncTask idMainA009End,tlAll;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Main for Project A011
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.12.19
    ! **************** ETH Zurich *******************
    !
    PROC rMainA011()
        !
        WaitSyncTask idMainA011Sta,tlAll;
        !
        ! Temp Msg for Operator
        TPWrite "Master in rMainA011";
        !
        ! Main Code for Master from Project A019
        ! Free to define form Project user
        ! 
        WaitSyncTask idMainA011End,tlAll;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Main for Project A019
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.12.19
    ! **************** ETH Zurich *******************
    !
    !* PROC rMainA019()
    !*      !
    !*      WaitSyncTask idMainA019Sta,tlAll;
    !*      !
    !*      ! Temp Msg for Operator
    !*      TPWrite "Master in rMainA019";
    !*      !
    !*      ! Main Code for Master from Project A019
    !*      ! Free to define form Project user
    !*      ! 
    !*      ! 
    !*      WaitSyncTask idMainA019End,tlAll;
    !*      !
    !* ERROR
    !*      ! Placeholder for Error Code...
    !* ENDPROC

    !************************************************
    ! Function    :     Main for Project A029
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.05.15
    ! **************** ETH Zurich *******************
    !
    PROC rMainA029()
        !
        WaitSyncTask idMainA029Sta,tlAll;
        !
        ! Temp Msg for Operator
        TPWrite "Master in rMainA029";
        !
        ! Main Code for Master from Project A029
        ! Free to define form Project user
        ! 
        WaitSyncTask idMainA029End,tlAll;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE
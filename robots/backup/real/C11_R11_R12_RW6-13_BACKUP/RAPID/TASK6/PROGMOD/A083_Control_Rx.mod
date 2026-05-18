MODULE A083_Control_Rx
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A083 Augmented-Timber
    !
    ! FUNCTION    :  Control modul and project main
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
    ! Function    :     Project main 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.20
    !***************** ETH Zurich *******************
    !
    PROC r_A083_Main()
        !
        ! Synchronize with controller 
        WaitSyncTask id_A083_MainSta,tl_RFL_All;
        !
        ! Message to user
        TPWrite "A083 Main";
        !
        ! Initialize task for Project
        r_A083_InitTask;
        !
        ! Execution loop
        WHILE b_A083_Run=TRUE DO
            !
            ! Use RRC
            r_RRC_Main;
        ENDWHILE
        !
        ! Message to user 
        TPWrite "A083 End";
        !
        ! Synchronize with controller 
        WaitSyncTask id_A083_MainEnd,tl_RFL_All;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize task for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.20
    ! **************** ETH Zurich *******************
    !
    PROC r_A083_InitTask()
        ! 
        WaitSyncTask id_A083_InitTaskSta,tl_RFL_All;
        !
        ! Initialize speed
        r_A083_InitSpeed;
        !
        ! Initialize signals
        r_A083_InitSig;
        !
        ! Initalize variables
        r_A083_InitVar;
        !
        WaitSyncTask id_A083_InitTaskEnd,tl_RFL_All;
        ! 
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize signals for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.20
    ! **************** ETH Zurich *******************
    !
    PROC r_A083_InitSig()
        !
        WaitSyncTask id_A083_InitSigSta,tl_RFL_All;
        !
        !
        WaitSyncTask id_A083_InitSigEnd,tl_RFL_All;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize variables for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.20
    !***************** ETH Zurich *******************
    !
    PROC r_A083_InitVar()
        ! 
        WaitSyncTask id_A083_InitVarSta,tl_RFL_All;
        ! 
        ! Placeholder
        !
        WaitSyncTask id_A083_InitVarEnd,tl_RFL_All;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize speed settings for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.20
    !***************** ETH Zurich *******************
    !
    PROC r_A083_InitSpeed()
        !
        WaitSyncTask id_A083_InitSpeedSta,tl_RFL_All;
        !
        !
        WaitSyncTask id_A083_InitSpeedSet,tl_RFL_All;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE
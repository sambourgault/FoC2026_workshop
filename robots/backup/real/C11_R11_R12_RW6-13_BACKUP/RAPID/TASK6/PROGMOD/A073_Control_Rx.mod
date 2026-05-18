MODULE A073_Control_Rx
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A073 Impact-Printing
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
    PROC r_A073_Main()
        !
        ! Synchronize with controller 
        WaitSyncTask id_A073_MainSta,tl_RFL_All;
        !
        ! Message to user
        TPWrite "A073 Main";
        !
        ! Initialize task for Project
        r_A073_InitTask;
        !
        ! Execution loop
        WHILE b_A073_Run=TRUE DO
            !
            ! Use RRC
            r_RRC_Main;
        ENDWHILE
        !
        ! Message to user 
        TPWrite "A073 End";
        !
        ! Synchronize with controller 
        WaitSyncTask id_A073_MainEnd,tl_RFL_All;
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
    PROC r_A073_InitTask()
        ! 
        WaitSyncTask id_A073_InitTaskSta,tl_RFL_All;
        !
        ! Initialize speed
        r_A073_InitSpeed;
        !
        ! Initialize signals
        r_A073_InitSig;
        !
        ! Initalize variables
        r_A073_InitVar;
        !
        WaitSyncTask id_A073_InitTaskEnd,tl_RFL_All;
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
    PROC r_A073_InitSig()
        !
        WaitSyncTask id_A073_InitSigSta,tl_RFL_All;
        !
        !
        WaitSyncTask id_A073_InitSigEnd,tl_RFL_All;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize variables for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.20
    !***************** ETH Zurich *******************
    !
    PROC r_A073_InitVar()
        ! 
        WaitSyncTask id_A073_InitVarSta,tl_RFL_All;
        ! 
        ! Placeholder
        !
        WaitSyncTask id_A073_InitVarEnd,tl_RFL_All;
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
    PROC r_A073_InitSpeed()
        !
        WaitSyncTask id_A073_InitSpeedSta,tl_RFL_All;
        !
        !
        WaitSyncTask id_A073_InitSpeedSet,tl_RFL_All;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE
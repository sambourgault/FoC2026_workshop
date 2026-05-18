MODULE A042_Control_Tx
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A042 RRC - RAPID Robot Communication
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
    PROC r_A042_Main()
        !
        ! Synchronize with controller 
        WaitSyncTask id_A042_MainSta,tl_RFL_All;
        !
        ! Message to user
        TPWrite "A042 Main";
        !
        ! Initialize task for Project
        r_A042_InitTask;
        !
        ! Execution loop
        WHILE b_A042_Run=TRUE DO
            !
            ! Use RRC
            r_RRC_Main;
        ENDWHILE
        !
        ! Message to user 
        TPWrite "A042 End";
        !
        ! Synchronize with controller 
        WaitSyncTask id_A042_MainEnd,tl_RFL_All;
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
    PROC r_A042_InitTask()
        ! 
        WaitSyncTask id_A042_InitTaskSta,tl_RFL_All;
        !
        ! Initialize speed
        r_A042_InitSpeed;
        !
        ! Initialize signals
        r_A042_InitSig;
        !
        ! Initalize variables
        r_A042_InitVar;
        !
        WaitSyncTask id_A042_InitTaskEnd,tl_RFL_All;
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
    PROC r_A042_InitSig()
        !
        WaitSyncTask id_A042_InitSigSta,tl_RFL_All;
        !
        !
        WaitSyncTask id_A042_InitSigEnd,tl_RFL_All;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize variables for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.20
    !***************** ETH Zurich *******************
    !
    PROC r_A042_InitVar()
        ! 
        WaitSyncTask id_A042_InitVarSta,tl_RFL_All;
        ! 
        ! Placeholder
        !
        WaitSyncTask id_A042_InitVarEnd,tl_RFL_All;
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
    PROC r_A042_InitSpeed()
        !
        WaitSyncTask id_A042_InitSpeedSta,tl_RFL_All;
        !
        !
        WaitSyncTask id_A042_InitSpeedSet,tl_RFL_All;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE
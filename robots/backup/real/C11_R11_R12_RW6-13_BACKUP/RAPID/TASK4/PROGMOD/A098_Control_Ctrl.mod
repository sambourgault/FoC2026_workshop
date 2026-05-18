MODULE A098_Control_Ctrl
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A098 Fall_Demo_2025
    !
    ! FUNCTION    :  Control modul and project main
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
    ! Function    :     Project main 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2025.10.31
    !***************** ETH Zurich *******************
    !
    PROC r_A098_Main()
        !
        ! Synchronize with controller 
        WaitSyncTask id_A098_MainSta,tl_RFL_All;
        !
        ! Message to user
        TPWrite "A098 Main";
        !
        ! Initialize task for Project
        r_A098_InitTask;
        !
        ! Execution loop
        WHILE b_A098_Run=TRUE DO
            !
            ! Use RRC
            r_RRC_Main;
        ENDWHILE
        !
        ! Message to user 
        TPWrite "A098 End";
        !
        ! Synchronize with controller 
        WaitSyncTask id_A098_MainEnd,tl_RFL_All;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize task for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2025.10.31
    ! **************** ETH Zurich *******************
    !
    PROC r_A098_InitTask()
        ! 
        WaitSyncTask id_A098_InitTaskSta,tl_RFL_All;
        !
        ! Initialize speed
        r_A098_InitSpeed;
        !
        ! Initialize signals
        r_A098_InitSig;
        !
        ! Initalize variables
        r_A098_InitVar;
        !
        WaitSyncTask id_A098_InitTaskEnd,tl_RFL_All;
        ! 
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize signals for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2025.10.31
    ! **************** ETH Zurich *******************
    !
    PROC r_A098_InitSig()
        !
        WaitSyncTask id_A098_InitSigSta,tl_RFL_All;
        !
        !
        WaitSyncTask id_A098_InitSigEnd,tl_RFL_All;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize variables for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2025.10.31
    !***************** ETH Zurich *******************
    !
    PROC r_A098_InitVar()
        ! 
        WaitSyncTask id_A098_InitVarSta,tl_RFL_All;
        ! 
        ! Placeholder
        !
        WaitSyncTask id_A098_InitVarEnd,tl_RFL_All;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize speed settings for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2025.10.31
    !***************** ETH Zurich *******************
    !
    PROC r_A098_InitSpeed()
        !
        WaitSyncTask id_A098_InitSpeedSta,tl_RFL_All;
        !
        !
        WaitSyncTask id_A098_InitSpeedSet,tl_RFL_All;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE
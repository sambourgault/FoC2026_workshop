MODULE A082_Control_Rob
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A082 Latthammer
    !
    ! FUNCTION    :  Control modul and project main
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

    !************************************************
    ! Function    :     Main function (start project) 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2019.11.29
    !***************** ETH Zurich *******************
    !
    PROC r_A082_Main()
        !
        ! Synchronize with controller 
        WaitSyncTask id_A082_MainSta,tl_RFL_All;
        !
        ! Message to user
        TPWrite "A082 Main";
        !
        ! Initialize task for Project
        r_A082_InitTask;
        !
        ! Execution loop
        WHILE b_A082_Run=TRUE DO
            !
            ! Add here your code..
            !* r_A082_LoadIdentifcation;
            !* r_A082_CollisionTest;
            !r_A082_Test;
            r_A082_NialShow;
            !
        ENDWHILE
        !
        ! Message to user 
        TPWrite "A082 End";
        !
        ! Synchronize with controller 
        WaitSyncTask id_A082_MainEnd,tl_RFL_All;
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
    PROC r_A082_InitTask()
        ! 
        WaitSyncTask id_A082_InitTaskSta,tl_RFL_All;
        !
        ! Initialize speed
        r_A082_InitSpeed;
        !
        ! Initialize signals
        r_A082_InitSig;
        !
        ! Initalize variables
        r_A082_InitVar;
        !
        WaitSyncTask id_A082_InitTaskEnd,tl_RFL_All;
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
    PROC r_A082_InitSig()
        !
        WaitSyncTask id_A082_InitSigSta,tl_RFL_All;
        !
        !
        WaitSyncTask id_A082_InitSigEnd,tl_RFL_All;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize variables for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.20
    !***************** ETH Zurich *******************
    !
    PROC r_A082_InitVar()
        ! 
        WaitSyncTask id_A082_InitVarSta,tl_RFL_All;
        ! 
        ! Placeholder
        !
        WaitSyncTask id_A082_InitVarEnd,tl_RFL_All;
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
    PROC r_A082_InitSpeed()
        !
        WaitSyncTask id_A082_InitSpeedSta,tl_RFL_All;
        !
        ! Set speed limits
        r_RFL_SetSpeedLimit slim_A082_Ctrl;
        !
        ! Safety time
        WaitTime\InPos,1.0;
        !
        WaitSyncTask id_A082_InitSpeedSet,tl_RFL_All;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

ENDMODULE
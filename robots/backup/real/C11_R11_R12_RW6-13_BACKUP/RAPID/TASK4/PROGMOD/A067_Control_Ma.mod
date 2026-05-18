MODULE A067_Control_Ma
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A067 Integral Timber Joints
    !
    ! FUNCTION    :  Main and Control Modul 
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2019.11.29
    !
    ! Copyright   :  ETH Zurich (CH) 2019
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Main function (start project) 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2019.11.29
    !***************** ETH Zurich *******************
    !
    PROC r_A067_Main()
        !
        ! Synchronize with master 
        WaitSyncTask id_A067_MainSta,tl_RFL_All;
        !
        ! Temp Msg for Operator
        TPWrite "A067 Main";
        !
        ! Initialize cell for Project
        r_A067_InitTask;
        !* r_A042_InitCell;
        !
        ! Production loop
        WHILE b_A067_Run=TRUE DO
            !
            ! Use RRC
            r_RRC_Main;
        ENDWHILE
        !
        ! Message for Operator
        TPWrite st_RFL_Taskname+" in A067 End";
        !
        ! Synchronize with master 
        WaitSyncTask id_A067_MainEnd,tl_RFL_All;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize cell for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2019.11.29
    ! **************** ETH Zurich *******************
    !
    PROC r_A067_InitTask()
        ! 
        WaitSyncTask id_A067_InitTaskSta,tl_RFL_All;
        !
        ! Speed
        r_A067_InitSpeed;
        !
        ! Signals
        r_A067_InitSig;
        !
        ! Variables
        r_A067_InitVar;
        !
        WaitSyncTask id_A067_InitTaskEnd,tl_RFL_All;
        ! 
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize Signals for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2019.11.29
    ! **************** ETH Zurich *******************
    !
    PROC r_A067_InitSig()
        !
        WaitSyncTask id_A067_InitSigSta,tl_RFL_All;
        !
        !
        WaitSyncTask id_A067_InitSigEnd,tl_RFL_All;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize variables for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2019.11.29
    !***************** ETH Zurich *******************
    !
    PROC r_A067_InitVar()
        ! 
        WaitSyncTask id_A067_InitVarSta,tl_RFL_All;
        ! 
        ! Placeholder
        !
        WaitSyncTask id_A067_InitVarEnd,tl_RFL_All;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize speed settings for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2019.11.29
    !***************** ETH Zurich *******************
    !
    PROC r_A067_InitSpeed()
        !
        WaitSyncTask id_A067_InitSpeedSta,tl_RFL_All;
        !
        !
        WaitSyncTask id_A067_InitSpeedSet,tl_RFL_All;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE
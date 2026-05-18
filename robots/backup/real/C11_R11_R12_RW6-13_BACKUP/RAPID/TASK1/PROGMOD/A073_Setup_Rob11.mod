MODULE A073_Setup_Rob11
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
    ! FUNCTION    :  Project specific instructions 
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2022.06.13
    !
    ! Copyright   :  ETH Zurich (CH) 2022
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Code for Setup Interface (Inititialize, Pick and Place Tool)
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.08.10
    !***************** ETH Zurich *******************
    !
    PROC r_A073_Setup()
        !
        ! Task synchronization 
        WaitSyncTask id_A073_Setup_Start,tl_A073_CtrlRob;
        !
        ! Setup loop
        WHILE b_A073_Setup=TRUE DO
            !
            ! Check for task
            IF b_A073_Init=TRUE THEN
                !
                ! Ininitialze Gantry basicly move Gantrys in start position
                r_A073_SetupInit;
            ELSEIF b_A073_PickTool=TRUE THEN
                !
                ! Pick Tool
                r_A073_SetupPickTool;
            ELSEIF b_A073_PlaceTool=TRUE THEN
                !
                ! Place Tool
                r_A073_SetupPlaceTool;
            ELSE
                !
                ! Idle loop
                WaitTime n_A073_Setup_CycleTime;
            ENDIF
            !
            ! Task synchronization 
            WaitSyncTask id_A073_Setup_End,tl_A073_CtrlRob;
        ENDWHILE
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Setup Inititialize (Gantry basicly move Gantrys in start position)
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.08.10
    !***************** ETH Zurich *******************
    !
    PROC r_A073_SetupInit()
        !
        ! Task synchronization 
        WaitSyncTask id_A073_Setup_Init_Start,tl_A073_CtrlRob;
        !
        ! Unsync Gantrys 
        r_A073_UnSyncGantry;
        !
        ! Wait to move robot 12 in park position   
        WaitSyncTask id_A073_Setup_Init_R12ToPark,tl_A073_CtrlRob;
        !
        ! Wait for robot 12 in park position   
        WaitSyncTask id_A073_Setup_Init_R12InPark,tl_A073_CtrlRob;
        !
        ! Wait for robot 11 moving to park position   
        WaitSyncTask id_A073_Setup_Init_R11ToPark,tl_A073_CtrlRob;
        !
        ! Move robot in park or compact position
        ! (quick and dirty solution)
        !* rSysH_ToPark;
        rSysH_ToCompact;
        !
        ! Robot 11 in park position   
        WaitSyncTask id_A073_Setup_Init_R11InPark,tl_A073_CtrlRob;
        !
        ! Task synchronization 
        WaitSyncTask id_A073_Setup_Init_End,tl_A073_CtrlRob;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Setup Pick Tool
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.08.10
    !***************** ETH Zurich *******************
    !
    PROC r_A073_SetupPickTool()
        !
        ! Task synchronization 
        WaitSyncTask id_A073_Setup_PickTool_Start,tl_A073_CtrlRob;
        !
        ! User message for moving robot in position 
        UIMsgBox
                \Header:="A073 Pick Tool","Please confirm with OK to move robot 11"
                \MsgLine2:="in position."
                \MsgLine4:=""
                \Buttons:=btnOK
                \Icon:=iconWarning
                \Result:=btr_A073_Answer;
        !
        ! Take over pick position (manualy teached position) 
        jp_A073_Act:=jp_A073_PickTool;
        !
        ! Set robot position
        jp_A073_Act.robax:=rj_A073_RobotStandby;
        !
        ! Move Robot X-,Y- anc Z-Axis in pre position
        EOffsSet [0,n_A073_PickOffsY,n_A073_PickOffsZ_Up,0,0,0];
        MoveAbsJ jp_A073_Act,v200,z50,tool0\WObj:=wobj0;
        !
        ! Move Z-Axis in insert position
        EOffsSet [0,n_A073_PickOffsY,n_A073_PickOffsZ_Down,0,0,0];
        MoveAbsJ jp_A073_Act,v200,z50,tool0\WObj:=wobj0;
        !
        ! Insert Gantry 
        EOffsSet [0,0,n_A073_PickOffsZ_Down,0,0,0];
        MoveAbsJ jp_A073_Act,v50,z5,tool0\WObj:=wobj0;
        !
        ! Move to final pick position 
        EOffsOff;
        MoveAbsJ jp_A073_Act,v10,fine,tool0\WObj:=wobj0;
        !
        ! Robot 11 in pos
        WaitSyncTask id_A073_Setup_PickTool_PosR11,tl_A073_CtrlRob;
        !
        ! Wait for robot 12 in pos
        WaitSyncTask id_A073_Setup_PickTool_PosR12,tl_A073_CtrlRob;
        !
        ! Sync Gantrys 
        r_A073_SyncGantry;
        !
        ! Move synchron up low speed 
        EOffsSet [0,0,n_A073_PickOffsZ_LiftTool_1,0,0,0];
        MoveAbsJ jp_A073_Act\ID:=idn_A073_SyncID_PickUp,v10,z10,tool0\WObj:=wobj0;
        !
        ! Move synchron up faster speed         
        EOffsSet [0,0,n_A073_PickOffsZ_LiftTool_2,0,0,0];
        MoveAbsJ jp_A073_Act\ID:=idn_A073_SyncID_PickUp,v200,z50,tool0\WObj:=wobj0;
        !
        ! Deactivate all offsets for extarnes axises  
        EOffsOff;
        ! 
        ! Task synchronization 
        WaitSyncTask id_A073_Setup_PickTool_End,tl_A073_CtrlRob;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Setup Place Tool
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.08.10
    !***************** ETH Zurich *******************
    !
    PROC r_A073_SetupPlaceTool()
        !
        ! Task synchronization 
        WaitSyncTask id_A073_Setup_PlaceTool_Start,tl_A073_CtrlRob;
        !
        ! Take over place position (manualy teached position) 
        jp_A073_Act:=jp_A073_PickTool;
        !
        ! Set robot position
        jp_A073_Act.robax:=rj_A073_RobotStandby;
        !
        ! Move robot to tool station 
        WaitSyncTask id_A073_Setup_PlaceTool_MovToSta,tl_A073_CtrlRob;
        !
        ! Move over place position          
        EOffsSet [0,0,n_A073_PickOffsZ_LiftTool_2,0,0,0];
        MoveAbsJ jp_A073_Act\ID:=idn_A073_SyncID_PlaceDown,v200,z50,tool0\WObj:=wobj0;
        !
        ! Move down to place position          
        EOffsSet [0,0,n_A073_PickOffsZ_LiftTool_1,0,0,0];
        MoveAbsJ jp_A073_Act\ID:=idn_A073_SyncID_PlaceDown,v200,z10,tool0\WObj:=wobj0;
        !
        ! Move to final place position 
        EOffsOff;
        MoveAbsJ jp_A073_Act\ID:=idn_A073_SyncID_PlaceDown,v10,fine,tool0\WObj:=wobj0;
        !
        ! Robot in place postion  
        WaitSyncTask id_A073_Setup_PlaceTool_InSta,tl_A073_CtrlRob;
        !
        ! Release robot 11  
        WaitSyncTask id_A073_Setup_PlaceTool_RelR11,tl_A073_CtrlRob;
        !
        ! Unsync Gantrys 
        r_A073_UnSyncGantry;
        !
        ! Move Gantry down 
        EOffsSet [0,0,n_A073_PickOffsZ_Down,0,0,0];
        MoveAbsJ jp_A073_Act,v10,z5,tool0\WObj:=wobj0;
        !
        ! Move Z-Axis out of tool position
        EOffsSet [0,n_A073_PickOffsY,n_A073_PickOffsZ_Down,0,0,0];
        MoveAbsJ jp_A073_Act,v50,z50,tool0\WObj:=wobj0;
        !
        ! Move Robot X-,Y- anc Z-Axis in pre position
        EOffsSet [0,n_A073_PickOffsY,n_A073_PickOffsZ_Up,0,0,0];
        MoveAbsJ jp_A073_Act,v200,fine,tool0\WObj:=wobj0;
        !
        ! Robot 11 is free
        WaitSyncTask id_A073_Setup_PlaceTool_R11Free,tl_A073_CtrlRob;
        !
        ! Release Robot 12  
        WaitSyncTask id_A073_Setup_PlaceTool_RelR12,tl_A073_CtrlRob;
        !
        ! Wait for Robot 12 free
        WaitSyncTask id_A073_Setup_PlaceTool_R12Free,tl_A073_CtrlRob;
        !
        ! Task synchronization 
        WaitSyncTask id_A073_Setup_PlaceTool_End,tl_A073_CtrlRob;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

ENDMODULE
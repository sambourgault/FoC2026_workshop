MODULE A073_Setup_Ctrl
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
            ! Check selected modus
            IF st_A073_Modus<>"Setup" b_A073_Setup:=FALSE;
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
        ! User message move robot 12 in park position
        UIMsgBox
                \Header:="A073 Initialization","Make sure that path to the park position is free"
                \MsgLine2:="before you press ok!"
                \MsgLine4:="By pressing ok Robot 12 will move direct to park position!"
                \Buttons:=btnOK
                \Icon:=iconWarning
                \Result:=btr_A073_Answer;
        !
        ! Move robot 12 in park position   
        WaitSyncTask id_A073_Setup_Init_R12ToPark,tl_A073_CtrlRob;
        !
        ! Wait for robot 12 in park position   
        WaitSyncTask id_A073_Setup_Init_R12InPark,tl_A073_CtrlRob;
        !
        ! User message move robot 11 in compact position
        UIMsgBox
                \Header:="A073 Initialization","Make sure that path to the compact position is free"
                \MsgLine2:="before you press ok!"
                \MsgLine4:="By pressing ok Robot 11 will move direct to compact position!"
                \Buttons:=btnOK
                \Icon:=iconWarning
                \Result:=btr_A073_Answer;
        !
        ! Move robot 11 in park position   
        WaitSyncTask id_A073_Setup_Init_R11ToPark,tl_A073_CtrlRob;
        !
        ! Wait for robot 11 in park position   
        WaitSyncTask id_A073_Setup_Init_R11InPark,tl_A073_CtrlRob;
        !
        ! Task synchronization 
        WaitSyncTask id_A073_Setup_Init_End,tl_A073_CtrlRob;
        !
        ! Reset initialize task variable 
        b_A073_Init:=FALSE;
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
        ! Wait for robot 11 in pos
        WaitSyncTask id_A073_Setup_PickTool_PosR11,tl_A073_CtrlRob;
        !
        ! Wait for robot 12 in pos
        WaitSyncTask id_A073_Setup_PickTool_PosR12,tl_A073_CtrlRob;
        !
        ! User message add screws  
        UIMsgBox
                \Header:="A073 Pick Tool","Please add the screws to connect the tool to the Gantry."
                \MsgLine2:="By pressing ok the program will stop."
                \MsgLine4:="Press play after you added the screws to continue."
                \Buttons:=btnOK
                \Icon:=iconWarning
                \Result:=btr_A073_Answer;
        !
        ! Stop this and all motion tasks 
        Stop\AllMoveTasks;
        !
        ! User message screws added confirmation   
        UIMsgBox
                \Header:="A073 Pick Tool","Please confirm with OK that you added the screws"
                \MsgLine2:="to connect the tool to the Gantry."
                \MsgLine4:="If not then stop with the stop button!"
                \Buttons:=btnOK
                \Icon:=iconWarning
                \Result:=btr_A073_Answer;
        !
        ! Sync Gantrys 
        r_A073_SyncGantry;
        !
        ! Task synchronization 
        WaitSyncTask id_A073_Setup_PickTool_End,tl_A073_CtrlRob;
        !
        ! Reset initialize task variable 
        b_A073_PickTool:=FALSE;
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
        ! User message robot will place tool   
        UIMsgBox
                \Header:="A073 Initialization","By pressing OK the robot will place the tool."
                \MsgLine2:=""
                \Buttons:=btnOK
                \Icon:=iconInfo
                \Result:=btr_A073_Answer;
        !
        ! Move robot to tool station 
        WaitSyncTask id_A073_Setup_PlaceTool_MovToSta,tl_A073_CtrlRob;
        !
        ! Wait for robot in place position 
        WaitSyncTask id_A073_Setup_PlaceTool_InSta,tl_A073_CtrlRob;
        !
        ! User message remove screws  
        UIMsgBox
                \Header:="A073 Initialization","Please remove the screws to release the tool from the Gantry."
                \MsgLine2:="By pressing ok the program will stop."
                \MsgLine4:="Press play after you removed the screws to continue."
                \Buttons:=btnOK
                \Icon:=iconWarning
                \Result:=btr_A073_Answer;
        !
        ! Stop this and all motion tasks 
        Stop\AllMoveTasks;
        !
        ! User message screws removed confirmation   
        UIMsgBox
                \Header:="A073 Initialization","Please confirm with OK that you removed the screws"
                \MsgLine2:="to release the Robot 11."
                \MsgLine4:="If not then stop with the stop button!"
                \Buttons:=btnOK
                \Icon:=iconWarning
                \Result:=btr_A073_Answer;
        !
        ! User message start moving of robot    
        UIMsgBox
                \Header:="A073 Initialization","Please confirm with OK"
                \MsgLine2:="to release the Robot 11."
                \MsgLine4:=""
                \Buttons:=btnOK
                \Icon:=iconWarning
                \Result:=btr_A073_Answer;
        !
        ! Release Robot 11  
        WaitSyncTask id_A073_Setup_PlaceTool_RelR11,tl_A073_CtrlRob;
        !
        ! Unsync Gantrys 
        r_A073_UnSyncGantry;
        !
        ! Wait for Robot 11 free
        WaitSyncTask id_A073_Setup_PlaceTool_R11Free,tl_A073_CtrlRob;
        !
        ! User message start moving of robot    
        UIMsgBox
                \Header:="A073 Initialization","Please confirm with OK"
                \MsgLine2:="to release the Robot 12."
                \MsgLine4:=""
                \Buttons:=btnOK
                \Icon:=iconWarning
                \Result:=btr_A073_Answer;
        !
        ! Release Robot 12  
        WaitSyncTask id_A073_Setup_PlaceTool_RelR12,tl_A073_CtrlRob;
        !
        ! Wait for Robot 12 free
        WaitSyncTask id_A073_Setup_PlaceTool_R12Free,tl_A073_CtrlRob;
        !
        ! Task synchronization 
        WaitSyncTask id_A073_Setup_PlaceTool_End,tl_A073_CtrlRob;
        !
        ! Reset initialize task variable 
        b_A073_PlaceTool:=FALSE;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE
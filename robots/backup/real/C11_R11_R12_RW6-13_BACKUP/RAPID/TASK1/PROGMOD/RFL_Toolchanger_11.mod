MODULE RFL_Toolchanger_11
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  RFL Tool Changer Robot 11
    !
    ! FUNCTION    :  Inclouds all tool changer featuers
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2017.07.27 Draft
    !
    ! Copyright   :  ETH Zurich (CH) 2017
    !
    !***********************************************************************************
    ! Description of Module 
    !***********************************************************************************
    !
    ! General:
    ! RFL TC11 (Master menue)
    ! RFL TC12 (Master menue)
    ! InitSig
    !
    ! User Msg:
    ! UiWin
    ! UiWinMan
    ! SafeInfo
    !
    ! Toolchanger:
    ! Toolhandler
    ! MovToStaTB1
    ! PickTool
    ! PlaceTool
    ! MovFrmPlaToPic
    ! InitTool
    ! ConTool
    ! DisconTool
    ! UpdateToolLoad
    ! ResTool
    ! ToolSigOff
    ! Lock
    ! Unlock
    !
    ! Functions: 
    ! Tool Selection
    ! CheckCurToolCode
    ! CheckNextToolCodde
    ! ButtonConformation
    !
    ! Tools:
    ! Tool 1 = Woodgripper with sensor
    ! Tool 2 = Spindels
    ! Tool 3 = Woodgripper without sensors
    ! Tool 4 = Vacuum Tool 1
    ! Tool 5 = Vacuum Tool 2
    !
    ! Teaching:
    ! Create Workobjects
    !
    !***********************************************************************************

    !************************************************
    ! Declaration :     bool
    !************************************************
    !
    TASK PERS bool b_Tc11_ToolSafe:=TRUE;
    TASK PERS bool b_Tc11_PlaceTool:=FALSE;
    TASK PERS bool b_Tc11_PickTool:=FALSE;
    TASK PERS bool b_Tc11_SimTool:=FALSE;
    TASK PERS bool b_Tc11_NoTool:=TRUE;
    TASK PERS bool b_Tc11_WrongTool:=FALSE;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    ! Tool-Changer
    CONST num nTime_Tc_Lock:=1.0;
    CONST num nTime_Tc_Unlock:=1.0;
    CONST num n_Tc_OffsX2:=0;
    CONST num n_Tc_OffsX1:=0;
    CONST num n_Tc_OffsY2:=150;
    CONST num n_Tc_OffsY1:=50;
    CONST num n_Tc_OffsZ3:=500;
    CONST num n_Tc_OffsZ2:=300;
    CONST num n_Tc_OffsZ1:=200;
    CONST num n_Tc_NumOfTools:=6;
    CONST num n_Tc_CodeForNoTool:=99;
    !
    TASK PERS num n_Tc11_PickCode:=0;
    TASK PERS num n_Tc11_PlaceCode:=0;
    TASK PERS num n_Tc11_SimToolCode:=1;
    TASK PERS num n_Tc11_CurToolCode:=99;
    !
    ! Tool 1 = Woodgripper with sensor
    CONST num nTime_Tc11_T1GripOn:=1;
    CONST num nTime_Tc11_T1GripOff:=1;
    CONST num nTime_Tc11_T1EdgeSenOn:=1.0;
    !
    ! Tool 2 = Spindels
    CONST num nTime_Tc11_T2PowerpOn:=1.0;
    !
    ! Tool 3 = Woodgripper without sensors
    CONST num nTime_Tc11_T3GripOn:=1.0;
    CONST num nTime_Tc11_T3GripOff:=1.0;
    !
    ! Tool 4 = Vacuum Tool 1
    CONST num nTime_Tc11_T4VacuumOn:=1.0;
    CONST num nTime_Tc11_T4VacuumOff:=1.0;
    !
    ! Tool 5 = Vacuum Tool 5
    CONST num nTime_Tc11_T5VacuumOn:=1.0;
    CONST num nTime_Tc11_T5VacuumOff:=1.0;
    !
    ! Tool 6 = Woodgripper without sensors
    CONST num nTime_Tc11_T6GripOn:=1.0;
    CONST num nTime_Tc11_T6GripOff:=1.0;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    CONST string st_Tc11_MsgHeader:="TC11";
    CONST string st_Tc11_T1MsgHeader:="TC11 Tool 1";
    CONST string st_Tc11_T2MsgHeader:="TC11 Tool 2";
    CONST string st_Tc11_T3MsgHeader:="TC11 Tool 3";
    CONST string st_Tc11_T4MsgHeader:="TC11 Tool 4";
    CONST string st_Tc11_T5MsgHeader:="TC11 Tool 5";
    CONST string st_Tc11_T6MsgHeader:="TC11 Tool 6";
    !
    CONST string st_Tc11_BtnToolSim{2}:=["No Tool","Sim"];

    !************************************************
    ! Declaration :     tooldata
    !************************************************
    !
    TASK PERS tooldata tTc11:=[TRUE,[[0,0,83],[1,0,0,0]],[0.5,[0,0,30],[1,0,0,0],0,0,0]];

    !************************************************
    ! Declaration :     loaddata
    !************************************************
    !
    TASK PERS loaddata ld_Tc11_NoTool:=[0.5,[0,0,30],[1,0,0,0],0,0,0];
    TASK PERS loaddata ld_Tc11_T1:=[1,[0,0,30],[1,0,0,0],0,0,0];
    TASK PERS loaddata ld_Tc11_T2:=[2,[0,0,30],[1,0,0,0],0,0,0];
    TASK PERS loaddata ld_Tc11_T3:=[3,[0,0,30],[1,0,0,0],0,0,0];
    TASK PERS loaddata ld_Tc11_T4:=[4,[0,0,30],[1,0,0,0],0,0,0];
    TASK PERS loaddata ld_Tc11_T5:=[5,[0,0,30],[1,0,0,0],0,0,0];
    TASK PERS loaddata ld_Tc11_T6:=[3,[0,0,30],[1,0,0,0],0,0,0];

    !************************************************
    ! Declaration :     wobjdata
    !************************************************
    !
    TASK PERS wobjdata ob_Tc11_Toolbox:=[FALSE,TRUE,"",[[9345.957,2618.161,237.703],[0.707106781,0.707106781,0,0]],[[216.3,10,0],[0.707106781,-0.707106781,0,0]]];
    !
    TASK PERS wobjdata ob_Tc11:=[FALSE,TRUE,"",[[10356.4,2576.98,464.222],[0.999999,-0.000946924,-0.000979289,-2.30521E-05]],[[0,0,0],[1,0,0,0]]];
    !
    !* TASK PERS wobjdata ob_Tc11_T1:=[FALSE,TRUE,"",[[10357.4,2580.13,464.564],[0.999999,-0.000940651,-0.00100347,-1.57058E-05]],[[0,0,0],[1,0,0,0]]];
    TASK PERS wobjdata ob_Tc11_T1:=[FALSE,TRUE,"",[[10356.4,2576.98,464.222],[0.999999,-0.000946924,-0.000979289,-2.30521E-05]],[[0,0,0],[1,0,0,0]]];
    TASK PERS wobjdata ob_Tc11_T2:=[FALSE,TRUE,"",[[9567.96,2578.61,464.204],[0.999991,8.61287E-05,0.00298509,0.00299114]],[[0,0,0],[1,0,0,0]]];
    TASK PERS wobjdata ob_Tc11_T3:=[FALSE,TRUE,"",[[8754.65,2576.81,465.237],[0.999999,3.13073E-05,0.000978425,-0.000984207]],[[0,0,0],[1,0,0,0]]];
    TASK PERS wobjdata ob_Tc11_T5:=[FALSE,TRUE,"",[[11155.6,2581.03,465.349],[0.999997,-1.5527E-05,0.00205088,0.00103393]],[[0,0,0],[1,0,0,0]]];
    TASK PERS wobjdata ob_Tc11_T4:=[FALSE,TRUE,"",[[7962.26,2668.16,471.703],[1,-1.04308E-07,4.47035E-08,-1.04308E-07]],[[0,0,0],[1,0,0,0]]];

    !************************************************
    ! Declaration :     pose
    !************************************************
    !
    TASK PERS pose po_Tc11_WobjOFrame:=[[145,0,0],[0.707106781,-0.707106781,0,0]];
    TASK PERS pose po_Tc11_Offset:=[[-88,0,34],[0.5,-0.5,0.5,-0.5]];

    !************************************************
    ! Declaration :     jointtarget
    !************************************************
    !
    !* CONST jointtarget jp_Tc11_StaPosTB:=[[-90,90,-155,180,25,0],[9561.73,-500,-4800,0,0,0]];
    CONST jointtarget jp_Tc11_StaPosTB:=[[-90,90,-155,180,25,0],[9561.73,-0,-4800,0,0,0]];
    CONST jointtarget jp_Tc11_ToTB1_10:=[[-90,90,-155,180,25,0],[9561.73,-800,-4800,0,0,0]];
    !
    ! Path in Toolbox
    !* CONST jointtarget jp_Tc11_PathInTB1_10:=[[90,90,-90,180,90,-180],[9561.73,-5600,-4800,0,0,0]];
    !* CONST jointtarget jp_Tc11_PathInTB1_20:=[[90,55,-150,180,45,-90],[9561.73,-3600,-4800,0,0,0]];
    !* CONST jointtarget jp_Tc11_PathInTB1_30:=[[0,25,-120,180,85,0],[9561.73,-2600,-4800,0,0,0]];
    !* CONST jointtarget jp_Tc11_PathInTB1_40:=[[-90,35,-140,180,85,0],[9561.73,-2600,-4000,0,0,0]];

    !************************************************
    ! Declaration :     robtarget
    !************************************************
    !
    TASK PERS robtarget p_Tc11_PlacePosTB:=[[0,34,88],[0.5,0.5,-0.5,0.5],[-1,2,0,2],[9561.73,-2600,-3100,0,0,0]];
    TASK PERS robtarget p_Tc11_PickPosTB:=[[0,34,88],[0.5,0.5,-0.5,0.5],[-1,2,0,2],[9561.73,-2600,-3100,0,0,0]];
    TASK PERS robtarget p_Tc11_InterPosTB:=[[-0.00,150.00,88.00],[0.5,0.5,-0.5,0.5],[-1,1,0,2],[9561.73,-2600,-3300,0,0,0]];
    TASK PERS robtarget p_Tc11_InterPos_T2:=[[0.00,200.00,312.00],[0.5,0.5,-0.5,0.5],[-1,1,0,2],[9561.73,-2600,-3300,0,0,0]];
    !
    !TASK PERS robtarget p_Tc11_PrePosTB:=[[-0.52563273,72.816243796,1198.160883144],[0.500000223,0.499999749,-0.500000094,0.499999934],[-1,2,0,2],[9561.731338501,-2400,-4000,0,0,0]];
    !
    ! Tool 1 = Woodgripper with sensor    
    TASK PERS robtarget p_Tc11_T1_TeachPoint:=[[10356.2,2611.15,552.1],[0.499997,0.499026,-0.500026,0.50095],[-1,1,-1,2],[9561.74,-2599.99,-3099.97,0,0,0]];
    TASK PERS robtarget p_Tc11_T1_PlaInTB:=[[0,34,88],[0.5,0.5,-0.5,0.5],[-1,2,0,2],[9561.73,-2600,-3100,0,0,0]];
    !
    ! Tool 2 = Spindels
    TASK PERS robtarget p_Tc11_T2_TeachPoint:=[[9568.28,2612.6,552.21],[0.499948,0.503028,-0.49705,0.499956],[-1,1,-1,2],[9561.74,-2599.99,-3299.99,0,0,0]];
    TASK PERS robtarget p_Tc11_T2_PlaInTB:=[[0,34,88],[0.5,0.5,-0.5,0.5],[-1,2,0,2],[9561.73,-2600,-3300,0,0,0]];
    !
    ! Tool 3 = Woodgripper without sensors
    TASK PERS robtarget p_Tc11_T3_TeachPoint:=[[8754.83,2610.81,553.22],[0.500963,0.500007,-0.500021,0.499007],[-2,2,0,2],[9561.74,-2599.99,-3099.99,0,0,0]];
    TASK PERS robtarget p_Tc11_T3_PlaInTB:=[[0,34,88],[0.5,0.5,-0.5,0.5],[-1,2,0,2],[9561.73,-2600,-3100,0,0,0]];
    !
    ! Tool 4 = Vacuum Tool 1
    TASK PERS robtarget p_Tc11_T4_TeachPoint:=[[8756.18,2611.36,552.83],[0.500954,0.50003,-0.500005,0.499009],[-2,2,0,2],[9561.74,-2599.99,-3100,0,0,0]];
    TASK PERS robtarget p_Tc11_T4_PlaInTB:=[[0,34,88],[0.5,0.5,-0.5,0.5],[-1,2,0,2],[9561.73,-2600,-2600,0,0,0]];
    !
    ! Tool 5 = Vacuum Tool 2
    TASK PERS robtarget p_Tc11_T5_TeachPoint:=[[11155.87,2615.03,553.35],[0.500515,0.501533,-0.498449,0.499498],[-1,1,-1,2],[9561.74,-2599.98,-2599.99,0,0,0]];
    TASK PERS robtarget p_Tc11_T5_PlaInTB:=[[0,34,88],[0.5,0.5,-0.5,0.5],[-1,2,0,2],[9561.73,-2600,-2600,0,0,0]];

    !************************************************
    ! Declaration :     signaldi
    !************************************************
    !
    ! Tool 1 = Woodgripper with sensor
    VAR signaldi di_Tc11_T1Gr1Open;
    VAR signaldi di_Tc11_T1Gr1Close;
    VAR signaldi di_Tc11_T1Gr2Open;
    VAR signaldi di_Tc11_T1Gr2Close;

    !************************************************
    ! Declaration :     signaldo
    !************************************************
    !
    ! Tool 1 = Woodgripper with sensor
    VAR signaldo do_Tc11_T1GrOff;
    VAR signaldo do_Tc11_T1GrOn;
    VAR signaldo do_Tc11_T1EdgeSenOn;
    !
    ! Tool 2 = Spindels
    VAR signaldo do_Tc11_T2MillOn;
    VAR signaldo do_Tc11_T2DrillOn;
    !
    ! Tool 3 = Woodgripper without sensors
    VAR signaldo do_Tc11_T3GrOff;
    VAR signaldo do_Tc11_T3GrOn;
    !
    ! Tool 4 = Vacuum Tool 1
    VAR signaldo do_Tc11_T4VacuumOn;
    !
    ! Tool 5 = Vacuum Tool 2
    VAR signaldo do_Tc11_T5VacuumOn;
    !
    ! Tool 3 = Woodgripper without sensors
    VAR signaldo do_Tc11_T6GrOff;
    VAR signaldo do_Tc11_T6GrOn;

    !************************************************
    ! Declaration :     listitem
    !************************************************
    !
    CONST listitem liTC11Win{4}:=[["","Place Tool in Toolbox"],["","Pick Tool from Toolbox"],[""," "],["","Manual Lock & Unlock"]];
    CONST listitem liTC11WinMan{2}:=[["","Lock Tool"],["","Unlock Tool"]];
    CONST listitem liTC11WinToolSelection{7}:=[["","T1: Woodgripper with Sensors"],["","T2: Spindeltool"],["","T3: Woodgripper without Sensors"],["","T4: Vacuumtool 1"],["","T5: Vacuumtool 2"],["","T6: Gipper MAS 2018"],["","T7: PDS Spindle"]];

    !************************************************
    ! Declaration :     smsg
    !************************************************
    !
    LOCAL CONST smsg smsgTcStart:=["Toolchanger 11","Press Go to start the toolchanger process.","Or exit the program with program stop and PP-Main.","","","","Go","x.jpg"];

    !***********************************************************************************
    ! Global Data
    !***********************************************************************************

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    PERS speeddata vTcMin:=[20,5,100,1];
    PERS speeddata vTcMed:=[250,10,250,1];
    PERS speeddata vTcMax:=[500,20,500,1];

    !***********************************************************************************
    ! General 
    !***********************************************************************************

    !************************************************
    ! Function    :     Start User Interface Tool-Changer 11
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.07
    ! **************** ETH Zurich *******************
    !
    PROC rRFL_TC11()
        !
        WaitSyncTask idRFL_TC11Sta,tlAll;
        !
        ! Temp Msg for Operator
        TPWrite "Master in RFL Tool-Changer 11";
        !
        ! User Interface Tool-Changer
        r_Tc11_UIWin;
        ! 
        WaitSyncTask idRFL_TC11End,tlAll;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Start User Interface Tool-Changer 12
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.07
    ! **************** ETH Zurich *******************
    !
    PROC rRFL_TC12()
        !
        WaitSyncTask idRFL_TC12Sta,tlAll;
        !
        ! Temp Msg for Operator
        TPWrite "Master in RFL Tool-Changer 12";
        !
        ! Placeholder for Master Code 
        ! 
        WaitSyncTask idRFL_TC12End,tlAll;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize current tool
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.15
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_InitSig()
        ! 
        ! Button led
        SetDo doTc11BtnLedOn,0;
        !
        RETURN ;
    ERROR
        !
        ! Try next when unit not available 
        IF ERRNO=ERR_NORUNUNIT TRYNEXT;
    ENDPROC

    !***********************************************************************************
    ! User Msg
    !***********************************************************************************

    !************************************************
    ! Function    :     Tool-Changer Interface Window 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_UIWin()
        VAR num nToolNr;
        !
        ! Tool-Changer loop
        !
        ! View Window Tool-Changer
        nUiListItem:=UIListView(
                    \Result:=btnAnswer
                    \Header:="Tool-Changer 11",
                    liTC11Win
                    \BtnArray:=stBtnOkExit
                    \Icon:=iconInfo
                    \DefaultIndex:=1);
        !
        ! Check answer
        IF btnAnswer=1 THEN
            !
            ! Button answer OK
            !
            ! Test answer
            TEST nUiListItem
            CASE 1:
                !
                ! Item Place Tool in Toolbox
                r_Tc11_Toolhandler nToolNr\Place;
            CASE 2:
                !
                ! Item Select Tool and change
                nToolNr:=f_Tc11_ToolSelection(\stAddText:="Pick");
                r_Tc11_Toolhandler nToolNr\Place\Pick;
            CASE 3:
                !
                ! No Item 
            CASE 4:
                !
                ! Item Manual 
                !
                ! Check 
                IF f_Tc11_ButtonConfirmation()=TRUE THEN
                    !
                    ! Call window manual
                    r_Tc11_UIWinMan;
                ENDIF
            DEFAULT:
                !
                ! Undefined Item 
                r_RFL_ProgError;
            ENDTEST
            !
        ELSE
            !
            ! Exit
        ENDIF
        !
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Tool-Changer Interface Window Manual
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_UIWinMan()
        VAR bool bUiWinMan;
        !
        ! Set variables
        bUiWinMan:=TRUE;
        !
        ! Window loop
        WHILE bUiWinMan=TRUE DO
            !
            ! View Window Tool-Changer
            nUiListItem:=UIListView(
                    \Result:=btnAnswer
                    \Header:="Tool-Changer 11 Manual",
                    liTC11WinMan
                    \BtnArray:=stBtnOkExit
                    \Icon:=iconInfo
                    \DefaultIndex:=1);
            !
            ! Check answer
            IF btnAnswer=1 THEN
                !
                ! Button answer OK
                !
                ! Test answer
                TEST nUiListItem
                CASE 1:
                    !
                    ! Item Lock Tool
                    r_Tc11_Lock;
                    !
                    ! Init Tool
                    r_Tc11_InitTool f_Tc11_CheckCurToolCode();
                CASE 2:
                    !
                    ! Item Safe check and Unlock Tool
                    !
                    ! Situation safe?
                    r_Tc11_SafInfo "Unlock the Tool-Changer ?";
                    !
                    ! Execute only when safe
                    IF b_Tc11_ToolSafe=TRUE THEN
                        !
                        ! Disconnect current Tool
                        r_Tc11_DisconTool 1;
                        r_Tc11_DisconTool 2;
                        r_Tc11_DisconTool 3;
                        r_Tc11_DisconTool 4;
                        r_Tc11_DisconTool 5;
                        !
                        ! All Tool signals off
                        r_Tc11_ToolSigOff;
                        !
                        ! Unlock current Tool
                        r_Tc11_Unlock;
                        !
                        ! Set Placeholder no Tool
                        n_Tc11_CurToolCode:=n_Tc_CodeForNoTool;
                    ENDIF
                DEFAULT:
                    !
                    ! Undefined Item 
                    r_RFL_ProgError;
                ENDTEST
                !
            ELSE
                ! 
                ! Exit 
                bUiWinMan:=FALSE;
            ENDIF
        ENDWHILE
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Safety information for the user during tool reset
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_SafInfo(string stMsgL1)
        !
        ! User Msg
        UIMsgBox
                \Header:="Tool-Changer 11 Safety Information","Is the situation safe to "
                \MsgLine2:=""
                \MsgLine3:=stMsgL1
                \MsgLine4:=""
                \MsgLine5:=""
                \Buttons:=btnYesNo
                \Icon:=iconWarning
                \Result:=btnAnswer;
        !
        ! Check answer
        IF btnAnswer=resYes THEN
            !
            ! Situation safe  
            b_Tc11_ToolSafe:=TRUE;
        ELSE
            !
            ! Situation not safe  
            b_Tc11_ToolSafe:=FALSE;
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !***********************************************************************************
    ! Toolchanger:
    !***********************************************************************************

    !************************************************
    ! Function    :     Manage Toolhandling
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_Toolhandler(num nToolNr\switch Place\switch Pick)
        !
        ! Check place tool
        IF Present(Place) AND b_Tc11_NoTool=FALSE THEN
            ! 
            ! Activat place tool
            b_Tc11_PlaceTool:=TRUE;
            !
            ! Read and check current tool code
            n_Tc11_PlaceCode:=n_Tc11_CurToolCode;
        ELSE
            ! 
            ! Deactivat place tool
            b_Tc11_PlaceTool:=FALSE;
            !
            ! Set code to zero
            n_Tc11_PlaceCode:=0;
        ENDIF
        !
        ! Check pick tool
        IF Present(Pick) THEN
            ! 
            ! Activat place tool
            b_Tc11_PickTool:=TRUE;
            !
            ! Read and check next tool code
            n_Tc11_PickCode:=f_Tc11_CheckNextToolCode(nToolNr);
        ELSE
            ! 
            ! Deactivat place tool
            b_Tc11_PickTool:=FALSE;
            !
            ! Set code to zero
            n_Tc11_PickCode:=0;
        ENDIF
        !
        ! Do not tool change when place and pick tool is the same
        IF n_Tc11_PickCode=n_Tc11_PlaceCode THEN
            !
            ! Deactivat pick and place
            b_Tc11_PickTool:=FALSE;
            b_Tc11_PlaceTool:=FALSE;
        ENDIF
        !
        ! Execute only when place or pick is active 
        IF b_Tc11_PlaceTool=TRUE OR b_Tc11_PickTool=TRUE THEN
            !
            ! Check the way of Y-Axis befor moving
            rCheckYAxisCol p_Tc11_T1_PlaInTB.extax.eax_b;
            !
            ! Move to station pos
            r_Tc11_MovToStaTB1;
            !
            ! User safety message befor speed up
            r_RFL_SMsg smsgTcStart;
            !
            ! Set toolchanger speedlimit
            r_RFL_SetSpeedLimit slim_TC_Master;
            !
            ! Move to Toolbox position
            r_Tc11_MovToTB1;
            !
            ! Place current tool
            IF b_Tc11_PlaceTool=TRUE r_Tc11_PlaceTool;
            !
            ! Pick new tool
            IF b_Tc11_PickTool=TRUE r_Tc11_PickTool;
            !
            ! Reset current Tool
            IF b_Tc11_PickTool=TRUE r_Tc11_ResTool n_Tc11_CurToolCode;
            !
            ! Move to Toolbox position
            r_Tc11_MovToTB1;
            !
            ! Move to station pos
            r_Tc11_MovToStaTB1;
            !
            ! Set actual porject speedlimit
            r_RFL_SetSpeedLimit slim_RFL_Act;
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Move to station Toolbox 1
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_MovToStaTB1()
        !
        ! Station Toolbox 
        MoveAbsJ jp_Tc11_StaPosTB,vRFLMax,z100,tool0;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Move in Toolbox 1
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.10.06
    !***************** ETH Zurich *******************
    !
    !* PROC r_Tc11_MovStaPosTb1ToTB1()
    !*     !
    !*     ! Path in Toolbox 
    !*     MoveAbsJ jp_Tc11_PathInTB1_10,vRFLMed,z200,tool0;
    !*     MoveAbsJ jp_Tc11_PathInTB1_20,vRFLMed,z200,tool0;
    !*     MoveAbsJ jp_Tc11_PathInTB1_30,vRFLMed,z200,tool0;
    !*     MoveAbsJ jp_Tc11_PathInTB1_40,vRFLMed,z200,tool0;
    !*     RETURN ;
    !* ERROR
    !*     ! Placeholder for Error Code...
    !* ENDPROC

    !************************************************
    ! Function    :     Move out Toolbox 1
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.10.06
    !***************** ETH Zurich *******************
    !
    !* PROC r_Tc11_MovTB1ToStaPosTB1()
    !*     !
    !*     ! Station Toolbox 
    !*     MoveAbsJ jp_Tc11_PathInTB1_40,vRFLMed,z200,tool0;
    !*     MoveAbsJ jp_Tc11_PathInTB1_30,vRFLMed,z200,tool0;
    !*     MoveAbsJ jp_Tc11_PathInTB1_20,vRFLMed,z200,tool0;
    !*     MoveAbsJ jp_Tc11_PathInTB1_10,vRFLMed,z200,tool0;
    !*     RETURN ;
    !* ERROR
    !*    ! Placeholder for Error Code...
    !* ENDPROC

    !************************************************
    ! Function    :     Move to Toolbox 1 position
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.10.02
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_MovToTB1()
        !
        ! Station Toolbox 
        MoveAbsJ jp_Tc11_ToTB1_10,vRFLMax,z100,tool0;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
    
    !************************************************
    ! Function    :     Pick tool in Toolbox
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_PickTool()
        !
        ! Set place position
        TEST n_Tc11_PickCode
        CASE 1:
            !
            ! Tool 1 = Woodgripper with sensor
            !
            ! Set Tool position
            p_Tc11_PickPosTB:=p_Tc11_T1_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc11:=ob_Tc11_T1;
        CASE 2:
            !
            ! Tool 2 = Spindels
            !
            ! Set Tool position
            p_Tc11_PickPosTB:=p_Tc11_T2_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc11:=ob_Tc11_T2;
        CASE 3:
            !
            ! Tool 3 = Woodgripper without sensors
            !
            ! Set Tool position
            p_Tc11_PickPosTB:=p_Tc11_T3_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc11:=ob_Tc11_T3;
        CASE 4:
            !
            ! Tool 4 = Vacuum Tool 1
            !
            ! Set Tool position
            p_Tc11_PickPosTB:=p_Tc11_T4_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc11:=ob_Tc11_T4;
        CASE 5:
            !
            ! Tool 5 = Vacuum Tool 2
            !
            ! Set Tool position
            p_Tc11_PickPosTB:=p_Tc11_T5_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc11:=ob_Tc11_T5;
        DEFAULT:
            !
            ! Not a correct Tool Code
            r_RFL_ProgError;
        ENDTEST
        !
        ! Execute only when pick tool true is
        IF b_Tc11_PickTool=TRUE THEN
            !
            ! Move over Toolbox when placing is not activated
            IF b_Tc11_PlaceTool=FALSE THEN
                !
                ! Move in pre position
                MoveJ Offs(p_Tc11_PickPosTB,0,n_Tc_OffsY2,n_Tc_OffsZ3),vTcMax,z50,tTc11\WObj:=ob_Tc11;
                !
                ! Move over place position
                MoveJ Offs(p_Tc11_PickPosTB,0,n_Tc_OffsY2,n_Tc_OffsZ2),vTcMax,z50,tTc11\WObj:=ob_Tc11;
            ELSE
                !
                ! Move over helper points
                r_Tc11_MovFrmPlaToPic;
            ENDIF
            !
            ! Set Error 
            b_Tc11_WrongTool:=TRUE;
            !
            ! Pick correct tool
            WHILE b_Tc11_WrongTool=TRUE DO
                !
                ! Move in front of pick position
                MoveL Offs(p_Tc11_PickPosTB,0,n_Tc_OffsY2,0),vTcMed,z20,tTc11\WObj:=ob_Tc11;
                !
                ! Move close to pick position
                MoveL Offs(p_Tc11_PickPosTB,0,n_Tc_OffsY1,0),vTcMed,z10,tTc11\WObj:=ob_Tc11;
                !
                ! Unlock 
                r_Tc11_Unlock;
                !
                ! Move to pick position
                MoveL p_Tc11_PickPosTB,vTcMin,fine,tTc11\WObj:=ob_Tc11;
                !
                ! Grap tool
                r_Tc11_Lock;
                !
                ! Compare current toolcode with target toolcode
                IF n_Tc11_PickCode=f_Tc11_CheckCurToolCode() THEN
                    !
                    ! Code ok
                    b_Tc11_WrongTool:=FALSE;
                ELSE
                    !
                    ! Code not ok
                    b_Tc11_WrongTool:=TRUE;
                    !
                    ! Redo grap tool
                    r_Tc11_Unlock;
                    !
                    ! Move away from to pick position
                    MoveL Offs(p_Tc11_PickPosTB,0,n_Tc_OffsY1,0),vTcMed,z10,tTc11\WObj:=ob_Tc11;
                    !
                    ! Move for pick position
                    MoveL Offs(p_Tc11_PickPosTB,0,n_Tc_OffsY2,0),vTcMed,fine,tTc11\WObj:=ob_Tc11;
                    !
                    ! User Msg
                    UIMsgBox
                            \Header:="Tool-Changer 11 Wrong Tool"," "
                            \MsgLine2:="Current Tool in Place ="+NumToStr(n_Tc11_CurToolCode,0)
                            \MsgLine3:="Correct Tool in Place ="+NumToStr(n_Tc11_PickCode,0)
                            \MsgLine4:=""
                            \MsgLine5:="Please inseert correct Tool in Place and press Ok to repeat"
                            \Buttons:=btnOk
                            \Icon:=iconWarning
                            \Result:=btnAnswer;
                ENDIF
            ENDWHILE
            !
            ! Initalize Tool
            r_Tc11_InitTool n_Tc11_CurToolCode;
            !
            ! Move out of toolbox
            MoveL Offs(p_Tc11_PickPosTB,0,0,n_Tc_OffsZ1),vTcMin,z10,tTc11\WObj:=ob_Tc11;
            !
            ! Move over pick position
            MoveL Offs(p_Tc11_PickPosTB,0,0,n_Tc_OffsZ2),vTcMed,z50,tTc11\WObj:=ob_Tc11;
            !
            ! Move back in pre position
            !* MoveJ p_Tc11_PrePosTB,vTcMax,z50,tTc11\WObj:=ob_Tc11;
            MoveJ Offs(p_Tc11_PickPosTB,0,0,n_Tc_OffsZ3),vTcMax,z50,tTc11\WObj:=ob_Tc11;
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Place current tool in Toolbox
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_PlaceTool()
        !
        ! Set place position
        TEST n_Tc11_PlaceCode
        CASE 1:
            !
            ! Tool 1 = Woodgripper with sensor
            !
            ! Set Tool position
            p_Tc11_PlacePosTB:=p_Tc11_T1_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc11:=ob_Tc11_T1;
        CASE 2:
            !
            ! Tool 2 = Spindels
            !
            ! Set Tool position
            p_Tc11_PlacePosTB:=p_Tc11_T2_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc11:=ob_Tc11_T2;
        CASE 3:
            !
            ! Tool 3 = Woodgripper without sensors
            !
            ! Set Tool position
            p_Tc11_PlacePosTB:=p_Tc11_T3_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc11:=ob_Tc11_T3;
        CASE 4:
            !
            ! Tool 4 = Vacuum Tool 1
            !
            ! Set Tool position
            p_Tc11_PlacePosTB:=p_Tc11_T4_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc11:=ob_Tc11_T4;
        CASE 5:
            !
            ! Tool 5 = Vacuum Tool 2
            !
            ! Set Tool position
            p_Tc11_PlacePosTB:=p_Tc11_T5_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc11:=ob_Tc11_T5;
        DEFAULT:
            !
            ! Not a correct Tool Code
            r_RFL_ProgError;
        ENDTEST
        !
        ! Execute only when place tool true is
        IF b_Tc11_PlaceTool=TRUE THEN
            !
            ! Move in pre position
            !*MoveJ p_Tc11_PrePosTB,vTcMax,z50,tTc11\WObj:=ob_Tc11_Toolbox;
            MoveJ Offs(p_Tc11_PlacePosTB,0,0,n_Tc_OffsZ3),vTcMax,z100,tTc11\WObj:=ob_Tc11;
            !
            ! Move over place position
            MoveJ Offs(p_Tc11_PlacePosTB,0,0,n_Tc_OffsZ2),vTcMax,z50,tTc11\WObj:=ob_Tc11;
            !
            ! Reset current Tool
            r_Tc11_ResTool n_Tc11_PlaceCode;
            !
            ! Move close to tool holder position
            MoveL Offs(p_Tc11_PlacePosTB,0,0,n_Tc_OffsZ1),vTcMed,z10,tTc11\WObj:=ob_Tc11;
            !
            ! Move to place position
            MoveL p_Tc11_PlacePosTB,vTcMin,fine,tTc11\WObj:=ob_Tc11;
            !
            ! Disconnect current tool
            r_Tc11_DisconTool n_Tc11_PlaceCode;
            !
            ! Set Placeholder no Tool
            n_Tc11_CurToolCode:=n_Tc_CodeForNoTool;
            !
            ! All tool signals off
            r_Tc11_ToolSigOff;
            !
            ! Realese tool
            r_Tc11_Unlock;
            !
            ! Move out of tool
            MoveL Offs(p_Tc11_PlacePosTB,0,n_Tc_OffsY1,0),vTcMin,z10,tTc11\WObj:=ob_Tc11;
            !
            ! Move away from tool place
            MoveL Offs(p_Tc11_PlacePosTB,0,n_Tc_OffsY2,0),vTcMed,z10,tTc11\WObj:=ob_Tc11;
            !
            ! Move over Toolbox when picking is not activated
            IF b_Tc11_PickTool=FALSE THEN
                !
                ! Move away from tool place
                MoveL Offs(p_Tc11_PlacePosTB,0,n_Tc_OffsY2,n_Tc_OffsZ2),vTcMed,z10,tTc11\WObj:=ob_Tc11;
                !
                ! Move in pre position
                MoveJ Offs(p_Tc11_PlacePosTB,0,n_Tc_OffsY2,n_Tc_OffsZ3),vTcMax,z50,tTc11\WObj:=ob_Tc11;
            ENDIF
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Move from place to pick pos
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_MovFrmPlaToPic()
        !
        ! Move over inter pos when the pick position is not
        ! direct reacheable
        TEST n_Tc11_PlaceCode
        CASE 1:
            !
            ! Tool 1 = Woodgripper with sensor
            TEST n_Tc11_PickCode
            CASE 2,3,5:
                !
                ! Tool 2 = Spindels
                ! Tool 3 = Woodgripper without sensors
                ! Tool 5 = Vacuum Tool 2
                ! Move direct posible
            CASE 4:
                !
                ! Tool 4 = Vacuum Tool 1
                ! Move over inter pos
                MoveL p_Tc11_InterPos_T2,vTcMed,z100,tTc11\WObj:=ob_Tc11_Toolbox;
            DEFAULT:
                !
                ! Situation not denied
                r_RFL_ProgError;
            ENDTEST
        CASE 2:
            ! 
            ! Tool 2 = Spindels
            TEST n_Tc11_PickCode
            CASE 1,3,4,5:
                !
                ! Tool 1 = Woodgripper with sensor
                ! Tool 3 = Woodgripper without sensors
                ! Tool 4 = Vacuum Tool 1
                ! Tool 5 = Vacuum Tool 2
                ! Move direct posible
            DEFAULT:
                !
                ! Situation not denied
                r_RFL_ProgError;
            ENDTEST
        CASE 3:
            !
            ! Tool 3 = Woodgripper without sensors
            TEST n_Tc11_PickCode
            CASE 1,2,4:
                !
                ! Tool 1 = Woodgripper with sensor
                ! Tool 2 = Spindels
                ! Tool 4 = Vacuum Tool 1
                ! Move direct posible
            CASE 5:
                !
                ! Tool 5 = Vacuum Tool 2
                ! Move over inter pos
                MoveL p_Tc11_InterPos_T2,vTcMed,z100,tTc11\WObj:=ob_Tc11_Toolbox;
            DEFAULT:
                !
                ! Situation not denied
                r_RFL_ProgError;
            ENDTEST
        CASE 4:
            !
            ! Tool 4 = Vacuum Tool 1
            TEST n_Tc11_PickCode
            CASE 2,3,4:
                !
                ! Tool 2 = Spindels
                ! Tool 3 = Woodgripper without sensors
                ! Tool 4 = Vacuum Tool 1
                ! Move direct posible
            CASE 1,5:
                !
                ! Tool 1 = Woodgripper with sensor
                ! Tool 5 = Vacuum Tool 2
                ! Move over inter pos
                MoveL p_Tc11_InterPos_T2,vTcMed,z100,tTc11\WObj:=ob_Tc11_Toolbox;
            DEFAULT:
                !
                ! Situation not denied
                r_RFL_ProgError;
            ENDTEST
        CASE 5:
            !
            ! Tool 5 = Vacuum Tool 2
            TEST n_Tc11_PickCode
            CASE 1,2:
                !
                ! Tool 1 = Woodgripper with sensor
                ! Tool 2 = Spindels
                ! Move direct posible
            CASE 3,4:
                !
                ! Tool 3 = Woodgripper without sensors
                ! Tool 4 = Vacuum Tool 1
                ! Move over inter pos
                MoveL p_Tc11_InterPos_T2,vTcMed,z100,tTc11\WObj:=ob_Tc11_Toolbox;
            DEFAULT:
                !
                ! Situation not denied
                r_RFL_ProgError;
            ENDTEST
        DEFAULT:
            !
            ! Situation not denied
            r_RFL_ProgError;
        ENDTEST
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize current tool
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.15
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_InitTool(num nToolNr)
        ! 
        ! Conect current alias signals
        r_Tc11_ConTool nToolNr;
        !
        ! Initialize current tool load
        r_Tc11_UpdateToolLoad nToolNr;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize current tool signls
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_ConTool(num nToolNr)
        !
        ! Reset current tool
        TEST nToolNr
        CASE 1:
            !
            ! Tool 1 = Woodgripper with sensor
            r_Tc11_T1_ConAliSig;
        CASE 2:
            !
            ! Tool 2 = Spindels
            r_Tc11_T2_ConAliSig;
        CASE 3:
            !
            ! Tool 3 = Woodgripper without sensors
            r_Tc11_T3_ConAliSig;
        CASE 4:
            !
            ! Tool 4 = Vacuum Tool 1
            r_Tc11_T4_ConAliSig;
        CASE 5:
            !
            ! Tool 5 = Vacuum Tool 2
            r_Tc11_T5_ConAliSig;
        CASE 6:
            !
            ! Tool 6 = Woodgripper without sensors MAS2018
            r_Tc11_T6_ConAliSig;
        CASE n_Tc_CodeForNoTool:
            !
            ! No Tool
        DEFAULT:
            !
            ! Not a correct Tool Code
            r_RFL_ProgError;
        ENDTEST
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Disconnect current tool
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_DisconTool(num nToolNr)
        !
        ! Reset current tool
        TEST nToolNr
        CASE 1:
            !
            ! Tool 1 = Woodgripper with sensor
            r_Tc11_T1_DisconAliSig;
        CASE 2:
            !
            ! Tool 2 = Spindels
            r_Tc11_T2_DisconAliSig;
        CASE 3:
            !
            ! Tool 3 = Woodgripper without sensors
            r_Tc11_T3_DisconAliSig;
        CASE 4:
            !
            ! Tool 4 = Vacuum Tool 1
            r_Tc11_T4_DisconAliSig;
        CASE 5:
            !
            ! Tool 5 = Vacuum Tool 2
            r_Tc11_T5_DisconAliSig;
        CASE 6:
            !
            ! Tool 6 = Woodgripper without sensors MAS2018
            r_Tc11_T6_DisconAliSig;
        DEFAULT:
            !
            ! Not a correct Tool Code
            r_RFL_ProgError;
        ENDTEST
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Update tool load
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_UpdateToolLoad(num nToolNr)
        !
        ! Reset current tool
        TEST nToolNr
        CASE 1:
            !
            ! Tool 1 = Woodgripper with sensor
            tTc11.tload:=ld_Tc11_T1;
        CASE 2:
            !
            ! Tool 2 = Spindels
            tTc11.tload:=ld_Tc11_T2;
        CASE 3:
            !
            ! Tool 3 = Woodgripper without sensors
            tTc11.tload:=ld_Tc11_T3;
        CASE 4:
            !
            ! Tool 4 = Vacuum Tool 1
            tTc11.tload:=ld_Tc11_T4;
        CASE 5:
            !
            ! Tool 5 = Vacuum Tool 2
            tTc11.tload:=ld_Tc11_T5;
        CASE 6:
            !
            ! Tool 6 = Woodgripper without sensors MAS2018
            tTc11.tload:=ld_Tc11_T6;
        CASE n_Tc_CodeForNoTool:
            !
            ! No Tool
            tTc11.tload:=ld_Tc11_NoTool;
        DEFAULT:
            !
            ! Not a correct Tool Code
            r_RFL_ProgError;
        ENDTEST
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Reset current tool
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_ResTool(num nToolNr)
        !
        ! Reset current tool
        TEST nToolNr
        CASE 1:
            !
            ! Tool 1 = Woodgripper with sensor
            r_Tc11_T1_ResTool;
        CASE 2:
            !
            ! Tool 2 = Spindels
            r_Tc11_T2_ResTool;
        CASE 3:
            !
            ! Tool 3 = Woodgripper without sensors
            r_Tc11_T3_ResTool;
        CASE 4:
            !
            ! Tool 4 = Vacuum Tool 1
            r_Tc11_T4_ResTool;
        CASE 5:
            !
            ! Tool 5 = Vacuum Tool 2
            r_Tc11_T5_ResTool;
        DEFAULT:
            !
            ! Not a correct Tool Code
            r_RFL_ProgError;
        ENDTEST
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     All tool signals off
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_ToolSigOff()
        !
        ! Set Signals
        SetDO doTc11Valve1A,0;
        SetDO doTc11Valve1B,0;
        !
        SetDO doTc11Res5,0;
        SetDO doTc11Res6,0;
        SetDO doTc11Res7,0;
        SetDO doTc11Res8,0;
        !
        SetDO doTc11PowerOn1,0;
        SetDO doTc11PowerOn2,0;
        SetDO doTc11PowerOn3,0;
        !
        SetDO doTc11Res12,0;
        !
        SetDO doTc11BtnLedOn,0;
        !
        SetDO doTc11Res14,0;
        SetDO doTc11Res15,0;
        !
        SetDO doTc11ToOut1,0;
        !
        ! Log Msg 
        rLogMsg st_Tc11_MsgHeader,"Reset done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Lock tool
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_Lock()
        !
        ! Set Signals
        SetDO doTc11Unlock,0;
        SetDo doTc11Lock,1;
        !
        ! Sensors must be integrated 
        !
        ! Time for action
        WaitTime nTime_Tc_Lock;
        !
        ! Update Variable
        b_Tc11_NoTool:=FALSE;
        !
        ! Log Msg 
        rLogMsg st_Tc11_MsgHeader,"Lock tool done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Unlock tool
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_Unlock()
        !
        ! Check unlock not done
        IF NOT (DOutput(doTC11Lock)=0 AND DOutput(doTC11Unlock)=1) THEN
            !
            ! Set Signals
            SetDo doTC11Lock,0;
            SetDO doTC11Unlock,1;
            !
            ! Update Variable
            b_Tc11_NoTool:=TRUE;
            !
            ! Time for action
            WaitTime nTime_Tc_Unlock;
            !
            ! Log Msg 
            rLogMsg st_Tc11_MsgHeader,"Unlock done";
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !***********************************************************************************
    ! Functions 
    !***********************************************************************************

    !************************************************
    ! Function    :     User Interface Tool Selection
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    FUNC num f_Tc11_ToolSelection(\string stAddText)
        VAR string stAddHeader;
        !
        ! Check add text present 
        IF Present(stAddText) THEN
            !
            ! Take text to add
            stAddHeader:=stAddText;
        ELSE
            !
            ! Set Placeholder
            stAddHeader:=" ";
        ENDIF
        !
        ! View Window Tool selection
        nUiListItem:=UIListView(
                    \Result:=btnAnswer
                    \Header:="Tool-Changer 11 "+stAddHeader,
                    liTC11WinToolSelection
                    \BtnArray:=stBtnOkExit
                    \Icon:=iconInfo
                    \DefaultIndex:=1);
        !
        ! Check answer
        IF btnAnswer=resOK THEN
            !
            ! Check posibility 
            IF nUiListItem>0 AND nUiListItem<=n_Tc_NumOfTools THEN
                !
                ! Ok
            ELSE
                !
                ! Not Ok
                r_RFL_ProgError;
            ENDIF
        ELSE
            ! 
            ! User has select Exit
            nUiListItem:=0;
        ENDIF
        RETURN nUiListItem;
    ERROR
        ! Placeholder for Error Code...
    ENDFUNC

    !************************************************
    ! Function    :     Check current tool code
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    !***************** ETH Zurich *******************
    !
    FUNC num f_Tc11_CheckCurToolCode()
        VAR string stMsg{5}:=["","","","",""];
        !
        ! Init Var
        b_Tc11_SimTool:=FALSE;
        !
        ! Read current toon code
        n_Tc11_CurToolCode:=giTc11Code;
        !
        ! Check current tool code
        IF n_Tc11_CurToolCode>0 AND n_Tc11_CurToolCode<=n_Tc_NumOfTools THEN
            !
            ! Toolcode ok
            !
            ! Update Variable
            b_Tc11_NoTool:=FALSE;
        ELSEIF b_Tc11_NoTool=TRUE THEN
            !
            ! No Tool
            !
            ! Set Placeholder no Tool
            n_Tc11_CurToolCode:=n_Tc_CodeForNoTool;
        ELSE
            !
            ! Toolcode not ok
            stMsg{1}:="Current Tool Code is not possible!";
            stMsg{2}:="Current Code is: "+NumToStr(n_Tc11_CurToolCode,0);
            stMsg{3}:="";
            stMsg{4}:="Yes = Sim Tool";
            stMsg{5}:="No  = Exit";
            !
            ! User Msg
            nAnswer:=UIMessageBox(
                \Header:="Tool-Changer 11"
                \MsgArray:=stMsg
                \BtnArray:=st_Tc11_BtnToolSim
                \Icon:=iconWarning);
            !
            ! Check answer
            IF nAnswer=1 THEN
                !
                ! No Tool
                !
                ! Set Placeholder no Tool
                n_Tc11_CurToolCode:=n_Tc_CodeForNoTool;
                !
                ! Update Variable
                b_Tc11_NoTool:=TRUE;
            ELSE
                !
                ! Sim
                !
                ! Acitvat tool simulation
                b_Tc11_SimTool:=TRUE;
                !
                ! Set tool code for simulation
                n_Tc11_CurToolCode:=f_Tc11_ToolSelection(\stAddText:="Sim Tool");
                !
                ! Update Variable
                b_Tc11_NoTool:=FALSE;
            ENDIF
        ENDIF
        RETURN n_Tc11_CurToolCode;
    ERROR
        !
        ! Try next when unit not available 
        IF ERRNO=ERR_NORUNUNIT TRYNEXT;
    ENDFUNC

    !************************************************
    ! Function    :     Check next tool Code
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    !***************** ETH Zurich *******************
    !
    FUNC num f_Tc11_CheckNextToolCode(num nNextToolCode)
        !
        !
        ! Check current tool code
        IF nNextToolCode>0 AND nNextToolCode<=n_Tc_NumOfTools THEN
            !
            ! Toolcode ok
        ELSE
            !
            ! Toolcode not ok
            !
            ! User Msg
            UIMsgBox
                \Header:="Tool-Changer 11","Next Tool Code is not possible!"
                \MsgLine2:="Next Code is: "+NumToStr(nNextToolCode,0)
                \MsgLine3:=""
                \MsgLine4:=""
                \MsgLine5:=""
                \Buttons:=btnOk
                \Icon:=iconError
                \Result:=btnAnswer;
            !
            ! Cancel tool place and pick
            b_Tc11_PlaceTool:=FALSE;
            b_Tc11_PickTool:=FALSE;
        ENDIF
        RETURN nNextToolCode;
    ERROR
        ! Placeholder for Error Code...
    ENDFUNC

    !************************************************
    ! Function    :     Tool-Changer Button confirmation 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.27
    ! **************** ETH Zurich *******************
    !
    FUNC bool f_Tc11_ButtonConfirmation()
        VAR bool bBtnFlag;
        ! 
        ! Init variables
        bBtnFlag:=FALSE;
        !
        ! Button led on
        SetDo doTc11BtnLedOn,1;
        !
        ! Msg for user push the button
        nAnswer:=UIMessageBox(
            \Header:="Tool-Changer 11"
            \MsgArray:=["For using manual lock and unlock","confirm this message with the hardware button","on the robot pack bag"]
            \BtnArray:=stBtnExit
            \Icon:=iconWarning
            \DIBreak:=diTc11Btn);
        !
        ! Button led off
        SetDo doTc11BtnLedOn,0;
        ! 
        ! Check result
        IF bBtnFlag=TRUE THEN
            !
            ! Confirm button pressed
            RETURN TRUE;
        ELSE
            !
            ! Exit 
            RETURN FALSE;
        ENDIF
    ERROR
        !
        ! Check for button
        IF ERRNO=ERR_TP_DIBREAK THEN
            !
            ! Confirm button pressed
            bBtnFlag:=TRUE;
            TRYNEXT;
        ENDIF
    ENDFUNC

    !***********************************************************************************
    ! Tool 1 = Woodgripper with sensor
    !***********************************************************************************

    !************************************************
    ! Function    :     Connect alias signals for 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T1_ConAliSig()
        !
        ! Inputs
        AliasIO diTc11ToIn1,di_Tc11_T1Gr1Open;
        AliasIO diTc11ToIn2,di_Tc11_T1Gr1Close;
        AliasIO diTc11ToIn3,di_Tc11_T1Gr2Open;
        AliasIO diTc11ToIn4,di_Tc11_T1Gr2Close;
        !
        ! Outputs
        AliasIO doTc11Valve1A,do_Tc11_T1GrOff;
        AliasIO doTc11Valve1B,do_Tc11_T1GrOn;
        AliasIO doTc11ToOut1,do_Tc11_T1EdgeSenOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T1MsgHeader,"Connect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Disconnect all alias signals
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_T1_DisconAliSig()
        !
        ! Inputs
        AliasIOReset di_Tc11_T1Gr1Open;
        AliasIOReset di_Tc11_T1Gr1Close;
        AliasIOReset di_Tc11_T1Gr2Open;
        AliasIOReset di_Tc11_T1Gr2Close;
        !
        ! Outputs
        AliasIOReset do_Tc11_T1GrOff;
        AliasIOReset do_Tc11_T1GrOn;
        AliasIOReset do_Tc11_T1EdgeSenOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T1MsgHeader,"Disonnect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Gripper on
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T1_GrOn()
        !
        ! Set Signals
        SetDO do_Tc11_T1GrOff,0;
        SetDO do_Tc11_T1GrOn,1;
        !
        ! Time for action
        WaitTime nTime_Tc11_T1GripOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T1MsgHeader,"Gripper on done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Gripper off
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T1_GrOff()
        !
        ! Set Signals
        SetDO do_Tc11_T1GrOn,0;
        SetDO do_Tc11_T1GrOff,1;
        !
        ! Time for action
        WaitTime nTime_Tc11_T1GripOff;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T1MsgHeader,"Gripper off done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Edge Sensor on
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T1_EdgeSenOn()
        !
        ! Set Signals
        SetDO do_Tc11_T1EdgeSenOn,1;
        !
        ! Time for action
        WaitTime nTime_Tc11_T1EdgeSenOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T1MsgHeader,"Edge Sensor on done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Edge Sensor off
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T1_EdgeSenOff()
        !
        ! Set Signals
        SetDO do_Tc11_T1EdgeSenOn,0;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T1MsgHeader,"Edge Sensor off done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Reset Tool 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T1_ResTool()
        !
        ! Switch Edge Sensor off
        r_Tc11_T1_EdgeSenOff;
        !
        ! When the gripper is not open then safe check
        IF di_Tc11_T1Gr1Open=0 OR di_Tc11_T1Gr1Open=0 THEN
            !
            ! Safe check
            r_Tc11_SafInfo "Open the Gripper ?";
        ENDIF
        !
        ! Open gripper when safe
        IF b_Tc11_ToolSafe=TRUE r_Tc11_T1_GrOff;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T1MsgHeader,"Reset tool done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !***********************************************************************************
    ! Tool 2 = Spindels
    !***********************************************************************************

    !************************************************
    ! Function    :     Connect alias signals for 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T2_ConAliSig()
        !
        ! Inputs
        !
        ! Outputs
        AliasIO doTc11PowerOn1,do_Tc11_T2MillOn;
        AliasIO doTc11PowerOn2,do_Tc11_T2DrillOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T2MsgHeader,"Connect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Disconnect all alias signals
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_T2_DisconAliSig()
        !
        ! Inputs
        !
        ! Outputs
        AliasIOReset do_Tc11_T2MillOn;
        AliasIOReset do_Tc11_T2DrillOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T2MsgHeader,"Disonnect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Mill On
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.04.26
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T2_MillOn()
        !
        ! Set Signals
        SetDO do_Tc11_T2DrillOn,0;
        SetDO do_Tc11_T2MillOn,1;
        !
        ! Time for action
        WaitTime\InPos,nTime_Tc11_T2PowerpOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T2MsgHeader,"Mill on done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Drill On
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.04.26
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T2_DrillOn()
        !
        ! Set Signals
        SetDO do_Tc11_T2MillOn,0;
        SetDO do_Tc11_T2DrillOn,1;
        !
        ! Time for action
        WaitTime\InPos,nTime_Tc11_T2PowerpOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T2MsgHeader,"Drill on done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Mill and Drill Off
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.04.26
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T2_MillDrillOff()
        !
        ! Set Signals
        SetDO do_Tc11_T2MillOn,0;
        SetDO do_Tc11_T2DrillOn,0;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T2MsgHeader,"Mill and Drill off done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Reset Tool 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T2_ResTool()
        !
        ! Switch Mill and Drill off
        r_Tc11_T2_MillDrillOff;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T2MsgHeader,"Reset tool done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !***********************************************************************************
    ! Tool 3 = Woodgripper without sensors
    !***********************************************************************************

    !************************************************
    ! Function    :     Connect alias signals for 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T3_ConAliSig()
        !
        ! Inputs
        !
        ! Outputs
        AliasIO doTc11Valve1A,do_Tc11_T3GrOff;
        AliasIO doTc11Valve1B,do_Tc11_T3GrOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T3MsgHeader,"Connect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Disconnect all alias signals
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_T3_DisconAliSig()
        !
        ! Inputs
        !
        ! Outputs
        AliasIOReset do_Tc11_T3GrOff;
        AliasIOReset do_Tc11_T3GrOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T3MsgHeader,"Disonnect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Gripper on
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T3_GrOn()
        !
        ! Set Signals
        SetDO do_Tc11_T3GrOff,0;
        SetDO do_Tc11_T3GrOn,1;
        !
        ! Time for action
        WaitTime nTime_Tc11_T3GripOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T3MsgHeader,"Gripper on done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Gripper off
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T3_GrOff()
        !
        ! Set Signals
        SetDO do_Tc11_T3GrOn,0;
        SetDO do_Tc11_T3GrOff,1;
        !
        ! Time for action
        WaitTime nTime_Tc11_T3GripOff;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T3MsgHeader,"Gripper off done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Reset Tool 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T3_ResTool()
        !
        ! When the gripper is not open then safe check
        IF NOT (DOutput(do_Tc11_T3GrOn)=0 AND DOutput(do_Tc11_T3GrOff)=1) THEN
            !
            ! Safe check
            r_Tc11_SafInfo "Open the Gripper ?";
        ENDIF
        !
        ! Open gripper when safe
        IF b_Tc11_ToolSafe=TRUE r_Tc11_T3_GrOff;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T3MsgHeader,"Reset tool done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !***********************************************************************************
    ! Tool 4 = Vacuum Tool 1
    !***********************************************************************************

    !************************************************
    ! Function    :     Connect alias signals for 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T4_ConAliSig()
        !
        ! Inputs
        !
        ! Outputs
        AliasIO doTc11Valve1A,do_Tc11_T4VacuumOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T4MsgHeader,"Connect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Disconnect all alias signals
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_T4_DisconAliSig()
        !
        ! Inputs
        !
        ! Outputs
        AliasIOReset do_Tc11_T4VacuumOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T4MsgHeader,"Disonnect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Vacuum on
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T4_VacuumOn()
        !
        ! Vacuum on
        SetDo do_Tc11_T4VacuumOn,1;
        !
        ! Agition time
        WaitTime nTime_Tc11_T4VacuumOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T4MsgHeader,"Vacuum on done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Vacuum off
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T4_VacuumOff()
        !
        ! Vacuum on
        SetDo do_Tc11_T4VacuumOn,0;
        !
        ! Agition time
        WaitTime nTime_Tc11_T4VacuumOff;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T4MsgHeader,"Vacuum off done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Reset Tool 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T4_ResTool()
        !
        ! When the vauum is activeted then safe check
        IF DOutput(do_Tc11_T4VacuumOn)=1 THEN
            !
            ! Safe check
            r_Tc11_SafInfo "Switch off the Vacuum ?";
        ENDIF
        !
        ! Switch vacuum off when safe
        IF b_Tc11_ToolSafe r_Tc11_T4_VacuumOff;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T4MsgHeader,"Reset tool done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !***********************************************************************************
    ! Tool 5 = Vacuum Tool 2
    !***********************************************************************************

    !************************************************
    ! Function    :     Connect alias signals for 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T5_ConAliSig()
        !
        ! Inputs
        !
        ! Outputs
        AliasIO doTc11Valve1A,do_Tc11_T5VacuumOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T5MsgHeader,"Connect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Disconnect all alias signals
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_T5_DisconAliSig()
        !
        ! Inputs
        !
        ! Outputs
        AliasIOReset do_Tc11_T5VacuumOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T5MsgHeader,"Disonnect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Vacuum on
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T5_VacuumOn()
        !
        ! Vacuum on
        SetDo do_Tc11_T5VacuumOn,1;
        !
        ! Agition time
        WaitTime nTime_Tc11_T5VacuumOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T5MsgHeader,"Vacuum on done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Vacuum off
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T5_VacuumOff()
        !
        ! Vacuum on
        SetDo do_Tc11_T5VacuumOn,0;
        !
        ! Agition time
        WaitTime nTime_Tc11_T5VacuumOff;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T5MsgHeader,"Vacuum off done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Reset Tool 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T5_ResTool()
        !
        ! When the vauum is activeted then safe check
        IF DOutput(do_Tc11_T5VacuumOn)=1 THEN
            !
            ! Safe check
            r_Tc11_SafInfo "Switch off the Vacuum ?";
        ENDIF
        !
        ! Switch vacuum off when safe
        IF b_Tc11_ToolSafe r_Tc11_T5_VacuumOff;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T5MsgHeader,"Reset tool done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !***********************************************************************************
    ! Tool 6 = Woodgripper without sensors MAS 2018
    !***********************************************************************************

    !************************************************
    ! Function    :     Connect alias signals for 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2015.05.02
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T6_ConAliSig()
        !
        ! Inputs
        !
        ! Outputs
        AliasIO doTc11Valve1A,do_Tc11_T6GrOff;
        AliasIO doTc11Valve1B,do_Tc11_T6GrOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T6MsgHeader,"Connect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Disconnect all alias signals
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2015.05.02
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_T6_DisconAliSig()
        !
        ! Inputs
        !
        ! Outputs
        AliasIOReset do_Tc11_T6GrOff;
        AliasIOReset do_Tc11_T6GrOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T6MsgHeader,"Disonnect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Gripper on
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2015.05.02
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T6_GrOn()
        !
        ! Set Signals
        SetDO do_Tc11_T6GrOff,0;
        SetDO do_Tc11_T6GrOn,1;
        !
        ! Time for action
        WaitTime nTime_Tc11_T6GripOn;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T6MsgHeader,"Gripper on done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Gripper off
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2015.05.02
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T6_GrOff()
        !
        ! Set Signals
        SetDO do_Tc11_T6GrOn,0;
        SetDO do_Tc11_T6GrOff,1;
        !
        ! Time for action
        WaitTime nTime_Tc11_T6GripOff;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T6MsgHeader,"Gripper off done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Reset Tool 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2015.05.02
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc11_T6_ResTool()
        !
        ! When the gripper is not open then safe check
        IF NOT (DOutput(do_Tc11_T6GrOn)=0 AND DOutput(do_Tc11_T6GrOff)=1) THEN
            !
            ! Safe check
            r_Tc11_SafInfo "Open the Gripper ?";
        ENDIF
        !
        ! Open gripper when safe
        IF b_Tc11_ToolSafe=TRUE r_Tc11_T6_GrOff;
        !
        ! Log Msg 
        rLogMsg st_Tc11_T6MsgHeader,"Reset tool done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !***********************************************************************************
    ! Teaching
    !***********************************************************************************

    !************************************************
    ! Function    :     Create workobjects from Teach Points
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    !***************** ETH Zurich *******************
    !
    PROC r_Tc11_CreateWorkobjects()
        !
        ! 1. Move the Robot over teach point with the locked tool  
        ! 2. Move the Robot manual in teach position
        ! 3. Modify Teachpoint 
        ! 4. Check the move in the tool maybe correct the teaching point manually
        ! 5. Update the workobject
        !
        !************************************************
        ! Tool 1 = Woodgripper with sensor
        !************************************************
        !
        ! Move over teach point 
        MoveJ Offs(p_Tc11_T1_TeachPoint,0,0,300),v100,fine,tTc11\WObj:=wobj0;
        !
        !
        ! Modify teach point 
        MoveL Offs(p_Tc11_T1_TeachPoint,0,25,0),v10,fine,tTc11\WObj:=wobj0;
        !MoveL Offs(p_Tc11_T1_TeachPoint,0,10,0),v10,fine,tTc11\WObj:=wobj0;
        MoveL p_Tc11_T1_TeachPoint,v10,fine,tTc11\WObj:=wobj0;
        !
        ! Update workobjekt 
        ob_Tc11_T1:=fCreateFream(tTc11\poOffset:=po_Tc11_Offset);
        !
        ! Move away from teach point 
        MoveL Offs(p_Tc11_T1_TeachPoint,0,100,0),v20,fine,tTc11\WObj:=wobj0;
        !
        !************************************************
        ! Tool 2 = Spindels
        !************************************************
        !
        ! Move over teach point 
        MoveJ Offs(p_Tc11_T2_TeachPoint,0,0,300),v100,fine,tTc11\WObj:=wobj0;
        !
        !
        ! Modify teach point 
        MoveL Offs(p_Tc11_T2_TeachPoint,0,25,0),v10,fine,tTc11\WObj:=wobj0;
        MoveL Offs(p_Tc11_T2_TeachPoint,0,10,0),v10,fine,tTc11\WObj:=wobj0;
        MoveL p_Tc11_T2_TeachPoint,v10,fine,tTc11\WObj:=wobj0;
        !
        ! Update workobjekt 
        ob_Tc11_T2:=fCreateFream(tTc11\poOffset:=po_Tc11_Offset);
        !
        ! Move away from teach point 
        MoveL Offs(p_Tc11_T2_TeachPoint,0,100,0),v20,fine,tTc11\WObj:=wobj0;
        !
        !************************************************
        ! Tool 3 = Woodgripper without sensors
        !************************************************
        !
        ! Move over teach point 
        MoveJ Offs(p_Tc11_T3_TeachPoint,0,0,300),v100,fine,tTc11\WObj:=wobj0;
        !
        !
        ! Modify teach point 
        MoveL Offs(p_Tc11_T3_TeachPoint,0,25,0),v10,fine,tTc11\WObj:=wobj0;
        MoveL Offs(p_Tc11_T3_TeachPoint,0,10,0),v10,fine,tTc11\WObj:=wobj0;
        MoveL p_Tc11_T3_TeachPoint,v10,fine,tTc11\WObj:=wobj0;
        !
        ! Update workobjekt 
        ob_Tc11_T3:=fCreateFream(tTc11\poOffset:=po_Tc11_Offset);
        !
        ! Move away from teach point 
        MoveL Offs(p_Tc11_T3_TeachPoint,0,100,0),v20,fine,tTc11\WObj:=wobj0;
        !
        !************************************************
        ! Tool 4 = Vacuum Tool 1
        !************************************************
        !
        ! Move over teach point 
        MoveJ Offs(p_Tc11_T4_TeachPoint,0,0,300),v100,fine,tTc11\WObj:=wobj0;
        !
        !
        ! Modify teach point 
        MoveL Offs(p_Tc11_T4_TeachPoint,0,25,0),v10,fine,tTc11\WObj:=wobj0;
        MoveL Offs(p_Tc11_T4_TeachPoint,0,10,0),v10,fine,tTc11\WObj:=wobj0;
        MoveL p_Tc11_T4_TeachPoint,v10,fine,tTc11\WObj:=wobj0;
        !
        ! Update workobjekt 
        ob_Tc11_T4:=fCreateFream(tTc11\poOffset:=po_Tc11_Offset);
        !
        ! Move away from teach point 
        MoveL Offs(p_Tc11_T4_TeachPoint,0,100,0),v20,fine,tTc11\WObj:=wobj0;
        !
        !************************************************
        ! Tool 5 = Vacuum Tool 2
        !************************************************
        !
        !
        ! Move over teach point 
        MoveJ Offs(p_Tc11_T5_TeachPoint,0,0,300),v100,fine,tTc11\WObj:=wobj0;
        !
        !
        ! Modify teach point 
        MoveL Offs(p_Tc11_T5_TeachPoint,0,25,0),v10,fine,tTc11\WObj:=wobj0;
        MoveL Offs(p_Tc11_T5_TeachPoint,0,10,0),v10,fine,tTc11\WObj:=wobj0;
        MoveL p_Tc11_T5_TeachPoint,v10,fine,tTc11\WObj:=wobj0;
        !
        ! Update workobjekt 
        ob_Tc11_T5:=fCreateFream(tTc11\poOffset:=po_Tc11_Offset);
        !
        ! Move away from teach point 
        MoveL Offs(p_Tc11_T5_TeachPoint,0,100,0),v20,fine,tTc11\WObj:=wobj0;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     RobotStudio Path 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_RobotStudioPath()
        !
        ! Configuartion switch
        ConfJ\On;
        !
        ! Station Toolbox 
        MoveAbsJ jp_Tc11_StaPosTB,vRFLMax,z100,tool0;
        !
        ! Move to place position
        MoveJ p_Tc11_T1_PlaInTB,vRFLMax,fine,tTc11\WObj:=ob_Tc11_T1;
        !
        ! Move to place position
        MoveJ p_Tc11_T2_PlaInTB,vRFLMax,fine,tTc11\WObj:=ob_Tc11_T2;
        !
        ! Move to place position
        MoveJ p_Tc11_T3_PlaInTB,vRFLMax,fine,tTc11\WObj:=ob_Tc11_T3;
        !
        ! Move to place position
        MoveJ p_Tc11_T4_PlaInTB,vRFLMax,fine,tTc11\WObj:=ob_Tc11_T4;
        !
        ! Move to place position
        MoveJ p_Tc11_T5_PlaInTB,vRFLMax,fine,tTc11\WObj:=ob_Tc11_T5;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE
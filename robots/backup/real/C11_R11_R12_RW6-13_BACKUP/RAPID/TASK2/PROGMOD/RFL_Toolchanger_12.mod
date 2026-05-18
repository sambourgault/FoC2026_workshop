MODULE RFL_Toolchanger_12
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  RFL Tool Changer Robot 12
    !
    ! FUNCTION    :  Inclouds all tool changer featuers
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2017.09.28 Draft
    !
    ! Copyright   :  ETH Zurich (CH) 2017
    !
    !***********************************************************************************
    ! Description of Module 
    !***********************************************************************************
    !
    ! General:
    ! RFL Tc12 (Master menue)
    ! RFL Tc11 (Master menue)
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
    TASK PERS bool b_Tc12_ToolSafe:=TRUE;
    TASK PERS bool b_Tc12_PlaceTool:=FALSE;
    TASK PERS bool b_Tc12_PickTool:=TRUE;
    TASK PERS bool b_Tc12_SimTool:=FALSE;
    TASK PERS bool b_Tc12_NoTool:=TRUE;
    TASK PERS bool b_Tc12_WrongTool:=TRUE;

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
    CONST num n_Tc_NumOfTools:=7;
    CONST num n_Tc_CodeForNoTool:=99;
    !
    TASK PERS num n_Tc12_PickCode:=3;
    TASK PERS num n_Tc12_PlaceCode:=0;
    TASK PERS num n_Tc12_SimToolCode:=1;
    TASK PERS num n_Tc12_CurToolCode:=99;
    !
    ! Tool 1 = Woodgripper with sensor
    CONST num nTime_Tc12_T1GripOn:=5.0;
    CONST num nTime_Tc12_T1GripOff:=1.0;
    CONST num nTime_Tc12_T1EdgeSenOn:=1.0;
    !
    ! Tool 2 = Spindels
    CONST num nTime_Tc12_T2PowerpOn:=1.0;
    !
    ! Tool 3 = Woodgripper without sensors
    CONST num nTime_Tc12_T3GripOn:=1.0;
    CONST num nTime_Tc12_T3GripOff:=1.0;
    !
    ! Tool 4 = Vacuum Tool 1
    CONST num nTime_Tc12_T4VacuumOn:=1.0;
    CONST num nTime_Tc12_T4VacuumOff:=1.0;
    !
    ! Tool 5 = Vacuum Tool 5
    CONST num nTime_Tc12_T5VacuumOn:=1.0;
    CONST num nTime_Tc12_T5VacuumOff:=1.0;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    CONST string st_Tc12_MsgHeader:="TC12";
    CONST string st_Tc12_T1MsgHeader:="TC12 Tool 1";
    CONST string st_Tc12_T2MsgHeader:="TC12 Tool 2";
    CONST string st_Tc12_T3MsgHeader:="TC12 Tool 3";
    CONST string st_Tc12_T4MsgHeader:="TC12 Tool 4";
    CONST string st_Tc12_T5MsgHeader:="TC12 Tool 5";
    CONST string st_Tc12_T6MsgHeader:="TC12 Tool 6";
    !
    CONST string st_Tc12_BtnToolSim{2}:=["No Tool","Sim"];

    !************************************************
    ! Declaration :     tooldata
    !************************************************
    !
    TASK PERS tooldata tTc12:=[TRUE,[[0,0,83],[1,0,0,0]],[0.5,[0,0,30],[1,0,0,0],0,0,0]];

    !************************************************
    ! Declaration :     loaddata
    !************************************************
    !
    TASK PERS loaddata ld_Tc12_NoTool:=[0.5,[0,0,30],[1,0,0,0],0,0,0];
    TASK PERS loaddata ld_Tc12_T1:=[1,[0,0,30],[1,0,0,0],0,0,0];
    TASK PERS loaddata ld_Tc12_T2:=[2,[0,0,30],[1,0,0,0],0,0,0];
    TASK PERS loaddata ld_Tc12_T3:=[3,[0,0,30],[1,0,0,0],0,0,0];
    TASK PERS loaddata ld_Tc12_T4:=[4,[0,0,30],[1,0,0,0],0,0,0];
    TASK PERS loaddata ld_Tc12_T5:=[5,[0,0,30],[1,0,0,0],0,0,0];

    !************************************************
    ! Declaration :     wobjdata
    !************************************************
    !
    TASK PERS wobjdata ob_Tc12_Toolbox:=[FALSE,TRUE,"",[[9345.957,2618.161,237.703],[0.707106781,0.707106781,0,0]],[[216.3,10,0],[0.707106781,-0.707106781,0,0]]];
    !
    TASK PERS wobjdata ob_Tc12:=[FALSE,TRUE,"",[[8759.55,2578.59,465.036],[0.999987,-0.000950903,0.0048998,-0.000974447]],[[0,0,0],[1,0,0,0]]];
    !
    !* TASK PERS wobjdata ob_Tc12_T1:=[FALSE,TRUE,"",[[10357.4,2580.13,464.564],[0.999999,-0.000940651,-0.00100347,-1.57058E-05]],[[0,0,0],[1,0,0,0]]];
    TASK PERS wobjdata ob_Tc12_T1:=[FALSE,TRUE,"",[[10362.6,2582.4,467.065],[0.999999,1.91033E-05,0.00106716,0.00100848]],[[0,0,0],[1,0,0,0]]];
    TASK PERS wobjdata ob_Tc12_T2:=[FALSE,TRUE,"",[[9573.12,2580.2,464.968],[0.999984,0.00028719,0.00454219,0.00344454]],[[0,0,0],[1,0,0,0]]];
    TASK PERS wobjdata ob_Tc12_T3:=[FALSE,TRUE,"",[[8759.55,2578.59,465.036],[0.999987,-0.000950903,0.0048998,-0.000974447]],[[0,0,0],[1,0,0,0]]];
    TASK PERS wobjdata ob_Tc12_T4:=[FALSE,TRUE,"",[[7962.26,2668.16,471.703],[1,-1.04308E-07,4.47035E-08,-1.04308E-07]],[[0,0,0],[1,0,0,0]]];
    TASK PERS wobjdata ob_Tc12_T5:=[FALSE,TRUE,"",[[11155.6,2581.03,465.349],[0.999997,-1.5527E-05,0.00205088,0.00103393]],[[0,0,0],[1,0,0,0]]];

    !************************************************
    ! Declaration :     pose
    !************************************************
    !
    TASK PERS pose po_Tc12_WobjOFrame:=[[145,0,0],[0.707106781,-0.707106781,0,0]];
    TASK PERS pose po_Tc12_Offset:=[[-88,0,34],[0.5,-0.5,0.5,-0.5]];

    !************************************************
    ! Declaration :     jointtarget
    !************************************************
    !
    !* CONST jointtarget jp_Tc12_StaPosTB:=[[-90,-81.8555,-33.7341,180,-25.5895,-4.86651E-05],[9561.73,-4300,-4800,0,0,0]];
    CONST jointtarget jp_Tc12_StaPosTB:=[[90,100,-100,180,90,-180],[9561.73,-5900,-4800,0,0,0]];
    CONST jointtarget jp_Tc12_ToTB1_10:=[[90,25,-120,180,85,0],[9561.73,-2600,-4800,0,0,0]];
    !
    ! Path in Toolbox
    CONST jointtarget jp_Tc12_PathInTB1_10:=[[90,90,-90,180,90,-180],[9561.73,-5600,-4800,0,0,0]];
    CONST jointtarget jp_Tc12_PathInTB1_20:=[[90,55,-150,180,45,-90],[9561.73,-3600,-4800,0,0,0]];
    CONST jointtarget jp_Tc12_PathInTB1_30:=[[0,25,-120,180,85,0],[9561.73,-2600,-4800,0,0,0]];
    CONST jointtarget jp_Tc12_PathInTB1_40:=[[-90,35,-140,180,85,0],[9561.73,-2600,-4000,0,0,0]];

    !************************************************
    ! Declaration :     robtarget
    !************************************************
    !
    TASK PERS robtarget p_Tc12_PlacePosTB:=[[0,34,88],[0.5,0.5,-0.5,0.5],[-1,2,0,2],[9561.73,-2630,-3100,0,0,0]];
    TASK PERS robtarget p_Tc12_PickPosTB:=[[0,34,88],[0.5,0.5,-0.5,0.5],[-1,2,0,2],[9561.73,-2630,-3100,0,0,0]];
    TASK PERS robtarget p_Tc12_InterPosTB:=[[-0.00,150.00,88.00],[0.5,0.5,-0.5,0.5],[-1,1,0,2],[9561.73,-2600,-3300,0,0,0]];
    TASK PERS robtarget p_Tc12_InterPos_T2:=[[0.00,200.00,312.00],[0.5,0.5,-0.5,0.5],[-1,1,0,2],[9561.73,-2600,-3300,0,0,0]];
    !
    !TASK PERS robtarget p_Tc12_PrePosTB:=[[-0.52563273,72.816243796,1198.160883144],[0.500000223,0.499999749,-0.500000094,0.499999934],[-1,2,0,2],[9561.731338501,-2400,-4000,0,0,0]];
    !
    ! Tool 1 = Woodgripper with sensor    
    TASK PERS robtarget p_Tc12_T1_TeachPoint:=[[10362.7,2616.39,553],[0.500032,0.50105,-0.498965,0.499951],[-1,1,-1,2],[9561.73,-2600,-3099.98,0,0,0]];
    TASK PERS robtarget p_Tc12_T1_PlaInTB:=[[0,34,88],[0.5,0.5,-0.5,0.5],[-1,2,0,2],[9561.73,-2630,-3100,0,0,0]];
    !
    ! Tool 2 = Spindels
    TASK PERS robtarget p_Tc12_T2_TeachPoint:=[[9573.69,2614.09,553],[0.500409,0.504119,-0.496137,0.499302],[-1,1,-1,2],[9561.74,-2600.03,-3300.01,0,0,0]];
    TASK PERS robtarget p_Tc12_T2_PlaInTB:=[[0,34,88],[0.5,0.5,-0.5,0.5],[-1,2,0,2],[9561.73,-2630,-3300,0,0,0]];
    !
    ! Tool 3 = Woodgripper without sensors
    TASK PERS robtarget p_Tc12_T3_TeachPoint:=[[8760.47,2612.74,553],[0.503401,0.501491,-0.497544,0.497538],[-2,2,0,2],[9561.74,-2600,-3100,0,0,0]];
    TASK PERS robtarget p_Tc12_T3_PlaInTB:=[[0,34,88],[0.5,0.5,-0.5,0.5],[-1,2,0,2],[9561.73,-2630,-3100,0,0,0]];
    !
    ! Tool 4 = Vacuum Tool 1
    TASK PERS robtarget p_Tc12_T4_TeachPoint:=[[8755.58,2611.36,552.83],[0.500032,0.50105,-0.498965,0.499951],[-2,2,0,2],[9561.74,-2599.99,-3100,0,0,0]];
    TASK PERS robtarget p_Tc12_T4_PlaInTB:=[[0,34,88],[0.5,0.5,-0.5,0.5],[-1,2,0,2],[9561.73,-2630,-2600,0,0,0]];
    !
    ! Tool 5 = Vacuum Tool 2
    TASK PERS robtarget p_Tc12_T5_TeachPoint:=[[11155.87,2615.03,553.35],[0.500032,0.50105,-0.498965,0.499951],[-1,1,-1,2],[9561.74,-2599.98,-2599.99,0,0,0]];
    TASK PERS robtarget p_Tc12_T5_PlaInTB:=[[0,34,88],[0.5,0.5,-0.5,0.5],[-1,2,0,2],[9561.73,-2630,-2600,0,0,0]];

    !************************************************
    ! Declaration :     signaldi
    !************************************************
    !
    ! Tool 1 = Woodgripper with sensor
    VAR signaldi di_Tc12_T1Gr1Open;
    VAR signaldi di_Tc12_T1Gr1Close;
    VAR signaldi di_Tc12_T1Gr2Open;
    VAR signaldi di_Tc12_T1Gr2Close;

    !************************************************
    ! Declaration :     signaldo
    !************************************************
    !
    ! Tool 1 = Woodgripper with sensor
    VAR signaldo do_Tc12_T1GrOff;
    VAR signaldo do_Tc12_T1GrOn;
    VAR signaldo do_Tc12_T1EdgeSenOn;
    !
    ! Tool 2 = Spindels
    VAR signaldo do_Tc12_T2MillOn;
    VAR signaldo do_Tc12_T2DrillOn;
    !
    ! Tool 3 = Woodgripper without sensors
    VAR signaldo do_Tc12_T3GrOff;
    VAR signaldo do_Tc12_T3GrOn;
    !
    ! Tool 4 = Vacuum Tool 1
    VAR signaldo do_Tc12_T4VacuumOn;
    !
    ! Tool 5 = Vacuum Tool 2
    VAR signaldo do_Tc12_T5VacuumOn;

    !************************************************
    ! Declaration :     listitem
    !************************************************
    !
    CONST listitem liTc12Win{4}:=[["","Place Tool in Toolbox"],["","Pick Tool from Toolbox"],[""," "],["","Manual Lock & Unlock"]];
    CONST listitem liTc12WinMan{2}:=[["","Lock Tool"],["","Unlock Tool"]];
    CONST listitem liTc12WinToolSelection{7}:=[["","T1: Woodgripper with Sensors"],["","T2: Spindeltool"],["","T3: Woodgripper without Sensors"],["","T4: Vacuumtool 1"],["","T5: Vacuumtool 2"],["","T6: Gipper MAS 2018"],["","T7: PDS Spindle"]];

    !************************************************
    ! Declaration :     smsg
    !************************************************
    !
    LOCAL CONST smsg smsgTcStart:=["Toolchanger 11","Press Go to start the toolchanger process.","Or exit the program with program stop and PP-Main.","","","","Go","x.jpg"];
    LOCAL CONST smsg smsgT7SpOn:=["PDS Spindle","Press Go to start the spindle.","Or exit the program with program stop and PP-Main.","","","","Go","x.jpg"];

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
    ! Function    :     Start User Interface Tool-Changer 12
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.07
    ! **************** ETH Zurich *******************
    !
    PROC rRFL_Tc12()
        !
        WaitSyncTask idRFL_Tc12Sta,tlAll;
        !
        ! Temp Msg for Operator
        TPWrite "Master in RFL Tool-Changer 12";
        !
        ! User Interface Tool-Changer
        r_Tc12_UIWin;
        ! 
        WaitSyncTask idRFL_Tc12End,tlAll;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Start User Interface Tool-Changer 11
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC rRFL_TC11()
        !
        WaitSyncTask idRFL_TC11Sta,tlAll;
        !
        ! Temp Msg for Operator
        TPWrite "Master in RFL Tool-Changer 11";
        !
        ! Placeholder for Master Code 
        ! 
        WaitSyncTask idRFL_TC11End,tlAll;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize current tool
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_InitSig()
        ! 
        ! Button led
        SetDo doTc12BtnLedOn,0;
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
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_UIWin()
        VAR num nToolNr;
        !
        ! Tool-Changer loop
        !
        ! View Window Tool-Changer
        nUiListItem:=UIListView(
                    \Result:=btnAnswer
                    \Header:="Tool-Changer 12",
                    liTc12Win
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
                r_Tc12_Toolhandler nToolNr\Place;
            CASE 2:
                !
                ! Item Select Tool and change
                nToolNr:=f_Tc12_ToolSelection(\stAddText:="Pick");
                r_Tc12_Toolhandler nToolNr\Place\Pick;
            CASE 3:
                !
                ! No Item 
            CASE 4:
                !
                ! Item Manual 
                !
                ! Check 
                IF f_Tc12_ButtonConfirmation()=TRUE THEN
                    !
                    ! Call window manual
                    r_Tc12_UIWinMan;
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
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_UIWinMan()
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
                    \Header:="Tool-Changer 12 Manual",
                    liTc12WinMan
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
                    r_Tc12_Lock;
                    !
                    ! Init Tool
                    r_Tc12_InitTool f_Tc12_CheckCurToolCode();
                CASE 2:
                    !
                    ! Item Safe check and Unlock Tool
                    !
                    ! Situation safe?
                    r_Tc12_SafInfo "Unlock the Tool-Changer ?";
                    !
                    ! Execute only when safe
                    IF b_Tc12_ToolSafe=TRUE THEN
                        !
                        ! Disconnect current Tool
                        r_Tc12_DisconTool 1;
                        r_Tc12_DisconTool 2;
                        r_Tc12_DisconTool 3;
                        r_Tc12_DisconTool 4;
                        r_Tc12_DisconTool 5;
                        !
                        ! All Tool signals off
                        r_Tc12_ToolSigOff;
                        !
                        ! Unlock current Tool
                        r_Tc12_Unlock;
                        !
                        ! Set Placeholder no Tool
                        n_Tc12_CurToolCode:=n_Tc_CodeForNoTool;
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
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_SafInfo(string stMsgL1)
        !
        ! User Msg
        UIMsgBox
                \Header:="Tool-Changer 12 Safety Information","Is the situation safe to "
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
            b_Tc12_ToolSafe:=TRUE;
        ELSE
            !
            ! Situation not safe  
            b_Tc12_ToolSafe:=FALSE;
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
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_Toolhandler(num nToolNr\switch Place\switch Pick)
        !
        ! Check place tool
        IF Present(Place) AND b_Tc12_NoTool=FALSE THEN
            ! 
            ! Activat place tool
            b_Tc12_PlaceTool:=TRUE;
            !
            ! Read and check current tool code
            n_Tc12_PlaceCode:=n_Tc12_CurToolCode;
        ELSE
            ! 
            ! Deactivat place tool
            b_Tc12_PlaceTool:=FALSE;
            !
            ! Set code to zero
            n_Tc12_PlaceCode:=0;
        ENDIF
        !
        ! Check pick tool
        IF Present(Pick) THEN
            ! 
            ! Activat place tool
            b_Tc12_PickTool:=TRUE;
            !
            ! Read and check next tool code
            n_Tc12_PickCode:=f_Tc12_CheckNextToolCode(nToolNr);
        ELSE
            ! 
            ! Deactivat place tool
            b_Tc12_PickTool:=FALSE;
            !
            ! Set code to zero
            n_Tc12_PickCode:=0;
        ENDIF
        !
        ! Do not tool change when place and pick tool is the same
        IF n_Tc12_PickCode=n_Tc12_PlaceCode THEN
            !
            ! Deactivat pick and place
            b_Tc12_PickTool:=FALSE;
            b_Tc12_PlaceTool:=FALSE;
        ENDIF
        !
        ! Execute only when place or pick is active 
        IF b_Tc12_PlaceTool=TRUE OR b_Tc12_PickTool=TRUE THEN
            !
            ! Check the way of Y-Axis befor moving
            rCheckYAxisCol p_Tc12_T1_PlaInTB.extax.eax_b;
            !
            ! Move to station pos
            r_Tc12_MovToStaTB1;
            !
            ! User safety message befor speed up
            r_RFL_SMsg smsgTcStart;
            !
            ! Set toolchanger speedlimit
            r_RFL_SetSpeedLimit slim_TC_Master;
            !
            ! Move in Toolbox 
            r_Tc12_MovStaPosTb1ToTB1;
            !
            ! Place current tool
            IF b_Tc12_PlaceTool=TRUE r_Tc12_PlaceTool;
            !
            ! Pick new tool
            IF b_Tc12_PickTool=TRUE r_Tc12_PickTool;
            !
            ! Reset current Tool
            IF b_Tc12_PickTool=TRUE r_Tc12_ResTool n_Tc12_CurToolCode;
            !
            ! Move out Toolbox 
            r_Tc12_MovTB1ToStaPosTB1;
            !
            ! Move to station pos
            r_Tc12_MovToStaTB1;
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
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_MovToStaTB1()
        !
        ! Station Toolbox 
        MoveAbsJ jp_Tc12_StaPosTB,vRFLMax,z100,tool0;
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
    PROC r_Tc12_MovStaPosTb1ToTB1()
        !
        ! Path in Toolbox 
        MoveAbsJ jp_Tc12_PathInTB1_10,vRFLMed,z200,tool0;
        MoveAbsJ jp_Tc12_PathInTB1_20,vRFLMed,z200,tool0;
        MoveAbsJ jp_Tc12_PathInTB1_30,vRFLMed,z200,tool0;
        MoveAbsJ jp_Tc12_PathInTB1_40,vRFLMed,z200,tool0;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Move out Toolbox 1
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.10.06
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_MovTB1ToStaPosTB1()
        !
        ! Station Toolbox 
        MoveAbsJ jp_Tc12_PathInTB1_40,vRFLMed,z200,tool0;
        MoveAbsJ jp_Tc12_PathInTB1_30,vRFLMed,z200,tool0;
        MoveAbsJ jp_Tc12_PathInTB1_20,vRFLMed,z200,tool0;
        MoveAbsJ jp_Tc12_PathInTB1_10,vRFLMed,z200,tool0;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Move to Toolbox 1 position
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.10.02
    !***************** ETH Zurich *******************
    !
    !* PROC r_Tc12_MovToTB1()
    !*     !
    !*     ! Station Toolbox 
    !*     MoveAbsJ jp_Tc12_ToTB1_10,vRFLMax,z100,tool0;
    !*     RETURN ;
    !* ERROR
    !*     ! Placeholder for Error Code...
    !* ENDPROC

    !************************************************
    ! Function    :     Pick tool in Toolbox
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_PickTool()
        !
        ! Set place position
        TEST n_Tc12_PickCode
        CASE 1:
            !
            ! Tool 1 = Woodgripper with sensor
            !
            ! Set Tool position
            p_Tc12_PickPosTB:=p_Tc12_T1_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc12:=ob_Tc12_T1;
        CASE 2:
            !
            ! Tool 2 = Spindels
            !
            ! Set Tool position
            p_Tc12_PickPosTB:=p_Tc12_T2_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc12:=ob_Tc12_T2;
        CASE 3:
            !
            ! Tool 3 = Woodgripper without sensors
            !
            ! Set Tool position
            p_Tc12_PickPosTB:=p_Tc12_T3_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc12:=ob_Tc12_T3;
        CASE 4:
            !
            ! Tool 4 = Vacuum Tool 1
            !
            ! Set Tool position
            p_Tc12_PickPosTB:=p_Tc12_T4_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc12:=ob_Tc12_T4;
        CASE 5:
            !
            ! Tool 5 = Vacuum Tool 2
            !
            ! Set Tool position
            p_Tc12_PickPosTB:=p_Tc12_T5_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc12:=ob_Tc12_T5;
        DEFAULT:
            !
            ! Not a correct Tool Code
            r_RFL_ProgError;
        ENDTEST
        !
        ! Execute only when pick tool true is
        IF b_Tc12_PickTool=TRUE THEN
            !
            ! Move over Toolbox when placing is not activated
            IF b_Tc12_PlaceTool=FALSE THEN
                !
                ! Move in pre position
                MoveJ Offs(p_Tc12_PickPosTB,0,n_Tc_OffsY2,n_Tc_OffsZ3),vTcMax,z50,tTc12\WObj:=ob_Tc12;
                !
                ! Move over place position
                MoveJ Offs(p_Tc12_PickPosTB,0,n_Tc_OffsY2,n_Tc_OffsZ2),vTcMax,z50,tTc12\WObj:=ob_Tc12;
            ELSE
                !
                ! Move over helper points
                r_Tc12_MovFrmPlaToPic;
            ENDIF
            !
            ! Set Error 
            b_Tc12_WrongTool:=TRUE;
            !
            ! Pick correct tool
            WHILE b_Tc12_WrongTool=TRUE DO
                !
                ! Move in front of pick position
                MoveL Offs(p_Tc12_PickPosTB,0,n_Tc_OffsY2,0),vTcMed,z20,tTc12\WObj:=ob_Tc12;
                !
                ! Move close to pick position
                MoveL Offs(p_Tc12_PickPosTB,0,n_Tc_OffsY1,0),vTcMed,z10,tTc12\WObj:=ob_Tc12;
                !
                ! Unlock 
                r_Tc12_Unlock;
                !
                ! Move to pick position
                MoveL p_Tc12_PickPosTB,vTcMin,fine,tTc12\WObj:=ob_Tc12;
                !
                ! Grap tool
                r_Tc12_Lock;
                !
                ! Compare current toolcode with target toolcode
                IF n_Tc12_PickCode=f_Tc12_CheckCurToolCode() THEN
                    !
                    ! Code ok
                    b_Tc12_WrongTool:=FALSE;
                ELSE
                    !
                    ! Code not ok
                    b_Tc12_WrongTool:=TRUE;
                    !
                    ! Redo grap tool
                    r_Tc12_Unlock;
                    !
                    ! Move away from to pick position
                    MoveL Offs(p_Tc12_PickPosTB,0,n_Tc_OffsY1,0),vTcMed,z10,tTc12\WObj:=ob_Tc12;
                    !
                    ! Move for pick position
                    MoveL Offs(p_Tc12_PickPosTB,0,n_Tc_OffsY2,0),vTcMed,fine,tTc12\WObj:=ob_Tc12;
                    !
                    ! User Msg
                    UIMsgBox
                            \Header:="Tool-Changer 12 Wrong Tool"," "
                            \MsgLine2:="Current Tool in Place ="+NumToStr(n_Tc12_CurToolCode,0)
                            \MsgLine3:="Correct Tool in Place ="+NumToStr(n_Tc12_PickCode,0)
                            \MsgLine4:=""
                            \MsgLine5:="Please inseert correct Tool in Place and press Ok to repeat"
                            \Buttons:=btnOk
                            \Icon:=iconWarning
                            \Result:=btnAnswer;
                ENDIF
            ENDWHILE
            !
            ! Initalize Tool
            r_Tc12_InitTool n_Tc12_CurToolCode;
            !
            ! Move out of toolbox
            MoveL Offs(p_Tc12_PickPosTB,0,0,n_Tc_OffsZ1),vTcMin,z10,tTc12\WObj:=ob_Tc12;
            !
            ! Move over pick position
            MoveL Offs(p_Tc12_PickPosTB,0,0,n_Tc_OffsZ2),vTcMed,z50,tTc12\WObj:=ob_Tc12;
            !
            ! Move back in pre position
            !* MoveJ p_Tc12_PrePosTB,vTcMax,z50,tTc12\WObj:=ob_Tc12;
            MoveJ Offs(p_Tc12_PickPosTB,0,0,n_Tc_OffsZ3),vTcMax,z50,tTc12\WObj:=ob_Tc12;
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Place current tool in Toolbox
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_PlaceTool()
        !
        ! Set place position
        TEST n_Tc12_PlaceCode
        CASE 1:
            !
            ! Tool 1 = Woodgripper with sensor
            !
            ! Set Tool position
            p_Tc12_PlacePosTB:=p_Tc12_T1_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc12:=ob_Tc12_T1;
        CASE 2:
            !
            ! Tool 2 = Spindels
            !
            ! Set Tool position
            p_Tc12_PlacePosTB:=p_Tc12_T2_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc12:=ob_Tc12_T2;
        CASE 3:
            !
            ! Tool 3 = Woodgripper without sensors
            !
            ! Set Tool position
            p_Tc12_PlacePosTB:=p_Tc12_T3_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc12:=ob_Tc12_T3;
        CASE 4:
            !
            ! Tool 4 = Vacuum Tool 1
            !
            ! Set Tool position
            p_Tc12_PlacePosTB:=p_Tc12_T4_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc12:=ob_Tc12_T4;
        CASE 5:
            !
            ! Tool 5 = Vacuum Tool 2
            !
            ! Set Tool position
            p_Tc12_PlacePosTB:=p_Tc12_T5_PlaInTB;
            !
            ! Set Tool workobject
            ob_Tc12:=ob_Tc12_T5;
        DEFAULT:
            !
            ! Not a correct Tool Code
            r_RFL_ProgError;
        ENDTEST
        !
        ! Execute only when place tool true is
        IF b_Tc12_PlaceTool=TRUE THEN
            !
            ! Move in pre position
            !*MoveJ p_Tc12_PrePosTB,vTcMax,z50,tTc12\WObj:=ob_Tc12_Toolbox;
            MoveJ Offs(p_Tc12_PlacePosTB,0,0,n_Tc_OffsZ3),vTcMax,z100,tTc12\WObj:=ob_Tc12;
            !
            ! Move over place position
            MoveJ Offs(p_Tc12_PlacePosTB,0,0,n_Tc_OffsZ2),vTcMax,z50,tTc12\WObj:=ob_Tc12;
            !
            ! Reset current Tool
            r_Tc12_ResTool n_Tc12_PlaceCode;
            !
            ! Move close to tool holder position
            MoveL Offs(p_Tc12_PlacePosTB,0,0,n_Tc_OffsZ1),vTcMed,z10,tTc12\WObj:=ob_Tc12;
            !
            ! Move to place position
            MoveL p_Tc12_PlacePosTB,vTcMin,fine,tTc12\WObj:=ob_Tc12;
            !
            ! Disconnect current tool
            r_Tc12_DisconTool n_Tc12_PlaceCode;
            !
            ! Set Placeholder no Tool
            n_Tc12_CurToolCode:=n_Tc_CodeForNoTool;
            !
            ! All tool signals off
            r_Tc12_ToolSigOff;
            !
            ! Realese tool
            r_Tc12_Unlock;
            !
            ! Move out of tool
            MoveL Offs(p_Tc12_PlacePosTB,0,n_Tc_OffsY1,0),vTcMin,z10,tTc12\WObj:=ob_Tc12;
            !
            ! Move away from tool place
            MoveL Offs(p_Tc12_PlacePosTB,0,n_Tc_OffsY2,0),vTcMed,z10,tTc12\WObj:=ob_Tc12;
            !
            ! Move over Toolbox when picking is not activated
            IF b_Tc12_PickTool=FALSE THEN
                !
                ! Move away from tool place
                MoveL Offs(p_Tc12_PlacePosTB,0,n_Tc_OffsY2,n_Tc_OffsZ2),vTcMed,z10,tTc12\WObj:=ob_Tc12;
                !
                ! Move in pre position
                MoveJ Offs(p_Tc12_PlacePosTB,0,n_Tc_OffsY2,n_Tc_OffsZ3),vTcMax,z50,tTc12\WObj:=ob_Tc12;
            ENDIF
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Move from place to pick pos
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_MovFrmPlaToPic()
        !
        ! Move over inter pos when the pick position is not
        ! direct reacheable
        TEST n_Tc12_PlaceCode
        CASE 1:
            !
            ! Tool 1 = Woodgripper with sensor
            TEST n_Tc12_PickCode
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
                MoveL p_Tc12_InterPos_T2,vTcMed,z100,tTc12\WObj:=ob_Tc12_Toolbox;
            DEFAULT:
                !
                ! Situation not denied
                r_RFL_ProgError;
            ENDTEST
        CASE 2:
            ! 
            ! Tool 2 = Spindels
            TEST n_Tc12_PickCode
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
            TEST n_Tc12_PickCode
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
                MoveL p_Tc12_InterPos_T2,vTcMed,z100,tTc12\WObj:=ob_Tc12_Toolbox;
            DEFAULT:
                !
                ! Situation not denied
                r_RFL_ProgError;
            ENDTEST
        CASE 4:
            !
            ! Tool 4 = Vacuum Tool 1
            TEST n_Tc12_PickCode
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
                MoveL p_Tc12_InterPos_T2,vTcMed,z100,tTc12\WObj:=ob_Tc12_Toolbox;
            DEFAULT:
                !
                ! Situation not denied
                r_RFL_ProgError;
            ENDTEST
        CASE 5:
            !
            ! Tool 5 = Vacuum Tool 2
            TEST n_Tc12_PickCode
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
                MoveL p_Tc12_InterPos_T2,vTcMed,z100,tTc12\WObj:=ob_Tc12_Toolbox;
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
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_InitTool(num nToolNr)
        ! 
        ! Conect current alias signals
        r_Tc12_ConTool nToolNr;
        !
        ! Initialize current tool load
        r_Tc12_UpdateToolLoad nToolNr;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize current tool signls
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_ConTool(num nToolNr)
        !
        ! Reset current tool
        TEST nToolNr
        CASE 1:
            !
            ! Tool 1 = Woodgripper with sensor
            r_Tc12_T1_ConAliSig;
        CASE 2:
            !
            ! Tool 2 = Spindels
            r_Tc12_T2_ConAliSig;
        CASE 3:
            !
            ! Tool 3 = Woodgripper without sensors
            r_Tc12_T3_ConAliSig;
        CASE 4:
            !
            ! Tool 4 = Vacuum Tool 1
            r_Tc12_T4_ConAliSig;
        CASE 5:
            !
            ! Tool 5 = Vacuum Tool 2
            r_Tc12_T5_ConAliSig;
        CASE 7:
            !
            ! Tool 7 = PDS Spindle
            r_Tc12_T7_ConAliSig;
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
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_DisconTool(num nToolNr)
        !
        ! Reset current tool
        TEST nToolNr
        CASE 1:
            !
            ! Tool 1 = Woodgripper with sensor
            r_Tc12_T1_DisconAliSig;
        CASE 2:
            !
            ! Tool 2 = Spindels
            r_Tc12_T2_DisconAliSig;
        CASE 3:
            !
            ! Tool 3 = Woodgripper without sensors
            r_Tc12_T3_DisconAliSig;
        CASE 4:
            !
            ! Tool 4 = Vacuum Tool 1
            r_Tc12_T4_DisconAliSig;
        CASE 5:
            !
            ! Tool 5 = Vacuum Tool 2
            r_Tc12_T5_DisconAliSig;
        CASE 7:
            !
            ! Tool 7 = PDS Spindle
            r_Tc12_T7_DisconAliSig;
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
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_UpdateToolLoad(num nToolNr)
        !
        ! Reset current tool
        TEST nToolNr
        CASE 1:
            !
            ! Tool 1 = Woodgripper with sensor
            tTc12.tload:=ld_Tc12_T1;
        CASE 2:
            !
            ! Tool 2 = Spindels
            tTc12.tload:=ld_Tc12_T2;
        CASE 3:
            !
            ! Tool 3 = Woodgripper without sensors
            tTc12.tload:=ld_Tc12_T3;
        CASE 4:
            !
            ! Tool 4 = Vacuum Tool 1
            tTc12.tload:=ld_Tc12_T4;
        CASE 5:
            !
            ! Tool 5 = Vacuum Tool 2
            tTc12.tload:=ld_Tc12_T5;
        CASE 7:
            !
            ! Tool 5 = PDS Spindle
            tTc12.tload:=ld_Tc12_T7;
        CASE n_Tc_CodeForNoTool:
            !
            ! No Tool
            tTc12.tload:=ld_Tc12_NoTool;
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
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_ResTool(num nToolNr)
        !
        ! Reset current tool
        TEST nToolNr
        CASE 1:
            !
            ! Tool 1 = Woodgripper with sensor
            r_Tc12_T1_ResTool;
        CASE 2:
            !
            ! Tool 2 = Spindels
            r_Tc12_T2_ResTool;
        CASE 3:
            !
            ! Tool 3 = Woodgripper without sensors
            r_Tc12_T3_ResTool;
        CASE 4:
            !
            ! Tool 4 = Vacuum Tool 1
            r_Tc12_T4_ResTool;
        CASE 5:
            !
            ! Tool 5 = Vacuum Tool 2
            r_Tc12_T5_ResTool;
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
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_ToolSigOff()
        !
        ! Set Signals
        SetDO doTc12Valve1A,0;
        SetDO doTc12Valve1B,0;
        !
        SetDO doTc12Res5,0;
        SetDO doTc12Res6,0;
        SetDO doTc12Res7,0;
        SetDO doTc12Res8,0;
        !
        SetDO doTc12PowerOn1,0;
        SetDO doTc12PowerOn2,0;
        SetDO doTc12PowerOn3,0;
        !
        SetDO doTc12Res12,0;
        !
        SetDO doTc12BtnLedOn,0;
        !
        SetDO doTc12Res14,0;
        SetDO doTc12Res15,0;
        !
        SetDO doTc12ToOut1,0;
        !
        ! Log Msg 
        rLogMsg st_Tc12_MsgHeader,"Reset done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Lock tool
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_Lock()
        !
        ! Set Signals
        SetDO doTc12Unlock,0;
        SetDo doTc12Lock,1;
        !
        ! Sensors must be integrated 
        !
        ! Time for action
        WaitTime nTime_Tc_Lock;
        !
        ! Update Variable
        b_Tc12_NoTool:=FALSE;
        !
        ! Log Msg 
        rLogMsg st_Tc12_MsgHeader,"Lock tool done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Unlock tool
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_Unlock()
        !
        ! Check unlock not done
        IF NOT (DOutput(doTc12Lock)=0 AND DOutput(doTc12Unlock)=1) THEN
            !
            ! Set Signals
            SetDo doTc12Lock,0;
            SetDO doTc12Unlock,1;
            !
            ! Update Variable
            b_Tc12_NoTool:=TRUE;
            !
            ! Time for action
            WaitTime nTime_Tc_Unlock;
            !
            ! Log Msg 
            rLogMsg st_Tc12_MsgHeader,"Unlock done";
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
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    FUNC num f_Tc12_ToolSelection(\string stAddText)
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
                    \Header:="Tool-Changer 12 "+stAddHeader,
                    liTc12WinToolSelection
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
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    FUNC num f_Tc12_CheckCurToolCode()
        VAR string stMsg{5}:=["","","","",""];
        !
        ! Init Var
        b_Tc12_SimTool:=FALSE;
        !
        ! Read current toon code
        n_Tc12_CurToolCode:=giTc12Code;
        !
        ! Check current tool code
        IF n_Tc12_CurToolCode>0 AND n_Tc12_CurToolCode<=n_Tc_NumOfTools THEN
            !
            ! Toolcode ok
            !
            ! Update Variable
            b_Tc12_NoTool:=FALSE;
        ELSEIF b_Tc12_NoTool=TRUE THEN
            !
            ! No Tool
            !
            ! Set Placeholder no Tool
            n_Tc12_CurToolCode:=n_Tc_CodeForNoTool;
        ELSE
            !
            ! Toolcode not ok
            stMsg{1}:="Current Tool Code is not possible!";
            stMsg{2}:="Current Code is: "+NumToStr(n_Tc12_CurToolCode,0);
            stMsg{3}:="";
            stMsg{4}:="Yes = Sim Tool";
            stMsg{5}:="No  = Exit";
            !
            ! User Msg
            nAnswer:=UIMessageBox(
                \Header:="Tool-Changer 12"
                \MsgArray:=stMsg
                \BtnArray:=st_Tc12_BtnToolSim
                \Icon:=iconWarning);
            !
            ! Check answer
            IF nAnswer=1 THEN
                !
                ! No Tool
                !
                ! Set Placeholder no Tool
                n_Tc12_CurToolCode:=n_Tc_CodeForNoTool;
                !
                ! Update Variable
                b_Tc12_NoTool:=TRUE;
            ELSE
                !
                ! Sim
                !
                ! Acitvat tool simulation
                b_Tc12_SimTool:=TRUE;
                !
                ! Set tool code for simulation
                n_Tc12_CurToolCode:=f_Tc12_ToolSelection(\stAddText:="Sim Tool");
                !
                ! Update Variable
                b_Tc12_NoTool:=FALSE;
            ENDIF
        ENDIF
        RETURN n_Tc12_CurToolCode;
    ERROR
        !
        ! Try next when unit not available 
        IF ERRNO=ERR_NORUNUNIT TRYNEXT;
    ENDFUNC

    !************************************************
    ! Function    :     Check next tool Code
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    FUNC num f_Tc12_CheckNextToolCode(num nNextToolCode)
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
                \Header:="Tool-Changer 12","Next Tool Code is not possible!"
                \MsgLine2:="Next Code is: "+NumToStr(nNextToolCode,0)
                \MsgLine3:=""
                \MsgLine4:=""
                \MsgLine5:=""
                \Buttons:=btnOk
                \Icon:=iconError
                \Result:=btnAnswer;
            !
            ! Cancel tool place and pick
            b_Tc12_PlaceTool:=FALSE;
            b_Tc12_PickTool:=FALSE;
        ENDIF
        RETURN nNextToolCode;
    ERROR
        ! Placeholder for Error Code...
    ENDFUNC

    !************************************************
    ! Function    :     Tool-Changer Button confirmation 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    FUNC bool f_Tc12_ButtonConfirmation()
        VAR bool bBtnFlag;
        ! 
        ! Init variables
        bBtnFlag:=FALSE;
        !
        ! Button led on
        SetDo doTc12BtnLedOn,1;
        !
        ! Msg for user push the button
        nAnswer:=UIMessageBox(
            \Header:="Tool-Changer 12"
            \MsgArray:=["For using manual lock and unlock","confirm this message with the hardware button","on the robot pack bag"]
            \BtnArray:=stBtnExit
            \Icon:=iconWarning
            \DIBreak:=diTc12Btn);
        !
        ! Button led off
        SetDo doTc12BtnLedOn,0;
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
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T1_ConAliSig()
        !
        ! Inputs
        AliasIO diTc12ToIn1,di_Tc12_T1Gr1Open;
        AliasIO diTc12ToIn2,di_Tc12_T1Gr1Close;
        AliasIO diTc12ToIn3,di_Tc12_T1Gr2Open;
        AliasIO diTc12ToIn4,di_Tc12_T1Gr2Close;
        !
        ! Outputs
        AliasIO doTc12Valve1A,do_Tc12_T1GrOff;
        AliasIO doTc12Valve1B,do_Tc12_T1GrOn;
        AliasIO doTc12ToOut1,do_Tc12_T1EdgeSenOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T1MsgHeader,"Connect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Disconnect all alias signals
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_T1_DisconAliSig()
        !
        ! Inputs
        AliasIOReset di_Tc12_T1Gr1Open;
        AliasIOReset di_Tc12_T1Gr1Close;
        AliasIOReset di_Tc12_T1Gr2Open;
        AliasIOReset di_Tc12_T1Gr2Close;
        !
        ! Outputs
        AliasIOReset do_Tc12_T1GrOff;
        AliasIOReset do_Tc12_T1GrOn;
        AliasIOReset do_Tc12_T1EdgeSenOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T1MsgHeader,"Disonnect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Gripper on
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T1_GrOn()
        !
        ! Set Signals
        SetDO do_Tc12_T1GrOff,0;
        SetDO do_Tc12_T1GrOn,1;
        !
        ! Time for action
        WaitTime nTime_Tc12_T1GripOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T1MsgHeader,"Gripper on done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Gripper off
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T1_GrOff()
        !
        ! Set Signals
        SetDO do_Tc12_T1GrOn,0;
        SetDO do_Tc12_T1GrOff,1;
        !
        ! Time for action
        WaitTime nTime_Tc12_T1GripOff;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T1MsgHeader,"Gripper off done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Edge Sensor on
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T1_EdgeSenOn()
        !
        ! Set Signals
        SetDO do_Tc12_T1EdgeSenOn,1;
        !
        ! Time for action
        WaitTime nTime_Tc12_T1EdgeSenOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T1MsgHeader,"Edge Sensor on done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Edge Sensor off
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T1_EdgeSenOff()
        !
        ! Set Signals
        SetDO do_Tc12_T1EdgeSenOn,0;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T1MsgHeader,"Edge Sensor off done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Reset Tool 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T1_ResTool()
        !
        ! Switch Edge Sensor off
        r_Tc12_T1_EdgeSenOff;
        !
        ! When the gripper is not open then safe check
        IF di_Tc12_T1Gr1Open=0 OR di_Tc12_T1Gr1Open=0 THEN
            !
            ! Safe check
            r_Tc12_SafInfo "Open the Gripper ?";
        ENDIF
        !
        ! Open gripper when safe
        IF b_Tc12_ToolSafe=TRUE r_Tc12_T1_GrOff;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T1MsgHeader,"Reset tool done";
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
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T2_ConAliSig()
        !
        ! Inputs
        !
        ! Outputs
        AliasIO doTc12PowerOn1,do_Tc12_T2MillOn;
        AliasIO doTc12PowerOn2,do_Tc12_T2DrillOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T2MsgHeader,"Connect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Disconnect all alias signals
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_T2_DisconAliSig()
        !
        ! Inputs
        !
        ! Outputs
        AliasIOReset do_Tc12_T2MillOn;
        AliasIOReset do_Tc12_T2DrillOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T2MsgHeader,"Disonnect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Mill On
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T2_MillOn()
        !
        ! Set Signals
        SetDO do_Tc12_T2DrillOn,0;
        SetDO do_Tc12_T2MillOn,1;
        !
        ! Time for action
        WaitTime\InPos,nTime_Tc12_T2PowerpOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T2MsgHeader,"Mill on done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Drill On
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T2_DrillOn()
        !
        ! Set Signals
        SetDO do_Tc12_T2MillOn,1;
        SetDO do_Tc12_T2DrillOn,0;
        !
        ! Time for action
        WaitTime\InPos,nTime_Tc12_T2PowerpOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T2MsgHeader,"Drill on done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Mill and Drill Off
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T2_MillDrillOff()
        !
        ! Set Signals
        SetDO do_Tc12_T2MillOn,0;
        SetDO do_Tc12_T2DrillOn,0;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T2MsgHeader,"Mill and Drill off done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Reset Tool 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T2_ResTool()
        !
        ! Switch Mill and Drill off
        r_Tc12_T2_MillDrillOff;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T2MsgHeader,"Reset tool done";
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
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T3_ConAliSig()
        !
        ! Inputs
        !
        ! Outputs
        AliasIO doTc12Valve1A,do_Tc12_T3GrOff;
        AliasIO doTc12Valve1B,do_Tc12_T3GrOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T3MsgHeader,"Connect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Disconnect all alias signals
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_T3_DisconAliSig()
        !
        ! Inputs
        !
        ! Outputs
        AliasIOReset do_Tc12_T3GrOff;
        AliasIOReset do_Tc12_T3GrOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T3MsgHeader,"Disonnect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Gripper on
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T3_GrOn()
        !
        ! Set Signals
        SetDO do_Tc12_T3GrOff,0;
        SetDO do_Tc12_T3GrOn,1;
        !
        ! Time for action
        WaitTime nTime_Tc12_T3GripOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T3MsgHeader,"Gripper on done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Gripper off
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T3_GrOff()
        !
        ! Set Signals
        SetDO do_Tc12_T3GrOn,0;
        SetDO do_Tc12_T3GrOff,1;
        !
        ! Time for action
        WaitTime nTime_Tc12_T3GripOff;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T3MsgHeader,"Gripper off done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Reset Tool 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T3_ResTool()
        !
        ! When the gripper is not open then safe check
        IF NOT (DOutput(do_Tc12_T3GrOn)=0 AND DOutput(do_Tc12_T3GrOff)=1) THEN
            !
            ! Safe check
            r_Tc12_SafInfo "Open the Gripper ?";
        ENDIF
        !
        ! Open gripper when safe
        IF b_Tc12_ToolSafe=TRUE r_Tc12_T3_GrOff;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T3MsgHeader,"Reset tool done";
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
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T4_ConAliSig()
        !
        ! Inputs
        !
        ! Outputs
        AliasIO doTc12Valve1A,do_Tc12_T4VacuumOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T4MsgHeader,"Connect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Disconnect all alias signals
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_T4_DisconAliSig()
        !
        ! Inputs
        !
        ! Outputs
        AliasIOReset do_Tc12_T4VacuumOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T4MsgHeader,"Disonnect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Vacuum on
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T4_VacuumOn()
        !
        ! Vacuum on
        SetDo do_Tc12_T4VacuumOn,1;
        !
        ! Agition time
        WaitTime nTime_Tc12_T4VacuumOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T4MsgHeader,"Vacuum on done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Vacuum off
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T4_VacuumOff()
        !
        ! Vacuum on
        SetDo do_Tc12_T4VacuumOn,0;
        !
        ! Agition time
        WaitTime nTime_Tc12_T4VacuumOff;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T4MsgHeader,"Vacuum off done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Reset Tool 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T4_ResTool()
        !
        ! When the vauum is activeted then safe check
        IF DOutput(do_Tc12_T4VacuumOn)=1 THEN
            !
            ! Safe check
            r_Tc12_SafInfo "Switch off the Vacuum ?";
        ENDIF
        !
        ! Switch vacuum off when safe
        IF b_Tc12_ToolSafe r_Tc12_T4_VacuumOff;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T4MsgHeader,"Reset tool done";
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
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T5_ConAliSig()
        !
        ! Inputs
        !
        ! Outputs
        AliasIO doTc12Valve1A,do_Tc12_T5VacuumOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T5MsgHeader,"Connect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Disconnect all alias signals
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_T5_DisconAliSig()
        !
        ! Inputs
        !
        ! Outputs
        AliasIOReset do_Tc12_T5VacuumOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T5MsgHeader,"Disonnect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Vacuum on
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T5_VacuumOn()
        !
        ! Vacuum on
        SetDo do_Tc12_T5VacuumOn,1;
        !
        ! Agition time
        WaitTime nTime_Tc12_T5VacuumOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T5MsgHeader,"Vacuum on done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Vacuum off
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T5_VacuumOff()
        !
        ! Vacuum on
        SetDo do_Tc12_T5VacuumOn,0;
        !
        ! Agition time
        WaitTime nTime_Tc12_T5VacuumOff;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T5MsgHeader,"Vacuum off done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Reset Tool 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.28
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T5_ResTool()
        !
        ! When the vauum is activeted then safe check
        IF DOutput(do_Tc12_T5VacuumOn)=1 THEN
            !
            ! Safe check
            r_Tc12_SafInfo "Switch off the Vacuum ?";
        ENDIF
        !
        ! Switch vacuum off when safe
        IF b_Tc12_ToolSafe r_Tc12_T5_VacuumOff;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T5MsgHeader,"Reset tool done";
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
    ! Date        :     2017.09.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_CreateWorkobjects()
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
        MoveJ Offs(p_Tc12_T1_TeachPoint,0,100,300),v100,fine,tTc12\WObj:=wobj0;
        MoveJ Offs(p_Tc12_T1_TeachPoint,0,100,0),v100,fine,tTc12\WObj:=wobj0;
        !
        ! Modify teach point 
        MoveL Offs(p_Tc12_T1_TeachPoint,0,25,0),v10,fine,tTc12\WObj:=wobj0;
        MoveL Offs(p_Tc12_T1_TeachPoint,0,10,0),v10,fine,tTc12\WObj:=wobj0;
        MoveL p_Tc12_T1_TeachPoint,v10,fine,tTc12\WObj:=wobj0;
        !
        ! Update workobjekt 
        ob_Tc12_T1:=fCreateFream(tTc12\poOffset:=po_Tc12_Offset);
        !
        ! Move away from teach point 
        MoveL Offs(p_Tc12_T1_TeachPoint,0,100,0),v20,fine,tTc12\WObj:=wobj0;
        !
        !************************************************
        ! Tool 2 = Spindels
        !************************************************
        !
        ! Move over teach point 
        MoveJ Offs(p_Tc12_T2_TeachPoint,0,100,300),v100,fine,tTc12\WObj:=wobj0;
        MoveJ Offs(p_Tc12_T2_TeachPoint,0,100,0),v100,fine,tTc12\WObj:=wobj0;
        !
        ! Modify teach point 
        MoveL Offs(p_Tc12_T2_TeachPoint,0,25,0),v10,fine,tTc12\WObj:=wobj0;
        MoveL Offs(p_Tc12_T2_TeachPoint,0,10,0),v10,fine,tTc12\WObj:=wobj0;
        MoveL p_Tc12_T2_TeachPoint,v10,fine,tTc12\WObj:=wobj0;
        !
        ! Update workobjekt 
        ob_Tc12_T2:=fCreateFream(tTc12\poOffset:=po_Tc12_Offset);
        !
        ! Move away from teach point 
        MoveL Offs(p_Tc12_T2_TeachPoint,0,100,0),v20,fine,tTc12\WObj:=wobj0;
        !
        !************************************************
        ! Tool 3 = Woodgripper without sensors
        !************************************************
        !
        ! Move over teach point 
        MoveJ Offs(p_Tc12_T3_TeachPoint,0,100,300),v100,fine,tTc12\WObj:=wobj0;
        MoveJ Offs(p_Tc12_T3_TeachPoint,0,0,300),v100,fine,tTc12\WObj:=wobj0;
        !
        ! Modify teach point 
        MoveL Offs(p_Tc12_T3_TeachPoint,0,25,0),v10,fine,tTc12\WObj:=wobj0;
        MoveL Offs(p_Tc12_T3_TeachPoint,0,10,0),v10,fine,tTc12\WObj:=wobj0;
        MoveL p_Tc12_T3_TeachPoint,v10,fine,tTc12\WObj:=wobj0;
        !
        ! Update workobjekt 
        ob_Tc12_T3:=fCreateFream(tTc12\poOffset:=po_Tc12_Offset);
        !
        ! Move away from teach point 
        MoveL Offs(p_Tc12_T3_TeachPoint,0,100,0),v20,fine,tTc12\WObj:=wobj0;
        !
        !************************************************
        ! Tool 4 = Vacuum Tool 1
        !************************************************
        !
        ! Move over teach point 
        MoveJ Offs(p_Tc12_T4_TeachPoint,0,100,300),v100,fine,tTc12\WObj:=wobj0;
        MoveJ Offs(p_Tc12_T4_TeachPoint,0,0,300),v100,fine,tTc12\WObj:=wobj0;
        !
        ! Modify teach point 
        MoveL Offs(p_Tc12_T4_TeachPoint,0,25,0),v10,fine,tTc12\WObj:=wobj0;
        MoveL Offs(p_Tc12_T4_TeachPoint,0,10,0),v10,fine,tTc12\WObj:=wobj0;
        MoveL p_Tc12_T4_TeachPoint,v10,fine,tTc12\WObj:=wobj0;
        !
        ! Update workobjekt 
        ob_Tc12_T4:=fCreateFream(tTc12\poOffset:=po_Tc12_Offset);
        !
        ! Move away from teach point 
        MoveL Offs(p_Tc12_T4_TeachPoint,0,0,300),v20,fine,tTc12\WObj:=wobj0;
        !
        !************************************************
        ! Tool 5 = Vacuum Tool 2
        !************************************************
        !
        ConfJ\Off;
        ! Move over teach point 
        MoveJ Offs(p_Tc12_T5_TeachPoint,0,100,300),v100,fine,tTc12\WObj:=wobj0;
        MoveJ Offs(p_Tc12_T5_TeachPoint,0,0,300),v100,fine,tTc12\WObj:=wobj0;
        !
        ! Modify teach point 
        MoveL Offs(p_Tc12_T5_TeachPoint,0,25,0),v10,fine,tTc12\WObj:=wobj0;
        MoveL Offs(p_Tc12_T5_TeachPoint,0,10,0),v10,fine,tTc12\WObj:=wobj0;
        MoveL p_Tc12_T5_TeachPoint,v10,fine,tTc12\WObj:=wobj0;
        !
        ! Update workobjekt 
        ob_Tc12_T5:=fCreateFream(tTc12\poOffset:=po_Tc12_Offset);
        !
        ! Move away from teach point 
        MoveL Offs(p_Tc12_T5_TeachPoint,0,0,300),v20,fine,tTc12\WObj:=wobj0;
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
        MoveAbsJ jp_Tc12_StaPosTB,vRFLMax,z100,tool0;
        !
        ! Move to place position
        MoveJ p_Tc12_T1_PlaInTB,vRFLMax,fine,tTc12\WObj:=ob_Tc12_T1;
        !
        ! Move to place position
        MoveJ p_Tc12_T2_PlaInTB,vRFLMax,fine,tTc12\WObj:=ob_Tc12_T2;
        !
        ! Move to place position
        MoveJ p_Tc12_T3_PlaInTB,vRFLMax,fine,tTc12\WObj:=ob_Tc12_T3;
        !
        ! Move to place position
        MoveJ p_Tc12_T4_PlaInTB,vRFLMax,fine,tTc12\WObj:=ob_Tc12_T4;
        !
        ! Move to place position
        MoveJ p_Tc12_T5_PlaInTB,vRFLMax,fine,tTc12\WObj:=ob_Tc12_T5;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE
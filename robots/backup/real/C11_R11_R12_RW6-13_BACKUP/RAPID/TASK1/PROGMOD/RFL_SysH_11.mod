MODULE RFL_SysH_11
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
    ! HIB C 13 / Stefano-Franscini-Platz 1 
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A011_RFL
    !
    ! FUNCTION    :  System Helper Routines for ETH
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2017.07.07 Draft
    !
    ! Copyright   :  ETH Zurich (CH) 2017
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Start System Helper Management
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.07
    ! **************** ETH Zurich *******************
    !
    PROC rRFL_SysHelper()
        !
        WaitSyncTask idRFL_SysHSta,tlAll;
        !
        ! Init Var
        bSysHFinish:=FALSE;
        !
        ! Loop for System Management
        WHILE bSysHFinish=FALSE DO
            !
            ! Start System Management
            rUIMaWinSysH;
        ENDWHILE
        ! 
        WaitSyncTask idRFL_SysHEnd,tlAll;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
    
    !************************************************
    ! Function    :     User Interface Window System Helper
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.06
    ! **************** ETH Zurich *******************
    !
    PROC rUIMaWinSysH()
        !
        ! View Window Project
        nUiListItem:=UIListView(
                    \Result:=btnAnswer
                    \Header:="System Helper",
                    liMaWinSysH
                    \BtnArray:=stBtnOkExit
                    \Icon:=iconInfo
                    \DefaultIndex:=1);
        !
        ! Check answer
        IF btnAnswer=1 THEN
            !
            ! User reaction time
            WaitTime nTimUserReaction;
            !
            ! Button answer OK
            TEST nUiListItem
            CASE 1:
                !
                ! Item To Top
                rSysH_ToTop;
            CASE 2:
                !
                ! Item To Compact
                rSysH_ToCompact;
            CASE 3:
                !
                ! Item To Park
                rSysH_ToPark;
            CASE 4:
                !
                ! Item To Service
                rSysH_ToService;
            CASE 5:
                !
                ! Item Copy Position
                rSysH_CopyPos;
            CASE 6:
                !
                ! Item To Position
                rSysH_GantryToPos;
            DEFAULT:
                !
                ! Undefined Item 
                r_RFL_ProgError;
            ENDTEST
            !
            ! System Helper not finish
            bSysHFinish:=FALSE;
        ELSE
            !
            ! System Helper finish
            bSysHFinish:=TRUE;
        ENDIF
        !
        ! Start Job for Tasks
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Move Z-Axis up to top
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.07
    ! **************** ETH Zurich *******************
    !
    PROC rSysH_ToTop(\switch zMin\switch zMed\switch zMax)
        VAR zonedata zX;
        !
        ! Check and Set Zonedata
        IF Present(zMin) THEN
            ! 
            ! Zone
            zX:=zMaMin;
        ELSEIF Present(zMed) THEN
            ! 
            ! Zone
            zX:=zMaMed;
        ELSEIF Present(zMax) THEN
            ! 
            ! Zone
            zX:=zMaMax;
        ELSE
            ! 
            ! No Zone
            zX:=fine;
        ENDIF
        !
        ! Read current position
        rReadPosTemp;
        !
        ! Set Z-Axis
        jpTemp.extax.eax_c:=nZTop;
        !
        ! Move in position
        MoveAbsJ jpTemp\NoEOffs,vSysHMed,zX,tTemp;
        !
        RETURN ;
    ENDPROC

    !************************************************
    ! Function    :     Move Robot to top compact position
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.07
    ! **************** ETH Zurich *******************
    !
    PROC rSysH_ToCompact()
        !
        ! Move to top
        rSysH_ToTop\zMax;
        !
        ! Set Robot Position
        jpTemp.robax:=rjCompact;
        !
        ! Move in position
        MoveAbsJ jpTemp\NoEOffs,vSysHMed,fine,tTemp;
        !
        RETURN ;
    ENDPROC

    !************************************************
    ! Function    :     Move YZ-Axis and Robot in Park Position
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.07
    ! **************** ETH Zurich *******************
    !
    PROC rSysH_ToPark()
        !
        ! Move to top
        rSysH_ToTop\zMax;
        !
        ! Set Robot Position
        jpTemp.robax:=rjPark;
        !
        ! Set YZ-Axis
        jpTemp.extax.eax_b:=nYPark;
        jpTemp.extax.eax_c:=nZPark;
        !
        ! Move in position
        MoveAbsJ jpTemp\NoEOffs,vSysHMed,fine,tTemp;
        !
        RETURN ;
    ENDPROC

    !************************************************
    ! Function    :     Move Z-Axis down and Robot in Service Position
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.07
    ! **************** ETH Zurich *******************
    !
    PROC rSysH_ToService()
        !
        ! Read current position
        rReadPosTemp;
        !
        ! Read current tool
        rReadToolTemp;
        !
        ! Set Robot Position
        jpTemp.robax:=rjService;
        !
        ! Move in position
        MoveAbsJ jpTemp\NoEOffs,vSysHMed,zMaMed,tTemp;
        !
        ! Set Z-Axis
        jpTemp.extax.eax_c:=nZBottom;
        !
        ! Move in position
        MoveAbsJ jpTemp\NoEOffs,vSysHMed,fine,tTemp;
        !
        RETURN ;
    ENDPROC

    !************************************************
    ! Function    :     Copy Position from an other Robot and move Z-Axis and Robot in the same Position
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.07
    ! **************** ETH Zurich *******************
    !
    PROC rSysH_CopyPos()
        VAR jointtarget jpCopy;
        !
        ! Read current position from T_ROB12
        jpCopy:=CJointT(\TaskName:="T_Rob12");
        !
        ! Read current position
        rReadPosTemp;
        !
        ! Read current tool
        rReadToolTemp;
        !
        ! Set Robot Position
        jpTemp.robax:=jpCopy.robax;
        !
        ! Move in position
        MoveAbsJ jpTemp\NoEOffs,vSysHMed,zMaMed,tTemp;
        !
        ! Set Z-Axis
        jpTemp.extax.eax_c:=jpCopy.extax.eax_c;
        !
        ! Move in position
        MoveAbsJ jpTemp\NoEOffs,vSysHMed,fine,tTemp;
        !
        RETURN ;
    ENDPROC

    !************************************************
    ! Function    :     Move Gantry in Position
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.07
    ! **************** ETH Zurich *******************
    !
    PROC rSysH_GantryToPos()
        VAR bool bSysHGantryToPos;
        VAR string stMsg{3}:=["","",""];
        !
        ! Init Var
        bSysHGantryToPos:=FALSE;
        !
        ! Loop for System Management
        WHILE bSysHGantryToPos=FALSE DO
            !
            ! Read current position
            rReadPosTemp;
            !
            ! Read current tool
            rReadToolTemp;
            !
            ! Writ Ax Values in Message Array
            stMsg{1}:="X Pos = "+NumToStr(jpTemp.extax.eax_a,0)+" mm";
            stMsg{2}:="Y Pos = "+NumToStr(jpTemp.extax.eax_b,0)+" mm";
            stMsg{3}:="Z Pos = "+NumToStr(jpTemp.extax.eax_c,0)+" mm";
            !
            ! User Windoew To Pos 
            nAnswer:=UIMessageBox(
                \Header:="Gantry To Pos"
                \MsgArray:=stMsg
                \BtnArray:=stBtnToPos
                \Icon:=iconInfo);
            !
            ! Check answer
            TEST nAnswer
            CASE 1,2,3:
                !
                ! X,Y and Z Pos Absolut
                !
                ! Select X,Y or Z
                TEST nAnswer
                CASE 1:
                    !
                    ! User Window X entry
                    nTemp:=UINumEntry(
                            \Header:=stMsg{1}
                            \Message:="Please, enter the nwe Data."
                            \Icon:=iconInfo
                            \InitValue:=Round(jpTemp.extax.eax_a)
                            \MinValue:=nMinValueX
                            \MaxValue:=nMaxValueX
                            \AsInteger);
                    !
                    ! Set X-Axis
                    jpTemp.extax.eax_a:=nTemp;
                CASE 2:
                    !
                    ! User Window Y entry
                    nTemp:=UINumEntry(
                            \Header:=stMsg{2}
                            \Message:="Please, enter the nwe Data."
                            \Icon:=iconInfo
                            \InitValue:=Round(jpTemp.extax.eax_b)
                            \MinValue:=nMinValueY
                            \MaxValue:=nMaxValueY
                            \AsInteger);
                    !
                    ! Set Y-Axis
                    jpTemp.extax.eax_b:=nTemp;
                CASE 3:
                    !
                    ! User Window Z entry
                    nTemp:=UINumEntry(
                            \Header:=stMsg{3}
                            \Message:="Please, enter the nwe Data."
                            \Icon:=iconInfo
                            \InitValue:=Round(jpTemp.extax.eax_c)
                            \MinValue:=nMinValueZ
                            \MaxValue:=nMaxValueZ
                            \AsInteger);
                    !
                    ! Set Z-Axis
                    jpTemp.extax.eax_c:=nTemp;
                DEFAULT:
                    !
                    ! No function
                    r_RFL_ProgError;
                ENDTEST
            CASE 4:
                !
                ! Exit
                bSysHGantryToPos:=TRUE;
            DEFAULT:
                !
                ! No function
                r_RFL_ProgError;
            ENDTEST
            !
            ! Move in position
            MoveAbsJ jpTemp\NoEOffs,vSysHMed,fine,tTemp;
        ENDWHILE
        !
        RETURN ;
    ENDPROC
ENDMODULE
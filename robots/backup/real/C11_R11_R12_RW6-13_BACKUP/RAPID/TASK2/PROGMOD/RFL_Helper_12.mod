MODULE RFL_Helper_12
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
    ! FUNCTION    :  Helper Routines for ETH
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2016.08.09 Draft
    !
    ! Copyright   :  ETH Zurich (CH) 2016
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Read curretn Roboterposition and write it in Temp Variables
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.05.05
    !***************** ETH Zurich *******************
    !
    PROC rReadPosTemp(\switch FlyBy)
        !
        ! Check for FlyBy
        IF Present(FlyBy) THEN
            !
            ! Do not wait for stand still
        ELSE
            !
            ! Wait for Robot in position or zero speed
            WaitRob\ZeroSpeed;
        ENDIF
        !
        ! Read current joint position
        jpTemp:=CJointT();
        !
        ! Read current robtarget position
        pTemp:=CRobT(\Tool:=tool0\WObj:=wobj0);
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Read curretn Robotertool and write it in Temp Variables
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.05.05
    !***************** ETH Zurich *******************
    !
    PROC rReadToolTemp()
        !
        ! Read tooldata and tool name
        GetSysData tTemp\ObjectName:=stTempToolName;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Stor current position
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.11.16
    ! **************** ETH Zurich *******************
    !
    PROC rStorePos()
        !
        ! Check that the robot is not in motion
        WaitRob\ZeroSpeed;
        !
        ! When robot in safepos z then not store
        IF fCompJPos(jpSafePosZ,1\bCheckZAxis:=TRUE\nLimMM:=1) THEN
            !
            ! Robot in SafePosZ => not stred
        ELSE
            ! Robot not in SafePosZ => stred
            !
            ! Store current position
            pStore:=CRobT(\Tool:=tool0\WObj:=wobj0);
            !
            ! Store current jointvalues
            jpStore:=CJointT();
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Current position
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.11.21
    ! **************** ETH Zurich *******************
    !
    PROC rCurrentPos()
        !
        ! Check that the robot is not in motion
        WaitRob\ZeroSpeed;
        !
        ! Store current position
        pCurrent:=CRobT(\Tool:=tool0\WObj:=wobj0);
        !
        ! Store current jointvalues
        jpCurrent:=CJointT();
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Move back to stored position
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.11.16
    ! **************** ETH Zurich *******************
    !
    PROC rRestorePos()
        VAR bool bConfJOff;
        !
        ! Read and store configuration state
        IF C_MOTSET.conf.jsup=FALSE bConfJOff:=TRUE;
        !
        ! Activate configuration
        ConfJ\On;
        !
        ! Move to stored position
        MoveJ pStore,vRestorPos,fine,tool0\WObj:=wobj0;
        !
        ! When the configuration was deactivated restor the state
        IF bConfJOff=TRUE ConfJ\Off;
        !
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Move Robot to safe position on top with Z-Axis
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.03.02
    ! **************** ETH Zurich *******************
    !
    PROC rMoveToSafePosZ()
        !
        ! Wait for Robot in position or zero speed
        WaitRob\ZeroSpeed;
        !
        ! Read current position
        jpTemp:=CJointT();
        !
        ! Move Z-Axis in safty position on top
        jpTemp.extax.eax_c:=nSafePosZ;
        MoveAbsJ jpTemp,vSafePosMed,z100,tool0;
        !
        ! Overwrite RobPos, X-Axis and Y-Axis 
        jpSafePosZ.extax.eax_a:=jpTemp.extax.eax_a;
        jpSafePosZ.extax.eax_b:=jpTemp.extax.eax_b;
        ! 
        ! Move to safty position on top
        MoveAbsJ jpSafePosZ,vSafePosMax,z100,tool0;
        !
        RETURN ;
    ENDPROC

    !************************************************
    ! Function    :     Move Z-Axis to top position
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.12.20
    ! **************** ETH Zurich *******************
    !
    PROC rMoveZAxToTop()
        !
        ! Wait for Robot in position or zero speed
        WaitRob\ZeroSpeed;
        !
        ! Read current position
        jpTemp:=CJointT();
        !
        ! Move Z-Axis in safty position on top
        jpTemp.extax.eax_c:=nTopPosZ;
        MoveAbsJ jpTemp,vSafePosMed,fine,tool0;
        !
        RETURN ;
    ENDPROC

    !************************************************
    ! Function    :     Test Relativ Task X-, Y-, Z-Axis 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.11.17
    ! **************** ETH Zurich *******************
    ! Code example:
    ! IF fCheckAchsPos(jpRoStop,1) THEN
    !
    FUNC bool fCompJPos(
        jointtarget jpCompare,
        num nLimDec,
        \bool bCheckXAxis,
        \bool bCheckYAxis,
        \bool bCheckZAxis,
        \num nLimMM)
        !
        ! Input Parameter:
        ! Jointarget to compare
        ! Limt [°] for comparability test
        ! opt. compare X-Axis
        ! opt. compare Y-Axis
        ! opt. compare Z-Axis
        ! Limt [mm] for comparability test
        !
        !  Return Parameter: 
        ! comparability test true or false
        VAR bool bRes:=TRUE;
        ! 
        ! Intern Declaration
        VAR jointtarget jpCurrent;
        !
        ! Start Function
        !
        ! Wait for Robo
        WaitRob\ZeroSpeed;
        !
        ! Read current jonttarget
        jpCurrent:=CJointT();
        !
        ! Compare Roboter Joints
        !
        ! If the values are too high, bRes go to "FALSE"
        IF Abs(jpCompare.robax.rax_1-jpCurrent.robax.rax_1)>=nLimDec bRes:=FALSE;
        IF Abs(jpCompare.robax.rax_2-jpCurrent.robax.rax_2)>=nLimDec bRes:=FALSE;
        IF Abs(jpCompare.robax.rax_3-jpCurrent.robax.rax_3)>=nLimDec bRes:=FALSE;
        IF Abs(jpCompare.robax.rax_4-jpCurrent.robax.rax_4)>=nLimDec bRes:=FALSE;
        IF Abs(jpCompare.robax.rax_5-jpCurrent.robax.rax_5)>=nLimDec bRes:=FALSE;
        IF Abs(jpCompare.robax.rax_6-jpCurrent.robax.rax_6)>=nLimDec bRes:=FALSE;
        !
        ! Compare X-Axis
        IF Present(bCheckXAxis) AND bCheckXAxis=TRUE THEN
            IF Abs(jpCompare.extax.eax_a-jpCurrent.extax.eax_a)>=nLimMM bRes:=FALSE;
        ENDIF
        !
        ! Compare Y-Axis
        IF Present(bCheckYAxis) AND bCheckYAxis=TRUE THEN
            IF Abs(jpCompare.extax.eax_b-jpCurrent.extax.eax_b)>=nLimMM bRes:=FALSE;
        ENDIF
        !
        ! Compare Z-Axis
        IF Present(bCheckZAxis) AND bCheckZAxis=TRUE THEN
            TPWrite ""\Num:=Abs(jpCompare.extax.eax_c-jpCurrent.extax.eax_c);
            IF Abs(jpCompare.extax.eax_c-jpCurrent.extax.eax_c)>=nLimMM bRes:=FALSE;
        ENDIF
        RETURN bRes;
    ENDFUNC

    PROC rSysChangePos()
        MoveAbsJ [[-0.00050335,-0.000943316,-0.000687733,-0.000387798,-0.00044726,0.00067497],[18766,-7079,-4514.99,0,0,0]]\NoEOffs,v1000,z50,tool0;
    ENDPROC

    !************************************************
    ! Function    :     TP Message User Information
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.04.26
    ! **************** ETH Zurich *******************
    !
    PROC rTPMsg(string stMsg)
        ! 
        ! Clear Msg Panel
        TPErase;
        !
        ! Msg for user
        TPWrite stMsg;
        !
        ! Time to read the Msg
        WaitTime nTimeTPMsg;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Safety Message
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.03.01
    !***************** ETH Zurich *******************
    !
    ! Example declaration 
    ! LOCAL CONST smsg smsgCute:=["E001 Saw Safety","Press Saw to start the sawing process.","Or exit the program with PP-Main","","","","* Saw *","180118_E001_CNC-Saw-Cut_PF.jpg"];
    ! 
    ! Example call
    !r_RFL_SMsg smsgCute;
    !
    !************************************************
    !
    PROC r_RFL_SMsg(smsg smsgMsg)
        VAR bool bAnswerOk;
        VAR num nBtnPos;
        VAR string stMsg{5};
        VAR string stBtn{5};
        !
        ! Init var
        bAnswerOk:=FALSE;
        !
        ! Set button position
        IF nSMsgBtnPos<5 THEN
            !
            ! increase button position
            Incr nSMsgBtnPos;
        ELSE
            !
            ! Reset button position
            nSMsgBtnPos:=1;
        ENDIF
        ! 
        ! Overgive message
        stMsg{1}:=smsgMsg.Line1;
        stMsg{2}:=smsgMsg.Line2;
        stMsg{3}:=smsgMsg.Line3;
        stMsg{4}:=smsgMsg.Line4;
        stMsg{5}:=smsgMsg.Line5;
        !
        ! Overgive button
        stBtn{nSMsgBtnPos}:=smsgMsg.Button;
        !
        ! Message loop
        WHILE bAnswerOk=FALSE DO
            !
            ! Message Window 
            nAnswer:=UIMessageBox(
            \Header:=smsgMsg.Header
            \MsgArray:=stMsg
            \BtnArray:=stBtn
            \Icon:=iconWarning
            \Image:=smsgMsg.Image);
            !
            ! Check answer
            TEST nAnswer
            CASE nSMsgBtnPos:
                !
                ! Answer ok
                bAnswerOk:=TRUE;
            DEFAULT:
                !
                ! Answer nok ok
            ENDTEST
        ENDWHILE
        RETURN ;
    ERROR
        RETURN ;
    ENDPROC

    !************************************************
    ! Function    :     Event Log Message
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.06.14
    !***************** ETH Zurich *******************
    !
    PROC r_RFL_EvLogMsg(string stHeader,string stMsg)
        ! 
        ! Msg for user
        ErrWrite\I,stHeader+" "+stMsg,"rLogMsg";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Log Message User Information
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.04.26
    ! **************** ETH Zurich *******************
    !
    PROC rLogMsg(string stHeader,string stMsg)
        ! 
        ! Msg for user
        ErrWrite\I,GetTaskName()+" "+stHeader+" "+stMsg,"rLogMsg";
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Check Y-Axis collision for moving
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.05.19
    !***************** ETH Zurich *******************
    !
    PROC rCheckYAxisCol(num nCheck)
        VAR num nY11;
        VAR num nY12;
        VAR num nMinDistance;
        VAR num nSafeOffs;
        !
        ! Set Default Values
        nSafeOffs:=29;
        nMinDistance:=-2587-nSafeOffs;
        !
        ! Read current pos form Rob11
        pTemp:=CRobT(\TaskName:="T_Rob11"\Tool:=tool0\WObj:=wobj0);
        !
        ! Write axis values to variable
        nY11:=pTemp.extax.eax_b+nMinDistance;
        !* nY12:=pCheck.extax.eax_b;
        nY12:=nCheck;
        !
        ! Compaire the Y-Values
        IF nY12<nY11 THEN
            !
            ! No collision
        ELSE
            !
            ! Y-Axis will collide
            rTPMsg " Y-Axis Collision";
            TPWrite "Min. Y-Position    = "\Num:=nY11;
            TPWrite "Planned Y-Position = "\Num:=nY12;
            !
            ! Stop program
            Stop;
        ENDIF
        !
        ! Log Msg 
        rLogMsg "RFL","Check Y-Axis collision done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    PROC r_Tc11_RefPoint()
        MoveAbsJ [[-0.000245842,-65,65.0002,-2.15874E-05,35.0001,1.40727E-05],[9561.73,-5555,-4850,0,0,0]]\NoEOffs,v100,fine,tool0;
    ENDPROC


    !************************************************
    ! Function    :     Get workobject data from a string
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.06.26
    !***************** ETH Zurich *******************
    !
    FUNC wobjdata fGetWobFrmStr(string stWobj)
        VAR wobjdata obVar:=[FALSE,TRUE,"",[[0,0,0],[1,0,0,0]],[[0,0,0],[1,0,0,0]]];
        !
        ! Read Value from string
        GetDataVal stWobj,obVar;
        RETURN obVar;
    ERROR
        ! Placeholder for Error Code...
    ENDFUNC

    !************************************************
    ! Function    :     Get tooldata from a string
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.06.26
    !***************** ETH Zurich *******************
    !
    FUNC tooldata fGetToolFrmStr(string stIn)
        VAR tooldata tVar:=[TRUE,[[0,0,0],[1,0,0,0]],[0,[0,0,0],[1,0,0,0],0,0,0]];
        !
        ! Read Value from string
        GetDataVal stIn,tVar;
        RETURN tVar;
    ERROR
        ! Placeholder for Error Code...
    ENDFUNC

    !************************************************
    ! Function    :     Create Frame with or without offset from Current position 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.27
    !***************** ETH Zurich *******************
    !
    FUNC wobjdata fCreateFream(tooldata tTool,\pose poOffset)
        VAR wobjdata obX;
        !
        ! Read current tool
        tTemp:=tTool;
        !
        ! Read current position 
        pTemp:=CRobT(\Tool:=tTemp\WObj:=wobj0);
        !
        ! Reset workobject
        obX:=wobj0;
        !
        ! Set translation 
        obX.uframe.trans:=pTemp.trans;
        !
        ! Set rotation 
        obX.uframe.rot:=pTemp.rot;
        !
        ! Calculate object with offset is present
        IF Present(poOffset) obX.uframe:=PoseMult(obX.uframe,poOffset);
        RETURN obX;
    ERROR
        ! Placeholder for Error Code...
    ENDFUNC

    !************************************************
    ! Function    :     Check IOUnit State
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.08.29
    !***************** ETH Zurich *******************
    !
    PROC r_RFL_GetIOUnitState(string stIOUnit\switch Phys\switch Logic)
        VAR num nIOUState;
        VAR string stIOUState;
        VAR string stIOUStateDescrL1;
        VAR string stIOUStateDescrL2;
        !
        ! Read IOUnit state depant 
        IF Present(Phys) THEN
            !
            ! Read physical state
            nIOUState:=IOUnitState(stIOUnit\Phys);
        ELSEIF Present(Logic) THEN
            !
            ! Read logical state
            nIOUState:=IOUnitState(stIOUnit\Logic);
        ELSE
            ! Read genearl state
            nIOUState:=IOUnitState(stIOUnit);
        ENDIF
        !
        ! Check IOUnit state
        TEST nIOUState
        CASE 1:
            !
            ! IOUNIT_RUNNING
            stIOUState:="IOUNIT_RUNNING";
            stIOUStateDescrL1:="I/O device is up and running";
        CASE 2:
            !
            ! IOUNIT_RUNERROR
            stIOUState:="IOUNIT_RUNERROR";
            stIOUStateDescrL1:="I/O device is not working because of some runtime error";
        CASE 3:
            !
            ! IOUNIT_DISABLE
            stIOUState:="IOUNIT_DISABLE";
            stIOUStateDescrL1:="I/O device is disabled by user from RAPID or FlexPendant";
        CASE 4:
            !
            ! IOUNIT_OTHERERR
            stIOUState:="IOUNIT_OTHERERR";
            stIOUStateDescrL1:="Other configuration or startup errors";
        CASE 10:
            !
            ! IOUNIT_LOG_STATE_DISABLED
            stIOUState:="IOUNIT_LOG_STATE_DISABLED";
            stIOUStateDescrL1:="I/O device is disabled by user from RAPID, FlexPendant or System Parameters.";
        CASE 11:
            !
            ! IOUNIT_LOG_STATE_ENABLED
            stIOUState:="IOUNIT_LOG_STATE_ENABLED";
            stIOUStateDescrL1:="I/O device is enabled by user from RAPID, FlexPendant or System Parameters.";
            stIOUStateDescrL2:="Default after startup.";
        CASE 20:
            !
            ! IOUNIT_PHYS_STATE_DEACTIVATED
            stIOUState:="IOUNIT_PHYS_STATE_DEACTIVATED";
            stIOUStateDescrL1:="I/O device is not running, disabled by user";
        CASE 21:
            !
            ! IOUNIT_PHYS_STATE_RUNNING
            stIOUState:="IOUNIT_PHYS_STATE_RUNNING";
            stIOUStateDescrL1:="I/O device is running";
        CASE 22:
            !
            ! IOUNIT_PHYS_STATE_ERROR
            stIOUState:="IOUNIT_PHYS_STATE_ERROR";
            stIOUStateDescrL1:="I/O device is not working because of some runtime error";
        CASE 23:
            !
            ! IOUNIT_PHYS_STATE_UNCONNECTED
            stIOUState:="IOUNIT_PHYS_STATE_UNCONNECTED";
            stIOUStateDescrL1:="I/O device is configured but not connected to the I/O network";
            stIOUStateDescrL2:="or the I/O network is stopped.";
        CASE 24:
            !
            ! IOUNIT_PHYS_STATE_UNCONFIGURED
            stIOUState:="IOUNIT_PHYS_STATE_UNCONFIGURED";
            stIOUStateDescrL1:="I/O device is not configured but connected to the I/O network. 1)";
        CASE 25:
            !
            ! IOUNIT_PHYS_STATE_STARTUP
            stIOUState:="IOUNIT_PHYS_STATE_STARTUP";
            stIOUStateDescrL1:="I/O device is in start up mode. 1)";
        CASE 26:
            !
            ! IOUNIT_PHYS_STATE_INIT
            stIOUState:="IOUNIT_PHYS_STATE_INIT";
            stIOUStateDescrL1:="I/O device is created. 1)";
        DEFAULT:
            !
            ! Unknown State
            stIOUState:="Unknown State Nr:= "+NumToStr(nIOUState,0);
            stIOUStateDescrL1:="Check the ABB Documentationn)";
        ENDTEST
        !
        ! User Message
        UIMsgBox
            \Header:="RFL IOUnit State",stIOUState
            \MsgLine2:=stIOUStateDescrL1
            \MsgLine3:=stIOUStateDescrL2
            \MsgLine4:=""
            \MsgLine5:="State Nr:= "+NumToStr(nIOUState,0)
            \Buttons:=btnOK
            \Icon:=iconInfo;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Check IOUnit Ready
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.08.29
    !***************** ETH Zurich *******************
    !
    FUNC bool f_RFL_CheckIOUnitReady(string stIOUnit)
        ! Read genearl state
        IF IOUnitState(stIOUnit)=1 THEN
            !    
            ! IOUNIT_RUNNING
            ! I/O device is up and running
            RETURN TRUE;
        ELSE
            !
            ! Allo other states
            RETURN FALSE;
        ENDIF
    ERROR
        ! Placeholder for Error Code...
    ENDFUNC
ENDMODULE
MODULE RFL_Helper_11
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

    !************************************************
    ! Function    :     TP Message User Information
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.04.26
    ! **************** ETH Zurich *******************
    !
    PROC rTPMsg(string stMsg\switch NoTime)
        ! 
        ! Clear Msg Panel
        TPErase;
        !
        ! Msg for user
        TPWrite stMsg;
        !
        ! Time to read the Msg
        IF NOT Present(NoTime) WaitTime nTimeTPMsg;
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
        pTemp:=CRobT(\TaskName:="T_Rob12"\Tool:=tool0\WObj:=wobj0);
        !
        ! Write axis values to variable
        !* nY11:=pCheck.extax.eax_b;
        nY11:=nCheck;
        nY12:=pTemp.extax.eax_b-nMinDistance;
        !
        ! Compaire the Y-Values
        IF nY11>nY12 THEN
            !
            ! No collision
        ELSE
            !
            ! Y-Axis will collide
            rTPMsg " Y-Axis Collision";
            TPWrite "Max. Y-Position    = "\Num:=nY12;
            TPWrite "Planned Y-Position = "\Num:=nY11;
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

ENDMODULE
MODULE RFL_Helper_M
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
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
    ! HISTORY     :  2017.07.06 Draft
    !
    ! Copyright   :  ETH Zurich (CH) 2017
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Safety Message cut
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.03.01
    !***************** ETH Zurich *******************
    !
    PROC r_RFL_SMsgOld(string stHeader,string stMsgName,string stBtn,string stImage)
        VAR string stButtons{5}:=["","","","",""];
        VAR string stSMsgCut{5}:=["","","","",""];
        !
        ! CONST string my_message{5}:= ["Message Line 1","Message Line 2", "Message Line 3","Message Line 4","Message Line 5"]; 
        ! [\MsgArray]
        ! Message Array
        ! Data type: string
        ! Several text lines from an array to be written on the display.
        ! Only one of parameter \Message or \MsgArray can be used at the same time.
        ! Max. layout space is 11 lines with 55 characters each.
        !
        ! Set button
        stButtons{3}:=stBtn;
        ! Test Message
        nAnswer:=UIMessageBox(
            \Header:=stHeader
            \MsgArray:=stSMsgCut
            \BtnArray:=stButtons
            \Icon:=iconWarning
            \Image:=stImage);
        RETURN ;
    ERROR
        RETURN ;
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


ENDMODULE
MODULE RRC_Performance_Tests
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  RRC - Rapid Robot Communication
    !
    ! FUNCTION    :  Includes instructions for all performance tests  
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  rrc@arch.ethz.ch
    !
    ! HISTORY     :  2021.06.30
    !
    ! Copyright   :  ETH Zurich (CH) 2019
    !                - Philippe Fleischmann
    !                - Michael Lyrenmann
    !                - Gonzalo Casas
    !
    ! License     :  This code base is governed by an EULA (End-User License Agreement)
    !                which you have received together with the software.
    !                You are not allowed to use the software on a real robots
    !                without a signed EULA.
    !
    !                A copy of the EULA content is in the controller task (T_CTRL).
    !
    !***********************************************************************************

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    ! Sequence ID
    TASK PERS num n_RRC_S_ID:=11;
    !
    ! Execution Level
    TASK PERS num n_RRC_E_Lev:=0;
    !
    ! Feedback Level
    TASK PERS num n_RRC_F_Lev:=2;
    !
    ! Value 1..10
    TASK PERS num n_RRC_Value_1:=1;
    TASK PERS num n_RRC_Value_2:=2;
    TASK PERS num n_RRC_Value_3:=3;
    TASK PERS num n_RRC_Value_4:=4;
    TASK PERS num n_RRC_Value_5:=5;
    TASK PERS num n_RRC_Value_6:=6;
    TASK PERS num n_RRC_Value_7:=7;
    TASK PERS num n_RRC_Value_8:=8;
    TASK PERS num n_RRC_Value_9:=9;
    TASK PERS num n_RRC_Value_10:=10;
    !
    ! Value 11..20
    TASK PERS num n_RRC_Value_11:=11;
    TASK PERS num n_RRC_Value_12:=12;
    TASK PERS num n_RRC_Value_13:=13;
    TASK PERS num n_RRC_Value_14:=14;
    TASK PERS num n_RRC_Value_15:=15;
    TASK PERS num n_RRC_Value_16:=16;
    TASK PERS num n_RRC_Value_17:=17;
    TASK PERS num n_RRC_Value_18:=18;
    TASK PERS num n_RRC_Value_19:=19;
    TASK PERS num n_RRC_Value_20:=20;
    !
    ! Value 21..30
    TASK PERS num n_RRC_Value_21:=21;
    TASK PERS num n_RRC_Value_22:=22;
    TASK PERS num n_RRC_Value_23:=23;
    TASK PERS num n_RRC_Value_24:=24;
    TASK PERS num n_RRC_Value_25:=25;
    TASK PERS num n_RRC_Value_26:=26;
    TASK PERS num n_RRC_Value_27:=27;
    TASK PERS num n_RRC_Value_28:=28;
    TASK PERS num n_RRC_Value_29:=29;
    TASK PERS num n_RRC_Value_30:=20;
    !
    ! Value 31..36
    TASK PERS num n_RRC_Value_31:=31;
    TASK PERS num n_RRC_Value_32:=32;
    TASK PERS num n_RRC_Value_33:=33;
    TASK PERS num n_RRC_Value_34:=34;
    TASK PERS num n_RRC_Value_35:=35;
    TASK PERS num n_RRC_Value_36:=36;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    ! Stings 1..8
    TASK PERS string st_RRC_String_1:="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
    TASK PERS string st_RRC_String_2:="bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb";
    TASK PERS string st_RRC_String_3:="cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc";
    TASK PERS string st_RRC_String_4:="dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd";
    TASK PERS string st_RRC_String_5:="eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee";
    TASK PERS string st_RRC_String_6:="ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff";
    TASK PERS string st_RRC_String_7:="gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg";
    TASK PERS string st_RRC_String_8:="hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh";

    !************************************************
    ! Function    :     Test Feedback minimum data
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2019.02.22
    !***************** ETH Zurich *******************
    !
    PROC r()
        !
        ! Empty instruction
        !
        ! Feedback
        IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>0 THEN
            !
            ! Instruction done 
            r_RRC_FDone;
            !
            ! Check additional feedback
            IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>1 THEN
                !
                ! Cenerate feedback
                TEST bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev
                DEFAULT:
                    !
                    ! Not defined 
                    !
                    ! Feedback not supported  
                    r_RRC_FError;
                ENDTEST
            ENDIF
            !
            ! Move message in send buffer
            r_RRC_MovMsgToSenBufRob n_RRC_ChaNr;
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Test Feedback maximal data
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2019.02.22
    !***************** ETH Zurich *******************
    !
    PROC r_RRC_PerfooooooooormanceMaxData()
        !
        ! Max data instruction but without any action
        !
        ! Sequence ID
        n_RRC_S_ID:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.S_ID;
        !
        ! Execution Level
        n_RRC_E_Lev:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.E_Lev;
        !
        ! Feedback Level
        n_RRC_F_Lev:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev;
        !
        ! Stings 1..8
        st_RRC_String_1:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.St1;
        st_RRC_String_2:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.St2;
        st_RRC_String_3:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.St3;
        st_RRC_String_4:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.St4;
        st_RRC_String_5:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.St5;
        st_RRC_String_6:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.St6;
        st_RRC_String_7:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.St7;
        st_RRC_String_8:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.St8;
        !
        ! Value 1..10
        n_RRC_Value_1:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V1;
        n_RRC_Value_2:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V2;
        n_RRC_Value_3:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V3;
        n_RRC_Value_4:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V4;
        n_RRC_Value_5:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V5;
        n_RRC_Value_6:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V6;
        n_RRC_Value_7:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V7;
        n_RRC_Value_8:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V8;
        n_RRC_Value_9:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V9;
        n_RRC_Value_10:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V10;
        !
        ! Value 11..20
        n_RRC_Value_11:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V11;
        n_RRC_Value_12:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V12;
        n_RRC_Value_13:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V13;
        n_RRC_Value_14:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V14;
        n_RRC_Value_15:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V15;
        n_RRC_Value_16:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V16;
        n_RRC_Value_17:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V17;
        n_RRC_Value_18:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V18;
        n_RRC_Value_19:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V19;
        n_RRC_Value_20:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V20;
        !
        ! Value 21..30
        n_RRC_Value_21:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V21;
        n_RRC_Value_22:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V22;
        n_RRC_Value_23:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V23;
        n_RRC_Value_24:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V24;
        n_RRC_Value_25:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V25;
        n_RRC_Value_26:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V26;
        n_RRC_Value_27:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V27;
        n_RRC_Value_28:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V28;
        n_RRC_Value_29:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V29;
        n_RRC_Value_30:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V20;
        !
        ! Value 31..36
        n_RRC_Value_31:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V31;
        n_RRC_Value_32:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V32;
        n_RRC_Value_33:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V33;
        n_RRC_Value_34:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V34;
        n_RRC_Value_35:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V35;
        n_RRC_Value_36:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V36;
        !
        ! Feedback
        IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>0 THEN
            !
            ! Instruction done 
            r_RRC_FDone;
            !
            ! Check additional feedback
            IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>1 THEN
                !
                ! Cenerate feedback
                TEST bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev
                CASE 2:
                    !
                    ! String feedback 1..4
                    r_RRC_FAddString "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
                    r_RRC_FAddString "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb";
                    r_RRC_FAddString "cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc";
                    r_RRC_FAddString "dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd";
                    !
                    ! String feedback 5..8
                    r_RRC_FAddString "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee";
                    r_RRC_FAddString "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff";
                    r_RRC_FAddString "gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg";
                    r_RRC_FAddString "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh";
                    !
                    ! Value feedback 1..10
                    r_RRC_FAddValue 1.1;
                    r_RRC_FAddValue 2.1;
                    r_RRC_FAddValue 3.1;
                    r_RRC_FAddValue 4.1;
                    r_RRC_FAddValue 5.1;
                    r_RRC_FAddValue 6.1;
                    r_RRC_FAddValue 7.1;
                    r_RRC_FAddValue 8.1;
                    r_RRC_FAddValue 9.1;
                    r_RRC_FAddValue 10.1;
                    !
                    ! Value feedback 11..20
                    r_RRC_FAddValue 11.1;
                    r_RRC_FAddValue 12.1;
                    r_RRC_FAddValue 13.1;
                    r_RRC_FAddValue 14.1;
                    r_RRC_FAddValue 15.1;
                    r_RRC_FAddValue 16.1;
                    r_RRC_FAddValue 17.1;
                    r_RRC_FAddValue 18.1;
                    r_RRC_FAddValue 19.1;
                    r_RRC_FAddValue 20.1;
                    !
                    ! Value feedback 21..30
                    r_RRC_FAddValue 21.1;
                    r_RRC_FAddValue 22.1;
                    r_RRC_FAddValue 23.1;
                    r_RRC_FAddValue 24.1;
                    r_RRC_FAddValue 25.1;
                    r_RRC_FAddValue 26.1;
                    r_RRC_FAddValue 27.1;
                    r_RRC_FAddValue 28.1;
                    r_RRC_FAddValue 29.1;
                    r_RRC_FAddValue 30.1;
                    !
                    ! Value feedback 31..36
                    r_RRC_FAddValue 31.1;
                    r_RRC_FAddValue 32.1;
                    r_RRC_FAddValue 33.1;
                    r_RRC_FAddValue 34.1;
                    r_RRC_FAddValue 35.1;
                    r_RRC_FAddValue 36.1;
                    !
                    ! Feedback 
                    bm_RRC_ActSenMsgRob.Data.Feedb:="Done_PerfooooooooooooooooooooooooooooooooooooooooooooooooooooooormenzTestMaxData";
                DEFAULT:
                    !
                    ! Feedback not supported  
                    r_RRC_FError;
                ENDTEST
            ENDIF
            !
            ! Move message in send buffer
            r_RRC_MovMsgToSenBufRob n_RRC_ChaNr;
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Test Feedback 128 byte data
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2019.02.22
    !***************** ETH Zurich *******************
    !
    PROC r_RRC_Performance_128()
        !
        ! Feedback
        IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>0 THEN
            !
            ! Instruction done 
            r_RRC_FDone;
            !
            ! Check additional feedback
            IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>1 THEN
                !
                ! Cenerate feedback
                TEST bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev
                CASE 2:
                    !
                    ! Value feedback 1..10
                    r_RRC_FAddValue 1.1;
                    r_RRC_FAddValue 2.1;
                    r_RRC_FAddValue 3.1;
                    r_RRC_FAddValue 4.1;
                    r_RRC_FAddValue 5.1;
                    r_RRC_FAddValue 6.1;
                    r_RRC_FAddValue 7.1;
                    r_RRC_FAddValue 8.1;
                    r_RRC_FAddValue 9.1;
                    r_RRC_FAddValue 10.1;
                    !
                    ! Value feedback 11..20
                    r_RRC_FAddValue 11.1;
                    r_RRC_FAddValue 12.1;
                    r_RRC_FAddValue 13.1;
                    r_RRC_FAddValue 14.1;
                DEFAULT:
                    !
                    ! Feedback not supported  
                    r_RRC_FError;
                ENDTEST
            ENDIF
            !
            ! Move message in send buffer
            r_RRC_MovMsgToSenBufRob n_RRC_ChaNr;
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Test Feedback 128 byte data
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2019.02.22
    !***************** ETH Zurich *******************
    !
    PROC r_RRC_Performance___127()
        !
        ! Feedback
        IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>0 THEN
            !
            ! Instruction done 
            r_RRC_FDone;
            !
            ! Check additional feedback
            IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>1 THEN
                !
                ! Cenerate feedback
                TEST bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev
                CASE 2:
                    !
                    ! Value feedback 1..10
                    r_RRC_FAddValue 1.1;
                    r_RRC_FAddValue 2.1;
                    r_RRC_FAddValue 3.1;
                    r_RRC_FAddValue 4.1;
                    r_RRC_FAddValue 5.1;
                    r_RRC_FAddValue 6.1;
                    r_RRC_FAddValue 7.1;
                    r_RRC_FAddValue 8.1;
                    r_RRC_FAddValue 9.1;
                    r_RRC_FAddValue 10.1;
                    !
                    ! Value feedback 11..20
                    r_RRC_FAddValue 11.1;
                    r_RRC_FAddValue 12.1;
                    r_RRC_FAddValue 13.1;
                DEFAULT:
                    !
                    ! Feedback not supported  
                    r_RRC_FError;
                ENDTEST
            ENDIF
            !
            ! Move message in send buffer
            r_RRC_MovMsgToSenBufRob n_RRC_ChaNr;
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE
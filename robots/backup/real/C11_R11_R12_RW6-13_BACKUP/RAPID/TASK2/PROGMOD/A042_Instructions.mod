MODULE A042_Instructions
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A042 RRC - RAPID Robot Communication
    !
    ! FUNCTION    :  Custom instructions
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  rrc@arch.ethz.ch
    !
    ! HISTORY     :  2024.1029
    !
    ! Copyright   :  ETH Zurich (CH) 2022
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Move to (MoveL or MoveJ)
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2019.02.22
    !***************** ETH Zurich *******************
    !
    PROC r_A042_MoveSearch()
        VAR robtarget pFastSearchPoint;
        VAR robtarget pFineSearchPoint;
        VAR num nSearchOffset;
        VAR num nSearchDistance;
        VAR num nFastSearch;
        VAR num nFineSearch;
        VAR speeddata vFastSearch;
        VAR speeddata vFineSearch;
        !
        ! Set search speed
        vFastSearch:=v5;
        vFastSearch.v_tcp:=50;
        vFineSearch:=v5;
        vFineSearch.v_tcp:=5;
        !
        ! Read and set robtarget
        r_RRC_RASRobtarget\stMoveType:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.st1;
        !
        ! Read and set tcp speed
        r_RRC_RasTCPSpeed bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V14;
        !
        ! Read and set zone
        r_RRC_RasZone bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V15;
        !
        ! Read search distance
        nSearchOffset:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V16;
        !
        ! Read search distance
        nSearchDistance:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V17;
        !
        ! Write user information to event log
        ErrWrite\I,st_A042_UserHeader+" "+"Search offset = "+NumToStr(nSearchOffset,1)+"mm","Add here your description.";
        ErrWrite\I,st_A042_UserHeader+" "+"Search distance = "+NumToStr(nSearchDistance,1)+"mm","Add here your description.";
        !
        ! Deactivate configuration check
        ConfL\Off;
        !
        ! Move start point robot
        MoveL RelTool(p_RRC_Act,0,0,-nSearchOffset),v_RRC_Act,z0,t_RRC_Act\WObj:=ob_RRC_Act;
        !
        ! Fast Search
        SearchL\Stop,diUnitR12In1\PosFlank,pFastSearchPoint,RelTool(p_RRC_Act,0,0,-nSearchOffset+nSearchDistance),vFastSearch,t_RRC_Act\WObj:=ob_RRC_Act;
        !
        ! Fine search
        SearchL\Stop,diUnitR12In1\NegFlank,pFineSearchPoint,RelTool(p_RRC_Act,0,0,-nSearchOffset),vFineSearch,t_RRC_Act\WObj:=ob_RRC_Act;
        !
        ! Activate configuration check
        ConfL\On;
        !
        ! Feed search points back
        nFastSearch:=Round(pFastSearchPoint.trans.z\Dec:=2);
        r_RRC_FAddString "Fast search = ";
        r_RRC_FAddValue nFastSearch;
        ErrWrite\I,st_A042_UserHeader+" "+"Fast search = "+NumToStr(nFastSearch,2)+"mm","Add here your description.";
        !
        nFineSearch:=Round(pFineSearchPoint.trans.z\Dec:=2);
        r_RRC_FAddString "Fine search = ";
        r_RRC_FAddValue nFineSearch;
        ErrWrite\I,st_A042_UserHeader+" "+"Fine search = "+NumToStr(nFineSearch,2)+"mm","Add here your description.";
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

        IF ERRNO=ERR_WHLSEARCH ErrWrite\I,st_A042_UserHeader+" "+"Search error!","Add here your description.";

        TRYNEXT;

    ENDPROC

    !************************************************
    ! Function    :     Move to Sync (MoveLSync or MoveJSync)
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2024.11.02
    !***************** ETH Zurich *******************
    !
    PROC r_A042_MoveToSyncFeedback()
        !
        ! Reset sync feedback trigger
        b_A042_SyncFeedbackDone:=FALSE;
        !
        ! Read and set robtarget
        r_RRC_RASRobtarget\stMoveType:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.st1;
        !
        ! Read and set tcp speed
        r_RRC_RasTCPSpeed bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V14;
        !
        ! Read and set zone
        r_RRC_RasZone bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V15;
        !
        ! Select move type
        IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.st1="L" OR bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.st1="FrameL" THEN
            !
            ! Linear
            !
            !
            ! Deactivate configuration check
            ConfL\Off;
            !
            ! Move robot
            MoveLSync p_RRC_Act,v_RRC_Act,z_RRC_Act,t_RRC_Act\WObj:=ob_RRC_Act,"r_A042_SyncFeedback";
            !
            ! Activate configuration check
            ConfL\On;
        ELSE
            !
            ! Joint
            !
            !
            ! Deactivate configuration check
            ConfJ\Off;
            !
            ! Move robot
            MoveJSync p_RRC_Act,v_RRC_Act,z_RRC_Act,t_RRC_Act\WObj:=ob_RRC_Act,"r_A042_SyncFeedback";
            !
            ! Activate configuration check
            ConfJ\On;
        ENDIF
        !
        ! Wait for trigger
        WaitUntil b_A042_SyncFeedbackDone=TRUE\PollRate:=0.004;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Feedback for Move to Sync (MoveLSync or MoveJSync)
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2024.11.02
    !***************** ETH Zurich *******************
    !
    PROC r_A042_SyncFeedback()
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
            !
            ! Set trigger
            b_A042_SyncFeedbackDone:=TRUE;
        ENDIF
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

ENDMODULE
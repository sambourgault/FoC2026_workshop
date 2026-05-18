MODULE RFL_Events_12
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
    ! FUNCTION    :  Event Routines
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2018.05.24 Draft
    !
    ! Copyright   :  ETH Zurich (CH) 2018
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Event Quick Stop (Emergency Stop)
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.08.29
    !***************** ETH Zurich *******************
    !
    PROC r_RFL_EveQStop()
        !
        ! Check Spindel Unit state
        IF f_RFL_CheckIOUnitReady(st_Tc12_T7_Unit) THEN
            ! 
            ! IF the unit is ready and the spindle was on bevor so switch it off
            IF DOutput(doTcT7DrSpFwdOn)=1 OR DOutput(doTcT7DrSpBwdOn)=1 THEN
                !
                ! Stop robot motion 
                StopMove;
                !
                ! Switch PDS Spindle off
                r_Tc12_T7_SpindleOff;
                !
                ! User message 
                nAnswer:=UIMessageBox(
                    \Header:=st_Tc12_T7_MsgHeader
                    \Message:="Spindel QStop, Robot has stopped, restart with PP-Main!"
                    \Buttons:=btnOK
                    \Icon:=iconError);
            ENDIF
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE
MODULE C001_Cam1
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
    ! FUNCTION    :  Equipment Routines for E1 Saw
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2018.03.16 Draft
    !
    ! Copyright   :  ETH Zurich (CH) 2018
    !
    !***********************************************************************************

    !************************************************
    ! Declaration :     syncident
    !************************************************
    !
    VAR syncident idRFL_C001Cam1Sta;
    VAR syncident idRFL_C001Cam1End;

    !************************************************
    ! Function    :     Start User Interface Camera  
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.03.16
    ! **************** ETH Zurich *******************
    !
    PROC r_C001_Cam1()
        !
        WaitSyncTask idRFL_C001Cam1Sta,tlAll;
        !
        ! Temp Msg for Operator
        TPWrite "T_Rob11 in RFL C001 Cam1";
        !
        ! Placeholder for Master Code 
        ! 
        WaitSyncTask idRFL_C001Cam1End,tlAll;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
    
ENDMODULE

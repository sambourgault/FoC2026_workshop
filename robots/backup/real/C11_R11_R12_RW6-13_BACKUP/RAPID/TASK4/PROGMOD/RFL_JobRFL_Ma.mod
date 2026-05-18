MODULE RFL_JobRFL_Ma
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
    ! FUNCTION    :  Job Routines for RFL Routines 
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
    ! Function    :     Start User Interface System Helper
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.06
    ! **************** ETH Zurich *******************
    !
    PROC rRFL_SysHelper()
        !
        WaitSyncTask idRFL_SysHSta,tlAll;
        !
        ! Temp Msg for Operator
        TPWrite "Master in RFL System Helper";
        !
        ! Placeholder for Master Code 
        ! 
        WaitSyncTask idRFL_SysHEnd,tlAll;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Start User Interface Equipment E001 RFL Saw 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.07
    ! **************** ETH Zurich *******************
    !
    !* PROC r_E001_Saw1()
    !*     !
    !*     WaitSyncTask idRFL_E1SawSta,tlAll;
    !*     !
    !*     ! Temp Msg for Operator
    !*     TPWrite "Master in RFL E1 Saw";
    !*     !
    !*     ! Placeholder for Master Code 
    !*     ! 
    !*     WaitSyncTask idRFL_E1SawEnd,tlAll;
    !*     !
    !* ERROR
    !*     ! Placeholder for Error Code...
    !* ENDPROC

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
        ! Placeholder for Master Code 
        ! 
        WaitSyncTask idRFL_TC11End,tlAll;
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
ENDMODULE
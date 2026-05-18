MODULE RFL_Events_Ma
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
    ! Function    :     Event Power On
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.05.24
    !***************** ETH Zurich *******************
    !
    PROC r_RFL_EvePowOn()
        !
        ! Set the resetsignal to show the Master menue
        SetDo doViMaFP3,1;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE
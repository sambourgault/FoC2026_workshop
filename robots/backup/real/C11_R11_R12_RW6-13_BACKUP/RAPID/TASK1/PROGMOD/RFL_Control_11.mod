MODULE RFL_Control_11
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
    ! FUNCTION    :  Control Routines for ETH
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2016.08.11 Draft
    !
    ! Copyright   :  ETH Zurich (CH) 2016
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Main
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.08.11
    ! **************** ETH Zurich *******************
    !
    PROC main()
        !        
        ! Initalisation 
        rInitTask;
        !
        ! Work process
        WHILE bRun=TRUE DO
            !
            ! Idle Loop
            WHILE bWaitForJob DO
                !
                ! User Interface
                ! 
                ! Short waittime
                WaitTime 0.1;
            ENDWHILE
            !
            ! Execute  Job from Master
            rExecuteJobFrmMa;
        ENDWHILE
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize Task
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.08.11
    ! **************** ETH Zurich *******************
    !
    PROC rInitTask()
        ! 
        WaitSyncTask idRFL_InitTaskSta,tlAll;
        !
        ! Speed
        rInitSpeed;
        !
        ! Signals
        rInitSig;
        !
        ! Variables
        rInitVar;
        !
        ! Initialzie Tool
        r_Tc11_InitTool f_Tc11_CheckCurToolCode();
        !
        ! Safety lock with a Tool
        IF b_Tc11_NoTool=FALSE r_Tc11_Lock;
        !
        WaitSyncTask idRFL_InitTaskEnd,tlAll;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize Signals
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.27
    ! **************** ETH Zurich *******************
    !
    PROC rInitSig()
        !
        WaitSyncTask idRFL_InitSigSta,tlAll;
        !
        ! Toolchanger
        r_Tc11_InitSig;
        !
        WaitSyncTask idRFL_InitSigEnd,tlAll;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize Variables
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.08.11
    ! **************** ETH Zurich *******************
    !
    PROC rInitVar()
        !
        WaitSyncTask idRFL_InitVarSta,tlAll;
        !
        bWaitForJob:=FALSE;
        !
        ! Initalisiere SafePosZ
        jpSafePosZ.robax:=rjSafePos;
        jpSafePosZ.extax.eax_c:=nSafePosZ;
        !
        WaitSyncTask idRFL_InitVarEnd,tlAll;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize Speed
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.02.21
    ! **************** ETH Zurich *******************
    !
    PROC rInitSpeed()
        ! 
        WaitSyncTask idRFL_InitSpeedSta,tlAll;
        !
        ! Set speed limit from Master
        r_RFL_SetSpeedLimit slim_RFL_Master;
        !
        ! Speed is set in task
        WaitSyncTask idRFL_InitSpeedSet,tlAll;
        !
        WaitSyncTask idRFL_InitTaskEnd,tlAll;
        ! 
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Execute Job from Master
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.08.11
    ! **************** ETH Zurich *******************
    !
    PROC rExecuteJobFrmMa()
        !
        WaitSyncTask idRFL_ExeJobFrmMaSta,tlAll;
        !
        %stJobFrmMa %;
        !
        WaitSyncTask idRFL_ExeJobFrmMaEnd,tlAll;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     ProgError
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.08.11
    ! **************** ETH Zurich *******************
    !
    PROC r_RFL_ProgError()
        ! 
        ! User Info
        TPWrite "Program Error";
        !
        ! Stop Program
        Stop;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE
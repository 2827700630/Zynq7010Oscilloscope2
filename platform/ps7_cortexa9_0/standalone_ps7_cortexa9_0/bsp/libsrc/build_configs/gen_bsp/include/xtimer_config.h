/******************************************************************************
* Copyright (c) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
#ifndef _XTIMER_CONFIG_H
#define _XTIMER_CONFIG_H

#include "xparameters.h"

/* #undef XSLEEPTIMER_BASEADDRESS */
/* #undef XSLEEPTIMER_IS_AXITIMER */
/* #undef XSLEEPTIMER_IS_TTCPS */
/* #undef XSLEEPTIMER_IS_SCUTIMER */
#define XSLEEPTIMER_FREQ	     XPAR_CPU_CORE_CLOCK_FREQ_HZ/2
#define COUNTS_PER_SECOND       XSLEEPTIMER_FREQ
#define XTIMER_IS_DEFAULT_TIMER 1
/* #undef XTIMER_DEFAULT_TIMER_IS_MB */
/* #undef XTIMER_DEFAULT_TIMER_IS_MB_RISCV */

#define XTICKTIMER_BASEADDRESS 0xf8f00600
/* #undef XTICKTIMER_IS_AXITIMER */
/* #undef XTICKTIMER_IS_TTCPS */
#define XTICKTIMER_IS_SCUTIMER  
/* #undef XTIMER_NO_TICK_TIMER */

#endif /* XTIMER_CONFIG_H */

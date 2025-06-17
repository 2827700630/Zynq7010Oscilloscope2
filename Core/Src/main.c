/* USER CODE BEGIN Header */
/**
 ******************************************************************************
 * @file           : main.c
 * @brief          : Main program body
 ******************************************************************************
 * @attention
 *
 * Copyright (c) 2022 STMicroelectronics.
 * All rights reserved.
 *
 * This software is licensed under terms that can be found in the LICENSE file
 * in the root directory of this software component.
 * If no LICENSE file comes with this software, it is provided AS-IS.
 *
 ******************************************************************************
 */
/* USER CODE END Header */
/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "i2c.h"
#include "gpio.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
#include "string.h"
#include "oled.h"
#include "stdio.h"
/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */
/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/**
 * @brief  The application entry point.
 * @retval int
 */
int main(void)
{
  /* USER CODE BEGIN 1 */

  /* USER CODE END 1 */

  /* MCU Configuration--------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* USER CODE BEGIN Init */

  /* USER CODE END Init */

  /* Configure the system clock */
  SystemClock_Config();

  /* USER CODE BEGIN SysInit */

  /* USER CODE END SysInit */

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  MX_I2C1_Init();
  /* USER CODE BEGIN 2 */
  HAL_Delay(20); // 单片机启动比OLED上电快,需要延迟等待一下
  OLED_Init();
  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  while (1)
  {
    // 中英文字符串混合显示
    OLED_NewFrame();
    OLED_PrintString(0, 0, "感谢关注", &font16x16, OLED_COLOR_REVERSED);
    OLED_ShowFrame();
    HAL_Delay(500);
    OLED_PrintString(0, 22, "B站-KEYSKING", &font16x16, OLED_COLOR_NORMAL);
    OLED_ShowFrame();
    HAL_Delay(500);
    OLED_PrintString(0, 44, "\\^o^/", &font16x16, OLED_COLOR_NORMAL);
    OLED_ShowFrame();
    HAL_Delay(1500);
    // 显示变量值
    int count = 0;
    char buf[20] = {0};
    OLED_NewFrame();
    for (;;)
    {
      sprintf(buf, "%d %%", count);
      OLED_PrintASCIIString(40, 20, buf, &afont24x12, OLED_COLOR_NORMAL);
      OLED_ShowFrame();
      HAL_Delay(15);
      if (count++ > 99)
      {
        break;
      }
    }
    HAL_Delay(1000);
    // 直线绘制
    OLED_NewFrame();
    for (int i = 0; i < 128; i += 8)
    {
      OLED_DrawLine(0, 0, i, 63, OLED_COLOR_NORMAL);
      OLED_DrawLine(127, 0, 127 - i, 63, OLED_COLOR_NORMAL);
      OLED_ShowFrame();
      HAL_Delay(30);
    }
    HAL_Delay(1500);
    // 矩形绘制
    OLED_NewFrame();
    for (int i = 0; i < 64; i += 8)
    {
      OLED_DrawRectangle(i, i / 2, 127 - i * 2, 63 - i, OLED_COLOR_NORMAL);
      OLED_ShowFrame();
      HAL_Delay(35);
    }
    HAL_Delay(1500);
    // 矩形圆形
    OLED_NewFrame();
    for (int i = 63; i > 0; i -= 8)
    {
      OLED_DrawCircle(64, 32, i / 2, OLED_COLOR_NORMAL);
      OLED_ShowFrame();
      HAL_Delay(40);
    }
    HAL_Delay(1500);
    // 图片显示1
    OLED_NewFrame();
    OLED_DrawImage((128 - (bilibiliImg.w)) / 2, 0, &bilibiliImg, OLED_COLOR_NORMAL);
    OLED_ShowFrame();
    HAL_Delay(1700);
    // 图片显示2
    OLED_NewFrame();
    OLED_DrawImage((128 - (bilibiliTVImg.w)) / 2, 0, &bilibiliTVImg, OLED_COLOR_NORMAL);
    OLED_ShowFrame();
    HAL_Delay(1700);
    /* USER CODE END WHILE */

    /* USER CODE BEGIN 3 */
  }
  /* USER CODE END 3 */
}

/**
 * @brief System Clock Configuration
 * @retval None
 */
void SystemClock_Config(void)
{
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};

  /** Initializes the RCC Oscillators according to the specified parameters
   * in the RCC_OscInitTypeDef structure.
   */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE;
  RCC_OscInitStruct.HSEState = RCC_HSE_ON;
  RCC_OscInitStruct.HSEPredivValue = RCC_HSE_PREDIV_DIV1;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
  RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL9;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }

  /** Initializes the CPU, AHB and APB buses clocks
   */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK | RCC_CLOCKTYPE_SYSCLK | RCC_CLOCKTYPE_PCLK1 | RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV2;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2) != HAL_OK)
  {
    Error_Handler();
  }
}

/* USER CODE BEGIN 4 */

/* USER CODE END 4 */

/**
 * @brief  This function is executed in case of error occurrence.
 * @retval None
 */
void Error_Handler(void)
{
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */
  __disable_irq();
  while (1)
  {
  }
  /* USER CODE END Error_Handler_Debug */
}

#ifdef USE_FULL_ASSERT
/**
 * @brief  Reports the name of the source file and the source line number
 *         where the assert_param error has occurred.
 * @param  file: pointer to the source file name
 * @param  line: assert_param error line source number
 * @retval None
 */
void assert_failed(uint8_t *file, uint32_t line)
{
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */

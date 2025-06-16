/* ------------------------------------------------------------ */
/*				头文件包含定义								*/
/* ------------------------------------------------------------ */
#include "wave.h"
#include "math.h"
/*
 *  画布描述
 *
 *				|
 * 				|
 *			---------------------------------------------------->  hor_x
 *				|	   							           |
 *				|                                          |
 *              |               宽度                      |
 *              |      --------------------------          |
 *              |      |                        |          |
 *              |      |                        |          |
 *              |      |                        |          |
 *              |      |         画布           | 高度     |
 *              |      |                        |          |
 *              |      |                        |          |
 *              |      |                        |          |
 *              |      --------------------------          |
 *              |                                          |
 *              |                              帧         |
 *				--------------------------------------------
 *				|
 *				ver_y
 */


/*
 * 在画布上绘制波形
 *
 *@param BufferPtr        用于绘制波形的数据缓冲区
 *@param CanvasBufferPtr  这是画布缓冲区指针，在画布缓冲区上绘制波形
 *@param Sign             数据符号：无符号字符0；字符1；无符号短整型2；短整型3
 *@param Bits             数据有效位数
 *@param color            波形颜色选择
 *@param coe              系数
 *
 *@note  此函数通过检查上一个数据和当前数据值在两点之间绘制线条，
 *		 通过加法器和系数将数据转换为u8
 */
void draw_wave(u32 width, u32 height,  void *BufferPtr, u8 *CanvasBufferPtr, u8 Sign, u8 Bits, u8 color, u16 coe)
{
	u16 last_data ;  // 改为u16以支持更大的高度范围
	u16 curr_data ;  // 改为u16以支持更大的高度范围
	u32 i ;
	int j ;
	u8 wRed, wBlue, wGreen;
	u16 adder ;

	char *CharBufferPtr ;
	short *ShortBufferPtr ;

	if(Sign == UNSIGNEDCHAR || Sign == CHAR)
		CharBufferPtr = (char *)BufferPtr ;
	else
		ShortBufferPtr = (short *)BufferPtr ;

	// 优化缩放系数，使8位ADC数据(0-255)充分利用1080像素高度
	// 缩放因子：1080/256 ≈ 4.22，为了更好的显示效果，使用4.0
	float height_scale = (float)height / 256.0;  // 动态缩放因子
	float data_coe = height_scale / coe ;
	
	switch(color)
	{
	case 0 : wRed = 255; wGreen = 255;	wBlue = 0;	    break ;     //黄色
	case 1 : wRed = 0;   wGreen = 255;	wBlue = 255;	break ;     //青色
	case 2 : wRed = 0;   wGreen = 255;	wBlue = 0;	    break ;     //绿色
	case 3 : wRed = 255; wGreen = 0;	wBlue = 255;	break ;     //洋红色
	case 4 : wRed = 255; wGreen = 0;	wBlue = 0;	    break ;     //红色
	case 5 : wRed = 0;   wGreen = 0;	wBlue = 255;	break ;     //蓝色
	case 6 : wRed = 255; wGreen = 255;	wBlue = 255 ;	break ;     //白色
	case 7 : wRed = 150; wGreen = 150;	wBlue = 0;	    break ;     //深黄色
	default: wRed = 255; wGreen = 255;  wBlue = 0;	    break ;
	}
	/* 如果符号是有符号的，加法器将是2^Bits的1/2，例如，Bits等于8，加法器将是2^8/2 = 128 */
	if (Sign == CHAR || Sign == SHORT)
		adder = pow(2, Bits)/2 ;
	else
		adder = 0 ;

	for(i = 0; i < width ; i++)
	{
		/* 将字符数据转换为适应新高度的范围 */
		if (i == 0)
		{
			if(Sign == UNSIGNEDCHAR || Sign == CHAR)
			{
				last_data = (u16)((CharBufferPtr[i] + adder) * data_coe) ;
				curr_data = (u16)((CharBufferPtr[i] + adder) * data_coe) ;
			}
			else
			{
				last_data = (u16)((ShortBufferPtr[i] + adder) * data_coe) ;
				curr_data = (u16)((ShortBufferPtr[i] + adder) * data_coe) ;
			}
		}
		else
		{
			if(Sign == UNSIGNEDCHAR || Sign == CHAR)
			{
				last_data = (u16)((CharBufferPtr[i-1] + adder) * data_coe) ;
				curr_data = (u16)((CharBufferPtr[i] + adder) * data_coe) ;
			}
			else
			{
				last_data = (u16)((ShortBufferPtr[i-1] + adder) * data_coe) ;
				curr_data = (u16)((ShortBufferPtr[i] + adder) * data_coe) ;
			}
		}
		
		// 限制数据范围，防止越界
		if (last_data >= height) last_data = height - 1;
		if (curr_data >= height) curr_data = height - 1;
		
		/* 比较上一个数据值和当前数据值，在两点之间绘制点 */
		if (curr_data >= last_data)
		{
			for (j = 0 ; j < (curr_data - last_data + 1) ; j++)
				draw_point(CanvasBufferPtr, i, (height - 1 - curr_data) + j, width, wBlue, wGreen, wRed) ;
		}
		else
		{
			for (j = 0 ; j < (last_data - curr_data + 1) ; j++)
				draw_point(CanvasBufferPtr, i, (height - 1 - last_data) + j, width, wBlue, wGreen, wRed) ;
		}
	}

}


/*
 * 在点缓冲区上绘制点
 *
 *@param PointBufferPtr     点缓冲区指针
 *@param hor_x  			水平位置
 *@param ver_y              垂直位置
 *@param width              画布宽度
 *
 *@note  无
 */
void draw_point(u8 *PointBufferPtr, u32 hor_x, u32 ver_y, u32 width, u8 wBlue, u8 wGreen, u8 wRed)
{
	PointBufferPtr[(hor_x + ver_y*width)*BYTES_PIXEL + 0] = wBlue;
	PointBufferPtr[(hor_x + ver_y*width)*BYTES_PIXEL + 1] = wGreen;
	PointBufferPtr[(hor_x + ver_y*width)*BYTES_PIXEL + 2] = wRed;
}


/*
 * 在点缓冲区上绘制网格
 *
 *@param width              画布宽度
 *@param height             画布高度
 *@param CanvasBufferPtr    画布缓冲区指针
 *
 *@note  优化为全屏1920x1080显示：
 *       水平方向：每120像素一条垂直主线(16条)，每24像素一条垂直细线
 *       垂直方向：每108像素一条水平主线(10条)，每27像素一条水平细线
 */
void draw_grid(u32 width, u32 height, u8 *CanvasBufferPtr)
{

	u32 xcoi, ycoi;
	u8 wRed, wBlue, wGreen;
	/*
	 * 在画布上覆盖网格，背景设置为黑色，网格颜色为灰色
	 * 全屏优化：主网格线更亮，辅助网格线较暗
	 */
	for(ycoi = 0; ycoi < height; ycoi++)
	{
		for(xcoi = 0; xcoi < width; xcoi++)
		{
			// 主网格线（每120x108像素）
			if (((ycoi % 108 == 0) && (xcoi % 6 == 0)) || ((xcoi % 120 == 0) && (ycoi % 6 == 0)))
			{
				/* 亮灰色主网格线 */
				wRed = 120;
				wGreen = 120;
				wBlue = 120;
			}
			// 辅助网格线（每24x27像素）
			else if (((ycoi % 27 == 0) && (xcoi % 3 == 0)) || ((xcoi % 24 == 0) && (ycoi % 3 == 0)))
			{
				/* 暗灰色辅助网格线 */
				wRed = 60;
				wGreen = 60;
				wBlue = 60;
			}
			// 中心十字线（示波器风格）
			else if ((ycoi == height/2) || (xcoi == width/2))
			{
				/* 更亮的中心线 */
				wRed = 180;
				wGreen = 180;
				wBlue = 180;
			}
			else
			{
				/* 黑色背景 */
				wRed = 0;
				wGreen = 0;
				wBlue = 0;
			}
			draw_point(CanvasBufferPtr, xcoi, ycoi, width, wBlue, wGreen, wRed);
		}
	}
}


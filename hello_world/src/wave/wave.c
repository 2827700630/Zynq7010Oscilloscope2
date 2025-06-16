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
	u8 last_data ;
	u8 curr_data ;
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



	float data_coe = 1.00/coe ;
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
		/* 将字符数据转换为u8 */
		if (i == 0)
		{
			if(Sign == UNSIGNEDCHAR || Sign == CHAR)
			{
				last_data = (u8)(CharBufferPtr[i] + adder)*data_coe ;
				curr_data = (u8)(CharBufferPtr[i] + adder)*data_coe ;
			}
			else
			{
				last_data = (u8)((u16)(ShortBufferPtr[i] + adder)*data_coe) ;
				curr_data = (u8)((u16)(ShortBufferPtr[i] + adder)*data_coe) ;
			}
		}
		else
		{
			if(Sign == UNSIGNEDCHAR || Sign == CHAR)
			{
				last_data = (u8)(CharBufferPtr[i-1] + adder)*data_coe ;
				curr_data = (u8)(CharBufferPtr[i] + adder)*data_coe ;
			}
			else
			{
				last_data = (u8)((u16)(ShortBufferPtr[i-1] + adder)*data_coe) ;
				curr_data = (u8)((u16)(ShortBufferPtr[i] + adder)*data_coe) ;
			}		}		/* 比较上一个数据值和当前数据值，在两点之间绘制点 */
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
 *@note  在水平方向上，每32条垂直线，每4个点绘制一个点
 *       在垂直方向上，每32个水平点，每4个点绘制一个点
 */
void draw_grid(u32 width, u32 height, u8 *CanvasBufferPtr)
{

	u32 xcoi, ycoi;
	u8 wRed, wBlue, wGreen;
	/*
	 * 在画布上覆盖网格，背景设置为黑色，网格颜色为灰色
	 */
	for(ycoi = 0; ycoi < height; ycoi++)
	{
		for(xcoi = 0; xcoi < width; xcoi++)
		{			if (((ycoi == 0 || (ycoi+1)%32 == 0) && (xcoi == 0 || (xcoi+1)%4 == 0))
					|| ((xcoi == 0 || (xcoi+1)%32 == 0) && (ycoi+1)%4 == 0))
			{
				/* 灰色 */
				wRed = 150;
				wGreen = 150;
				wBlue = 150;
			}
			else
			{
				/* 黑色 */
				wRed = 0;
				wGreen = 0;
				wBlue = 0;
			}
			draw_point(CanvasBufferPtr, xcoi, ycoi, width, wBlue, wGreen, wRed);
		}
	}
}


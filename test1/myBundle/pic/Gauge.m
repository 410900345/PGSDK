//
//  Gauge.m
//  GaugeDemo
//
//  Created by 海锋 周 on 12-3-27.
//  Copyright (c) 2012年 CJLU. All rights reserved.
//

#import "Gauge.h"
#import <QuartzCore/QuartzCore.h>

#define MAXOFFSETANGLE 120.0f

#define POINTEROFFSET  90.0f
//最大数字
#define MAXVALUE       300.0f
//每一个cell的数
//#define CELLMARKNUM    5
#define CELLMARKNUM    10
//数字的多少
#define CELLNUM        12
#define GAUGESTRING    @"单位:Km/h"
//上面的阿拉伯数字的的大小
//#define DEFLUATSIZE    300
#define DEFLUATSIZE    300

//最大为120是满,
#define DEFLUATEXCIRCLELENGTH  50
/************************************************
    仪表盘的大小不建议设置的太小。
    长宽都是300是最适合的
    如果要更小的需要自行修改刻度长度和文字大小
 ***********************************************/
@interface Gauge ()
- (CGFloat) parseToX:(CGFloat) radius Angle:(CGFloat)angle;
- (CGFloat) parseToY:(CGFloat) radius Angle:(CGFloat)angle;
- (CGFloat) transToRadian:(CGFloat)angel;
- (CGFloat) parseToAngle:(CGFloat) val;
- (CGFloat) parseToValue:(CGFloat) val;
- (void)setTextLabel:(NSInteger)labelNum;
- (void)setLineMark:(NSInteger)labelNum;
- (void) pointToAngle:(CGFloat) angle Duration:(CGFloat) duration;
@end


@implementation Gauge

@synthesize gaugeView,pointer,context;
@synthesize labelArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //设置背景透明
        [self setBackgroundColor:[UIColor clearColor]];
        
        scoleNum = DEFLUATSIZE/frame.size.width;
        NSLog(@"%f",scoleNum);
//        120
        maxNum = MAXVALUE;
        minNum = 0.0f;
//        -120
        minAngle = -MAXOFFSETANGLE;
//        120 
        maxAngle = MAXOFFSETANGLE;
        gaugeValue = 0.0f;
        stopNum = 200.0f;
        gaugeAngle = -MAXOFFSETANGLE;
//        240/120=20
        angleperValue = (maxAngle - minAngle)/(maxNum - minNum);
        
//        gaugeView= [UIImage imageNamed:@"gaugeback.png"];
         gaugeView= [UIImage imageNamed:@""];
        //添加指针
        UIImage *_pointer = [UIImage imageNamed:@"pointer2.png"];
        pointer = [[UIImageView alloc] initWithImage:_pointer];
        pointer.layer.anchorPoint = CGPointMake(0.5, 0.78);
        pointer.center = self.center;
        pointer.transform = CGAffineTransformMakeScale(scoleNum, scoleNum);
        [self addSubview:pointer];
        //设置文字标签
        [self setTextLabel:CELLNUM];
        //设置指针到0位置
        pointer.layer.transform = CATransform3DMakeRotation([self transToRadian:-MAXOFFSETANGLE], 0, 0, 1);
    }
    return self;
}

/*
 * setTextLabel 绘制刻度值
 * @labelNum NSInteger 刻度值的数目
 */
-(void)setTextLabel:(NSInteger)labelNum
{
//    labelcell的数量是12 组
     labelArray = [NSMutableArray arrayWithCapacity:labelNum];
    
    CGFloat textDis = (maxNum - minNum)/labelNum;
    CGFloat angelDis = (maxAngle - minAngle)/labelNum;
    CGFloat radius = (self.center.x - 75)*scoleNum;
    CGFloat currentAngle;
    CGFloat currentText = 0.0f;
    CGPoint centerPoint = self.center;
    
    for(int i=0;i<=labelNum;i++)
    {
        currentAngle = minAngle + i * angelDis - POINTEROFFSET;
        currentText = minNum + i * textDis;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0 , 0 , 30, 50)];
        label.autoresizesSubviews = YES;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        //设置刻度的文字的格式
        if(i<labelNum/2)
        {
            label.textAlignment = UITextAlignmentLeft;
        }
        else if (i==labelNum/2)
        {
            label.textAlignment = UITextAlignmentCenter;
        }
        else
        {
            label.textAlignment = UITextAlignmentRight;
        }
//        设置从为50倍数的显示出刻度
        if ((int)currentText%50 == 0)
        {
            label.text = [NSString stringWithFormat:@"%d",(int)currentText];
        }
        label.center = CGPointMake(centerPoint.x+[self parseToX:radius Angle:currentAngle],centerPoint.y+[self parseToY:radius Angle:currentAngle]);
        
        [labelArray addObject:label];
        [self addSubview:label];        
    }
    // 设置刻度表的名称
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0 , 0 ,100, 40)];
    label.autoresizesSubviews = YES;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    label.text = GAUGESTRING;
    label.center = CGPointMake(centerPoint.x,centerPoint.y*3/2);
    [self addSubview:label];    
}
- (void)drawRect:(CGRect)rect
{
    //获取上下文
    context = UIGraphicsGetCurrentContext();
    //设置背景透明
    CGContextSetFillColorWithColor(context,self.backgroundColor.CGColor);
	CGContextFillRect(context, rect);
    //绘制仪表背景
    [[self gaugeView ]drawInRect:self.bounds];
    //绘制刻度 12
    [self setLineMarkToo:CELLNUM*CELLMARKNUM];
    CGContextStrokePath(context);
    //    [self setLineMark:CELLNUM*CELLMARKNUM];
    //    外圈
    context = UIGraphicsGetCurrentContext();
    //     [self setLineMark:CELLNUM*CELLMARKNUM];
    [self setLineMark:CELLNUM*CELLMARKNUM];
    
    //    刻度总数 120
    NSLog(@"刻度总数 %s %d",__FUNCTION__,CELLNUM*CELLMARKNUM);
	CGContextStrokePath(context);
}
/*
 * setLineMark 绘制刻度的标记
 * @labelNum NSInteger 刻度是数目
 */
//外圈刻度 labelNum 是控制长度
-(void)setLineMark:(NSInteger)labelNum
{
    CGFloat angelDis = (maxAngle - minAngle)/labelNum;
    CGFloat radius = self.center.x;
    CGFloat currentAngle;
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    for(int i=0;i <= labelNum;i++)
    {
        stopNum = 300.0;
        currentAngle = minAngle + i * angelDis - POINTEROFFSET;
        //给刻度标记绘制不同的颜色
        int colorCompment = labelNum*1/2;
        if(i >= colorCompment)
        {
            CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:1 green:(labelNum-i)/60.0 blue:0 alpha:0.8] CGColor]);
        }
        else
        {
            CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:i/60.0 green:1 blue:0 alpha:0.8] CGColor]);
        }
//        这个控制外圈的大小
        if (i == DEFLUATEXCIRCLELENGTH)
        {
            break;
        }
        
        if(i%5==0)
        {
            CGContextSetLineCap(context, kCGLineCapSquare);
            CGContextSetLineWidth(context, 5);
            CGContextStrokePath(context);
            CGContextMoveToPoint(context,centerPoint.x+[self parseToX:radius-25*scoleNum Angle:currentAngle], centerPoint.y+[self parseToY:radius-25*scoleNum Angle:currentAngle]);
            CGContextAddLineToPoint(context,centerPoint.x+[self parseToX:radius-30*scoleNum Angle:currentAngle], centerPoint.y+[self parseToY:radius-30*scoleNum Angle:currentAngle]);
        }else{
            CGContextSetLineWidth(context, 5);
            CGContextSetLineCap(context, kCGLineCapSquare);
            CGContextStrokePath(context);
            CGContextMoveToPoint(context,centerPoint.x+[self parseToX:radius-25*scoleNum Angle:currentAngle], centerPoint.y+[self parseToY:radius-25*scoleNum Angle:currentAngle]);
            CGContextAddLineToPoint(context,centerPoint.x+[self parseToX:radius-30*scoleNum Angle:currentAngle], centerPoint.y+[self parseToY:radius-30*scoleNum Angle:currentAngle]);
        }

    }
    
}
//内圈刻度
-(void)setLineMarkToo:(NSInteger)labelNum
{
    CGFloat angelDis = (maxAngle - minAngle)/labelNum;
    CGFloat radius = self.center.x;
    CGFloat currentAngle;
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    for(int i=0;i<=labelNum;i++)
    {
//        NSLog(@"labelNum is %d",labelNum);
        currentAngle = minAngle + i * angelDis - POINTEROFFSET;
//给刻度标记绘制不同的颜色
        if(i>labelNum*2/3)
        {
            CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:1 green:0 blue:0 alpha:0.8] CGColor]);
        }
        else if(i>labelNum*1/3)
        {
            CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:1 green:1 blue:0 alpha:0.8] CGColor]);
        }
        else
        {
            CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:0 green:1 blue:0 alpha:0.8] CGColor]);
        }
        //绘制不同的长短的刻度
        if(i%5==0 && i%10 !=0)
        {
            CGContextSetLineCap(context, kCGLineCapSquare);
            CGContextSetLineWidth(context, 1);
            CGContextStrokePath(context);
//           绘图起始点
            CGContextMoveToPoint(context,centerPoint.x+[self parseToX:radius-35*scoleNum Angle:currentAngle], centerPoint.y+[self parseToY:radius-35*scoleNum Angle:currentAngle]);
//           控制长度
            CGContextAddLineToPoint(context,centerPoint.x+[self parseToX:radius-55*scoleNum Angle:currentAngle], centerPoint.y+[self parseToY:radius-55*scoleNum Angle:currentAngle]);
        }
        else if(i%10==0)
        {
            CGContextSetLineCap(context, kCGLineCapSquare);
            CGContextSetLineWidth(context, 1);
            CGContextStrokePath(context);
            CGContextMoveToPoint(context,centerPoint.x+[self parseToX:radius-35*scoleNum Angle:currentAngle], centerPoint.y+[self parseToY:radius-35*scoleNum Angle:currentAngle]);
            CGContextAddLineToPoint(context,centerPoint.x+[self parseToX:radius-65*scoleNum Angle:currentAngle], centerPoint.y+[self parseToY:radius-65*scoleNum Angle:currentAngle]);
        }
        else
        {
            CGContextSetLineWidth(context, 1);
            CGContextSetLineCap(context, kCGLineCapSquare);
            CGContextStrokePath(context);
            CGContextMoveToPoint(context,centerPoint.x+[self parseToX:radius-35*scoleNum Angle:currentAngle], centerPoint.y+[self parseToY:radius-35*scoleNum Angle:currentAngle]);
            CGContextAddLineToPoint(context,centerPoint.x+[self parseToX:radius-50*scoleNum Angle:currentAngle], centerPoint.y+[self parseToY:radius-50*scoleNum Angle:currentAngle]);
        }
        
    }
}

/*
 * setGaugeValue 移动到某个数值
 * @value CGFloat 移动到的数值
 * @isAnim BOOL   是否执行动画
 */
-(void)setGaugeValue:(CGFloat)value animation:(BOOL)isAnim
{
//    value 是传进来的数值
    CGFloat tempAngle = [self parseToAngle:value];
    gaugeValue = value;
      NSLog(@"labelNum is %f",gaugeValue);
    //设置转动时间和转动动画
    if(isAnim)
    {
        [self pointToAngle:tempAngle Duration:0.6f];
    }
    else
    {
        [self pointToAngle:tempAngle Duration:0.0f];
    }
}

/*
 * pointToAngle 按角度旋转
 * @angel CGFloat 角度
 * @duration CGFloat 动画执行时间
 */
- (void) pointToAngle:(CGFloat) angle Duration:(CGFloat) duration
{
    CAKeyframeAnimation *anim=[CAKeyframeAnimation animationWithKeyPath:@"transform"]; 
    NSMutableArray *values=[NSMutableArray array]; 
    anim.duration = duration;
    anim.autoreverses = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion= NO;
    
    CGFloat distance = angle/10;
    //设置转动路径，不能直接用 CABaseAnimation 的toValue，那样是按最短路径的，转动超过180度时无法控制方向
    int i = 1;
    for(;i<=10;i++)
    {
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DIdentity, [self transToRadian:(gaugeAngle+distance*i)], 0, 0, 1)]];
        }
    //添加缓动效果
     [values addObject:[NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DIdentity, [self transToRadian:(gaugeAngle+distance*(i))], 0, 0, 1)]];
     [values addObject:[NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DIdentity, [self transToRadian:(gaugeAngle+distance*(i-2))], 0, 0, 1)]];     
     [values addObject:[NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DIdentity, [self transToRadian:(gaugeAngle+distance*(i-1))], 0, 0, 1)]];
                                                                           
    anim.values=values; ;
    [pointer.layer addAnimation:anim forKey:@"cubeIn"];
    
    gaugeAngle = gaugeAngle+angle;
    
}

/*
 * parseToX 角度转弧度
 * @angel CGFloat 角度
 */
-(CGFloat)transToRadian:(CGFloat)angel
{
    return angel*M_PI/180;
}


/*
 * parseToX 根据角度，半径计算X坐标
 * @radius CGFloat 半径  
 * @angle  CGFloat 角度
 */
- (CGFloat) parseToX:(CGFloat) radius Angle:(CGFloat)angle
{
    CGFloat tempRadian = [self transToRadian:angle];
    return radius*cos(tempRadian);
}

/*
 * parseToY 根据角度，半径计算Y坐标
 * @radius CGFloat 半径  
 * @angle  CGFloat 角度
 */
- (CGFloat) parseToY:(CGFloat) radius Angle:(CGFloat)angle
{
    CGFloat tempRadian = [self transToRadian:angle];
    return radius*sin(tempRadian);
}

/*
 * parseToAngle 根据数据计算需要转动的角度
 * @val CGFloat 要移动到的数值
 */
-(CGFloat) parseToAngle:(CGFloat) val
{
	//异常的数据
	if(val<minNum)
    {
		return minNum;
	}else if(val>maxNum)
    {
		return maxNum;
	}
	CGFloat temp =(val-gaugeValue)*angleperValue;
	return temp;
}

/*
 * parseToValue 根据角度计算数值
 * @val CGFloat 要移动到的角度
 */
-(CGFloat) parseToValue:(CGFloat) val
{
	CGFloat temp=val/angleperValue;
	CGFloat temp2=maxNum/2+temp;
	if(temp2>maxNum){
		return maxNum;
	}else if(temp2<maxNum){
		return maxNum;
	}
	return temp2;
}



@end

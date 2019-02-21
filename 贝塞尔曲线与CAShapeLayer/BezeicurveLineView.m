//
//  BezeicurveLineView.m
//  贝塞尔曲线与CAShapeLayer
//
//  Created by ganzaihong on 2019/2/20.
//  Copyright © 2019 YD. All rights reserved.
//

#import "BezeicurveLineView.h"

static CGRect bgFrame;
@interface BezeicurveLineView()


@end

@implementation BezeicurveLineView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addBackGroudView:frame];
        [self drawXYLine:nil];
    }
    return self;
}

/** 添加背景 */
-(void)addBackGroudView:(CGRect)frame{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    view.backgroundColor = [UIColor cyanColor];
    [self addSubview:view];
    bgFrame = frame;
}


/** 画坐标轴 */
-(void)drawXYLine:(NSArray *)x_items{
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    CGPoint Y_Point  = CGPointMake(MARGIN, MARGIN);
    CGPoint Zone_Point  = CGPointMake(MARGIN, bgFrame.size.height - MARGIN * 2);
    CGPoint X_Point = CGPointMake(bgFrame.size.width - MARGIN, bgFrame.size.height - MARGIN * 2);
    //画x，y轴线 -> y轴
    [bezierPath moveToPoint:Y_Point];
    [bezierPath addLineToPoint:Zone_Point];
    //画x，y轴线 -> x轴
    [bezierPath moveToPoint:Zone_Point];
    [bezierPath addLineToPoint:X_Point];
    
    //添加x轴箭头
    [bezierPath moveToPoint:X_Point];
    [bezierPath addLineToPoint:CGPointMake( X_Point.x - 5 , X_Point.y - 5)];
    [bezierPath moveToPoint:X_Point];
    [bezierPath addLineToPoint:CGPointMake( X_Point.x - 5 , X_Point.y + 5)];
    
    //添加Y轴箭头
    [bezierPath moveToPoint:Y_Point];
    [bezierPath addLineToPoint:CGPointMake(Y_Point.x - 5, Y_Point.y + 5)];
    [bezierPath moveToPoint:Y_Point];
    [bezierPath addLineToPoint:CGPointMake(Y_Point.x + 5, Y_Point.y + 5)];
    
    //添加x索引格
    CGFloat x_margin  = (bgFrame.size.width - MARGIN * 2)/10;
    for (int i = 0 ; i < 10; i ++) {
        if (i ==9)break;
        
        [bezierPath moveToPoint:CGPointMake(Zone_Point.x + (i + 1) * x_margin, Zone_Point.y)];
        [bezierPath addLineToPoint:CGPointMake(Zone_Point.x + (i + 1) * x_margin, Zone_Point.y - 5)];
        
    }
    
    //添加y索引格
    for (int i = 0; i < 10; i ++ ) {
        if (i == 9) break;
        [bezierPath moveToPoint:CGPointMake(Zone_Point.x  , Zone_Point.y - (i + 1) * Y_EVERY_MARGIN * 2)];
        [bezierPath addLineToPoint:CGPointMake(Zone_Point.x + 5 , Zone_Point.y - (i + 1) * Y_EVERY_MARGIN * 2)];
    }
    
    //添加x轴文字
    
    for (int i = 0; i < 10; i ++) {
        if(i == 9)break;
        UILabel *label = [[UILabel alloc]init];
        label.text = @"2~4";
        label.transform = CGAffineTransformMakeRotation(-M_PI_4);
        [self addSubview:label];
        CGFloat x = MARGIN  + x_margin * i ;
        label.frame = CGRectMake(x, Zone_Point.y + 10, x_margin * 2, 20);
        [label setFont:[UIFont systemFontOfSize:12]];
        [label setTextColor:[UIColor redColor]];
        
    }
    
    //添加y轴文字
    
    for (int i = 0; i < 11; i ++) {
        if(i == 9)break;
        UILabel *label = [[UILabel alloc]init];
        label.text = [NSString stringWithFormat:@"%d",10*(i + 1)];;
        [self addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        CGFloat y = Zone_Point.y - Y_EVERY_MARGIN * 2 * (i + 1) - Y_EVERY_MARGIN/2 ;
        
        label.frame = CGRectMake(0, y, 20, Y_EVERY_MARGIN);
        [label setFont:[UIFont systemFontOfSize:12]];
        [label setTextColor:[UIColor redColor]];
        
    }

    
    
    
    
    
    //使用shapelayer渲染路径
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.borderWidth = 5;
    shapeLayer.borderColor = [UIColor redColor].CGColor;
    shapeLayer.strokeColor    = [UIColor blackColor].CGColor;
    shapeLayer.fillColor = [UIColor blueColor].CGColor;
    shapeLayer.path = bezierPath.CGPath;
    [self.layer addSublayer:shapeLayer];
    
    
    //2.获取目标值点坐标
    NSArray *targets = @[@20,@40,@20,@50,@32,@91,@30,@100,@55];
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < targets.count; i ++) {
        
        int currentNumber =  4 * [targets[i] intValue];
        int x = i + 2;
        if (x >= targets.count) {
            break;
        }
        int currentNumber1 =  4 * [targets[i + 1] intValue];
        [path moveToPoint:CGPointMake(Zone_Point.x + x_margin * (i + 1) ,Zone_Point.y - currentNumber)];
        [path addLineToPoint:CGPointMake(Zone_Point.x + x_margin * (i+2),Zone_Point.y - currentNumber1)];
    
        
    }
    
    CAShapeLayer *currentLayer = [CAShapeLayer layer];
    currentLayer.path = path.CGPath;
    currentLayer.strokeColor = [UIColor redColor].CGColor;
    currentLayer.borderWidth = 2.0;
    [self.layer addSublayer:currentLayer];
    
//    NSMutableArray *allPoints = [NSMutableArray array];
//    for (int i=0; i<targets.count; i++) {
//        //由于标度值为20的时候，高度其实是80个点，缩小了4倍，所以计算坐标值得时候需要扩大4倍计算
//        CGFloat doubleValue = 4*[targets[i] floatValue]; //目标值放大四倍
//        CGFloat X = MARGIN + x_margin*(i+1);
//        CGFloat Y = CGRectGetHeight(bgFrame)-2*MARGIN-doubleValue;
//        CGPoint point = CGPointMake(X,Y);
//        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(point.x-1, point.y-1, 2, 2) cornerRadius:1];
//
//        CAShapeLayer *layer = [CAShapeLayer layer];
//        layer.strokeColor = [UIColor purpleColor].CGColor;
//        layer.fillColor = [UIColor purpleColor].CGColor;
//        layer.path = path.CGPath;
//        [self.subviews[0].layer addSublayer:layer];
//        [allPoints addObject:[NSValue valueWithCGPoint:point]];
//    }
//
//    //3.坐标连线
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:[allPoints[0] CGPointValue]];
//    for (int i =1; i<allPoints.count; i++) {
//        CGPoint point = [allPoints[i] CGPointValue];
//        [path addLineToPoint:point];
//    }
    
//    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
//    shapeLayer1.path = path.CGPath;
//    shapeLayer1.strokeColor = [UIColor redColor].CGColor;
//    shapeLayer1.fillColor = [UIColor clearColor].CGColor;
//    shapeLayer1.borderWidth = 2.0;
//    [self.subviews[0].layer addSublayer:shapeLayer1];
}


//- (void)drawRect:(CGRect)rect {
//    //采用 CGContextRef c
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 3.0);
//    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
//    CGContextMoveToPoint(context, 20, 20);
//    CGContextAddLineToPoint(context, 20, rect.size.height - 20);
//    CGContextAddLineToPoint(context, rect.size.width - 20, rect.size.height - 20);
//    CGContextStrokePath(context);
//
//
//
//}


@end

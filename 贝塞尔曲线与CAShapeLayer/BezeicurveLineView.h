//
//  BezeicurveLineView.h
//  贝塞尔曲线与CAShapeLayer
//
//  Created by ganzaihong on 2019/2/20.
//  Copyright © 2019 YD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define MARGIN            30   // 坐标轴与画布间距
#define Y_EVERY_MARGIN    20   // y轴每一个值的间隔数

// 颜色RGB
#define SSColor(r, g, b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define SSColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

// 随机色
#define SSRandomColor  SSColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 线条类型
typedef NS_ENUM(NSInteger, LineType) {
    LineType_Straight, // 折线
    LineType_Curve     // 曲线
};

@interface BezeicurveLineView : UIView

@end

NS_ASSUME_NONNULL_END

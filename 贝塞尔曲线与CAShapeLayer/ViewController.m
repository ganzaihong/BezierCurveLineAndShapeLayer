//
//  ViewController.m
//  贝塞尔曲线与CAShapeLayer
//
//  Created by ganzaihong on 2019/2/20.
//  Copyright © 2019 YD. All rights reserved.
//

#import "ViewController.h"
#import "BezeicurveLineView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BezeicurveLineView *beziercurveView = [[BezeicurveLineView alloc]initWithFrame:CGRectMake(10, 60, 375,500)];

    [self.view addSubview:beziercurveView];
   // beziercurveView.backgroundColor = [UIColor yellowColor];
}


@end

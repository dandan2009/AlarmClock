//
//  MDTimePickerView.m
//  AlarmClock
//
//  Created by IIMare on 14/6/10.
//  Copyright (c) 2014年 IIMare. All rights reserved.
//

#import "MDTimePickerView.h"

// 圆形选择器具View的边距
#define EDGE_OF_CIRCLE 40

/** Helper Functions **/
#define ToRad(deg) 		( (M_PI * (deg)) / 180.0 )
#define ToDeg(rad)		( (180.0 * (rad)) / M_PI )
#define SQR(x)			( (x) * (x) )

@interface MDTimePickerView ()

// 圆的半径
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat angle;
@property (nonatomic, assign) CGPoint centerPoint;

@end

@implementation MDTimePickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.opaque = NO;
        _centerPoint.x = frame.size.width / 2;
        _centerPoint.y = frame.size.height / 2;
        
        // 根据View大小适配圆形半径
        if (frame.size.width > frame.size.height) {
            _radius = frame.size.height/2 - EDGE_OF_CIRCLE;
        } else if (frame.size.width < frame.size.height) {
            _radius = frame.size.width/2 - EDGE_OF_CIRCLE;
        } else {
            _radius = frame.size.width / 2 - EDGE_OF_CIRCLE;
        }
        
        // A.M按钮
        UIButton *buttonAM = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        buttonAM.frame = CGRectMake(140, 90, 40, 20);
        //button.backgroundColor = [UIColor redColor];
        buttonAM.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        [buttonAM setTitle:@"A.M" forState:UIControlStateNormal];
        [buttonAM setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buttonAM addTarget:self action:@selector(tapAmButton:) forControlEvents:UIControlEventTouchUpInside];
        buttonAM.tag = 1;
        [self addSubview:buttonAM];
        
        // P.M按钮
        UIButton *buttonPM = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        buttonPM.frame = CGRectMake(140, 210, 40, 20);
        //button2.backgroundColor = [UIColor redColor];
        buttonPM.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        [buttonPM setTitle:@"P.M" forState:UIControlStateNormal];
        [buttonPM setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [buttonPM addTarget:self action:@selector(tapPmButton:) forControlEvents:UIControlEventTouchUpInside];
        buttonPM.tag = 2;
        [self addSubview:buttonPM];
        
        // Hour Label
        UILabel *hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 130, 70, 50)];
        //hourLabel.backgroundColor = [UIColor redColor];
        hourLabel.tag = 3;
        hourLabel.textAlignment = NSTextAlignmentCenter;
        hourLabel.text = @"00";
        hourLabel.textColor = [UIColor whiteColor];
        hourLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60];
        [self addSubview:hourLabel];
        
        // : Label
        UILabel *colonLabel = [[UILabel alloc] initWithFrame:CGRectMake(154, 130, 10, 50)];
        //colonLabel.backgroundColor = [UIColor blueColor];
        colonLabel.textAlignment = NSTextAlignmentLeft;
        colonLabel.text = @":";
        colonLabel.textColor = [UIColor whiteColor];
        colonLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60];
        [self addSubview:colonLabel];
        
        // Time Lable
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(168, 130, 70, 50)];
        timeLabel.text = @"00";
        timeLabel.tag = 4;
        timeLabel.textAlignment = NSTextAlignmentCenter;
        //timeLabel.backgroundColor = [UIColor redColor];
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60];
        [self addSubview:timeLabel];
        
        
    }
    return self;
}

#pragma mark - The am pm button event
- (void)tapAmButton:(UIButton *)sender
{
    if (sender.titleLabel.textColor == [UIColor grayColor]) {
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIButton *button2 = (UIButton *)[self viewWithTag:2];
       [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

- (void)tapPmButton:(UIButton *)sender
{

    if (sender.titleLabel.textColor == [UIColor grayColor]) {
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIButton *button1 = (UIButton *)[self viewWithTag:1];
        [button1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // 得到当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 绘制圆形的背景
    CGContextAddArc(context,self.centerPoint.x,self.centerPoint.y, self.radius, 0, M_PI * 2, YES);
    CGContextSetLineWidth(context, 3.5);
    CGContextSetLineCap(context, kCGLineCapButt);
    [[UIColor whiteColor] setStroke];
    CGContextDrawPath(context, kCGPathStroke);

}


@end

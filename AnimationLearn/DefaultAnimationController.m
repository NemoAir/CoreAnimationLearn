//
//  DefaultAnimationController.m
//  AnimationLearn
//
//  Created by Nemo on 14/11/24.
//  Copyright (c) 2014年 Nemo. All rights reserved.
//

#import "DefaultAnimationController.h"

@interface DefaultAnimationController ()
@property (strong, nonatomic) IBOutlet UIView *colorLayer;
@property (strong, nonatomic) IBOutlet UIButton *change;
@property (nonatomic, strong) CALayer *color;
@property (strong, nonatomic) IBOutlet UIImageView *rotationImageView;
@property (strong, nonatomic) IBOutlet UILabel *timeOffsetLable;
@end

@implementation DefaultAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.multipleTouchEnabled = YES;
    self.color = [CALayer layer];
    self.color.bounds = self.colorLayer.bounds;
    self.color.position = self.view.center;
    self.color.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
//    self.color.actions = @{@"backgroundColor":transition};
    [self.view.layer addSublayer:self.color];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    animation.toValue = @(-M_PI_2);
    animation.duration = 2.0f;
    animation.beginTime = 1.0;
//    animation.repeatCount = INFINITY;
//    animation.autoreverses = YES;
    self.rotationImageView.layer.speed = 0;
    animation.fillMode = kCAFillModeBoth;
    animation.removedOnCompletion = NO;
    [self.rotationImageView.layer addAnimation:animation forKey:nil];
}
- (IBAction)changeTimeOffset:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.rotationImageView.layer.timeOffset = slider.value;
    self.timeOffsetLable.text = [NSString stringWithFormat:@"timeOffset:%.3f",slider.value];
    [self.timeOffsetLable sizeToFit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    if ([self.color.presentationLayer hitTest:point]) {
        CGFloat red = arc4random()/(CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.color.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    }else{
        [CATransaction begin];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [CATransaction setAnimationDuration:4.0];
        self.color.position = point;
        [CATransaction commit];
    }
    NSLog(@"begin touches %d",touches.count);
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"move touches %d",touches.count);

    [super touchesMoved:touches withEvent:event];

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"end touches %d",touches.count);

    [super touchesEnded:touches withEvent:event];

}
- (IBAction)changeColor:(id)sender {
    //隐式动画
//    [CATransaction begin];
//    [CATransaction setAnimationDuration:1.0];
//    [CATransaction setCompletionBlock:^{
//        CGAffineTransform transform = self.color.affineTransform;
//        transform = CGAffineTransformRotate(transform, M_PI_4);
//        self.color.affineTransform = transform;
//    }];
//    CGFloat red = arc4random() / (CGFloat)INT_MAX;
//    CGFloat green = arc4random() / (CGFloat)INT_MAX;
//    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
//    UIColor *backColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
////    self.color.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
//    
//    [CATransaction commit];
    
    //显示动画
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    CALayer *layer= self.color.presentationLayer ? self.color.presentationLayer: self.color;
//    animation.fromValue = (__bridge id)(layer.backgroundColor);
//    animation.keyPath = @"backgroundColor";
//    animation.fromValue = (__bridge id)self.color.backgroundColor;
//
//    CGFloat red = arc4random() / (CGFloat)INT_MAX;
//    CGFloat green = arc4random() / (CGFloat)INT_MAX;
//    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
//    UIColor *backColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//    self.color.backgroundColor = backColor.CGColor;
//    animation.toValue = (__bridge id)backColor.CGColor;

//    [self.color addAnimation:animation forKey:nil];
    
    //关键帧动画
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.keyPath = @"backgroundColor";
    keyAnimation.duration = 4.0f;
    keyAnimation.values = @[
                            (__bridge id)[UIColor colorWithRed:1.000 green:0.275 blue:0.939 alpha:1.000].CGColor,
                            (__bridge id)[UIColor redColor].CGColor,
                            (__bridge id)[UIColor greenColor].CGColor,
                            (__bridge id)[UIColor colorWithRed:1.000 green:0.657 blue:0.922 alpha:1.000].CGColor
                            ];
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    keyAnimation.timingFunctions = @[fn,fn,fn];
    [self.color addAnimation:keyAnimation forKey:@"keyFrame"];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

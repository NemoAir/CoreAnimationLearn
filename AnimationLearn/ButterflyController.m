//
//  ButterflyController.m
//  AnimationLearn
//
//  Created by Nemo on 14/11/26.
//  Copyright (c) 2014年 Nemo. All rights reserved.
//

#import "ButterflyController.h"

@interface ButterflyController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageview;
@property (strong, nonatomic) IBOutlet UIButton *switchButton;

@property (nonatomic, strong) NSArray *images;
@property (strong, nonatomic) IBOutlet UIButton *animationControl;
@property (nonatomic, strong) CALayer *butterfly;
@property (strong, nonatomic) IBOutlet UILabel *timeOffsetLabel;
@property (strong, nonatomic) IBOutlet UILabel *speedLabel;
@end

@implementation ButterflyController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(20, 150)];
    [path addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = path.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor colorWithRed:1.000 green:0.864 blue:0.464 alpha:1.000].CGColor;
    pathLayer.lineWidth = 3.0;
    pathLayer.lineCap = kCALineCapRound;
    [self.view.layer addSublayer:pathLayer];
    
    CALayer *butterfly = [CALayer layer];
    butterfly.contents = (__bridge id)[UIImage imageNamed:@"butterfly"].CGImage;
    butterfly.shadowOffset = CGSizeMake(20, 20);
    butterfly.shadowRadius = 20;
    butterfly.shadowOpacity = 1;
    butterfly.position = CGPointMake(20, 150);
    butterfly.bounds = CGRectMake(0, 0, 64, 64);
    [self.view.layer addSublayer:butterfly];
    
    self.butterfly = butterfly;

    self.images = @[
                    [UIImage imageNamed:@"petal"],
                    [UIImage imageNamed:@"butterfly"],
                    [UIImage imageNamed:@"clock_bg"],
                    [UIImage imageNamed:@"background.jpg"],
                    ];
//    self.butterfly.fillMode = kCAFillModeBoth;
    
}
- (IBAction)changeSpeed:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.butterfly.speed = slider.value;
    self.speedLabel.text = [NSString stringWithFormat:@"speed:%.0f",slider.value];


}
- (IBAction)changeTimeOffset:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.butterfly.timeOffset = slider.value;
    self.timeOffsetLabel.text = [NSString stringWithFormat:@"timeOffset:%.0f",slider.value];
}
- (IBAction)controlAnimation:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if ([btn.currentTitle isEqualToString:@"start"]) {
        [btn setTitle:@"stop" forState:UIControlStateNormal];
        
        UIBezierPath *path = [[UIBezierPath alloc]init];
        [path moveToPoint:CGPointMake(20, 150)];
        [path addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
        [UIColor colorWithRed:1.0 green:0.593458 blue:0.0352083 alpha:1.000];
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"position";
        animation.path = path.CGPath;
        animation.rotationMode = kCAAnimationRotateAuto;
//        animation.autoreverses = YES;
        //    [butterfly addAnimation:animation forKey:@"butter"];
        
        CABasicAnimation *animation2 = [CABasicAnimation animation];
        animation2.keyPath = @"shadowColor";
        animation2.toValue = (__bridge id)[UIColor redColor].CGColor;
        
        CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
        groupAnimation.animations = @[animation,animation2];
        groupAnimation.duration = 4.0;
//        groupAnimation.repeatCount = INFINITY;
        groupAnimation.removedOnCompletion = NO;
        groupAnimation.fillMode = kCAFillModeBackwards;
        groupAnimation.delegate = self;
        [self.butterfly addAnimation:groupAnimation forKey:@"group"];
        groupAnimation.autoreverses = YES;
        
    }else{
        [btn setTitle:@"start" forState:UIControlStateNormal];
        [self.butterfly removeAnimationForKey:@"group"];
    }
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.animationControl setTitle:@"start" forState:UIControlStateNormal];
    NSLog(@"the animation stopped(finished:%@)",flag ? @"YES":@"NO");
}
- (IBAction)switchImage:(id)sender {
    [self performTransiton];

    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionReveal;
    transition.autoreverses = YES;
    transition.subtype = kCATransitionFromBottom;
    [self.imageview.layer addAnimation:transition forKey:nil];
    
    UIImage *currentImage = self.imageview.image;
    
    NSInteger index = [self.images indexOfObject:currentImage];
    
    index = (index + 1)%self.images.count;
    
    self.imageview.image = self.images[index];
    
}
- (void)performTransiton{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, [UIScreen mainScreen].scale);
    //    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];//这个方法获取当前视图截图效率最低
    
    //    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];//这个方法获取当前视图截图速度稍次
//    UIView *coverView = [[UIImageView alloc]initWithImage:UIGraphicsGetImageFromCurrentImageContext()];
//    coverView.frame = self.view.bounds;
    UIView *coverView = [self.view snapshotViewAfterScreenUpdates:YES];//这个获取当前视图的截图方法最快
    [self.view addSubview:coverView];
    
    CGFloat red = arc4random()/(CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    
    [UIView animateWithDuration:1.0 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(0.1, 0.1);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        
        coverView.transform = transform;
        coverView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        [coverView removeFromSuperview];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

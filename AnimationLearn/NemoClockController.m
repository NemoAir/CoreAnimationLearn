//
//  NemoClockController.m
//  AnimationLearn
//
//  Created by Nemo on 14/11/20.
//  Copyright (c) 2014年 Nemo. All rights reserved.
//

#import "NemoClockController.h"

@interface NemoClockController ()
@property (strong, nonatomic) IBOutlet UIImageView *hour;
@property (strong, nonatomic) IBOutlet UIImageView *minute;
@property (strong, nonatomic) IBOutlet UIImageView *second;
@property (strong, nonatomic) IBOutlet UIImageView *clock;
@property (nonatomic, strong) NSTimer *timer;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *clockTimes;

@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@end

@implementation NemoClockController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/255.0 alpha:1];
    self.hour.layer.anchorPoint = CGPointMake(0.5, 0.8);
    self.minute.layer.anchorPoint = CGPointMake(0.5, 0.8);
    self.second.layer.anchorPoint = CGPointMake(0.5, 0.8);
    
    self.hour.layer.position = self.clock.layer.position;
    self.minute.layer.position = self.clock.layer.position;
    self.second.layer.position = self.clock.layer.position;
    [self.view sendSubviewToBack:self.clock];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    CALayer *maskLayer = [[CALayer alloc]init];
    maskLayer.frame = self.imageView.bounds;
   
    maskLayer.contentsGravity =  kCAGravityResizeAspect;
    UIImage *petal = [UIImage imageNamed:@"petal"];
    maskLayer.contents = (__bridge id)petal.CGImage;
    
    CALayer *shadowLayer = [[CALayer alloc]init];
    shadowLayer.bounds = CGRectMake(0, 0, petal.size.width,petal.size.height);
    shadowLayer.contents = maskLayer.contents;
    shadowLayer.position = self.imageView.layer.position;
    shadowLayer.shadowRadius = 5;
    shadowLayer.shadowColor = [UIColor colorWithRed:1.000 green:0.173 blue:0.367 alpha:1.000].CGColor;
    shadowLayer.shadowOpacity = 0.5;
    shadowLayer.shadowOffset = CGSizeMake(4, 90);
    
    self.imageView.layer.mask = maskLayer;
//    [self.view.layer addSublayer:shadowLayer];



    
    UIImage *digits = [UIImage imageNamed:@"digits"];
    
    for (UIView *view in self.clockTimes) {
        view.layer.contents = (__bridge id)digits.CGImage;
        view.layer.contentsRect = CGRectMake(0.1, 0, 0.1, 1);
        view.layer.contentsGravity = kCAGravityResizeAspect;
        view.layer.magnificationFilter = kCAFilterNearest;
    }
    [self customButton:self.leftButton];
    [self customButton:self.rightButton];
    
    self.leftButton.layer.shadowOffset = CGSizeMake(3, 4);

    self.leftButton.layer.shadowColor = [UIColor colorWithRed:1.000 green:0.996 blue:0.271 alpha:1.000].CGColor;
    self.leftButton.layer.shadowOpacity = 0.5;
//    self.leftButton.layer.shadowRadius = 10;
//    self.rightButton.alpha = 0.5;
    self.rightButton.layer.opacity = 0.5;
    self.rightButton.layer.shouldRasterize = YES;
    self.rightButton.layer.rasterizationScale = [UIScreen mainScreen].scale;
}
- (void)customButton:(UIButton *)btn{
    btn.backgroundColor = [UIColor whiteColor];
    CGRect rect = CGRectInset(btn.bounds, 10, 10);
    UILabel *lable = [[UILabel alloc]initWithFrame:rect];
    [btn addSubview:lable];
    lable.backgroundColor = [UIColor whiteColor];
    lable.text = @"Hello World";
    lable.textAlignment = NSTextAlignmentCenter;
    
    btn.layer.cornerRadius = 10;
}
- (void)tick{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger  units = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *compoents = [calendar components:units fromDate:[NSDate date]];
    
    CGFloat hourAngle = (compoents.hour/12.0) * M_PI * 2.0;
    
    CGFloat minAngle = (compoents.minute / 60.0) * 2 * M_PI;
    
    CGFloat secondAngle = (compoents.second / 60.0) * 2 * M_PI;
    
//    self.hour.transform = CGAffineTransformMakeRotation(hourAngle);
//    self.minute.transform = CGAffineTransformMakeRotation(minAngle);
//    self.second.transform = CGAffineTransformMakeRotation(secondAngle);
    
  
    
    [self setDigit:compoents.hour/10 forView:self.clockTimes[0]];
    [self setDigit:compoents.hour%10 forView:self.clockTimes[1]];
    
    [self setDigit:compoents.minute/10 forView:self.clockTimes[2]];
    [self setDigit:compoents.minute%10 forView:self.clockTimes[3]];
    
    [self setDigit:compoents.second/10 forView:self.clockTimes[4]];
    [self setDigit:compoents.second%10 forView:self.clockTimes[5]];
    
    [self setAngle:hourAngle forHand:self.hour animated:YES];
    [self setAngle:minAngle forHand:self.minute animated:YES];
    [self setAngle:secondAngle forHand:self.second animated:YES];
}
- (void)setDigit:(NSInteger)digit forView:(UIView *)view{
    view.layer.contentsRect = CGRectMake(digit*0.1, 0, 0.1, 1.0);
}
- (void)setAngle:(CGFloat)angle forHand:(UIView *)handView animated:(BOOL)animated{
    CABasicAnimation *animation;
    CATransform3D transform = CATransform3DMakeRotation(angle, 0, 0, 1);


    animation = [CABasicAnimation animation];
    animation.fromValue = [NSValue valueWithCATransform3D:handView.layer.transform];
    
    //在动画开始前修改model layer的结束状态
    //    [CATransaction begin];
    //    [CATransaction setDisableActions:YES];
    //    handView.layer.transform = transform;
    //    [CATransaction commit];
    //    handView.layer.transform = transform;
    
    animation.keyPath = @"transform";
    animation.toValue = [NSValue valueWithCATransform3D:transform];
    animation.duration = 1.0;
    animation.delegate = self;
    [animation setValue:handView forKey:@"handView"];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;

    [handView.layer addAnimation:animation forKey:@"rotation"];
    

}
-(void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag{
    //在动画结束后修改model layer的结束状态，不能完美动画，因为实际设备会在动画完成前就调用动画结束的回调。所以设置model tree的结束状态不能精准到动画刚好结束时。
    UIView *handView = [anim valueForKey:@"handView"];
    [handView.layer removeAnimationForKey:@"rotation"];
    handView.layer.transform = [anim.toValue CATransform3DValue];
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

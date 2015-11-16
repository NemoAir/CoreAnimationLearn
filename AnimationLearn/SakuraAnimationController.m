//
//  SakuraAnimationController.m
//  AnimationLearn
//
//  Created by Nemo on 14/11/18.
//  Copyright (c) 2014年 Nemo. All rights reserved.
//

#import "SakuraAnimationController.h"

@interface SakuraAnimationController ()

@property (nonatomic, strong) CALayer *sakura;
@end

@implementation SakuraAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
 
    self.sakura = [CALayer new];
    _sakura.bounds = CGRectMake(0, 0, 10, 20);
    _sakura.position = CGPointMake(50, 150);
    _sakura.contents = (__bridge id)[UIImage imageNamed:@"petal"].CGImage;
    _sakura.anchorPoint = CGPointMake(0.5, 0.6);
    [self.view.layer addSublayer:_sakura];
}
#pragma mark 移动动画

- (void)translationAnimation:(CGPoint )location{
    //1.创建动画并指定动画属性

    CABasicAnimation *basciAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    //2.设置动画属性初始值和结束值
    //    basicAnimation.fromValue=[NSNumber numberWithInteger:50];//可以不设置，默认为图层初始状态
    basciAnimation.toValue = [NSValue valueWithCGPoint:location];
    
    basciAnimation.duration = 5;
//    basciAnimation.repeatCount = HUGE_VALL;//设置重复次数,HUGE_VALF可看做无穷大，起到循环动画的效果
//    basciAnimation.removedOnCompletion = NO;//运行一次是否移除动画
    //3.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    
    [basciAnimation setValue:[NSValue valueWithCGPoint:location] forKey:@"NeBasicAnimationLocation"];
    basciAnimation.delegate = self;
    [_sakura addAnimation:basciAnimation forKey:@"NeBasicAnimation"];
    
}

#pragma mark 旋转动画
- (void)rotationAnimation{
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    basicAnimation.toValue = [NSNumber numberWithFloat:M_PI_2*3];
    
    basicAnimation.duration = 2.5;
    basicAnimation.autoreverses = YES;
    
    [_sakura addAnimation:basicAnimation forKey:@"NeRotationAnimation"];
}
#pragma mark 点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
    
    if (_sakura.speed == 0 ) {
        [self animationResume];
       
    }else{
        [self animationPause];
    }
    [self translationAnimation:location];
    [self rotationAnimation];
}

- (void)animationPause{
    CFTimeInterval interval = [_sakura convertTime:CACurrentMediaTime() fromLayer:nil];
//    _sakura.timeOffset = interval;
    _sakura.speed = 0;
}
- (void)animationResume{
    CFTimeInterval beginTime = CACurrentMediaTime() - _sakura.timeOffset;
//    _sakura.timeOffset = 0;
//    _sakura.beginTime = beginTime;
    _sakura.speed = 1.0;
}
-(void)animationDidStart:(CAAnimation *)anim {

    NSLog(@"animation(%@) start.\r_layer.frame=%@",anim,NSStringFromCGRect(_sakura.frame));
    NSLog(@"%@",[_sakura animationForKey:@"NeBasicAnimation"]);//通过前面的设置的key获得动画

    

}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"animation(%@) stop.\r_layer.frame=%@",anim,NSStringFromCGRect(_sakura.frame));
    [CATransaction begin];
    
    [CATransaction setDisableActions:YES];
    _sakura.position=[[anim valueForKey:@"NeBasicAnimationLocation"] CGPointValue];
    
    [CATransaction commit];
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

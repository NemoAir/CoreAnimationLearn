//
//  SpecialLayerController.m
//  AnimationLearn
//
//  Created by Nemo on 14/11/24.
//  Copyright (c) 2014年 Nemo. All rights reserved.
//

#import "SpecialLayerController.h"

@interface SpecialLayerController ()

@property (nonatomic, strong) CAEmitterLayer *emitterLayer;
@property (strong, nonatomic) IBOutlet UILabel *renderMode;
@property (strong, nonatomic) IBOutlet UILabel *emitterMode;
@property (strong, nonatomic) IBOutlet UILabel *emitterShape;
@end

@implementation SpecialLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = - 1/500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 1, -1, 0);
        self.view.layer.sublayerTransform = transform;
    UIBezierPath *path = [[UIBezierPath alloc]init];
    
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    shaperLayer.strokeColor = [UIColor colorWithRed:1.000 green:0.797 blue:0.238 alpha:1.000].CGColor;
    shaperLayer.fillColor = [UIColor clearColor].CGColor;
    //    shaperLayer.lineCap = kCALineCapButt;
    //    shaperLayer.lineCap = kCALineCapSquare;
    //    shaperLayer.lineJoin = kCALineJoinBevel;
    //    shaperLayer.lineJoin = kCALineJoinMiter;
    shaperLayer.lineWidth = 5;
    shaperLayer.path = path.CGPath;
    [self.view.layer addSublayer:shaperLayer];
    
    CGRect rect = CGRectMake(100, 250, 100, 200);
    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft;
    UIBezierPath *pathRect = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    CAShapeLayer *rectlayer = [CAShapeLayer layer];
//    rectlayer.frame = rect;

    rectlayer.path = pathRect.CGPath;
    rectlayer.fillColor = [UIColor colorWithRed:0.500 green:0.354 blue:0.482 alpha:1.000].CGColor;
    
    
    CAShapeLayer *arcLayer = [CAShapeLayer layer];
    arcLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 300) radius:40 startAngle:0 endAngle:M_PI clockwise:YES].CGPath;
    arcLayer.fillColor = [UIColor colorWithRed:0.356 green:0.296 blue:1.000 alpha:1.000].CGColor;
    [self.view.layer addSublayer:arcLayer];
//    rectlayer.mask = arcLayer;
    [self.view.layer addSublayer:rectlayer];
    
    UIView *bubble = [[UIView alloc]initWithFrame:CGRectMake(100, 500, 300, 200)];
    bubble.backgroundColor = [UIColor colorWithRed:1.000 green:0.726 blue:0.887 alpha:1.000];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    CGRect maskRect = CGRectMake(0, 0, 100, 200);
//    maskLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 550) radius:20 startAngle:0 endAngle:M_PI clockwise:YES].CGPath;
    maskLayer.path = [UIBezierPath bezierPathWithOvalInRect:maskRect].CGPath;
    
//    maskLayer.frame = CGRectMake(0, 0, 100, 200);
    bubble.layer.mask = maskLayer;

    [self.view addSubview:bubble];
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(50, 250, 150, 150);
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:0.390 green:1.000 blue:0.228 alpha:1.000].CGColor,(__bridge id)[UIColor colorWithRed:0.285 green:0.198 blue:1.000 alpha:1.000].CGColor,(__bridge id)[UIColor colorWithRed:1.000 green:0.327 blue:0.089 alpha:1.000].CGColor];
    gradientLayer.startPoint = CGPointMake(1, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.locations = @[@0.0,@.05,@0.75];
    [self.view.layer addSublayer:gradientLayer];
  
    [self setSakuraEmitterLayer];
}
- (void)setSakuraEmitterLayer{
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.view.bounds;
    [self.view.layer addSublayer:emitter];
    
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width/2.0, emitter.frame.size.height/2.0);
    emitter.zPosition = 10;
    CAEmitterCell *cell = [CAEmitterCell new];
    cell.contents = (__bridge id)[UIImage imageNamed:@"petal"].CGImage;
    cell.birthRate = 10;
    cell.lifetime = 3.0;
    cell.color = [UIColor colorWithRed:1.000 green:0.386 blue:0.608 alpha:1.000].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 20;
    cell.velocityRange = 60;
    cell.scale = 1.0;
    cell.scaleRange = 1.5;
    cell.scaleSpeed = 0.8;
    cell.spin = M_PI_4 / 2.0;
    cell.spinRange = M_PI * 2.0;
    
    cell.magnificationFilter = kCAFilterTrilinear;
//    cell.emissionLatitude = M_PI;
//    cell.emissionLongitude = M_PI;
    cell.emissionRange = M_PI* 2.0 ;
    
    CAEmitterCell *RadusCell = [CAEmitterCell emitterCell];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 3, 3)];
    
    view.backgroundColor = [UIColor clearColor];
    view.layer.cornerRadius = view.bounds.size.width/2.0;
    
    RadusCell.contents = (__bridge id)[UIImage imageNamed:@"butterfly"].CGImage;
//    RadusCell.contents = cell.contents;
//    RadusCell.redRange = 255;
//    RadusCell.redSpeed = 1.0;
//    RadusCell.repeatCount = HUGE_VAL;
//    RadusCell.greenRange = 255;
//    RadusCell.greenSpeed = 1.5;
//    RadusCell.blueRange = 255;
//    RadusCell.blueSpeed = 2.0;
    RadusCell.alphaRange = 0.5;
    RadusCell.alphaSpeed = 0.15;
    
    RadusCell.birthRate = 3;
    RadusCell.lifetime = 5.0;
    RadusCell.velocity = 15;
    RadusCell.velocityRange = 30;
    RadusCell.scale = 1.0;
    RadusCell.scale = 1.3;
    RadusCell.magnificationFilter = kCAFilterTrilinear;
    RadusCell.emissionRange = M_PI;
    
    emitter.emitterCells = @[RadusCell,cell];
    
    self.emitterLayer = emitter;

}
- (UIImage *)creatImageFromView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, [UIScreen mainScreen].scale);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
- (IBAction)changeEmitter:(id)sender {
    NSArray *renderMode = @[kCAEmitterLayerUnordered,kCAEmitterLayerOldestFirst,kCAEmitterLayerOldestLast,kCAEmitterLayerBackToFront,kCAEmitterLayerAdditive];
    NSArray *emitterMode = @[kCAEmitterLayerPoints,kCAEmitterLayerOutline,kCAEmitterLayerSurface,kCAEmitterLayerVolume];
    NSArray *emitterShape = @[kCAEmitterLayerPoint,kCAEmitterLayerLine,kCAEmitterLayerRectangle,kCAEmitterLayerCuboid,kCAEmitterLayerCircle,kCAEmitterLayerSphere];
    
    NSInteger index = [renderMode indexOfObject:self.emitterLayer.renderMode];
    if (index == renderMode.count - 1) {
        index = 0;
    }else{
        index++;
    }

    self.emitterLayer.renderMode = renderMode[index];
    self.renderMode.text = self.emitterLayer.renderMode;
    [self.renderMode sizeToFit];
    
    
    index = [emitterMode indexOfObject:self.emitterLayer.emitterMode];
 
    if (index == emitterMode.count - 1) {
        index =0;
    }else {
        index ++;
    }
    self.emitterLayer.emitterMode = emitterMode[index];
    self.emitterMode.text = self.emitterLayer.emitterMode;
    [self.emitterMode sizeToFit];
    
    index = [emitterShape indexOfObject:self.emitterLayer.emitterShape];
    if (index == emitterShape.count - 1) {
        index = 0;
    }else {
        index++;
    }
    self.emitterLayer.emitterShape = emitterShape[index];

    self.emitterShape.text = self.emitterLayer.emitterShape;
    [self.emitterShape sizeToFit];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    

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

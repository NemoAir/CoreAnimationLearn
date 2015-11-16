//
//  CubicController.m
//  AnimationLearn
//
//  Created by Nemo on 14/11/20.
//  Copyright (c) 2014年 Nemo. All rights reserved.
//

#import "CubicController.h"
#import <QuartzCore/QuartzCore.h>
#import <GLKit/GLKit.h>

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

@interface CubicController ()

@property (strong, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, strong) NSMutableArray *faces;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@end

@implementation CubicController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.faces = [NSMutableArray array];
    [self creatCubeView];
    CGFloat r = ((arc4random() % 255) + 1 )/255.0;
    CGFloat g = ((arc4random() % 255) + 1 )/255.0;
    CGFloat b = ((arc4random() % 255) + 1 )/255.0;
    self.view.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
    self.containerView.backgroundColor = self.view.backgroundColor;
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    
    self.containerView.layer.sublayerTransform = perspective;
    NSInteger width = self.containerView.bounds.size.width/2.0;
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, width);
    [self addFace:0 withTransform:transform];
    //add cube face 2
    transform = CATransform3DMakeTranslation(width, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
  
    //add cube face 4
    transform = CATransform3DMakeTranslation(0, width, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    //add cube face 5
    transform = CATransform3DMakeTranslation(-width, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -width);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];

    //add cube face 3
    transform = CATransform3DMakeTranslation(0, -width, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeLightColor) userInfo:nil repeats:YES];
}
- (void)changeLightColor{
    for (UIView *face in self.faces) {
        [self applyLightingToFace:face.layer];
    }
  
    [self thirdButtonClicked:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)applyLightingToFace:(CALayer *)face
{
    //add lighting layer
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    CGFloat r = ((arc4random() % 255) + 1 )/255.0;
    CGFloat g = ((arc4random() % 255) + 1 )/255.0;
    CGFloat b = ((arc4random() % 255) + 1 )/255.0;
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:shadow];
//    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}
- (void)creatCubeView{
    
    for (int index = 0; index< 6; index++) {
        UIView *view = [[UIView alloc]initWithFrame:self.containerView.bounds];

        view.center = CGPointMake(self.containerView.bounds.size.width/2.0f, self.containerView.bounds.size.height/2.0f);
      
        CGFloat r = ((arc4random() % 255) + 1 )/255.0;
        CGFloat g = ((arc4random() % 255) + 1 )/255.0;
        CGFloat b = ((arc4random() % 255) + 1 )/255.0;
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectInset(self.containerView.bounds, 20, 20)];

        if (index != 2) {
            lable.text = [NSString stringWithFormat:@"%d",index];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.textColor = [UIColor colorWithRed:r green:g blue:b alpha:1];

            [view addSubview:lable];
        }else{
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectInset(self.containerView.bounds, 20, 20)];
//            button.titleLabel.text = @"3";
            [button setTitle:@"3" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor blueColor];
            [view addSubview:button];
            [button addTarget:self action:@selector(thirdButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        view.layer.shadowColor = lable.textColor.CGColor;
        view.layer.shadowOffset = CGSizeMake(5, 5);
        view.layer.shadowRadius = 10;
        view.backgroundColor = [UIColor colorWithRed:g green:r blue:b alpha:1];
        
        [self.faces addObject:view];
    }

    
}
- (void)thirdButtonClicked:(UIButton *)btn{
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500;
    CGFloat value = ((arc4random() % 1000) + 1 );
//    value++;
    [self.slider setValue:value animated:YES];

    perspective = CATransform3DRotate(perspective, -M_PI_4/45 * value, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4/45 * value, 0, 1, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4/45 * value, 0, 0, 1);
    
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.fromValue = [NSValue valueWithCATransform3D:self.containerView.layer.sublayerTransform];
    
    [CATransaction begin];
    self.containerView.layer.sublayerTransform = perspective;
    [CATransaction setDisableActions:YES];
    [CATransaction commit];
    
    animation.toValue = [NSValue valueWithCATransform3D:perspective];
    animation.duration = 1.0;
    animation.keyPath = @"sublayerTransform";
    [self.containerView.layer addAnimation:animation forKey:nil];
    
}
- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform{
    UIView *face = self.faces[index];
    [self.containerView addSubview:face];
    [self applyLightingToFace:face.layer];

    face.layer.transform = transform;
}
- (IBAction)changePerspective:(id)sender {
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500;
  
    perspective = CATransform3DRotate(perspective, -M_PI_4/45 * self.slider.value, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4/45 * self.slider.value, 0, 1, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4/45 * self.slider.value, 0, 0, 1);

      self.containerView.layer.sublayerTransform = perspective;
   

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

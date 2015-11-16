//
//  TransformController.m
//  AnimationLearn
//
//  Created by Nemo on 14/11/20.
//  Copyright (c) 2014年 Nemo. All rights reserved.
//

#import "TransformController.h"

@interface TransformController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *imageview2;
@property (strong, nonatomic) IBOutlet UIImageView *clock0;
@property (strong, nonatomic) IBOutlet UIImageView *clock1;
@property (strong, nonatomic) IBOutlet UIImageView *clock2;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@end

@implementation TransformController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
CGAffineTransform CGAffineTransformMakeShear(CGFloat x, CGFloat y)
{
    //倾斜变换
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.c = -x;
    transform.b = y;
    return transform;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGAffineTransform transform1 = CGAffineTransformIdentity;
    
    transform = CGAffineTransformTranslate(transform, 150, 0);

    transform1 = CGAffineTransformScale(transform, 0.8, 0.8);

    transform1 = CGAffineTransformRotate(transform, M_PI);
    

//    self.imageView.layer.affineTransform = transform1;
    self.imageview2.layer.affineTransform = CGAffineTransformMakeShear(0, 1);
    
    self.clock0.layer.transform = CATransform3DMakeRotation(M_PI_4, 1, 0, 0);
    self.clock1.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.clock2.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    
    [UIView animateWithDuration:1.0
                           delay:0.0
                         options:UIViewAnimationOptionRepeat animations:^{
                             //iOS7、8 默认旋转方向相反
                             if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
                                 
                                 self.imageView.layer.affineTransform = CGAffineTransformMakeRotation( (M_PI- 0.000000001));

                             }else{
                                 self.imageView.layer.affineTransform = CGAffineTransformMakeRotation( M_PI);

                             }
    } completion:^(BOOL finished) {
        
    }];
    

}
- (IBAction)sliderChange:(id)sender {
    UISlider *slider = (UISlider *)sender;
    CATransform3D transfrom = CATransform3DIdentity;
    transfrom.m34 = - 1.0 / slider.value;
    self.view.layer.sublayerTransform = transfrom;
    
//    self.clock0.layer.transform = CATransform3DRotate(transfrom, M_PI_4, 0, 1, 0);
//    self.clock1.layer.transform = CATransform3DRotate(transfrom, M_PI_4, 1, 0, 0);
//    self.clock2.layer.transform = CATransform3DRotate(transfrom, M_PI_4, 1, 1, 0);
    self.clock0.layer.transform = CATransform3DMakeRotation(M_PI_4, 1, 0, 0);
    self.clock1.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.clock2.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, slider.value);
    self.clock2.layer.affineTransform = CGAffineTransformMakeRotation(M_PI_4/45 * slider.value);
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

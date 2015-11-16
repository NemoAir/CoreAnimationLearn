//
//  PortraitController.m
//  AnimationLearn
//
//  Created by Nemo on 14/11/18.
//  Copyright (c) 2014年 Nemo. All rights reserved.
//

#import "PortraitController.h"
#define PHOTO_HEIGHT 150


@interface PortraitController ()

@end

@implementation PortraitController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CGPoint position = CGPointMake(160, 200);
    CGRect bounds = CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    CGFloat corradius = PHOTO_HEIGHT/2;
    CGFloat borderWidth = 2;
    
    CALayer *shadowLayer = [[CALayer alloc]init];
    shadowLayer.bounds = bounds;
    shadowLayer.position = position;
    shadowLayer.cornerRadius = corradius;
    shadowLayer.shadowColor = [UIColor grayColor].CGColor;
    shadowLayer.shadowOffset = CGSizeMake(2, 1);
    shadowLayer.shadowOpacity = 1;
    shadowLayer.borderColor = [UIColor whiteColor].CGColor;
    shadowLayer.borderWidth = borderWidth;
    [self.view.layer addSublayer:shadowLayer];
    
    
    CALayer *layer = [CALayer new];
    layer.bounds = bounds;
    layer.position = position;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = corradius;
    layer.masksToBounds = YES;
    layer.borderWidth = borderWidth;
    layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self.view.layer addSublayer:layer];
    
    layer.delegate = self;
    //可以直接设置contents 不绘图就不会出现图像倒立的问题
    //[layer setNeedsDisplay];

    UIImage *image = [UIImage imageNamed:@"open2"];
    layer.contents = CFBridgingRelease(image.CGImage);
}


- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    
    //可以使用transform属性解决
    //    CGContextScaleCTM(ctx, 1, -1);
    //    CGContextTranslateCTM(ctx, 0, -PHOTO_HEIGHT);
    layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);

    UIImage *image = [UIImage imageNamed:@"open2"];
    CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);
    
   CGContextRestoreGState(ctx);
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch=[touches anyObject];
    CALayer *shadowLayer = self.view.layer.sublayers[0];
    CALayer *layer=self.view.layer.sublayers[1];
    CGFloat width=layer.bounds.size.width;
    
    CGFloat shadowWidth = shadowLayer.bounds.size.width;
    if (width==PHOTO_HEIGHT) {
        width=PHOTO_HEIGHT/2;
        shadowWidth = PHOTO_HEIGHT/4;
    }else{
        width=PHOTO_HEIGHT;
    }
    layer.bounds=CGRectMake(0, 0, width, width);
//    shadowLayer.bounds = layer.bounds;
    layer.position=[touch locationInView:self.view];
    shadowLayer.position = layer.position;
    
    layer.cornerRadius=width/2;
    shadowLayer.cornerRadius = shadowWidth/2;

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

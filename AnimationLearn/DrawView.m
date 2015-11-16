//
//  DrawView.m
//  AnimationLearn
//
//  Created by Nemo on 14/11/27.
//  Copyright (c) 2014年 Nemo. All rights reserved.
//

#import "DrawView.h"
#define BrushSize 30
@interface DrawView ()

@property (nonatomic, strong) UIBezierPath *path;

@property (nonatomic, strong) NSMutableArray *strokes;
@end
@implementation DrawView

+(Class)layerClass{
    return [CAShapeLayer class];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.path = [[UIBezierPath alloc]init];
        
        CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
        shapeLayer.strokeColor = [UIColor colorWithRed:1.0 green:0.593458 blue:0.0352083 alpha:1.000].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.lineWidth = 5;
        
        //用图片代替绘制
        _strokes = [NSMutableArray array];
    }
    return self;
}
-(void)awakeFromNib{


}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    
    [self.path moveToPoint:point];
    [self addBurshStrokeAtPoint:point];
}
-(void)addBurshStrokeAtPoint:(CGPoint)point{
    [self.strokes addObject:[NSValue valueWithCGPoint:point]];
    
    [self setNeedsDisplayInRect:[self redrawRectAtPoint:point]];
}
- (CGRect)redrawRectAtPoint:(CGPoint)point{
    return CGRectMake(point.x - BrushSize/2, point.y - BrushSize/2, BrushSize, BrushSize);
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    [self.path addLineToPoint:point];
    
    [self addBurshStrokeAtPoint:point];
    
    //((CAShapeLayer *)self.layer).path = self.path.CGPath;
    
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    for (NSValue *value in self.strokes) {
        CGPoint point = [value CGPointValue];
        CGRect drawrect = [self redrawRectAtPoint:point];
        
        if (CGRectIntersectsRect(rect, drawrect)) {
            [[UIImage imageNamed:@"petal"] drawInRect:drawrect];

        }
    }
//    [[UIImage imageNamed:@"petal"] drawInRect:rect];

}


@end

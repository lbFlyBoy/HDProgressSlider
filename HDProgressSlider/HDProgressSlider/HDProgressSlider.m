//
//  HDProgressSlider.m
//  HDProgressSlider
//
//  Created by admin on 2017/7/3.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "HDProgressSlider.h"

static const CGFloat kTrackH = 7.f;
static const CGFloat kTrackMariginTop = 2.5f;

@interface HDProgressSlider ()
@property (nonatomic, strong) UILabel *tisLab;
@property (nonatomic, strong) CAShapeLayer *pathLayer;
@property (nonatomic, strong) CAShapeLayer *subLayer;

@end

@implementation HDProgressSlider
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {

    }
    return self;
}


- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();

    [self drawTrack:context withRect:CGRectMake(0, kTrackMariginTop, rect.size.width, kTrackH)];
    
    [self drawProgress:context withRect:CGRectMake(0, kTrackMariginTop, rect.size.width, kTrackH)];
}

- (void)drawProgress:(CGContextRef)context withRect:(CGRect)rect
{
    
    CGFloat progressY = rect.origin.y;
    
    // 弧度 preArc nextArc
    CGFloat preArc = rect.size.height * 0.5;//3.5
    CGFloat nextArcM = 2.5f;
    CGFloat nextArc = preArc + nextArcM;//6
    CGFloat nextArcTailW = 14.f;
    
    CGFloat progressLength = (rect.size.width - preArc - nextArc - nextArcTailW) / 10 ;
    CGFloat sumLength = progressLength * _progress;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(rect.size.height  * 0.5, progressY + rect.size.height * 0.5) radius:rect.size.height * 0.5 startAngle:M_PI_2 endAngle: - M_PI_2 clockwise:1];
    
    
        [path addLineToPoint:CGPointMake(preArc + sumLength, progressY)];

        [path addLineToPoint:CGPointMake(preArc + nextArcTailW + sumLength, progressY - nextArcM)];
        
        
        [path addArcWithCenter:CGPointMake(preArc + nextArcTailW + sumLength, progressY + rect.size.height * 0.5) radius:nextArc startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:1];
        
        //
        [path addLineToPoint:CGPointMake(preArc + sumLength, progressY + rect.size.height)];
        //
        
        [path addLineToPoint:CGPointMake(preArc, progressY + rect.size.height)];
    
    


    
    self.pathLayer.path = path.CGPath;
    
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(preArc + nextArcTailW + sumLength,progressY + rect.size.height * 0.5) radius:nextArc - nextArcM startAngle:0 endAngle:M_PI * 2 clockwise:1];
    
    self.subLayer.path = bezierPath.CGPath;
//    CAShapeLayer *subLayer = [CAShapeLayer layer];
//    subLayer.path = bezierPath.CGPath;
//    subLayer.fillColor = [UIColor whiteColor].CGColor;
//    [pathLayer addSublayer:subLayer];

    
    self.tisLab.text = [NSString stringWithFormat:@"+%@%%",@(_progress * 10)];
    CGSize tipsLabSize = [self.tisLab sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat tipsLabX = (preArc + nextArcTailW + nextArc + sumLength) - tipsLabSize.width;
    CGFloat tipsLabY = progressY + kTrackH + 3.;
    self.tisLab.frame =CGRectMake(tipsLabX, progressY + tipsLabY, tipsLabSize.width, tipsLabSize.height);
}

- (void)drawTrack:(CGContextRef)context withRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:kTrackH];
    [[UIColor colorWithRed:235/255. green:235/255. blue:235/255. alpha:1.0] setFill];
    [path fill];
    [path closePath];
}


- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    if (progress<0. || progress>10.)return;
    [self setNeedsDisplay];
}

- (CAShapeLayer *)pathLayer{
    if (!_pathLayer) {
        _pathLayer = [CAShapeLayer layer];
        _pathLayer.shadowColor = [UIColor colorWithRed:255/255. green:183/255. blue:84/255. alpha:1.0].CGColor;
        _pathLayer.shadowOffset = CGSizeMake(0, 0);
        _pathLayer.shadowOpacity = 1;
        _pathLayer.shadowRadius = 3.5;
        _pathLayer.fillColor = [UIColor colorWithRed:255/255. green:183/255. blue:84/255. alpha:1.0].CGColor;
        [self.layer addSublayer:_pathLayer];
    }
    return _pathLayer;
}

- (CAShapeLayer *)subLayer{
    if (!_subLayer) {
        _subLayer = [CAShapeLayer layer];

        _subLayer.fillColor = [UIColor whiteColor].CGColor;
        [self.pathLayer addSublayer:_subLayer];
    }
    return _subLayer;
}

- (UILabel *)tisLab{
    if (!_tisLab) {
        _tisLab = [[UILabel alloc] init];
        _tisLab.textColor = [UIColor colorWithRed:255/255. green:184/255. blue:69/255. alpha:1.0];
        _tisLab.font = [UIFont systemFontOfSize:13];
        [self addSubview:_tisLab];
    }
    return _tisLab;
}
@end

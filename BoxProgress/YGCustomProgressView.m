//
//  YGCustomProgressView.m
//  BoxProgress
//
//  Created by echgg on 17/3/12.
//  Copyright © 2017年 micro robot. All rights reserved.
//

#import "YGCustomProgressView.h"
#define DEGREES_2_RADIANS(x) ((M_PI_2 / 360.0) * (x))

@interface YGCustomProgressView()

@property(nonatomic, strong)UILabel *progressLabel;

@end

@implementation YGCustomProgressView{
    ProgressType _progressType;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        //default setting
        self.backgroundColor = [UIColor clearColor];
        _progress = 0.0;
        _progressWidth = 1.0f;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame andProgressType:(ProgressType)progressType{
    self = [super initWithFrame:frame];
    if(self){
        //default setting
        _progressType = progressType;
        self.backgroundColor = [UIColor clearColor];
        _progress = 0.0;
        _progressWidth = 1.0f;
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGPoint centerPoint = CGPointMake(rect.size.width / 2, rect.size.height / 2);

    switch (_progressType) {
        case CircleTypeProgress:
        case RingTypeProgress:
        {
            CGFloat radius = MIN(rect.size.height, rect.size.width) / 2;
            CGContextRef context = UIGraphicsGetCurrentContext();
            
            [self.trackTintColor setFill];
            CGMutablePathRef trackPath = CGPathCreateMutable();
            CGPathMoveToPoint(trackPath, NULL, centerPoint.x, centerPoint.y);
            CGPathAddArc(trackPath, NULL, centerPoint.x, centerPoint.y, radius, DEGREES_2_RADIANS(0), DEGREES_2_RADIANS(360), NO);
            CGPathCloseSubpath(trackPath);
            CGContextAddPath(context, trackPath);
            CGContextFillPath(context);
            CGPathRelease(trackPath);
            
            [self.progressTintColor setFill];
            CGMutablePathRef progressPath = CGPathCreateMutable();
            CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
            CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, radius, -M_PI_2, M_PI*2*self.progress-M_PI_2, NO);
            CGPathCloseSubpath(progressPath);
            CGContextAddPath(context, progressPath);
            CGContextFillPath(context);
            CGPathRelease(progressPath);
            if(_progressType == RingTypeProgress){
                CGContextSetBlendMode(context, kCGBlendModeClear);
                CGFloat innerRadius = radius - _progressWidth;
                CGPoint newCenterPoint = CGPointMake(centerPoint.x - innerRadius, centerPoint.y - innerRadius);
                CGContextAddEllipseInRect(context, CGRectMake(newCenterPoint.x, newCenterPoint.y, innerRadius*2, innerRadius*2));
                CGContextFillPath(context);
            }
        }
            break;
        case BoxTypeProgress:
        {
            
            CGContextRef context = UIGraphicsGetCurrentContext();
            
            [self.trackTintColor setFill];
            CGMutablePathRef trackPath = CGPathCreateMutable();
            CGPathMoveToPoint(trackPath, NULL, centerPoint.x, centerPoint.y);
            CGPathAddRect(trackPath, NULL, rect);
            CGPathCloseSubpath(trackPath);
            CGContextAddPath(context, trackPath);
            CGContextFillPath(context);
            CGPathRelease(trackPath);
            
            [self.progressTintColor setFill];
            CGMutablePathRef progressPath = CGPathCreateMutable();
            CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
            if(self.progress <= 0.25){
                CGPathAddRect(progressPath, NULL, CGRectMake(0, 0, self.progress/0.25 * rect.size.width, _progressWidth));
            }else if(self.progress >0.25 && self.progress <= 0.5){
                CGPathAddRect(progressPath, NULL, CGRectMake(0, 0, rect.size.width, _progressWidth));
                CGPathAddRect(progressPath, NULL, CGRectMake(rect.size.width - _progressWidth, 0, _progressWidth, (self.progress - 0.25)/0.25 *rect.size.height));
            }else if(self.progress > 0.5 && self.progress <= 0.75){
                CGPathAddRect(progressPath, NULL, CGRectMake(0, 0, rect.size.width, _progressWidth));
                CGPathAddRect(progressPath, NULL, CGRectMake(rect.size.width - _progressWidth, 0, _progressWidth, rect.size.height));
                CGAffineTransform transformx = CGAffineTransformMakeTranslation(-(self.progress - 0.5)/0.25 *rect.size.width,0);
                CGPathAddRect(progressPath, &transformx, CGRectMake(rect.size.width - _progressWidth, rect.size.height - _progressWidth, (self.progress - 0.5)/0.25 *rect.size.width, _progressWidth));
            }else{
                CGPathAddRect(progressPath, NULL, CGRectMake(0, 0, rect.size.width, _progressWidth));
                CGPathAddRect(progressPath, NULL, CGRectMake(rect.size.width - _progressWidth, 0, _progressWidth, rect.size.height));
                CGAffineTransform transformx = CGAffineTransformMakeTranslation(-rect.size.width,0);
                CGPathAddRect(progressPath, &transformx, CGRectMake(rect.size.width - _progressWidth, rect.size.height - _progressWidth, rect.size.width, _progressWidth));
                CGAffineTransform transformy = CGAffineTransformMakeTranslation(0,-(self.progress - 0.75)/0.25 *rect.size.height);
                CGPathAddRect(progressPath, &transformy, CGRectMake(0, rect.size.height - _progressWidth, _progressWidth, (self.progress - 0.75)/0.25 *rect.size.height));
                
            }
            CGPathCloseSubpath(progressPath);
            CGContextAddPath(context, progressPath);
            CGContextFillPath(context);
            CGPathRelease(progressPath);
            
            CGContextSetBlendMode(context, kCGBlendModeClear);
            CGContextAddRect(context, CGRectMake(rect.origin.x + _progressWidth, rect.origin.y + _progressWidth, rect.size.width-_progressWidth * 2, rect.size.height - _progressWidth * 2));
            CGContextFillPath(context);
        }
            break;
        default:
            break;
    }
}

#pragma mark ------- property -------

-(void)setIsShowProgressLabel:(BOOL)isShowProgressLabel{
    _isShowProgressLabel = isShowProgressLabel;
    if(isShowProgressLabel && !_progressLabel){
        _progressLabel = [UILabel new];
        _progressLabel.font = [UIFont systemFontOfSize:8];
        _progressLabel.textColor = [[UIColor alloc] initWithRed:232.0 / 255 green:110.0 / 255 blue:131.0 / 255 alpha:1.0];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_progressLabel];
        _progressLabel = [[UILabel alloc] initWithFrame:self.frame];
    }
}

-(void)setProgressLabelFont:(UIFont *)progressLabelFont{
    _progressLabelFont = progressLabelFont;
    if(_progressLabel){
        _progressLabel.font = progressLabelFont;
    }
}

-(void)setProgressLabelTextColor:(UIColor *)progressLabelTextColor{
    _progressLabelTextColor = progressLabelTextColor;
    if(_progressLabelTextColor){
        _progressLabel.textColor = progressLabelTextColor;
    }
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    if(_progressLabel){
        _progressLabel.text = [NSString stringWithFormat:@"%d%%",(int)(progress * 100)];
    }
    [self setNeedsDisplay];
}

//- (void)setProgressWidth:(CGFloat)progressWidth
//{
//    _progressWidth = progressWidth;
//}
@end

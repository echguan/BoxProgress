//
//  YGCustomProgressView.m
//  BoxProgress
//
//  Created by echgg on 17/3/12.
//  Copyright © 2017年 micro robot. All rights reserved.
//

#import "YGCustomProgressView.h"

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
    switch (_progressType) {
        case CircleTypeProgress:
        {
            
        }
            break;
        case BoxTypeProgress:
        {
            CGPoint centerPoint = CGPointMake(rect.size.height / 2, rect.size.width / 2);
            
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

@end

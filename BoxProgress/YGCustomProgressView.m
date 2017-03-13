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
        _progressWdth = 1.0f;
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
        _progressWdth = 1.0f;
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
            
        }
            break;
        default:
            break;
    }
}

@end

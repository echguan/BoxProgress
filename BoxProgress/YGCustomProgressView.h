//
//  YGCustomProgressView.h
//  BoxProgress
//
//  Created by echgg on 17/3/12.
//  Copyright © 2017年 micro robot. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    CircleTypeProgress,
    RingTypeProgress,
    BoxTypeProgress,
    RectTypeProgress,
    BorderTypeProgress
}ProgressType;
@interface YGCustomProgressView : UIView

@property(nonatomic, strong)UIColor *trackTintColor;
@property(nonatomic, strong)UIColor *progressTintColor;
@property(nonatomic, strong)UIColor *progressLabelTextColor;
@property(nonatomic, strong)UIFont  *progressLabelFont;

@property(nonatomic, assign)CGFloat progress;
@property(nonatomic, assign)CGFloat progressWidth;

@property(nonatomic, assign)CGFloat borderWidth;//bordertype border width

@property(nonatomic, assign)BOOL isShowProgressLabel;
@property(nonatomic, assign)BOOL clockwise;//for circle && ring default:NO
-(instancetype)initWithFrame:(CGRect)frame andProgressType:(ProgressType)progressType;
@end

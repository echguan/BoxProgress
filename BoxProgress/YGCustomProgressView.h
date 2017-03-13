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
    BoxTypeProgress
}ProgressType;
@interface YGCustomProgressView : UIView

@property(nonatomic, strong)UIColor *progressTinkColor;
@property(nonatomic, strong)UIColor *strokeColor;
@property(nonatomic, strong)UIColor *progressLabelTextColor;
@property(nonatomic, strong)UIFont  *progressLabelFont;

@property(nonatomic, assign)CGFloat progress;
@property(nonatomic, assign)CGFloat progressWdth;

@property(nonatomic, assign)BOOL isShowProgressLabel;

-(instancetype)initWithFrame:(CGRect)frame andProgressType:(ProgressType)progressType;
@end

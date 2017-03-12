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

@property(nonatomic, assign)CGFloat progress;
@property(nonatomic, strong)UIColor *progressColor;
@property(nonatomic, strong)UIColor *strokeColor;

@end

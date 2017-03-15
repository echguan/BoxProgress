//
//  ViewController.m
//  BoxProgress
//
//  Created by echgg on 17/2/25.
//  Copyright © 2017年 micro robot. All rights reserved.
//

#import "ViewController.h"
#import "YGCustomProgressView.h"
@interface ViewController ()
@property (nonatomic, strong)YGCustomProgressView *rectProgressView;
@end

@implementation ViewController{
    NSTimer *_progressTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initContent];
//    [self initTimer];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initContentWithType:(ProgressType)type{
    if(!_rectProgressView){
        CGFloat viewWidth = 150;
        CGFloat viewHeight = 200;
        _rectProgressView = [[YGCustomProgressView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - viewWidth) / 2, (self.view.frame.size.height - viewHeight) / 2, viewWidth, viewHeight) andProgressType:type];
        [self.view addSubview:_rectProgressView];
        _rectProgressView.trackTintColor = [UIColor clearColor];
        _rectProgressView.progressTintColor = [[UIColor alloc] initWithRed:43.0 / 255 green:216.0 / 255 blue:186.0 / 255 alpha:1.0];
        _rectProgressView.progressWidth = 3;
        _rectProgressView.isShowProgressLabel = YES;
        _rectProgressView.progress = 0.0;
        _rectProgressView.clockwise = YES;
        _rectProgressView.userInteractionEnabled = NO;
    }
}

-(void)initTimer{
    _progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(testShow) userInfo:nil repeats:YES];
}

-(void)testShow{
    _rectProgressView.progress += 0.01;
    if(_rectProgressView.progress >= 1.0){
        [_progressTimer invalidate],_progressTimer = nil;
    }
}
- (IBAction)showCircleProgress:(id)sender {
    [_rectProgressView removeFromSuperview];
    _rectProgressView = nil;
    [_progressTimer invalidate],_progressTimer = nil;
    [self initTimer];
    [self initContentWithType:CircleTypeProgress];
}
- (IBAction)showRingProgress:(id)sender {
    [_rectProgressView removeFromSuperview];
    _rectProgressView = nil;
    [_progressTimer invalidate],_progressTimer = nil;
    [self initTimer];
    [self initContentWithType:RingTypeProgress];
}
- (IBAction)showBoxProgress:(id)sender {
    [_rectProgressView removeFromSuperview];
    _rectProgressView = nil;
    [_progressTimer invalidate],_progressTimer = nil;
    [self initTimer];
    [self initContentWithType:BoxTypeProgress
     ];
}

@end

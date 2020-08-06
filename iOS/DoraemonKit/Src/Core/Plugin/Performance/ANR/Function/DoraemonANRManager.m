//
//  DoraemonANRManager.m
//  DoraemonKit-DoraemonKit
//
//  Created by yixiang on 2018/6/14.
//

#import "DoraemonANRManager.h"
#import "DoraemonCacheManager.h"
#import "DoraemonANRTracker.h"
#import "DoraemonMemoryUtil.h"
#import "DoraemonAppInfoUtil.h"
#import "Doraemoni18NUtil.h"
#import "DoraemonANRTool.h"
#import "DoraemonANRDetailViewController.h"
#import "MBProgressHUD.h"
#import "DoraemonManager.h"

//默认超时间隔
static CGFloat const kDoraemonBlockMonitorTimeInterval = 0.2f;

@interface DoraemonANRManager()

@property (nonatomic, strong) DoraemonANRTracker *doraemonANRTracker;
@property (nonatomic, copy) DoraemonANRManagerBlock block;

@end

@implementation DoraemonANRManager

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _doraemonANRTracker = [[DoraemonANRTracker alloc] init];
        _timeOut = kDoraemonBlockMonitorTimeInterval;
        _anrTrackOn = [DoraemonCacheManager sharedInstance].anrTrackSwitch;
        if (_anrTrackOn) {
            [self start];
        } else {
            [self stop];
            // 如果是关闭的话，删除上一次的卡顿记录
            NSFileManager *fm = [NSFileManager defaultManager];
            [fm removeItemAtPath:[DoraemonANRTool anrDirectory] error:nil];
        }
    }
    
    return self;
}

- (void)start {
    __weak typeof(self) weakSelf = self;
    [_doraemonANRTracker startWithThreshold:self.timeOut handler:^(NSDictionary *info) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf dumpWithInfo:info];
    }];
}

- (void)dumpWithInfo:(NSDictionary *)info {
    if (![info isKindOfClass:[NSDictionary class]]) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.block) {
            self.block(info);
        }
        [DoraemonANRTool saveANRInfo:info];
        
        if (![DoraemonManager shareInstance].isAlreadyNoticed) {
            [DoraemonManager shareInstance].isAlreadyNoticed = YES;
            int duration = [info[@"duration"] intValue];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:true];
            hud.mode = MBProgressHUDModeText;
            hud.detailsLabel.text = [NSString stringWithFormat: @"在主线程中阻塞时间超过 %d ms，请查看详细的调用堆栈信息解决问题", duration];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:true];
            });
        }

    });

}

- (void)addANRBlock:(DoraemonANRManagerBlock)block{
    self.block = block;
}


- (void)dealloc {
    [self stop];
}

- (void)stop {
    [self.doraemonANRTracker stop];
}

- (void)setAnrTrackOn:(BOOL)anrTrackOn {
    _anrTrackOn = anrTrackOn;
    [[DoraemonCacheManager sharedInstance] saveANRTrackSwitch:anrTrackOn];
}

@end

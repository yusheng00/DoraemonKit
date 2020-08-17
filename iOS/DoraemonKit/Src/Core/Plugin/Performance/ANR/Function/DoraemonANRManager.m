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
#import "DoraemonToastUtil.h"
#import "DoraemonManager.h"

//默认超时间隔
static CGFloat const kDoraemonBlockMonitorTimeInterval = 0.2f;

@interface DoraemonANRManager()

@property (nonatomic, strong) DoraemonANRTracker *doraemonANRTracker;
@property (nonatomic, copy) DoraemonANRManagerBlock block;

@property (nonatomic, strong) UIView *anrNoticeView;
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
        
        self.anrNoticeView.alpha = 1;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1 animations:^{
                self.anrNoticeView.alpha = 0;
            }];
        });

    });

}

- (UIView *)anrNoticeView {
    if (_anrNoticeView == nil) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - 40, 40, 20, 20)];
        view.backgroundColor = [UIColor redColor];
        view.alpha = 0;
        view.layer.cornerRadius = 10;
        _anrNoticeView = view;
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    }
    
    return _anrNoticeView;
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

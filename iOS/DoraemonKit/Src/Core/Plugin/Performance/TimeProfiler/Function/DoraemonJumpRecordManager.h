//
//  DoraemonJumpRecordManager.h
//  DoraemonKit
//
//  Created by apple on 2020/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DoraemonJumpRecordManager : NSObject

+ (instancetype)sharedInstance;

- (void)startRecordWithOrigin:(UIViewController *)origin target:(UIViewController *)target;


- (void)finishRecord:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END

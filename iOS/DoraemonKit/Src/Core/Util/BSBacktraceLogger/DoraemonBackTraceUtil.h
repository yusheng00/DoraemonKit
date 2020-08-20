//
//  DoraemonBackTraceUtil.h
//  DoraemonKit
//
//  Created by apple on 2020/8/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define WXGBackTraceMaxEntries 300

@interface DoraemonBackTraceUtil : NSObject

+ (void)getCurrentMainThreadStack:(void (^)(NSUInteger pc))saveResultBlock;

+ (int)getCurrentMainThreadStack:(void (^)(NSUInteger pc))saveResultBlock
                  withMaxEntries:(NSUInteger)maxEntries;

+ (int)getCurrentMainThreadStack:(void (^)(NSUInteger pc))saveResultBlock
                  withMaxEntries:(NSUInteger)maxEntries
                 withThreadCount:(NSUInteger)retThreadCount;


@end

NS_ASSUME_NONNULL_END

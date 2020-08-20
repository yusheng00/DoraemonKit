//
//  DoraemonBackTraceUtil.m
//  DoraemonKit
//
//  Created by apple on 2020/8/19.
//

#import "DoraemonBackTraceUtil.h"
#import <mach/mach_types.h>
#import <mach/mach_init.h>
#import <mach/thread_act.h>
#import <mach/task.h>
#import <mach/mach_port.h>
#import <mach/vm_map.h>
#import "KSStackCursor_SelfThread.h"
#import "KSThread.h"
#import "KSStackCursor_Backtrace.h"
#import "KSSymbolicator.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>


@implementation DoraemonBackTraceUtil

+ (void)getCurrentMainThreadStack:(void (^)(NSUInteger pc))saveResultBlock
{
    [DoraemonBackTraceUtil getCurrentMainThreadStack:saveResultBlock withMaxEntries:WXGBackTraceMaxEntries];
}

+ (int)getCurrentMainThreadStack:(void (^)(NSUInteger pc))saveResultBlock
                  withMaxEntries:(NSUInteger)maxEntries
{
    NSUInteger tmpThreadCount = 0;
    return [DoraemonBackTraceUtil getCurrentMainThreadStack:saveResultBlock
                                           withMaxEntries:maxEntries
                                          withThreadCount:tmpThreadCount];
}

+ (int)getCurrentMainThreadStack:(void (^)(NSUInteger pc))saveResultBlock
                  withMaxEntries:(NSUInteger)maxEntries
                 withThreadCount:(NSUInteger)retThreadCount
{
    thread_act_array_t threads;
    mach_msg_type_number_t thread_count;

    if (task_threads(mach_task_self(), &threads, &thread_count) != KERN_SUCCESS) {
        return 0;
    }

    thread_t mainThread = threads[0];

    KSThread currentThread = ksthread_self();
    if (mainThread == currentThread) {
        return 0;
    }

    if (thread_suspend(mainThread) != KERN_SUCCESS) {
        return 0;
    }

    uintptr_t backtraceBuffer[maxEntries];

    int backTraceLength = kssc_backtraceCurrentThread(mainThread, backtraceBuffer, (int) maxEntries);

    uintptr_t* callstack = malloc(backTraceLength * sizeof(*callstack));

    for (int i = 0; i < backTraceLength; i++) {
        NSUInteger pc = backtraceBuffer[i];
        callstack[i] = kssymbolicator_callInstructionAddress(pc);
        saveResultBlock(pc);
    }
    
    KSMC_NEW_CONTEXT(machineContext);
    ksmc_getContextForThread(ksthread_self(), machineContext, true);

    KSStackCursor cursor;
    kssc_initWithBacktrace(&cursor, callstack, backTraceLength, 0);
    kssymbolicator_symbolicate(&cursor);

    void* callstacks[128];
    int frames = backtrace(callstacks, 128);
    char **strs = backtrace_symbols(callstacks, frames);
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (i = 0;i < frames;i++){
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    NSLog(@"=====>>>>>堆栈<<<<<=====\n%@",backtrace);

    retThreadCount = thread_count;

    thread_resume(mainThread);

    for (mach_msg_type_number_t i = 0; i < thread_count; i++) {
        mach_port_deallocate(mach_task_self(), threads[i]);
    }
    vm_deallocate(mach_task_self(), (vm_address_t) threads, sizeof(thread_t) * thread_count);

    return backTraceLength;
}

@end

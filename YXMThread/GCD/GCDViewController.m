//
//  GCDViewController.m
//  YXMThread
//
//  Created by xingmin yu on 2018/7/26.
//  Copyright © 2018年 xingminyu. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()
- (IBAction)click1:(UIButton *)sender;
- (IBAction)click2:(UIButton *)sender;
- (IBAction)click3:(id)sender;
- (IBAction)click4:(id)sender;
- (IBAction)click5:(id)sender;
- (IBAction)click6:(id)sender;
- (IBAction)click7:(id)sender;

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    

}


//说明：dispatch_get_global_queue指的全局并发队列，创建3个线程，并且每个线程同时执行任务
- (IBAction)click1:(UIButton *)sender {

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"执行耗时操作1");
        [NSThread sleepForTimeInterval:3];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"回到主线程更新界面1");
        });
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"执行耗时操作2");
        [NSThread sleepForTimeInterval:3];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"回到主线程更新界面2");
        });
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"执行耗时操作3");
        [NSThread sleepForTimeInterval:3];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"回到主线程更新界面3");
        });
    });
}

//说明：自定义队列，创建一个线程，多个任务顺序执行任务 dispatch_queue_create("custon_queue", NULL);
//或者dispatch_queue_create("custon_queue", DISPATCH_QUEUE_SERIAL);
- (IBAction)click2:(UIButton *)sender {
    dispatch_queue_t queue = dispatch_queue_create("custon_queue", NULL);
    dispatch_async(queue, ^{
        NSLog(@"开始任务1");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"结束任务1");
    });
    dispatch_async(queue, ^{
        NSLog(@"开始任务2");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"结束任务2");
    });
    dispatch_async(queue, ^{
        NSLog(@"开始任务3");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"结束任务3");
    });
}
//说明：自定义队列，创建多个线程，同时执行任务 dispatch_queue_create("custon_queue", DISPATCH_QUEUE_CONCURRENT);
- (IBAction)click3:(id)sender {
    dispatch_queue_t queue = dispatch_queue_create("custon_queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"开始任务1");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"结束任务1");
    });
    dispatch_async(queue, ^{
        NSLog(@"开始任务2");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"结束任务2");
    });
    dispatch_async(queue, ^{
        NSLog(@"开始任务3");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"结束任务3");
    });
}
//说明：自定义队列多任务并发执行，监听所有任务都结束后在操作
- (IBAction)click4:(id)sender {
    dispatch_queue_t queue = dispatch_queue_create("custon_queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"开始任务1");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"结束任务1");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"开始任务2");
        [NSThread sleepForTimeInterval:5];
        NSLog(@"结束任务2");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"开始任务3");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"结束任务3");
    });
    
    ///三个任务都结束后执行
    dispatch_group_notify(group, queue, ^{
        NSLog(@"三个线程的任务都结束了");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"回到主线程");
        });
    });
    
}
//说明：多任务并发执行，监听所有任务block都结束后在操作2
- (IBAction)click5:(id)sender {
    dispatch_queue_t queue = dispatch_queue_create("custon_queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();

    /////dispatch_group_enter和dispatch_group_leave成对出现
    dispatch_group_enter(group);
    [self networkRequest:^(NSString *name) {
        NSLog(@"回调结束1:%@",name);
        dispatch_group_leave(group);
    }];
    dispatch_group_enter(group);
    [self networkRequest:^(NSString *name) {
        NSLog(@"回调结束2:%@",name);
        dispatch_group_leave(group);
    }];

    ///三个任务都结束后执行
    dispatch_group_notify(group, queue, ^{
        NSLog(@"两个任务都结束了");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"回到主线程");
        });
    });

}


/////模拟网络请求
-(void)networkRequest:(void(^)(NSString * name))block
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"开始网络请求");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"网路请求结束");
        dispatch_async(dispatch_get_main_queue(), ^{
            block(@"我是请求的json数据");
        });
    });
}

//说明：生命周期只执行一次
- (IBAction)click6:(id)sender {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"只执行一次，再次点击也不会执行了");
    });
}
//说明：延迟执行，小心使用，无法取消，开始了就必须要执行，
- (IBAction)click7:(id)sender {
    NSLog(@"开始");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"结束");
    });
}

@end

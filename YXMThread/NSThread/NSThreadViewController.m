//
//  NSThreadViewController.m
//  YXMThread
//
//  Created by xingmin yu on 2018/7/26.
//  Copyright © 2018年 xingminyu. All rights reserved.
//

#import "NSThreadViewController.h"
#import "TicketManager.h"
@interface NSThreadViewController ()
- (IBAction)createNSThread:(id)sender;
- (IBAction)addLock:(id)sender;

@end

@implementation NSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"我在主线程");


    
}
/////////主要3中方式创建，调试的话可以屏蔽其中两种/////
- (IBAction)createNSThread:(id)sender {
    
    
    //第一种
    NSThread *thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(run1) object:nil];
    [thread1 setName:@"线程创建方式1"];//线程名，当多个的时候可以用此加以区别
    [thread1 setThreadPriority:0.5];//设置线程优先级
    [thread1 start];//需要start
    
    //第二种 //有block的方式
    [NSThread detachNewThreadSelector:@selector(run2) toTarget:self withObject:nil];
    
    
    //第三种
    [self performSelectorInBackground:@selector(run3) withObject:nil];
}


//模拟买票系统，多地同时卖票，访问同一资源的问题

- (IBAction)addLock:(id)sender {
    TicketManager *manager = [[TicketManager alloc] init];
    [manager startToSale];
}


-(void)run1
{
    for (int i = 0; i<10; i++) {
        NSLog(@"我在子线程1:%d",i);
        sleep(1);
    }
}

-(void)run2
{
    for (int i = 0; i<10; i++) {
        NSLog(@"我在子线程2:%d",i);
        sleep(1);
    }
}

-(void)run3
{
    for (int i = 0; i<10; i++) {
        NSLog(@"我在子线程3:%d",i);
        sleep(1);
        if (i==9) {
            [self performSelectorOnMainThread:@selector(backMain) withObject:nil waitUntilDone:YES];//使用此方法可以返回主线程
        }
    }
}

-(void)backMain
{
    NSLog(@"我回到了主线程");
}


@end

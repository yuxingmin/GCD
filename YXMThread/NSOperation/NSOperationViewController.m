//
//  NSOperationViewController.m
//  YXMThread
//
//  Created by xingmin yu on 2018/7/26.
//  Copyright © 2018年 xingminyu. All rights reserved.
//

#import "NSOperationViewController.h"

@interface NSOperationViewController ()
- (IBAction)click1:(UIButton *)sender;
- (IBAction)click2:(id)sender;
- (IBAction)click3:(id)sender;
@property(nonatomic,strong)NSOperationQueue *operQueue;
@end

@implementation NSOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (IBAction)click1:(UIButton *)sender {
    NSLog(@"主线程:%@",[NSThread currentThread]);
//    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(function1) object:nil];
//    [operation start];//在主线程执行的话就会在主线程中执行，会阻塞主线程
    
    ////创建子线程中使用不会阻塞主线程，但会阻塞子线程，也就是说会阻塞当前线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(function1) object:nil];
        [operation start];//在主线程执行的话就会在主线程中执行，回阻塞主线程
    });
    
    
}
-(void)function1
{
    for (int i = 0; i<3; i++) {
        NSLog(@"NSInvocationOperation:%d",i);
        [NSThread sleepForTimeInterval:3];
    }
}



- (IBAction)click2:(id)sender {
    NSBlockOperation *blockoper = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i<3; i++) {
            NSLog(@"NSBlockOperation:%d",i);
            [NSThread sleepForTimeInterval:3];
        }
    }];
    [blockoper start];
}

- (IBAction)click3:(id)sender {
    
    if (self.operQueue==nil) {
        self.operQueue = [[NSOperationQueue alloc]init];
    }
    
    NSBlockOperation *blockoper1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i<3; i++) {
            NSLog(@"NSBlockOperation1:%d",i);
            [NSThread sleepForTimeInterval:3];
        }
    }];
    [self.operQueue addOperation:blockoper1];
    NSBlockOperation *blockoper2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i<3; i++) {
            NSLog(@"NSBlockOperation2:%d",i);
            [NSThread sleepForTimeInterval:3];
        }
    }];
    [self.operQueue addOperation:blockoper2];
    NSBlockOperation *blockoper3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i<5; i++) {
            NSLog(@"NSBlockOperation3:%d",i);
            [NSThread sleepForTimeInterval:3];
        }
    }];
    [self.operQueue addOperation:blockoper3];
    
    
    
    
    
}
@end

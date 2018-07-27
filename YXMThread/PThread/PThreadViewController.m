//
//  PThreadViewController.m
//  YXMThread
//
//  Created by xingmin yu on 2018/7/26.
//  Copyright © 2018年 xingminyu. All rights reserved.
//

#import "PThreadViewController.h"
#import <pthread.h>//导入头文件
@interface PThreadViewController ()

@end

@implementation PThreadViewController
////////////////ios 不常用pthread////////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"我在主线程1");
    pthread_t pthread;
    pthread_create(&pthread, NULL, run, NULL);
    NSLog(@"我在主线程2");
    
}

void *run(void *data){
    NSLog(@"我在子线程");
    for (int i = 0; i<10; i++) {
        NSLog(@"%d",i);
        sleep(1);
    }
    return NULL;
}

@end

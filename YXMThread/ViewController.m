//
//  ViewController.m
//  YXMThread
//
//  Created by xingmin yu on 2018/7/26.
//  Copyright © 2018年 xingminyu. All rights reserved.
//

#import "ViewController.h"
#import "PThreadViewController.h"
#import "NSThreadViewController.h"
#import "GCDViewController.h"
#import "NSOperationViewController.h"

@interface ViewController ()
- (IBAction)pthreadClick:(id)sender;
- (IBAction)nsthreadClick:(id)sender;
- (IBAction)gcdClick:(id)sender;
- (IBAction)nsoperationClick:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (IBAction)pthreadClick:(id)sender {
    PThreadViewController *vc = [[PThreadViewController alloc]init];
    vc.title = @"PThread";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)nsthreadClick:(id)sender {
    NSThreadViewController *vc = [[NSThreadViewController alloc]init];
    vc.title = @"NSThread";
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)gcdClick:(id)sender {
    GCDViewController *vc = [[GCDViewController alloc]init];
    vc.title = @"GCD";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)nsoperationClick:(id)sender {
    NSOperationViewController *vc = [[NSOperationViewController alloc]init];
    vc.title = @"NSOperation";
    [self.navigationController pushViewController:vc animated:YES];
}

@end

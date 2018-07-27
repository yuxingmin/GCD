//
//  TicketManager.m
//  YXMThread
//
//  Created by xingmin yu on 2018/7/26.
//  Copyright © 2018年 xingminyu. All rights reserved.
//

#import "TicketManager.h"
#define Total 50
@interface TicketManager()
@property int tickets;//剩余票数
@property int saleCount;//卖出票数

@property(nonatomic,strong)NSThread *threadBJ;//北京卖票
@property(nonatomic,strong)NSThread *threadSH;//上海卖票
@end

@implementation TicketManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tickets = Total;
        
        self.threadBJ = [[NSThread alloc]initWithTarget:self selector:@selector(sale) object:nil];
        self.threadBJ.name = @"北京";
        
        
        self.threadSH = [[NSThread alloc]initWithTarget:self selector:@selector(sale) object:nil];
        self.threadSH.name = @"上海";
    }
    return self;
}


-(void)sale
{
    while (true) {
        ///////@synchronized////////
        @synchronized(self){
            if (self.tickets>0) {
                [NSThread sleepForTimeInterval:0.5];
                self.tickets--;
                self.saleCount = Total-self.tickets;
                NSLog(@"售票方：%@ ,当前余票：%d,售出: %d",[NSThread currentThread].name,self.tickets,self.saleCount);
            }
            else
            {
                NSLog(@"票卖完了");
                break;
            }
        }
    }
}

-(void)startToSale
{
    [self.threadBJ start];
    [self.threadSH start];
    
}
@end

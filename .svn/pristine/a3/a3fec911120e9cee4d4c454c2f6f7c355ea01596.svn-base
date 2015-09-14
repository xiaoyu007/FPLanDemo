//
//  YouGuOpendingStatus.m
//  优顾理财
//
//  Created by Mac on 14-9-18.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "YouGuOpendingStatus.h"

@implementation YouGuOpendingStatus
{
    BOOL isRequesting;
}


+ (YouGuOpendingStatus *)instance {
    static YouGuOpendingStatus *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[YouGuOpendingStatus alloc] init];
    });
    return instance;
}

-(id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (TradeStatus)getExchangeStatus {
    
    long long ctime = [[NSDate date] timeIntervalSince1970];
    long long diff = (ctime - self.mtime) * 1000;
    
    if (diff > 1000 * 60 * 10) { //缓存的对象生命超过10分钟
        [self requestExchangeStatus];
    }
    
    if (diff > 1000 * 60 * 60) { //缓存的对象生命超过1小时  由于网络原因，暂无法判断
        return TradeStatusUnknown;
    }
    
    if (self.result == -2) { // -2：非交易日
        return TradeClosed;
    }
    
    if (self.result == -1) { //-1非交易时间
        if (diff >= self.openCountDown) {
            [self requestExchangeStatus]; //状态变化，重新请求一次，更新数据
            return TradeOpenning;
        } else {
            return TradeClosed;
        }
    }
    
    if (self.result == 0) { // 0：交易时间
        if (diff >= self.closeCountDown) {
            [self requestExchangeStatus]; //状态变化，重新请求一次，更新数据
            return TradeClosed;
        } else {
            return TradeOpenning;
        }
    }
    
    return TradeClosed;
}

//取得距离开盘还有多长时间数据
- (void)requestExchangeStatus {
    if (isRequesting) {
        return;
    }
    isRequesting = YES;
    
    [[WebServiceManager sharedManager]The_server_time_calibration_completion:^(NSDictionary * dic)
    {
        isRequesting = NO;
        if (dic && [dic[@"status"] isEqualToString:@"0000"]==YES)
        {
            NSDictionary *result = dic[@"result"];
//            YouGuOpendingStatus *instance = [YouGuOpendingStatus instance];
            self.result = [result[@"status"] intValue];
            self.desc = result[@"desc"];;
            self.serverTime = [result[@"serverTime"] longLongValue];
            self.openCountDown = [result[@"openCountDown"] longLongValue];
            self.closeCountDown = [result[@"closeCountDown"] longLongValue];
            
            if (dic[@"mtime"] == nil) {
                self.mtime = [[NSDate date] timeIntervalSince1970];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                NSMutableDictionary *dictionary =
                [[NSMutableDictionary alloc] initWithDictionary:dic] ;
                [dictionary setValue:@(self.mtime)
                              forKey:@"mtime"];
                [userDefaults setObject:dictionary forKey:@"SimTradeStatus"];
                [userDefaults synchronize];
            } else {
                self.mtime = [dic[@"mtime"] longLongValue];
            }
        }
        
    }];
}


@end

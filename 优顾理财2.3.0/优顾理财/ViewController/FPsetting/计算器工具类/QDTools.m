//
//  QDTools.m
//  Saiko+
//
//  Created by xuqidong on 15/4/26.
//  Copyright (c) 2015年 xuqidong. All rights reserved.
//

#import "QDTools.h"

@implementation QDTools

#pragma mark - 判断时间差
+ (NSString*)timeLess:(NSString*)endtime {
    
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm"];
    NSString *  nowTime = [dateformatter stringFromDate:senddate];
    //    NSString *nowTime = [[NSString stringWithFormat:@"%@",[NSDate date]] substringToIndex:16];
    NSLog(@"当前时间－－%@",nowTime);
    NSLog(@"结束时间－－%@",endtime);
    
    int now_year = [[nowTime substringToIndex:4] intValue];
    int now_mont = [[nowTime substringWithRange:NSMakeRange(5, 2)] intValue];
    int now_day = [[nowTime substringFromIndex:8] intValue];
    int now_hour = [[nowTime substringWithRange:NSMakeRange(11, 2)] intValue];
    int now_min = [[nowTime substringWithRange:NSMakeRange(14, 2)] intValue];
    NSLog(@"%d,%d,%d,%d,%d",now_year,now_mont,now_day,now_hour,now_min);
    int now_total = now_min + now_hour*60 + now_day*24*60 + now_mont*30*24*60 +now_year*12*30*24*60;
    
    NSString *endTime1 = [endtime substringToIndex:16];
    int end_year = [[endTime1 substringToIndex:4] intValue];
    int end_mont = [[endTime1 substringWithRange:NSMakeRange(5, 2)] intValue];
    int end_day = [[endTime1 substringFromIndex:8] intValue];
    int end_hour = [[endTime1 substringWithRange:NSMakeRange(11, 2)] intValue];
    int end_min = [[endTime1 substringWithRange:NSMakeRange(14, 2)] intValue];
    //    int end_hour = 12;
    //    int end_min = 12;
    
    NSLog(@"%d,%d,%d,%d,%d",end_year,end_mont,end_day,end_hour,end_min);
    int end_total = end_min + end_hour*60 + end_day*24*60 + end_mont*30*24*60 +end_year*12*30*24*60;
    int dis_time = end_total - now_total;
    
    if (dis_time <= 0) {
        NSLog(@"－－结束");
        return @"0";
    }
    
    NSLog(@"dis_time-%d",dis_time);
    NSString *str = [NSString stringWithFormat:@"%d days %d hours %d mins",dis_time/60/24%30,dis_time/60%24,dis_time%60];
    
    int dd = dis_time/60/24%30;
    int hh = dis_time/60%24;
    int mm = dis_time%60;
    
    NSLog(@"-------%d,%d,%d",dd,hh,mm);
    if (dd == 0) {
        str = [NSString stringWithFormat:@"%d hours %d mins",hh,mm];
    }
    if (hh == 0 && dd != 0) {
        str = [NSString stringWithFormat:@"%d days %d mins",dd,mm];
    }
    if (dd == 0 && hh == 0) {
        str = [NSString stringWithFormat:@"%d mins",mm];
    }
    
    NSLog(@"结束时间－－%@",str);
    return str;
}

@end

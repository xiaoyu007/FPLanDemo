//
//  date_simple.m
//  TrafficReport
//
//  Created by you wuquan on 13-5-7.
//  Copyright (c) 2013年 Jamper. All rights reserved.
//

static date_simple *_sharedManager = nil;
@implementation date_simple
+ (date_simple *)sharedManager {
  @synchronized([date_simple class]) {
    if (!_sharedManager)
      _sharedManager = [[self alloc] init];
    return _sharedManager;
  }
  return nil;
}

+ (id)alloc {
  @synchronized([date_simple class]) {
    NSAssert(_sharedManager == nil,
             @"Attempted to allocated a second instance_____data_simple");
    _sharedManager = [super alloc];
    return _sharedManager;
  }
  return nil;
}

- (id)init {
  self = [super init];
  if (self) {
  }
  return self;
}
/** 时间字符串->时间（date） */
- (NSDate *)dateStringSwitchToDate:(NSString *)dateString{
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
  [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
  [dateFormat setLocale:[NSLocale currentLocale]];
  [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  [dateFormat setFormatterBehavior:NSDateFormatterBehaviorDefault];
  NSDate *date = [dateFormat dateFromString:dateString];
  return date;
}
- (NSString *)DateFormaterForStr1:(NSString *)mDate {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  NSDate *tDate = [dateFormatter dateFromString:mDate];

  //    return @"今天";
  return [self DateFormater1:tDate];
}

- (NSString *)DateFormater1:(NSDate *)mDate {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy-MM-dd"];
  NSString *curr = [dateFormatter stringFromDate:mDate];
  NSString *today = [dateFormatter stringFromDate:[NSDate date]];
  NSString *yesterday = [dateFormatter
      stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-3600 * 24]];
  NSString *theDayBeforeYesterday = [dateFormatter
      stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-3600 * 24 * 2]];
  NSString *oneWeekAgo = [dateFormatter
      stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-3600 * 24 * 7]];
  NSString *oneMonthAgo = [dateFormatter
      stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-3600 * 24 * 30]];

  if ([curr isEqualToString:today]) {
    return @"今天";
  } else if ([curr isEqualToString:yesterday]) {
    return @"昨天";
  } else if ([curr isEqualToString:theDayBeforeYesterday]) {
    return @"前天";
  } else if ([theDayBeforeYesterday compare:curr] == NSOrderedDescending &&
             [curr compare:oneWeekAgo] == NSOrderedDescending) {
    return @"几天前";
  } else if (([oneWeekAgo compare:curr] == NSOrderedSame ||
              [oneWeekAgo compare:curr] == NSOrderedDescending) &&
             [curr compare:oneMonthAgo] == NSOrderedDescending) {
    return @"一周前";
  } else {
    return @"很久前";
  }
  return @"";
}

#pragma mark - 微博时间
//微薄时间
- (NSString *)DateFormaterForStr:(NSString *)mDate {
  if (mDate == nil) {
    return [self refresh_time_date:[NSDate date]];
  }
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  NSDate *tDate = [dateFormatter dateFromString:mDate];

  return [self DateFormater:tDate];
  //    return [self refresh_time_date:tDate];
}

- (NSString *)DateFormater:(NSDate *)mDate {
  NSTimeInterval between = -[mDate timeIntervalSinceNow];

  if (between < 60) {
    return @"刚刚";
  }

  int minutes = between / 60;

  if (minutes == 60) {
    return @"1小时前";
  } else if (minutes < 60) {
    return [NSString stringWithFormat:@"%d分钟前", minutes];
  }

  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy-MM-dd"];
  NSString *curr = [dateFormatter stringFromDate:mDate];
  NSString *today = [dateFormatter stringFromDate:[NSDate date]];
  NSString *yesterday = [dateFormatter
      stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-3600 * 24]];
  NSString *theDayBeforeYesterday = [dateFormatter
      stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-3600 * 24 * 2]];

  NSString *res = nil;
  if ([theDayBeforeYesterday compare:curr] == NSOrderedDescending) {
    [dateFormatter setDateFormat:@"yyyy"];
    if ([[dateFormatter stringFromDate:[NSDate date]]
            isEqualToString:[dateFormatter stringFromDate:mDate]]) { // in the
                                                                     // same
                                                                     // year
      [dateFormatter setDateFormat:@"M月d日 HH:mm"];
    } else {
      [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    res = [dateFormatter stringFromDate:mDate];
  } else if ([curr isEqualToString:today]) {
    [dateFormatter setDateFormat:@"HH:mm"];
    res = [@"今天 "
        stringByAppendingString:[dateFormatter stringFromDate:mDate]];

  } else if ([curr isEqualToString:yesterday]) {
    [dateFormatter setDateFormat:@"HH:mm"];
    res = [@"昨天 "
        stringByAppendingString:[dateFormatter stringFromDate:mDate]];
  } else if ([curr isEqualToString:theDayBeforeYesterday]) {
    [dateFormatter setDateFormat:@"HH:mm"];
    res = [@"前天 "
        stringByAppendingString:[dateFormatter stringFromDate:mDate]];
  } else {
    res = @"";
  }

  return res;
}

#pragma mark - 获得时间
//获得时间
- (NSString *)get_time_date:(NSString *)time {
  if (!time && [time length] == 0) {
    return @"";
  }

  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"MM/dd HH:mm";
  NSDate *sj_datatime = [[NSDate alloc]
      initWithTimeIntervalSince1970:[time longLongValue] / 1000.0];
  NSString *sj = [dateFormatter stringFromDate:sj_datatime];

  return sj;
}

- (NSString *)get_time_date_quan:(NSString *)time {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"yyyy-MM-DD HH:mm:ss";
  NSDate *sj_datatime = [[NSDate alloc]
      initWithTimeIntervalSince1970:[time longLongValue] / 1000.0];
  NSString *sj = [dateFormatter stringFromDate:sj_datatime];
  sj = [self DateFormaterForStr:sj];

  return sj;
}

#pragma mark - 刷新时间
//刷新时间
- (NSString *)refresh_time_date:(NSDate *)date {

  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  df.dateFormat = @"yyyy-MM-dd HH:mm";
  NSString *dateString = [df stringFromDate:date];
  NSString *title = NSLocalizedString(@"今天", nil);
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *components = [calendar
      components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
        fromDate:date
          toDate:[NSDate date]
         options:0];

  int year = (int)[components year];
  int month = (int)[components month];
  int day = (int)[components day];
  if (year == 0 && month == 0 && day < 3) {
    if (day == 0) {
      title = NSLocalizedString(@"今天", nil);
    } else if (day == 1) {
      title = NSLocalizedString(@"昨天", nil);
    } else if (day == 2) {
      title = NSLocalizedString(@"前天", nil);
    }
    df.dateFormat = [NSString stringWithFormat:@"%@ HH:mm", title];
    dateString = [df stringFromDate:date];
  }
  if (year == 0 && month == 0 && day >= 3 && day <= 31) {
    dateString = [NSString stringWithFormat:@"%d天前", day];
    //        title = NSLocalizedString(tt,nil);
    //        df.dateFormat = [NSString stringWithFormat:@"%@ HH:mm",title];
    //        dateString = [df stringFromDate:date];
  }
  if (year == 0 && month > 0) {
    dateString = [NSString stringWithFormat:@"%d月前", month];
  }
  if (year > 0) {
    dateString = [NSString stringWithFormat:@"%d年前", year];
  }

  return [NSString stringWithFormat:@" %@", dateString];
}
@end

//
//  NSURL+QueryComponent.m
//  SimuStock
//
//  Created by Mac on 14/12/31.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "NSURL+QueryComponent.h"

@implementation NSURL (QueryComponent)

-(NSDictionary *)queryComponents{
  
  NSArray *components = [[self query] componentsSeparatedByString:@"&"];
  NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
  for (NSString *component in components) {
    NSArray *subcomponents = [component componentsSeparatedByString:@"="];
    if ([subcomponents count]<2) {
      continue;
    }
    dic[[subcomponents[0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] = [subcomponents[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  }
  return dic;
}

@end

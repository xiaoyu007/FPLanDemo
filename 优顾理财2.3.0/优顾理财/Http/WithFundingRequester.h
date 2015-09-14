//
//  WithFundingRequester.h
//  SimuStock
//
//  Created by Mac on 15/4/9.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequester.h"

/** 配资系统错误类型 */
typedef NS_ENUM(NSUInteger, WFError) {
  /// 1=权限错误
  WFErrorAuth = 1,
  /// 2=参数错误
  WFErrorParameter = 2,
  /// 3=业务错误
  WFErrorBusiness = 3,
  /// 9=未知错误
  WFErrorUnknown = 9,
};


/** 配资请求返回结果基本类 */
@interface BaseWithFundingResponseObject : BaseRequestObject<ParseJson>


@end

/** 配资接口请求及解析框架类 */
@interface WithFundingRequester : BaseRequester

@end

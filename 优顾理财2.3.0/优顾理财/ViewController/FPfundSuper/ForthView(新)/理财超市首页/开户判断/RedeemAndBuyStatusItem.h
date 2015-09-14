//
//  RedeemAndBuyStatusUrl.h
//  优顾理财
//
//  Created by Mac on 15/8/11.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseRequestObject.h"

@interface RedeemAndBuyStatusItem : JsonRequestObject
/** 赎回状态 */
@property(assign) BOOL redeemButtonStatus;
/** 申购状态 */
@property(assign) BOOL buyButtonStatus;

/**
 *  获取申购赎回状态
 *
 *  @param fundId 基金id
 */
+ (void)getButtonStatusOfRedeemAndBuyWithFundId:(NSString *)fundId
                                   withCallback:(HttpRequestCallBack *)callback;

@end

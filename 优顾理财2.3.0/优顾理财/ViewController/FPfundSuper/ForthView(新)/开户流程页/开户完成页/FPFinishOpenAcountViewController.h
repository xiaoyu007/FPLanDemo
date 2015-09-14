//
//  FinishOpenAcountViewController.h
//  优顾理财
//
//  Created by Mac on 15/3/19.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

/**
 
 本类主要是开户完成类
 */
#import "YGBaseViewController.h"
typedef void (^buyOpenCallback)(BOOL openSuccessCallback);
@interface FPFinishOpenAcountViewController : YGBaseViewController
{
  /**  申购界面回调*/
  buyOpenCallback buyCallBack;
}

/** 调用开户页面 */
+(void)checkOpenAcountStatusWithCallback:(buyOpenCallback)callback;
@end

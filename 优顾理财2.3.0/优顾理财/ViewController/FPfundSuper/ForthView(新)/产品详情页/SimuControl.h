//
//  SimuControl.h
//  优顾理财
//
//  Created by jhss on 15-4-21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 用户理财状态缓存 */
@interface SimuControl : NSObject
typedef NS_ENUM(NSInteger, Test) {

  ///姓名
  CivicsName,
  ///身份证
  IDCardNumber,
  ///银行卡
  BankCarNumber,
};

@property(nonatomic, assign) Test *bankIdentity;
/** 取出本地字符串 */
+ (NSString *)getObjectWithKey:(NSString *)key;
/** 本地保存字符串 */
+ (void)saveObjectWithObject:(NSString *)object withKey:(NSString *)key;

///登录状态
+ (NSInteger)OnLoginType;
/**登录状态*/
+ (void)OnLoginWithType:(NSInteger)type;
///手机绑定状态
+ (NSInteger)bingMobileType;
///手机绑定状态
+ (void)bingMobileWithType:(NSInteger)type;
///开户完成状态
+ (NSString *)openAcountType;
///开户完成状态
+ (void)openAcountWithType:(NSString *)type;

///我的资产判断开户状态
+ (NSString *)myAssetOpenAcountType;
///我的资产判断开户状态
+ (void)myAssetOpenAcountType:(NSString *)type;


///自动离线下载数据
+ (NSString *)downDataType;
//自动离线下载数据
+ (void)downDataWithType:(NSString *)type;


/**  自动下载离线文件的个数*/
+ (NSInteger)downDataArrayType;
/**  自动下载离线文件的个数*/
+ (void)downDataArrayWithType:(NSInteger)type;



/**  自动下载离线文件的总个数*/
+ (NSInteger)downDataTotalArrayType;
/**  自动下载离线文件的总个数*/
+ (void)downDataTotalArrayWithType:(NSInteger)type;




+ (BOOL)citizensInformationAndIdentityCardNumberAndBank:(NSString *)information
                                           bankIdentity:(Test)bankIdentity;
///姓名
+ (BOOL)validateIdentityCard:(NSString *)identityCard;
///手机号码正则法则
+ (BOOL)lengalPhoneNumber:(NSString *)numStr;

///数字只能是六位数字
+ (BOOL)validateSixNumberIdentityCard:(NSString *)identityCard;
///判断银行卡号的有效性
+ (BOOL)checkCardNo:(NSString *)cardNo;

///判断身份证有效性
+ (BOOL)checkIdentityNumber:(NSString *)value;
@end

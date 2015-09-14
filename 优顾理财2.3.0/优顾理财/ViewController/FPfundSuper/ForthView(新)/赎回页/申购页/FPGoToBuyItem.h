//
//  GoToBuyItem.h
//  优顾理财
//
//  Created by jhss on 15-4-29.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface feeItem : NSObject
/**   费率*/
@property(nonatomic, strong) NSString *fee;
/**   数额判断*/
@property(nonatomic,strong)NSString *condition;
/**   费率列表*/
@end

@interface bankItem : NSObject
/**   用户绑卡ID*/
@property(nonatomic, strong) NSString *bankid;
/**   展示名称*/
@property(nonatomic, strong) NSString *bankName;
/**   银行logo*/
@property(nonatomic, strong) NSString *logo;
/**   合作方*/
@property(nonatomic, strong) NSString *partnerid;
@end

@interface FPGoToBuyItem : NSObject
/**  基金代码 */
@property(nonatomic, strong) NSString *fundid;
/**   最小申购金额*/
@property(nonatomic, strong) NSString *minPurchaseMoney;
/**   基金名称*/
@property(nonatomic, strong) NSString *fundname;
/**   众禄费率*/
@property(nonatomic,strong)NSString *netfee;
/**   费率列表*/
@property(nonatomic,strong)NSMutableArray  *feeLists;

/** 用户绑卡列表 */
@property(nonatomic, strong) NSMutableArray *bankLists;


@end

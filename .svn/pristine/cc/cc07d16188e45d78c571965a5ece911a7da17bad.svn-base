//
//  Tools_data_object.h
//  优顾理财
//
//  Created by Mac on 14/11/25.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools_data_object : NSObject

@end

//********************************************************************************************************
//**************************  Tools_Salary_range_object  (工资区间)
//********************************************************************************************************

@interface Tools_Salary_range_object : NSObject

/**个税返差*/
@property(nonatomic, strong) NSString *Tax_Return;
/**工资（上区间）*/
@property(nonatomic, strong) NSString *Up_Section;
/**工资（下区间）*/
@property(nonatomic, strong) NSString *Down_Section;
/**税收比例*/
@property(nonatomic, strong) NSString *Tax_Scale;
/**更新时间*/
@property(nonatomic, strong) NSString *UpdateTime;
/**基本 起税点*/
@property(nonatomic, strong) NSString *taxBase;

#pragma mark - 工资，征收个人所得税区间
/**
 * 函数描述 : 工资，征收个人所得税区间
 * @param
 *     输入参数 :(NSDictionary * )dic——————(json数据)
 * @return
 *      (NSMutableArray *)返回解析后的，对象集合
 */
+ (NSMutableArray *)Wage_Insurance_reData_analysis:(NSDictionary *)dic;
@end

//********************************************************************************************************
//**************************  Tools_Social_Security_object  (社保比例)
//********************************************************************************************************

@interface Tools_Social_Security_object : NSObject

/**城市信息-编码*/
@property(nonatomic, strong) NSString *cityCode;
/**城市信息-城市名称*/
@property(nonatomic, strong) NSString *cityName;
/**城市信息-公积金基数*/
@property(nonatomic, strong) NSString *houseBase;
/**城市信息-社保基数*/
@property(nonatomic, strong) NSString *socialBase;
/**封顶值*/
@property(nonatomic, strong) NSString *socialMax;

/**生育保险 (上线)*/
@property(nonatomic, strong) NSString *birthDown;
/**生育保险 (占比例)*/
@property(nonatomic, strong) NSString *birthRate;
/**生育保险 (下线)*/
@property(nonatomic, strong) NSString *birthUp;

/**住房公积金(上线)*/
@property(nonatomic, strong) NSString *houseDown;
/**住房公积金（占比例）*/
@property(nonatomic, strong) NSString *houseRate;
/**住房公积金（下线）*/
@property(nonatomic, strong) NSString *houseUp;

/**医疗保险(上线)*/
@property(nonatomic, strong) NSString *medicalDown;
/**医疗保险（占比例）*/
@property(nonatomic, strong) NSString *medicalRate;
/**医疗保险（下线）*/
@property(nonatomic, strong) NSString *medicalUp;
/**医疗附加值*/
@property(nonatomic, strong) NSString *medicalExt;

/**工伤保险(上线)*/
@property(nonatomic, strong) NSString *injuryDown;
/**工伤保险(占比例)*/
@property(nonatomic, strong) NSString *injuryRate;
/**工伤保险(下线)*/
@property(nonatomic, strong) NSString *injuryUp;

/**养老保险(上线)*/
@property(nonatomic, strong) NSString *oldDown;
/**养老保险(占比例)*/
@property(nonatomic, strong) NSString *oldRate;
/**养老保险(下线)*/
@property(nonatomic, strong) NSString *oldUp;

/**失业保险(上线)*/
@property(nonatomic, strong) NSString *workDown;
/**失业保险(占比例)*/
@property(nonatomic, strong) NSString *workRate;
/**失业保险(下线)*/
@property(nonatomic, strong) NSString *workUp;

/**总和*/
@property(nonatomic, strong) NSString *The_Social_sum;

#pragma mark - 社保和公积金，各城市 ,征收比例和上下区间
/**
 * 函数描述 : 社保和公积金，各城市 ,征收比例和上下区间
 * @param
 *     输入参数 : (NSDictionary * )dic——————(json数据)
 * @return
 *      (NSMutableArray *)返回解析后的，对象集合
 */
+ (NSMutableArray *)Social_Security_reData_analysis:(NSDictionary *)dic;
@end

//********************************************************************************************************
//**************************  Tools_Bank_depositRate_object  (银行存款，利息率)
//********************************************************************************************************

@interface Tools_Bank_depositRate_object : NSObject

/** 采用央行编码 */
@property(nonatomic, strong) NSString *bankCode;
/** 银行简称 */
@property(nonatomic, strong) NSString *bankName;
/** 活期存款利率 */
@property(nonatomic, strong) NSString *currentDepositRate;
/** 三个月定期 */
@property(nonatomic, strong) NSString *fixedDeposit3month;
/** 六个月定期 */
@property(nonatomic, strong) NSString *fixedDeposit6month;
/** 一年定期 */
@property(nonatomic, strong) NSString *fixedDeposit1year;
/** 两年定期 */
@property(nonatomic, strong) NSString *fixedDeposit2year;
/** 三年定期 */
@property(nonatomic, strong) NSString *fixedDeposit3year;
/** 五年定期 */
@property(nonatomic, strong) NSString *fixedDeposit5year;

/** 更新时间 */
@property(nonatomic, strong) NSString *updateTime;

#pragma mark - 存款利息利率
/**
 * 函数描述 : 存款利息利率
 * @param
 *     输入参数 : (NSDictionary * )dic——————(json数据)
 * @return
 *      (NSMutableArray *)返回解析后的，对象集合
 */
+ (NSMutableArray *)DepositRate_reData_analysis:(NSDictionary *)dic;

@end

//********************************************************************************************************
//**************************  Tools_Foreign_object  (外汇   兑换)
//********************************************************************************************************

@interface Tools_Foreign_object : NSObject

///** 序列号 */
//@property(nonatomic,strong) NSString *  foreign_num;
/** 货币简码 */
@property(nonatomic, strong) NSString *foreign_code;
/** 货币简称 */
@property(nonatomic, strong) NSString *foreign_name;

#pragma mark - 货币存储
/**
 * 函数描述 : 货币存储
 * @param
 *     输入参数 : (NSDictionary * )dic——————(json数据)
 * @return
 *      (NSMutableArray *)返回解析后的，对象集合
 */
+ (NSMutableArray *)Foreign_reData_analysis:(NSDictionary *)dic;
@end

//********************************************************************************************************
//**************************  Tools_Foreign_Exchange_Rate_object  (外汇   兑换)
//********************************************************************************************************

@interface Tools_Foreign_Exchange_Rate_object : NSObject

/** 持有——货币简码 */
@property(nonatomic, strong) NSString *first_foreign_code;
/** 持有——货币简称 */
@property(nonatomic, strong) NSString *first_foreign_name;

/** 兑现——货币简码 */
@property(nonatomic, strong) NSString *second_foreign_code;
/** 兑现——货币简称 */
@property(nonatomic, strong) NSString *second_foreign_name;

/** 持有——兑现 汇率*/
@property(nonatomic, strong) NSString *result_Rate;
/** 更新时间 */
@property(nonatomic, strong) NSString *updateTime;

#pragma mark - 货币存储
/**
 * 函数描述 : 货币存储
 * @param
 *     输入参数 : (NSDictionary * )dic——————(json数据)
 * @return
 *      (NSMutableArray *)返回解析后的，对象集合
 */
+ (NSMutableArray *)Foreign_Exchange_Rate_reData_analysis:(NSDictionary *)dic;
@end

//********************************************************************************************************
//**************************  Tools_Car_Loan_object  (车贷  利率)
//********************************************************************************************************

@interface Tools_Car_Loan_object : NSObject

/** 银行简码 */
@property(nonatomic, strong) NSString *bankCode;
/** 银行简称 */
@property(nonatomic, strong) NSString *bankName;

/** 六个月以下 */
@property(nonatomic, strong) NSString *six_below_Rate;
/** 六个月至一年 */
@property(nonatomic, strong) NSString *one_year_Rate;

/** 一年至三年 */
@property(nonatomic, strong) NSString *three_year_Rate;
/** 三年至五年 */
@property(nonatomic, strong) NSString *five_year_Rate;

/** 五年以上  (或公积金 五年以上） */
@property(nonatomic, strong) NSString *five_Above_Rate;

/** 公积金五年以下 */
@property(nonatomic, strong) NSString *five_below_Rate;

/** 更新时间 */
@property(nonatomic, strong) NSString *updateTime;
#pragma mark - 货币存储
/**
 * 函数描述 : 货币存储
 * @param
 *     输入参数 : (NSDictionary * )dic——————(json数据)
 * @return
 *      (NSMutableArray *)返回解析后的，对象集合
 */
+ (NSMutableArray *)Car_Loan_Rate_reData_analysis:(NSDictionary *)dic;
@end
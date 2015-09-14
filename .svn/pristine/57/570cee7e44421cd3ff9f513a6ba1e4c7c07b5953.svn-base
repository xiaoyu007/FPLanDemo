//
//  Tools_data_object.m
//  优顾理财
//
//  Created by Mac on 14/11/25.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "Tools_data_object.h"

@implementation Tools_data_object

@end

//********************************************************************************************************
//**************************  Tools_Salary_range_object (工资区间)
//********************************************************************************************************
@implementation Tools_Salary_range_object

+ (NSMutableArray *)Wage_Insurance_reData_analysis:(NSDictionary *)dic {
  NSArray *pay_tax_array = dic[@"taxList"];
  NSMutableArray *Salary_pay_array =
      [[NSMutableArray alloc] initWithCapacity:0];
  for (NSDictionary *pay_tax_object in pay_tax_array) {
    Tools_Salary_range_object *Salary_pay_single =
        [[Tools_Salary_range_object alloc] init];

    Salary_pay_single.Tax_Return =
        YouGu_ishave_blank(pay_tax_object[@"quickDeduction"]);
    Salary_pay_single.Up_Section =
        YouGu_ishave_blank(pay_tax_object[@"salaryEnd"]);
    Salary_pay_single.Down_Section =
        YouGu_ishave_blank(pay_tax_object[@"salaryStart"]);
    Salary_pay_single.Tax_Scale =
        YouGu_ishave_blank(pay_tax_object[@"taxRate"]);
    Salary_pay_single.UpdateTime =
        YouGu_ishave_blank(pay_tax_object[@"updateTime"]);
    Salary_pay_single.taxBase =
        YouGu_ishave_blank(dic[@"taxBase"]);

    [Salary_pay_array addObject:Salary_pay_single];
  }
  return Salary_pay_array;
}

@end

//********************************************************************************************************
//**************************  Tools_Social_Security_object  (社保比例)
//********************************************************************************************************
@implementation Tools_Social_Security_object
+ (NSMutableArray *)Social_Security_reData_analysis:(NSDictionary *)dic {
  NSArray *Social_array = dic[@"socialList"];

  NSMutableArray *Social_Security_array =
      [[NSMutableArray alloc] initWithCapacity:0];
  for (NSDictionary *social_object in Social_array) {
    Tools_Social_Security_object *social_single_object =
        [[Tools_Social_Security_object alloc] init];
    social_single_object.cityCode =
        YouGu_ishave_blank(social_object[@"cityCode"]);
    social_single_object.cityName =
        YouGu_ishave_blank(social_object[@"cityName"]);
    social_single_object.houseBase =
        YouGu_ishave_blank(social_object[@"houseBase"]);
    social_single_object.socialBase =
        YouGu_ishave_blank(social_object[@"socialBase"]);
    social_single_object.socialMax =
        YouGu_ishave_blank(social_object[@"socialMax"]);

    social_single_object.houseDown =
        YouGu_ishave_blank(social_object[@"houseDown"]);
    social_single_object.houseRate =
        YouGu_ishave_blank(social_object[@"houseRate"]);
    social_single_object.houseUp =
        YouGu_ishave_blank(social_object[@"houseUp"]);

    social_single_object.oldDown =
        YouGu_ishave_blank(social_object[@"oldDown"]);
    social_single_object.oldRate =
        YouGu_ishave_blank(social_object[@"oldRate"]);
    social_single_object.oldUp =
        YouGu_ishave_blank(social_object[@"oldUp"]);

    social_single_object.injuryDown =
        YouGu_ishave_blank(social_object[@"injuryDown"]);
    social_single_object.injuryRate =
        YouGu_ishave_blank(social_object[@"injuryRate"]);
    social_single_object.injuryUp =
        YouGu_ishave_blank(social_object[@"injuryUp"]);

    social_single_object.medicalDown =
        YouGu_ishave_blank(social_object[@"medicalDown"]);
    social_single_object.medicalRate =
        YouGu_ishave_blank(social_object[@"medicalRate"]);
    social_single_object.medicalUp =
        YouGu_ishave_blank(social_object[@"medicalUp"]);
    social_single_object.medicalExt =
        YouGu_ishave_blank(social_object[@"medicalExt"]);

    social_single_object.workDown =
        YouGu_ishave_blank(social_object[@"workDown"]);
    social_single_object.workRate =
        YouGu_ishave_blank(social_object[@"workRate"]);
    social_single_object.workUp =
        YouGu_ishave_blank(social_object[@"workUp"]);

    social_single_object.birthDown =
        YouGu_ishave_blank(social_object[@"birthDown"]);
    social_single_object.birthRate =
        YouGu_ishave_blank(social_object[@"birthRate"]);
    social_single_object.birthUp =
        YouGu_ishave_blank(social_object[@"birthUp"]);

    [Social_Security_array addObject:social_single_object];
  }

  return Social_Security_array;
}

@end

//********************************************************************************************************
//**************************  Tools_Bank_depositRate_object (银行  存款利息利率)
//********************************************************************************************************
@implementation Tools_Bank_depositRate_object

+ (NSMutableArray *)DepositRate_reData_analysis:(NSDictionary *)dic {
  NSArray *depositList = dic[@"depositList"];
  NSMutableArray *deposit_array = [[NSMutableArray alloc] initWithCapacity:0];

  for (NSDictionary *deposit_object in depositList) {
    Tools_Bank_depositRate_object *deposit_single_object =
        [[Tools_Bank_depositRate_object alloc] init];

    deposit_single_object.bankCode =
        YouGu_ishave_blank(deposit_object[@"bankCode"]);
    deposit_single_object.bankName =
        YouGu_ishave_blank(deposit_object[@"bankName"]);
    deposit_single_object.currentDepositRate =
        YouGu_ishave_blank(deposit_object[@"currentDepositRate"]);
    deposit_single_object.fixedDeposit3month =
        YouGu_ishave_blank(deposit_object[@"fixedDeposit3month"]);
    deposit_single_object.fixedDeposit6month =
        YouGu_ishave_blank(deposit_object[@"fixedDeposit6month"]);
    deposit_single_object.fixedDeposit1year =
        YouGu_ishave_blank(deposit_object[@"fixedDeposit1year"]);
    deposit_single_object.fixedDeposit2year =
        YouGu_ishave_blank(deposit_object[@"fixedDeposit2year"]);
    deposit_single_object.fixedDeposit3year =
        YouGu_ishave_blank(deposit_object[@"fixedDeposit3year"]);
    deposit_single_object.fixedDeposit5year =
        YouGu_ishave_blank(deposit_object[@"fixedDeposit5year"]);

    [deposit_array addObject:deposit_single_object];
  }
  return deposit_array;
}

@end

//********************************************************************************************************
//**************************  Tools_Foreign_object (外汇   转换)
//********************************************************************************************************
@implementation Tools_Foreign_object

+ (NSMutableArray *)Foreign_reData_analysis:(NSDictionary *)dic {
  NSArray *result = dic[@"result"];
  NSMutableArray *result_array = [[NSMutableArray alloc] initWithCapacity:0];

  for (NSDictionary *foreign_object in result) {
    Tools_Foreign_object *foreign_single_object =
        [[Tools_Foreign_object alloc] init];

    foreign_single_object.foreign_code =
        YouGu_ishave_blank(foreign_object[@"code"]);
    foreign_single_object.foreign_name =
        YouGu_ishave_blank(foreign_object[@"name"]);

    [result_array addObject:foreign_single_object.foreign_name];
  }
  return result_array;
}

@end
//********************************************************************************************************
//**************************  Tools_Foreign_Exchange_Rate_object (外汇   转换)
//********************************************************************************************************
@implementation Tools_Foreign_Exchange_Rate_object

+ (NSMutableArray *)Foreign_Exchange_Rate_reData_analysis:(NSDictionary *)dic {
  NSArray *result = dic[@"foreignList"];
  NSMutableArray *result_array = [[NSMutableArray alloc] initWithCapacity:0];

  for (NSDictionary *foreign_object in result) {
    Tools_Foreign_Exchange_Rate_object *foreign_Rate_single_object =
        [[Tools_Foreign_Exchange_Rate_object alloc] init];

    foreign_Rate_single_object.first_foreign_code =
        YouGu_ishave_blank(foreign_object[@"beforeMoneyCode"]);
    foreign_Rate_single_object.first_foreign_name =
        YouGu_ishave_blank(foreign_object[@"beforeMoneyName"]);

    foreign_Rate_single_object.second_foreign_code =
        YouGu_ishave_blank(foreign_object[@"afterMoneyCode"]);
    foreign_Rate_single_object.second_foreign_name =
        YouGu_ishave_blank(foreign_object[@"afterMoneyName"]);

    foreign_Rate_single_object.result_Rate =
        YouGu_ishave_blank(foreign_object[@"convertRate"]);
    foreign_Rate_single_object.updateTime =
        YouGu_ishave_blank(foreign_object[@"updateTime"]);

    [result_array addObject:foreign_Rate_single_object];
  }
  return result_array;
}

@end

//********************************************************************************************************
//**************************  Tools_Car_Loan_object (车贷  利率)
//********************************************************************************************************
@implementation Tools_Car_Loan_object

+ (NSMutableArray *)Car_Loan_Rate_reData_analysis:(NSDictionary *)dic {
  NSArray *result = dic[@"lendingList"];
  NSMutableArray *result_array = [[NSMutableArray alloc] initWithCapacity:0];

  for (NSDictionary *Car_object in result) {
    Tools_Car_Loan_object *Car_Loan_single_object =
        [[Tools_Car_Loan_object alloc] init];

    Car_Loan_single_object.bankCode =
        YouGu_ishave_blank(Car_object[@"bankCode"]);
    Car_Loan_single_object.bankName =
        YouGu_ishave_blank(Car_object[@"bankName"]);

    Car_Loan_single_object.six_below_Rate =
        YouGu_ishave_blank(Car_object[@"month6Below"]);
    Car_Loan_single_object.one_year_Rate =
        YouGu_ishave_blank(Car_object[@"month6ToYear1"]);
    Car_Loan_single_object.three_year_Rate =
        YouGu_ishave_blank(Car_object[@"year1ToYear3"]);
    Car_Loan_single_object.five_year_Rate =
        YouGu_ishave_blank(Car_object[@"year3ToYear5"]);
    Car_Loan_single_object.five_Above_Rate =
        YouGu_ishave_blank(Car_object[@"year5Above"]);
    ///公积金
    Car_Loan_single_object.five_below_Rate =
        YouGu_ishave_blank(Car_object[@"year5Below"]);

    Car_Loan_single_object.updateTime =
        YouGu_ishave_blank(Car_object[@"updateTime"]);

    [result_array addObject:Car_Loan_single_object];
  }
  return result_array;
}

@end

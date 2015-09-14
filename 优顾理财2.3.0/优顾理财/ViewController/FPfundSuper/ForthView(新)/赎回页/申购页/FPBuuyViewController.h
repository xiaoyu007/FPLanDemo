//
//  BuuyViewController.h
//  优顾理财
//
//  Created by jhss on 15-4-2.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPBaseViewController.h"

@interface FPBuuyViewController : UIViewController<UITextFieldDelegate, UITableViewDataSource,
UITableViewDelegate>
{

  ///购买时间
  NSString *timeLabel;
  ///预计确认时间
  NSString *planTime;  
  NSString *textFieldString;
  NSString *moneyStr;
  NSString *moneyStr1;
  /**  费率*/
  NSMutableArray *feeArr2;
  NSArray *feeArr1;
  ///银行卡列表
  UITableView *_tableView;
}
@property(nonatomic, strong) UIView *btnView;
@property(nonatomic, strong) UIView *grayView;
@property(nonatomic, strong) UIView *whiteView;
@property(nonatomic, strong) UIView *buyGrayView;
@property(nonatomic, strong) UIView *buyWhiteView;
@property(nonatomic, strong) UIButton *cancelBtn;

///所选银行卡ID
@property(nonatomic, strong) NSString *buyUserBankId;
///基金代码
@property(nonatomic, strong) NSString *buyFundId;
///金额
@property(nonatomic, strong) NSString *buyMoney;
///交易密码
@property(nonatomic, strong) NSString *buyTradecode;

/**费率*/
@property(weak, nonatomic) IBOutlet UILabel *rateLabel;

/**  众禄费率*/
@property(nonatomic,strong)IBOutlet UILabel *netrateLabel;
///银行卡名称
@property (weak, nonatomic) IBOutlet UILabel *btnBankNamelabel;
/**基金名称*/
@property(weak, nonatomic) IBOutlet UILabel *nameLabel;

@property(weak, nonatomic) IBOutlet UITextField *buyTextField;

@property (weak, nonatomic) IBOutlet UIView *rateView;

/**最少输入多少金额*/
@property(nonatomic, strong) NSString *buyTextFieldStr;
/**传过来的费率*/
@property(nonatomic, strong) NSString *ratelabelStr;

/**传过来的众禄费率*/
@property(nonatomic, strong) NSString *netRatelabelStr;
/**   费率数组*/
@property(nonatomic,strong)NSMutableArray *mutFeeList;

/**传过来基金名称*/
@property(nonatomic, strong) NSString *nameLabelStr;
/**传过来的银行卡名称*/
@property(nonatomic, strong) NSString *bankNameStr;
/**传过来的银行数组*/
@property(nonatomic, strong) NSMutableArray *bankNumArray;

///索引选中的哪一行
@property(nonatomic, assign) NSInteger selectedIndex;
///交易密码输入框
@property(nonatomic, strong) NSString *tradeField;

@end

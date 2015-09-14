//
//  RedemViewController.h
//  优顾理财
//
//  Created by jhss on 15-4-7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "YGBaseViewController.h"

/** 赎回回调 */
typedef void (^TradeAccountBlock)(BOOL isSuccess);

@interface FPRedemViewController : UIViewController<UIAlertViewDelegate>
{
  /** 赎回份额 */
  NSString *endRedeemStr;
}
@property(nonatomic, strong) NSString *redemUserbankid; //所选银行卡ID
@property(nonatomic, strong) NSString *redemFundid;     //基金代码
///基金名称
@property(nonatomic, strong) NSString *fundNameStr;
///持仓份额
@property(nonatomic, strong) NSString *balanceStr;
///最小赎回份额
@property(nonatomic, strong) NSString *minRedeemStr;
/** 当前交易账号 */
@property(nonatomic, strong) NSString *currentTradeAcco;
/** 赎回回调 */
@property (copy, nonatomic) TradeAccountBlock currentBlock;

///赎回份额输入框
@property (weak, nonatomic) IBOutlet UITextField *redeemTextField;
///产品名称
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
///银行卡及尾号  按钮
@property (weak, nonatomic) IBOutlet UILabel *bankNameAndNumLabel;
///最大赎回份额
@property (weak, nonatomic) IBOutlet UILabel *maxRedeemMoeny;
///中间的背景view
@property (weak, nonatomic) IBOutlet UIView *midBackGroundView;
/** 赎回按钮 */
@property (weak, nonatomic) IBOutlet UIButton *redeemButton;
///赎回按钮
- (IBAction)redeemButtonClicked:(id)sender;


@end

//
//  FourForegnViewController.h
//  优顾理财
//
//  Created by jhss on 15/8/31.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourForegnViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate>
{

  UITableView *foregnTableView;
  //持有外币   按钮
  BOOL holdClick;
  //兑换外币  按钮
  BOOL exchangeForeignClick;
  //手势
  UITapGestureRecognizer *tap;
  
 
}
/**  持有外币的种类*/
@property (weak, nonatomic) IBOutlet UITextField *holdForeignTitle;
/**  持有外币  按钮*/
@property (weak, nonatomic) IBOutlet UIButton *holdForeignBtn;
/**  兑换外币的种类*/
@property (weak, nonatomic) IBOutlet UITextField *exchangeForeignTitle;
/**  兑换外币   按钮*/
@property (weak, nonatomic) IBOutlet UIButton *exchangeForeignBtn;
/**  兑换  按钮*/
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtn;


/**  持有外币金额*/
@property (weak, nonatomic) IBOutlet UITextField *holdForeignMoney;
/**  持有金币金额名称*/
@property (weak, nonatomic) IBOutlet UILabel *holdForeignName;
/**  兑换币金额*/
@property (weak, nonatomic) IBOutlet UITextField *exchangeForeignMoney;
/**  兑换金币名称*/
@property (weak, nonatomic) IBOutlet UILabel *exchangeMoneyName;

/**  兑换金额*/
@property (weak, nonatomic) IBOutlet UILabel *exchangeMoney;



///   持有/兑换货币  数据
@property(nonatomic, retain) NSMutableArray *CurrencyArray;

///   两个货币兑换比率
@property(nonatomic, retain) NSMutableArray *exchangeRate;



@end

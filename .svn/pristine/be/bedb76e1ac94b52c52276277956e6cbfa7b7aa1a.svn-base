//
//  FPBuyAndRedeemTipVC.h
//  优顾理财
//
//  Created by Mac on 15/7/23.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TextFieldCallback)(NSString *callbackStr);
@interface FPBuyAndRedeemTipVC : UIViewController<UITextFieldDelegate>{
  /** 提示框回调 */
  TextFieldCallback currentCallback;
}

/** 提示框背景 */
@property(weak, nonatomic) IBOutlet UIView *tipBGView;
/** 提示标题 */
@property(weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 提示内容 */
@property(weak, nonatomic) IBOutlet UILabel *contentLabel;
/** 取消按钮 */
@property(weak, nonatomic) IBOutlet UIButton *cancelButton;
/** 确定按钮 */
@property(weak, nonatomic) IBOutlet UIButton *confirmButton;
/** 输入的资金 */
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
/** 输入交易密码 */
@property (weak, nonatomic) IBOutlet UITextField *textTradeField;
/** 底部灰色背景 */
@property(nonatomic,strong)IBOutlet UIView *grayView;

/** 提示框的标题和内容及输入框 */
- (void)showTipWithTitle:(NSString *)title
               withMoney:(NSString *)monenyTitle
             withContent:(NSString *)content
           withTextField:(NSString *)textFieldTitle
      withCancelBtnTitle:(NSString *)cancelTitle
     withConfirmBtnTitle:(NSString *)confirmTitle
            withCallback:(TextFieldCallback)callback;
/** 取消按钮点击 */
- (IBAction)cancelButtonClicked:(id)sender;
/** 确认按钮点击 */
- (IBAction)confirmButtonClicked:(id)sender;

@end

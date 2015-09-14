//
//  TipViewController.h
//  优顾理财
//
//  Created by Mac on 15-4-28.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, CusTipType) {
  /** 提示框评测 */
  CusTipTypeVerificate = 1,
  /** 提示框申购 */
  CusTipTypePurchase,
};
typedef void (^TextFieldCallback)(NSString *callbackStr);

@interface TipViewController : UIViewController {
  /** 提示框回调 */
  TextFieldCallback currentCallback;
  /** 提示框类型 */
  CusTipType tipType;
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
/**  返回按钮*/
@property(nonatomic,strong)UIButton *cancelBtn;

@property(nonatomic, strong) NSString *strTextField;

@property(nonatomic,strong)IBOutlet UIView *grayView;

/** 提示框的标题和内容 */
- (void)showTipWithTitle:(NSString *)title
             withContent:(NSString *)content
      withCancelBtnTitle:(NSString *)cancelTitle
     withConfirmBtnTitle:(NSString *)confirmTitle;

/** 提示框的标题和内容及输入框 */
- (void)showTipWithTitle:(NSString *)title
               withMoney:(NSString *)monenyTitle
             withContent:(NSString *)content
           withTextField:(NSString *)textFieldTitle
      withCancelBtnTitle:(NSString *)cancelTitle
     withConfirmBtnTitle:(NSString *)confirmTitle
            withCallback:(TextFieldCallback)callback;
/** 时间提示框的标题和内容 */
- (void)showTipWithTitle:(NSString *)title
             withContent:(NSString *)content
      withCancelBtnTitle:(NSString *)cancelTitle;

@end

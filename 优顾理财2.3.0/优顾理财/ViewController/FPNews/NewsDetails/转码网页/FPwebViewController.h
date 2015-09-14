//
//  FPwebViewController.h
//  优顾理财
//
//  Created by Mac on 15/7/13.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPBaseViewController.h"
@interface XToolBar : UIToolbar {
}
@end
@interface FPwebViewController : FPBaseViewController<UIWebViewDelegate,UIActionSheetDelegate>

- (id)initWithPathurl:(NSString *)pathurl;
- (id)initWithPathurl:(NSString *)pathurl
             andTitle:(NSString *)title;
@end

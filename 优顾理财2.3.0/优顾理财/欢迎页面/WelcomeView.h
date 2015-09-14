//
//  Welcome_View.h
//  优顾理财
//
//  Created by moulin wang on 13-10-8.
//  Copyright (c) 2013年 Ling YU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WelcomeViewDelegate
@optional
- (void)introDidFinish;
@end

@interface WelcomeView : UIView<UIScrollViewDelegate,UIAlertViewDelegate>
{
    UIScrollView * welcome_scroll;
    
    UIPageControl * pageControl;
}
@property (nonatomic, retain)UIScrollView * welcome_scroll;
@property(nonatomic,retain)UIPageControl * pageControl;
@property(nonatomic,assign)id<WelcomeViewDelegate> my_delegate;
@end

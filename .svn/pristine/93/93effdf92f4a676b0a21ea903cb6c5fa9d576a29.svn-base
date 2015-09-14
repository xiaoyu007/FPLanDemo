//
//  RootViewController.m
//  优顾理财
//
//  Created by Mac on 15/1/17.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "YGImageDown.h"
#import "UIImageView+WebCache.h"

@interface RootViewController () {
  UIImageView *headerImgView;
  UIImageView *footerImgView;
  UIImageView *localImgView;
}
@end
//
@implementation RootViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  //////////////////////////////////////////////////////////////////////////////////////////////////
  //服务器没有的话，就拿工程中的默认图片去展示
  self.childView.clipsToBounds = NO;
  localImgView = [[UIImageView alloc]
      initWithFrame:CGRectMake(0, -BOTTOM_TOOL_BAR_OFFSET_Y,
                               self.childView.width,
                               self.childView.height - 98)];
  localImgView.image = [UIImage imageNamed:@"ios广告启动页切图_-640×960.jpg"];
  [self.childView addSubview:localImgView];
  //上半部分（来自服务器）
  headerImgView = [[UIImageView alloc]
      initWithFrame:CGRectMake(0, 0, self.childView.width,
                               self.childView.height - 98)];
  [self.childView addSubview:headerImgView];
  //地半部分（来自工程）
  footerImgView = [[UIImageView alloc]
      initWithFrame:CGRectMake((self.childView.width - 210) / 2 + 3,
                               self.childView.height - 98 + 23 -
                                   BOTTOM_TOOL_BAR_OFFSET_Y,
                               210, 52)];
  footerImgView.image = [UIImage imageNamed:@"ios-_引导小icon"];
  [self.childView addSubview:footerImgView];

  ///获取图片的路径
  NSString *path =
      [[NSUserDefaults standardUserDefaults] objectForKey:@"StartPicPathUrl"];

  if (!path) {
    localImgView.image = [UIImage imageNamed:@"ios广告启动页切图_-640×960.jpg"];
  } else {
    [[YGImageDown sharedManager] add_image:path
                                completion:^(UIImage *image) {
                                  if (image) {
                                    localImgView.image = image;
                                  }
                                }];
  }
  //进入应用后先去服务器请求图片，放到本地
  [FPYouguUtil performBlockOnGlobalThread:^{
    [self requestInternetHeaderImgView];
  } withDelaySeconds:0.05];
}

- (void)requestInternetHeaderImgView {
  [[WebServiceManager sharedManager] StartPicAPIWithcompletion:^(NSDictionary
                                                                     *dic) {
    if (dic && [dic[@"status"] isEqualToString:@"0000"]) {
      NSString *picPath = dic[@"adImage"];
      __weak RootViewController *weakSelf = self;
      if (picPath && [picPath length] > 0) {
        RootViewController *strongSelf = weakSelf;
        if (strongSelf) {
          [[NSUserDefaults standardUserDefaults] setObject:picPath
                                                    forKey:@"StartPicPathUrl"];
          [[NSUserDefaults standardUserDefaults]synchronize];
          [[YGImageDown sharedManager] add_image:picPath
                                      completion:^(UIImage *image) {
                                        if (image) {
                                        }
                                      }];
        }
      }
    }
  }];
}


@end

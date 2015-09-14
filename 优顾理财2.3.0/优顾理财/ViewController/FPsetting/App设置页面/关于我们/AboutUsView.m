//
//  AboutUsView.m
//  优顾理财
//
//  Created by Mac on 15/8/5.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "AboutUsView.h"

@implementation AboutUsView
-(void)awakeFromNib
{
  [super awakeFromNib];
  //版本号
  NSString *version =
  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
  _versionLable.text = [NSString stringWithFormat:@"版本:%@", version];
}

- (IBAction)sendTelephone:(UIButton *)sender {
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://010-80443260"]];
}

@end

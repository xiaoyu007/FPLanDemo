//
//  Basic_iPhone_parameters.m
//  优顾理财
//
//  Created by moulin wang on 13-10-10.
//  Copyright (c) 2013年 Ling YU. All rights reserved.
//

#pragma mark - 获得手机唯一身份码
//获得手机唯一身份码
NSString *GetDeviceID() {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString *DeviceID = [defaults objectForKey:@"DeviceID"];

  if (DeviceID == nil) {
    DeviceID = [[UIDevice currentDevice] uniqueDeviceIdentifier];
    [defaults setObject:DeviceID forKey:@"DeviceID"];
    [defaults synchronize];
  }

  return DeviceID;
}

#pragma mark - 手机机型
//手机机型
NSString *Iphone_model() {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString *iPhone_model = [defaults objectForKey:@"iPhone_model"];
  if (iPhone_model == nil) {
    iPhone_model = [[UIDevice currentDevice] model];
    [defaults setObject:iPhone_model forKey:@"iPhone_model"];
    [defaults synchronize];
  }
  return iPhone_model;
}

#pragma mark - 屏幕分辨率
//屏幕分辨率
NSString *Iphone_Size() {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString *iPhone_Size = [defaults objectForKey:@"iPhone_Size"];
  if (iPhone_Size == nil) {
    UIScreen *MainScreen = [UIScreen mainScreen];
    CGSize Size = [MainScreen bounds].size;
    CGFloat scale = [MainScreen scale];
    CGFloat screenWidth = Size.width * scale;
    CGFloat screenHeight = Size.height * scale;

    iPhone_Size = [NSString
        stringWithFormat:@"%d*%d", (int)screenWidth, (int)screenHeight];
    [defaults setObject:iPhone_Size forKey:@"iPhone_Size"];
    [defaults synchronize];
  }
  return iPhone_Size;
}

#pragma mark - 获得手机操作系统版本号
//获得手机操作系统版本号
NSString *Iphone_OS() {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString *iPhone_OS = [defaults objectForKey:@"iPhone_OS"];
  if (iPhone_OS == nil) {
    NSString *sys_name = [[UIDevice currentDevice] systemName];
    NSString *sys_Version = [[UIDevice currentDevice] systemVersion];
    iPhone_OS = [NSString stringWithFormat:@"%@ %@", sys_name, sys_Version];
    [defaults setObject:iPhone_OS forKey:@"iPhone_OS"];
    [defaults synchronize];
  }

  return iPhone_OS;
}

#pragma mark - 获取上网方式
//获得手机上网方式
NSString *CheckNetWork() {
  NSString *network = @"无网络";
  Reachability *reachability =
      [Reachability reachabilityWithHostName:@"www.youguu.com"];
  switch ([reachability currentReachabilityStatus]) {
  case NotReachable:
    network = @"无网络";
    //无网络提示
    YouGu_animation_Did_Start(networkFailed);
    break;
  case ReachableViaWWAN:
    network = @"3G或GPRS";
    break;
  case ReachableViaWiFi:
    network = @"wifi";
    break;
  default:
    network = @"无网络";
    break;
  }
  return network;
}
BOOL CheckNetWorkStatus(NSString *name){

  if ([CheckNetWork() isEqualToString:name]) {
    return YES;
  }
  return NO;
}
/** 没有提示的无网判断 */
NSString *checkNetWorkNoTip(){
  NSString *network = @"无网络";
  Reachability *reachability =
  [Reachability reachabilityWithHostName:@"www.youguu.com"];
  switch ([reachability currentReachabilityStatus]) {
    case NotReachable:
      network = @"无网络";
      break;
    case ReachableViaWWAN:
      network = @"3G或GPRS";
      break;
    case ReachableViaWiFi:
      network = @"wifi";
      break;
    default:
      network = @"无网络";
      break;
  }
  return network;
}
#pragma mark - 获得运营商
//获得运营商
NSString *CarrierName() {

  CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];

  CTCarrier *carrier = [netInfo subscriberCellularProvider];

  NSString *carrierCode = [carrier carrierName];

  if ([carrierCode isEqualToString:@""] || carrierCode == nil) {

    return @"WiFi";
  }

  return carrierCode;
}

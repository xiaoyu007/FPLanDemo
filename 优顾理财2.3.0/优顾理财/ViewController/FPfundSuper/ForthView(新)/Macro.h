//
//  Macro.h
//  SoftWare
//
//  Created by _TZ on 14-11-24.
//  Copyright (c) 2014年 com.touna. All rights reserved.
// 全局可用的宏定义，大大减少代码量

#ifndef SoftWare_Macro_h
#define SoftWare_Macro_h
#endif

// URL接口
#define HTTP_URL @"http://192.168.1.13:8080/college/getview/app"

//网络请求方法
#define POSTMethod @"POST"
#define GETMethod @"GET"

//月利率
#define MonthRate @"monthRate"

//用户名
#define Username @"userName"

//标示
#define tokenId @"tokenId"

//屏幕宽高
#define Screen_height [UIScreen mainScreen].bounds.size.height
#define Screen_width [UIScreen mainScreen].bounds.size.width

//宝贝详情页面ScrollView的高度
#define kGalaryHeight 550 * 0.5

//系统版本
#define IOS_Verson [[[UIDevice currentDevice] systemVersion] floatValue]

//设备型号
#define IOS_Model [[UIDevice currentDevice] model]

//常用的颜色
#define ClearColor [UIColor clearColor]
#define OrangeColor [UIColor orangeColor]
#define PurpleColor [UIColor purpleColor]
#define RedColor [UIColor redColor]
#define WhiteColor [UIColor whiteColor]
#define GrayColor [UIColor grayColor]
#define BlackColor [UIColor blackColor]
#define GlobalBg RGBACOLOR(242, 242, 242, 1)

//字体的宏定义
#define font(size) [UIFont systemFontOfSize:(size)]
#define boldFont(size) [UIFont boldSystemFontOfSize:(size)]

/*
 Debug : 调试（开发阶段），系统会自定义一个叫做DEBUG的宏
 Release : 发布（打包），系统会自动删掉叫做DEBUG的宏
 */
#ifdef DEBUG

#define YGLog(...) NSLog(__VA_ARGS__)

#else

#define YGLog(...) NSLog(__VA_ARGS__)

#endif

//软件主色调
#define BackgrounColor                                                         \
  [UIColor colorWithRed:232 / 255.0 green:233 / 255.0 blue:232 / 255.0 alpha:1]
#define ButtonGrounColor                                                       \
  [UIColor colorWithRed:61 / 255.0 green:133 / 255.0 blue:212 / 255.0 alpha:1]

//隐藏tabbar
#define HiddenTabbar                                                           \
  [TTool hideTabbarWithTabbarVC:self.tabBarController duration:0.3]

//显示tabBar
#define ShownTabbar                                                            \
  [TTool showTabbarWithTabbarVC:self.tabBarController duration:0.3]

//销毁navigationControll
#define PopViewController                                                      \
  [self.navigationController popViewControllerAnimated:YES]

//白天模式的灰色
#define YGLightGray                                                            \
  [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f]
#define YGORANG_CORLOR                                                         \
  [UIColor colorWithRed:0.94f green:0.46f blue:0.20f alpha:1.00f]

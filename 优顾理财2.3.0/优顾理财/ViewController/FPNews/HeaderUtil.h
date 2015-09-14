//
//  HeaderUtil.h
//  优顾理财
//
//  Created by Mac on 15/6/30.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#ifndef _____HeaderUtil_h
#define _____HeaderUtil_h


//会话id
#define Defaut_Sid @"USER_SESSIONID"
//默认用户id
#define Defaut_UserID @"USER_ID"
#define Defaut_YouGu_UserID @"YouGu_USER_ID"

//实盘交易非法登录
#define illegal_Logon_realtrade @"illegal_logon_for_realtrade"
#pragma mark
#pragma mark 常用句丙宏定义
#define WINDOW [[[UIApplication sharedApplication] delegate] window]

//通知登录成功
#define NotifactionLoginSuccess @"NotifactionLoginSuccess"





/*
 *字体定义
 */
//字体
#define FONT_ARIAL @"Arial"

//字体高度
#define Font_Height_25_0 25.0f
#define Font_Height_21_0 21.0f
#define Font_Height_20_0 20.0f
#define Font_Height_19_0 19.0f
#define Font_Height_18_0 18.0f
#define Font_Height_17_0 17.0f
#define Font_Height_16_0 16.0f
#define Font_Height_15_0 15.0f
#define Font_Height_14_0 14.0f
#define Font_Height_13_0 13.0f
#define Font_Height_12_0 12.0f
#define Font_Height_11_0 11.0f
#define Font_Height_10_0 10.0f
#define Font_Height_09_0 9.0f
#define Font_Height_08_0 8.0f

/*
 *颜色定义
 */
#define Color_White @"#FFFFFF"          //白色
#define Color_Black @"#000000"          //黑色
#define Color_YELLOW_VIP @"#FABE00"     //黄色
#define Color_Dark @"#2F2E2E"           //深色
#define Color_Gray @"#939393"           //中灰色，提示文字颜色
#define Color_Cube @"#8D8E93"           //深灰色，股聊更多···
#define COLOR_SIGNATURE @"#A8A8A8"      //主页签名灰色
#define Color_Light @"#ACACAC"          //浅色
#define Color_Red @"#f61f1f"            //红色（涨）
#define Color_Green @"#359301"          //绿色（跌）
#define Color_Yellow @"#f5a60d"         //黄色（跌）
#define Color_Table_Title @"#222222"    //表格标题文字颜色
#define Color_Blue_Profit @"#0083d1"    //蓝色主页盈利区域文字颜色
#define Color_Blue_but @"#086dae"       //蓝色按钮色值
#define Color_Gray_but @"#B9B9B9"       //深灰按钮按下色值
#define Color_Blue_butDown @"#055081"   //蓝色按钮按下色值
#define Color_yellow_but @"#ffa10e"     //黄色按钮色值
#define Color_yellow_butDown @"#d18501" //黄色按钮按下色值
#define Color_BG_Table_Title @"#e1e3e8" //表格标题背景色
#define Color_BG_Common @"#f7f7f7"      //通用背景色
#define Color_Text_Common @"#454545"    //通用文字颜色
#define Color_Cell_Line @"#e3e3e3"      //表格底边浅灰色
#define Color_Border @"#d7d7d7"         //像素描边颜色
#define Color_Botom_Gray @"#393939"     //底部按钮灰颜色
#define Color_Botom_Red @"#c7292D"      //底部按钮红颜色
#define Color_Stock_Code @"#ff8400"     //股票代码通用颜色
#define Color_Black_Stock_Price @"#343434" //正确股票价格字体颜色
#define Color_Red_Stock_Price @"#d70000"   //错误股票价格字体颜色
#define Color_Icon_Title @"#5A5A5A"        //首页模块的标题颜色
#define Color_Pressed_Gray @"#E8E8E8"      //按钮按下灰色背景
#define Color_StockInfo_Name @"#818181" //行情分时页面，个股报价名称字段颜色
#define Color_Circle @"#CBCBCB"              // DDPageConrol点
#define Color_Gray_Edge @"#D3D3D3"           //股聊logo描边
#define Color_Publish @"#05F4F7"             //聊股发表按钮文字颜色
#define Color_ReplyBubble @"#EAEAEA"         //回复框气泡颜色
#define Color_AlwaysTemplate @"#007AFF"      //单图标的蓝色高亮
#define Color_SeparatorLeft @"#3D7199"       //拓展按钮左侧竖线
#define Color_SeparatorRight @"#275477"      //拓展按钮右侧竖线
#define Color_PraiseRed @"#F36C6C"           //赞数字红色
#define Color_NormalBackground @"#87C8f1"    //聊股吧默认背景
#define Color_TooltipCancelButton @"#AFB3B5" //微博提示框取消按钮背景色
#define Color_TooltipSureButton @"#31BCE9" //微博提示框确定按钮背景色
#define Color_WeiboButtonPressDown                                             \
@"#D9D9D9" //分享、评论、赞按钮按下态颜色，cell选中颜色
#define Color_TRACK_BUTTON_BORDER @"#AEAEAE" //主页追踪按钮边框
#define Color_Text_Details                                                     \
@"#5a5a5a" //确认支付、账户充值、资金明细等显示金额的颜色
#define Color_WFOrange_btn @"#FD8418"     //配资橘黄色按钮按色值
#define Color_WFOrange_btnDown @"#de6402" //配资橘黄色按钮按下色值
#define COLOR_KLINE_BORDER @"#CAD2D8"     // K线边框颜色
#define COLOR_KLINE_SEPARATOR @"#DEE1E2"  // K线分割线
#define COLOR_AVERAGE_LINE @"#F4CB71"     // k线均线
#define COLOR_DARK_BLUE @"#146DAE"        //深蓝色
#define COLOR_MA_BLUE @"#00ACE5"          // MA蓝
#define COLOR_MA_ORANGE @"#D98500"        // MA橙
#define COLOR_MA_PURPLE @"#C32EC3"        // MA紫
#define COLOR_MA_GREEN @"#35CE00"         // MA绿
#define COLOR_MA_MAGENTA @"#FF3E6B"       // MA品红
#define COLOR_COW_BEAR_RED @"#F16F6F"     //牛熊比红
#define COLOR_GRAY_PURPLE @"#CCCDE7"      //资金流向 浅紫
#define COLOR_INDICATOR_LINE @"#4691C1"   // k线指标线颜色，深蓝色
#define COLOR_KLINE_INFO_TITLE @"#818181" // K线信息标题颜色，比如成交、时间

//公用字符串常量
#define REQUEST_FAILED_MESSAGE @"您当前网络不给力哦" //有网络，但是网络异常

// ViewController的frame
#define WINDOWUISCREEN [[UIScreen mainScreen] bounds]
// ViewController横向宽度
#define WIDTH_OF_VIEWCONTROLLER self.view.bounds.size.width
// ViewController纵向宽度
#define HEIGHT_OF_VIEWCONTROLLER self.view.bounds.size.height
// view的横向宽度
#define WIDTH_OF_VIEW self.bounds.size.width
// view的纵向高度
#define HEIGHT_OF_VIEW self.bounds.size.height
// screen的宽度
#define WIDTH_OF_SCREEN [[UIScreen mainScreen] bounds].size.width
// screen的高度
#define HEIGHT_OF_SCREEN [[UIScreen mainScreen] bounds].size.height
#define EqualToString(a,b) [a isEqualToString:b]


///APPdelegate单例对象
#define FPYouGuuAppDelegaet  ((AppDelegate *)[[UIApplication sharedApplication] delegate])
//static (AppDelegate *) fpAppDelegaet = ((AppDelegate *)[[UIApplication sharedApplication] delegate]);
#endif

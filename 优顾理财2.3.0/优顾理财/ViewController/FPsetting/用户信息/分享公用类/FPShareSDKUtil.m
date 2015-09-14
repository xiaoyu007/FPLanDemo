//
//  FPShareSDKUtil.m
//  优顾理财
//
//  Created by Mac on 15/8/7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPShareSDKUtil.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"

@implementation FPShareSDKUtil

+ (id<ISSAuthOptions>)getAuthOptions {
  id<ISSAuthOptions> authOptions =
      [ShareSDK authOptionsWithAutoAuth:NO
                          allowCallback:NO
                                 scopes:nil
                          powerByHidden:YES
                         followAccounts:nil
                          authViewStyle:SSAuthViewStyleFullScreenPopup
                           viewDelegate:nil
                authManagerViewDelegate:nil];
  return authOptions;
}

///绑定第三方平台
+ (void)authWithType:(ShareType)type
             options:(id<ISSAuthOptions>)options
              result:(FPShareResult)result {
  [ShareSDK authWithType:type
                 options:[FPShareSDKUtil getAuthOptions]
                  result:^(SSAuthState state, id<ICMErrorInfo> error) {
                    if (state == SSAuthStateSuccess) {
                      switch (type) {
                      case ShareTypeSinaWeibo: { //腾讯账号绑定成功
                        YouGu_animation_Did_Start(@"新浪微" @"博"
                                                               @"账号绑定成"
                                                               @"功");
                      } break;
                      case ShareTypeTencentWeibo: { //腾讯账号绑定成功
                        YouGu_animation_Did_Start(@"腾讯微" @"博"
                                                               @"账号绑定成"
                                                               @"功");
                      } break;
                      default:
                        break;
                      }
                    } else if (state == SSAuthStateCancel) {
                      //取消腾讯账号绑定
                      YouGu_animation_Did_Start(@"绑定失败");
                    }
                    result(state);
                  }];
}
//取消微博账号绑定
+ (void)cancelAuthWithType:(ShareType)type {
  if (type) {
    switch (type) {
    case ShareTypeSinaWeibo: { //已解除新浪微博绑定
      YouGu_animation_Did_Start(@"已解除新浪微博绑定");
    } break;
    case ShareTypeTencentWeibo: { //已解除腾讯微博绑定
      YouGu_animation_Did_Start(@"已解除腾讯微博绑定");
    } break;
    case ShareTypeWeixiSession: { //已解除微信好友绑定
      YouGu_animation_Did_Start(@"已解除微信好友绑定");
    } break;
    case ShareTypeWeixiTimeline: { //已解除微信朋友圈绑定
      YouGu_animation_Did_Start(@"已解除微信朋友圈绑定");
    } break;
    case ShareTypeQQ: { //已解除QQ好友账号绑定
      YouGu_animation_Did_Start(@"已解除QQ好友账号绑定");
    } break;
    case ShareTypeQQSpace: { //已解除QQ空间账号绑定QQ
      YouGu_animation_Did_Start(@"已解除QQ空间账号绑定QQ");
    } break;
    default:
      break;
    }
    [ShareSDK cancelAuthWithType:type];
  }
}
///获取用户第三平台的基本信息
+ (void)getUserInfoWithType:(ShareType)shareType
                authOptions:(id<ISSAuthOptions>)authOptions
                     result:(FPShareUserInfoResult)resultValue {
  
  if (![WXApi isWXAppInstalled]&&shareType == ShareTypeWeixiSession) {
    YouGu_animation_Did_Start(@"微信未安装");
    resultValue(NO, nil);
    return;
  }
  if (![TencentOAuth iphoneQQInstalled]&& shareType == ShareTypeQQ) {
    YouGu_animation_Did_Start(@"QQ未安装");
    resultValue(NO, nil);
    return;
  }

  [ShareSDK
      getUserInfoWithType:shareType   //平台类型
              authOptions:authOptions //授权选项
                   result:^(BOOL result, id<ISSPlatformUser> userInfo,
                            id<ICMErrorInfo> error) { //返回回调
                     if (result) {
                       NSLog(@"成功");
                     } else {
                       if (error &&
                           [error respondsToSelector:@selector(
                                                         errorDescription)] &&
                           [[error errorDescription] length] > 0) {
                         //提示语，动画
                         YouGu_animation_Did_Start([error errorDescription]);
                       } else {
                         //提示语，动画
                         YouGu_animation_Did_Start(@"未授权");
                       }
                       NSLog(@"失败");
                     }
                     resultValue(result, userInfo);
                   }];
}
///是否绑定过微博
+ (BOOL)hasAuthorizedWithType:(ShareType)type {
  return [ShareSDK hasAuthorizedWithType:type];
}
#pragma mark - 默认内容
//默认内容
+ (id<ISSContent>)getShareContent {
  id<ISSContent> publishContent = nil;
  //    标题内容
  NSString *content_string = YouGu_defaults(@"content_title_news");
  if (content_string && [content_string length] == 0) {
    content_string = @"优顾理财——财知道";
  }
  //标题内容
  NSString *contentString = YouGu_StringWithFormat_double(
      YouGu_defaults(@"share_content_to_youguu"), YouGu_defaults(@"weburl"));
  NSString *imagePath =
      [[NSBundle mainBundle] pathForResource:@"Icon" ofType:@"png"];
  NSString *webUrl =
      [NSString stringWithFormat:@"%@", YouGu_defaults(@"weburl")];
  publishContent = [ShareSDK content:contentString
                      defaultContent:@""
                               image:[ShareSDK imageWithPath:imagePath]
                               title:content_string
                                 url:webUrl
                         description:@"优顾理财助手"
                           mediaType:SSPublishContentMediaTypeNews];
  //定制QQ空间信息
  [publishContent addQQSpaceUnitWithTitle:INHERIT_VALUE
                                      url:INHERIT_VALUE
                                     site:nil
                                  fromUrl:nil
                                  comment:INHERIT_VALUE
                                  summary:INHERIT_VALUE
                                    image:[ShareSDK imageWithPath:imagePath]
                                     type:INHERIT_VALUE
                                  playUrl:nil
                                     nswb:nil];
  //定制微信好友信息
  [publishContent addWeixinSessionUnitWithType:@(SSPublishContentMediaTypeNews)
                                       content:INHERIT_VALUE
                                         title:INHERIT_VALUE
                                           url:INHERIT_VALUE
                                         image:INHERIT_VALUE
                                  musicFileUrl:nil
                                       extInfo:nil
                                      fileData:nil
                                  emoticonData:nil];

  //定制微信朋友圈信息
  [publishContent addWeixinTimelineUnitWithType:@(SSPublishContentMediaTypeNews)
                                        content:INHERIT_VALUE
                                          title:INHERIT_VALUE
                                            url:INHERIT_VALUE
                                          image:INHERIT_VALUE
                                   musicFileUrl:nil
                                        extInfo:nil
                                       fileData:nil
                                   emoticonData:nil];
  //定制QQ分享信息
  [publishContent addQQUnitWithType:@(SSPublishContentMediaTypeNews)
                            content:INHERIT_VALUE
                              title:INHERIT_VALUE
                                url:INHERIT_VALUE
                              image:INHERIT_VALUE];
  return publishContent;
}

#pragma mark - 分享框设计
//分享框设计
+ (id<ISSShareOptions>)getShareOptions {
  id<ISSShareOptions> shareOptions =
      [ShareSDK defaultShareOptionsWithTitle:@"分享内容"
                             oneKeyShareList:nil
                          cameraButtonHidden:NO
                         mentionButtonHidden:NO
                           topicButtonHidden:NO
                              qqButtonHidden:NO
                       wxSessionButtonHidden:NO
                      wxTimelineButtonHidden:NO
                        showKeyboardOnAppear:NO
                           shareViewDelegate:nil
                         friendsViewDelegate:nil
                       picViewerViewDelegate:nil];

  return shareOptions;
}
#pragma mark - 分享到不同平台的方法
+ (void)contentShareTotype:(ShareType)aType {
  id<ISSContent> publishContent = [FPShareSDKUtil getShareContent];
  id<ISSShareOptions> shareOptions = [FPShareSDKUtil getShareOptions];
  [ShareSDK shareContent:publishContent
                    type:aType
             authOptions:[FPShareSDKUtil getAuthOptions]
            shareOptions:shareOptions
           statusBarTips:NO
                  result:^(ShareType type, SSResponseState state,
                           id<ISSPlatformShareInfo> statusInfo,
                           id<ICMErrorInfo> error, BOOL end) {
                    if (state == SSPublishContentStateSuccess) {
                      // 分享成功的，动画提示语
                      if (type) {
                        switch (aType) {
                        case ShareTypeSinaWeibo: { //新浪微博分享成功
                          YouGu_animation_Did_Start(@"新"
                                                    @"浪微博分享成功");
                        } break;
                        case ShareTypeTencentWeibo: { //腾讯微博分享成功
                          YouGu_animation_Did_Start(@"腾"
                                                    @"讯微博分享成功");
                        } break;
                        case ShareTypeWeixiSession: { //微信好友分享成功
                          YouGu_animation_Did_Start(@"微"
                                                    @"信好友分享成功");
                        } break;
                        case ShareTypeWeixiTimeline: { //微信朋友圈分享成功
                          YouGu_animation_Did_Start(@"微"
                                                    @"信朋友圈分享成功");
                        } break;
                        case ShareTypeQQ: { // QQ好友分享成功
                          YouGu_animation_Did_Start(@"QQ好友分享成功");
                        } break;
                        case ShareTypeQQSpace: { // QQ空间分享成功
                          YouGu_animation_Did_Start(@"QQ空间分享成功");
                        } break;
                        default:
                          break;
                        }
                      }
                    } else if (state == SSPublishContentStateFail) {
                      //分享失败的，动画提示语
                      YouGu_animation_Did_Start([error errorDescription]);
                    }
                  }];
}
@end

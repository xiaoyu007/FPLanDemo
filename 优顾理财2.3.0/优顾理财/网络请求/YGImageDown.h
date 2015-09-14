//
//
//  TrafficReport
//
//  Created by you yuling on 13-5-13.
//  Copyright (c) 2013年 Jamper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

typedef void (^IMAGE_Completion)(id response);

@interface YGImageDown : NSObject {
  UIImage *image_return;
}
@property(nonatomic, retain) UIImage *image_return;

+ (YGImageDown *)sharedManager;
///将图片的pathurl,转化成唯一表述的图片名称
- (NSString *)resultPicName:(NSString *)picUrl;
///沙盒路径下，是否有指定的图片(通过图片的唯一名称标示)
- (BOOL)isExistPathFile:(NSString *)picname;

///通过图片的url，block返回图片，并保存本地
- (void)add_image:(NSString *)pathurl completion:(IMAGE_Completion)completion;
///将nsdata 图片数据保存到本地
-(BOOL)savePhotoToNativeWithImage:(NSData *) imageData andPicName:(NSString *)name;
@end

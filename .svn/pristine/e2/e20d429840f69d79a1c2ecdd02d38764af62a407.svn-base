//
//
//  TrafficReport
//
//  Created by you yuling on 13-5-13.
//  Copyright (c) 2013年 Jamper. All rights reserved.
//

#import "YGImageDown.h"

static YGImageDown* _sharedManager = nil;

@implementation YGImageDown
@synthesize image_return;
+ (YGImageDown*)sharedManager {
  @synchronized([YGImageDown class]) {
    if (!_sharedManager)
      _sharedManager = [[self alloc] init];
    return _sharedManager;
  }
  return nil;
}

+ (id)alloc {
  @synchronized([YGImageDown class]) {
    NSAssert(_sharedManager == nil,
             @"Attempted to allocated a second instance__YGImageDown");
    _sharedManager = [super alloc];
    return _sharedManager;
  }
  return nil;
}

- (id)init {
  self = [super init];
  if (self) {
  }
  return self;
}

///将图片的pathurl,转化成唯一表述的图片名称
- (NSString*)resultPicName:(NSString*)picUrl {
  //获取图片存储在本地的名称
  NSString* label = @"://";

  NSRange foundObj =
      [picUrl rangeOfString:label options:NSCaseInsensitiveSearch];
  NSString* picName = @"";
  if (foundObj.length > 0) {
    picName = [[picUrl substringFromIndex:foundObj.location + 3]
        stringByReplacingOccurrencesOfString:@"/"
                                  withString:@"a"];
    picName =
        [picName stringByReplacingOccurrencesOfString:@"." withString:@"b"];
  }
  return picName;
}

///沙盒路径下，是否有指定的图片(通过图片的唯一名称标示)
- (BOOL)isExistPathFile:(NSString*)picname {
  NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                       NSUserDomainMask, YES);
  NSString* url_name =
      [NSString stringWithFormat:@"ALL_images_thing.xmly/%@", picname];
  //并给文件起个文件名
  NSString* uniquePath =
      [paths[0] stringByAppendingPathComponent:url_name];
  BOOL ishas = [[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
  return ishas;
}

- (void)add_image:(NSString*)pathurl completion:(IMAGE_Completion)completion {
  if (pathurl == nil) {
    self.image_return = nil;
    completion(nil);
  } else {
    pathurl = [pathurl
        stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //获取图片存储在本地的名称
    NSString* picName = [self resultPicName:pathurl];
    BOOL ishas = [self isExistPathFile:picName];
    if (ishas) {
      UIImage* image_s = [self getPhotoFromName:picName];
      if (image_s != nil) {
        self.image_return = image_s;
        completion(image_s);
      }
    } else {
      if (!YouGu_Wifi_Image) {
        completion(nil);
        return;
      }
      UIImageFromURL([NSURL URLWithString:pathurl],
                     ^(UIImage* image) {
                       if (image != nil) {
                         [self setPhotoToPath:image isName:picName];
                         completion(image);
                       }
                     },
                     ^(void){
                     });
    }
  }
}

///将nsdata 图片数据保存到本地
-(BOOL)savePhotoToNativeWithImage:(NSData *) imageData andPicName:(NSString *)name
{
  if (imageData && imageData.length>0) {
    //获取图片存储在本地的名称
    NSString* picName = [self resultPicName:name];
    //此处首先指定了图片存取路径（默认写到应用程序沙盒 中）
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                         NSUserDomainMask, YES);
    //并给文件起个文件名
    NSString* Name_image = [paths[0]
                            stringByAppendingPathComponent:
                            [NSString stringWithFormat:@"ALL_images_thing.xmly/%@",picName]];
    BOOL result = [imageData writeToFile:Name_image atomically:YES];
    if (result) {
      return YES;
    } else {
      return NO;
    }
  }
  NSLog(@"保存到本地的图片为空图片");
  return NO;
}



- (BOOL)setPhotoToPath:(UIImage*)image isName:(NSString*)name {
  //此处首先指定了图片存取路径（默认写到应用程序沙盒 中）
  NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                       NSUserDomainMask, YES);
  //并给文件起个文件名
  NSString* Name_image = [paths[0]
      stringByAppendingPathComponent:
          [NSString stringWithFormat:@"ALL_images_thing.xmly/%@", name]];
  NSData* data1 = UIImagePNGRepresentation(image);
  BOOL result = [data1 writeToFile:Name_image atomically:YES];
  if (result) {
    // nslog(@"success");
    return YES;
  } else {
    // nslog(@"no success");
    return NO;
  }
}

- (UIImage*)getPhotoFromName:(NSString*)name {
  NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                       NSUserDomainMask, YES);
  NSString* Name_image = [paths[0]
      stringByAppendingPathComponent:
          [NSString stringWithFormat:@"ALL_images_thing.xmly/%@", name]];
  BOOL blHave = [[NSFileManager defaultManager] fileExistsAtPath:Name_image];
  if (!blHave) {
    return nil;
  } else {
    //        NSData*data2=[NSData dataWithContentsOfFile:Name_image];
    //        UIImage*img=[[[UIImage alloc]initWithData:data2]autorelease];
    UIImage* img = [UIImage imageWithContentsOfFile:Name_image];

    return img;
  }
}
#pragma mark - 方法二
static void UIImageFromURL(NSURL* URL,
                           void (^imageBlock)(UIImage* image),
                           void (^errorBlock)(void)) {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                 ^(void) {
                   NSData* data = [[NSData alloc] initWithContentsOfURL:URL];
                   UIImage* image = [[UIImage alloc] initWithData:data];
                   dispatch_async(dispatch_get_main_queue(), ^(void) {
                     if (image != nil) {
                       imageBlock(image);
                     } else {
                       errorBlock();
                     }
                   });
                 });
}

@end

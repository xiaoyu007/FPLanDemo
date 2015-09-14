//
//  Json+Data_Nsstring.m
//  DDMenuController
//
//  Created by moulin wang on 13-8-13.
//
//

#import "Json+Data_Nsstring.h"

static Json_Data_Nsstring *_sharedManager = nil;
@implementation Json_Data_Nsstring

+ (Json_Data_Nsstring *)sharedManager {
  @synchronized([Json_Data_Nsstring class]) {
    if (!_sharedManager)
      _sharedManager = [[self alloc] init];
    return _sharedManager;
  }
  return nil;
}

+ (id)alloc {
  @synchronized([Json_Data_Nsstring class]) {
    NSAssert(_sharedManager == nil, @"Attempted to allocated a second instance");
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
//将json数据存入chche文件夹中collect_to_comly
- (void)json_data_chche_file:(NSData *)JsonData andfile_name:(NSString *)file_name {
  NSString *Json_path = pathInCacheDirectory([NSString stringWithFormat:@"Collection.xmly/%@", file_name]);
  //==写入文件
  [JsonData writeToFile:Json_path atomically:YES];
}

//将json数据存进本地cache文件夹
- (void)Json_To_File:(NSData *)JsonData andfile_name:(NSString *)file_name {
  NSString *Json_path = pathInCacheDirectory([NSString stringWithFormat:@"com.xmly/%@.json", file_name]);
  //==写入文件
  [JsonData writeToFile:Json_path atomically:YES];
}

//将从chche文件夹file中读出json数据
- (id)json_to_document_file:(NSString *)file_name {
  //==Json文件路径
  NSString *Json_path = pathInCacheDirectory([NSString stringWithFormat:@"Collection.xmly/%@", file_name]);
  NSData *data = [NSData dataWithContentsOfFile:Json_path];
  if (data) {
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (str) {
      NSDictionary *dic = [[CommonFunc textFromBase64String:str] objectFromJSONString];

      return dic;
    } else {
      return nil;
    }
  }
  return nil;
}
//将从chche文件夹中File中读出Json数据
- (id)Json_From_File:(NSString *)file_name {
  //==Json文件路径
  NSString *Json_path = pathInCacheDirectory([NSString stringWithFormat:@"com.xmly/%@.json", file_name]);
  //==Json数据
  NSData *data = [NSData dataWithContentsOfFile:Json_path];

  if (data) {
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (str) {
      NSDictionary *dic = [[CommonFunc textFromBase64String:str] objectFromJSONString];
      return dic;
    } else {
      return nil;
    }
  }
  return nil;
}
@end

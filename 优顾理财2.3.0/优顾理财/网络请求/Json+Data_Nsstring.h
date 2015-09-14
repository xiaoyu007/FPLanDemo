//
//  Json+Data_Nsstring.h
//  DDMenuController
//
//  Created by moulin wang on 13-8-13.
//
//

#import <Foundation/Foundation.h>
/**
 *  读取缓存数据
 */
@interface Json_Data_Nsstring : NSObject
+(Json_Data_Nsstring *)sharedManager;
//将从File中读出Json数据
-(id)Json_From_File:(NSString *)file_nam;
//将json数据存进本地文件夹
-(void)Json_To_File:(NSData *)JsonData andfile_name:(NSString *)file_name;

////将json数据存进本来document文件夹里面
//-(void)Json_To_Document_Fileandfile_name:(NSString *)file_name;
////将json数据存进本来cache文件夹里面
//-(void)Json_collect_to_comly_Fileandfile_name:(NSString *)file_name;

//将从chche文件夹file中读出json数据
//-(id)json_to_QU_LI_CAI_file:(NSString *)file_name;


//将json数据存入chche文件夹中
-(void)json_data_chche_file:(NSData *)JsonData andfile_name:(NSString *)file_name;
//将从Document文件夹file中读出json数据
-(id)json_to_document_file:(NSString *)file_name;
//将json数据存进本来cache文件夹里面
//-(void)Json_QU_LI_CAI_to_comly_Fileandfile_name:(NSString *)file_name;
@end

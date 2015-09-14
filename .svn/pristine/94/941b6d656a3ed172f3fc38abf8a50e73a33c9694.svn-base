//
//  event_view_log.h
//  DDMenuController
//
//  Created by moulin wang on 13-9-7.
//
//

#import <Foundation/Foundation.h>
#import "FMDatabaseAdditions.h"
#import "FMDatabase.h"

@interface event_view_log : NSObject {

  FMDatabase *_db;
  NSString *_name;

  NSString *my_event_id;
}
@property(nonatomic, retain) NSString *my_event_id;
+ (event_view_log *)sharedManager;
+ (id)alloc;
- (id)init;

// event事件
- (void)event_log:(NSString *)event_id;
@end

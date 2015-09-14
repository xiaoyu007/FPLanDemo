//
//  QuestionAnswerViewController.m
//  优顾理财
//
//  Created by Mac on 15/7/20.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

@interface QuestionAnswerViewController ()

@end

@implementation QuestionAnswerViewController
-(id)initWithFrame:(CGRect)frame andType:(UserListType)type andUid:(NSString *)userId
{
  self = [super initWithFrame:frame];
  if (self) {
    self.type = type;
    self.userId = userId;
    self.view.backgroundColor =[UIColor blueColor];
    self.isStatus = NO;
    refrash_is_have = NO;
    //    数据 数组
    _mainArray = [[NSMutableArray alloc] initWithCapacity:0];
    num = 0;
    _User_tableview = [[PullingRefreshTableView alloc]
                       initWithFrame:CGRectMake(0, 0, 320, self.childView.height)
                       pullingDelegate:self
                       andRefresh_id:YouGu_StringWithFormat_Third(@"UserListRefresh",
                                                                  [@(self.type) stringValue],_userId)];
    _User_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _User_tableview.backgroundColor = [UIColor clearColor];
    _User_tableview.dataSource = self;
    _User_tableview.delegate = self;
    _User_tableview.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.childView addSubview:_User_tableview];
    [self loadData_Cai];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

}
-(void)loadData_Cai
{
  if (1||self.type == QuestionType) {
    [QTRequestList getQTListWithUid:self.userId AndStart:num*20 WithComplemate:^(BaseResultType status,QTRequestList * listObject) {
      if (status == onSuccess) {
        if (num==0) {
          [self.mainArray removeAllObjects];
        }
        if (listObject.QTList.count>0) {
          [self.mainArray addObjectsFromArray:listObject.QTList];
        }
        [self.User_tableview reloadData];
      }
      else
      {
        num--;
      }
    }];
  }else{
    [AWRequestList getAWListWithUid:self.userId AndStart:num*20 WithComplemate:^(BaseResultType status,AWRequestList* listObject) {
      if (status == onSuccess) {
        if (num==0) {
          [self.mainArray removeAllObjects];
        }
        if (listObject.AWList.count>0) {
          [self.mainArray addObjectsFromArray:listObject.AWList];
        }
        [self.User_tableview reloadData];
      }
      else
      {
        num--;
      }
    }];
  }
}

#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView {
  if (YouGu_Not_NetWork == YES) {
    [_User_tableview tableViewDidFinishedLoading];
    return;
  }
  num = 0;
  [self performSelector:@selector(loadData_Cai) withObject:nil afterDelay:1.f];
}

- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView {
  if (YouGu_Not_NetWork == YES) {
    [_User_tableview tableViewDidFinishedLoading];
    return;
  }
  num++;
  if (num<0) {
    num=0;
  }
  [self performSelector:@selector(loadData_Cai)
             withObject:nil
             afterDelay:1.f];
}
//刷新结束后，更变，更新刷新时间
- (NSDate *)pullingTableViewRefreshingFinishedDate {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
  
  NSString * signLable = YouGu_StringWithFormat_Third(@"_refresh_time_date_UserListRefresh",[@(self.type) stringValue], self.userId);
  //    特点的一片文章的评论
  NSDate *date =
  [dateFormatter dateFromString:signLable];
  if (refrash_is_have) {
    date = [NSDate date];
    NSString *date_ttime = [dateFormatter stringFromDate:date];
    [YouGu_default
     setObject:date_ttime
     forKey:signLable];
    refrash_is_have = NO;
  }
  return date;
}
#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  //    任何情况下，下拉刷新，都是要可以的
  CGPoint offset = scrollView.contentOffset;
  if (offset.y < 0) {
    [_User_tableview tableViewDidScroll:scrollView];
    return;
  }
  
  //    其他情况，及，上拉刷新，是要再array_tableview数据不为0时，才可以刷新
  if ([self.mainArray count] < 20) {
    [_User_tableview My_add_hidden_view];
  } else if ([self.mainArray count] >= 20) {
    [_User_tableview My_add_cancel_hidden_view];
    [_User_tableview tableViewDidScroll:scrollView];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
  [_User_tableview tableViewDidEndDragging:scrollView];
}
#pragma mark - 计算cell的高度，和，html的形成
//计算cell的高度
- (CGFloat)set_Cell_Height:(NSInteger)row {
  RTLabel *rtLabel = [QATableViewCell textLabel];
  [rtLabel setFont:[UIFont systemFontOfSize:15.0f]];
  [rtLabel setText:[self set_html_text:row]];
  rtLabel.lineSpacing = 10.0f;
  CGSize optimumSize = [rtLabel optimumSize];
  
  return optimumSize.height;
}
//组成html，的文本，
- (NSString *)set_html_text:(NSInteger)row {
  QTRequestItem *qtItem =
  [self.mainArray objectAtIndex:row];
  
  NSString *Content_text_string = qtItem.userSummary;
  if ([qtItem.userBeNickname length] > 0) {
    Content_text_string = [NSString
                           stringWithFormat:
                           @"<font size=15><p><font color=#14a5f0>@%@:</font>%@</p></font>",
                           qtItem.userBeNickname, Content_text_string];
  }
  
  return Content_text_string;
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 60;
  return 60 + [self set_Cell_Height:indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  return 4;
  return [self.mainArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"QATableViewCell";
  QATableViewCell * cell =
  [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[QATableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                    reuseIdentifier:CellIdentifier];
  }
//  
//  if (indexPath.row == 0) {
//    [cell is_not_first_cell:YES];
//  } else {
//    [cell is_not_first_cell:NO];
//  }
//  
//  QTRequestItem * item = [self.mainArray objectAtIndex:indexPath.row];
//  
//  //    cell被选择一会的背景效果颜色
//  cell.Lable_time.text = item.userCreattime;
//  cell.Lable_context.text = [self set_html_text:indexPath.row];
//  [cell Cell_auto_height:[self set_Cell_Height:indexPath.row]];
  
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
  
  QTRequestItem *qtItem =
  [self.mainArray objectAtIndex:indexPath.row];
  
  //    获取talk_id
  [YouGu_default setObject:qtItem.aid forKey:@"Cai_NEWS_talk_id"];
  
  if ([_delegate respondsToSelector:@selector(selectCellWithNewsDetail)]) {
    [_delegate selectCellWithNewsDetail];
  }
  [tableView reloadData];
}


@end

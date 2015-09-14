//
//  KnowDetailTitleTableViewController.m
//  优顾理财
//
//  Created by Yuemeng on 15/9/9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "KnowDetailTitleTableViewController.h"
#import "KnowCommentViewTableViewCell.h"
#import "UserDetailViewController.h"

@implementation KnowDetailTableAdapter

- (NSString *)nibName {
  static NSString *nibFileName;
  if (nibFileName == nil) {
    nibFileName = NSStringFromClass([KnowCommentViewTableViewCell class]);
  }
  return nibFileName;
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 60 + [self set_Cell_Height:indexPath.row];
}

- (CGFloat)set_Cell_Height:(NSInteger)row {
  RTLabel *rtLabel = [KnowCommentViewTableViewCell textLabel];
  [rtLabel setText:[self set_html_text:row]];
  CGSize optimumSize = [rtLabel optimumSize];
  return optimumSize.height + 2;
}

- (NSString *)set_html_text:(NSInteger)row {
  NSString *content;
  if ([self.dataArray.array count] > row) {
    KnowDetailCommentItem *item = self.dataArray.array[row];
    content = [self changle_string:row];
    if ([item.slaveName length] > 0) {
      if (item.slaveName && [item.slaveRid intValue] > 0 &&
          ![item.slaveRid
              isEqualToString:self.headerItem.userListItem.userId]) {
        content = [NSString
            stringWithFormat:
                @"<p><font color=#14a5f0>回复%@:</font></p><p> %@</p>",
                item.slaveName, content];
      }
    }
  }
  return content;
}

- (NSString *)changle_string:(NSInteger)row {
  KnowDetailCommentItem *item = self.dataArray.array[row];

  //去掉字符串 头，尾，的空格和换行符
  [item.content stringByTrimmingCharactersInSet:
                    [NSCharacterSet whitespaceAndNewlineCharacterSet]];

  while ([[item.content componentsSeparatedByString:@"\n\n"] count] > 1) {
    item.content = [item.content stringByReplacingOccurrencesOfString:@"\n\n"
                                                           withString:@"\n"];
  }
  return item.content;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"KnowCommentViewTableViewCell";
  KnowCommentViewTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (self.dataArray.array.count > indexPath.row) {
    KnowDetailCommentItem *item = self.dataArray.array[indexPath.row];
    cell.userName.text = item.userListItem.nickName;
    cell.timeLable.text = item.creatTime;
    [cell.userPicHeaderImage down_pic:item.userListItem.headPic];
    cell.praiseAnimateLabel.hidden = YES;
    cell.userBtn.tag = 1000 + indexPath.row;
    [cell.userBtn addTarget:self
                     action:@selector(userClickBtn:)
           forControlEvents:UIControlEventTouchUpInside];
    cell.userPicHeaderImage.tag = 1000 + indexPath.row;
    cell.userPicHeaderImage.delegate = self;
    [cell.userPicHeaderImage downloadPic:item.userListItem.headPic
                                andVtype:[item.userListItem.vipType boolValue]];
    cell.praiseNum = [item.praiseNum intValue];
    BOOL ss = [[PraiseObject sharedManager] isDonePraise:item.talkid];
    [cell praiseBtnStatus:ss];
    cell.praiseBtn.tag = 3000 + indexPath.row;
    [cell.praiseBtn addTarget:self
                       action:@selector(praiseClickBtn:)
             forControlEvents:UIControlEventTouchUpInside];
    // cell的具体内容
    cell.commentLable.text = [self set_html_text:indexPath.row];
    cell.reviewBtn.tag = 2000 + indexPath.row;
    [cell.reviewBtn addTarget:self
                       action:@selector(reviewBtnClick:)
             forControlEvents:UIControlEventTouchUpInside];
  }
  return cell;
}

- (void)userClickBtn:(UIButton *)sender {
  [self picBtnClick:sender.tag];
}

- (void)picBtnClick:(NSInteger)index {
  if ([self.dataArray.array count] > index - 1000) {
    //    存入用户的id
    KnowDetailCommentItem *item = self.dataArray.array[index - 1000];
    if ([item.userListItem.userId length] > 0) {
      UserDetailViewController *userVC = [[UserDetailViewController alloc]
          initWithUserListItem:item.userListItem];
      [AppDelegate pushViewControllerFromRight:userVC];
    }
  }
}

- (void)praiseClickBtn:(UIButton *)sender {
  if (sender.selected == YES) {
    //提示语，动画
    YouGu_animation_Did_Start(@"该评论,您已经赞过！");
    return;
  }
  if ([self.dataArray.array count] > sender.tag - 3000) {
    KnowDetailCommentItem *item = self.dataArray.array[sender.tag - 3000];
    [[PraiseObject sharedManager] addPraise:2 andTalkId:item.talkid];
    HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
    __weak KnowDetailTableAdapter *weakSelf = self;
    callBack.onSuccess = ^(NSObject *obj) {
      KnowDetailTableAdapter *strongSelf = weakSelf;
      if (strongSelf) {
        sender.selected = NO;
        item.praiseNum =
            [NSString stringWithFormat:@"%d", [item.praiseNum intValue] + 1];
      }
    };
    [KnowCommentPraiseRequest getKnowCommentPraiseWithCommentId:item.talkid
                                                   withCallback:callBack];
  }
}

- (void)reviewBtnClick:(UIButton *)sender {
  [((KnowDetailTableViewController *)self.baseTableViewController)
      reviewBtnClick:sender];
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView reloadData];
}

@end

/**
 *  tableViewController
 */
@implementation KnowDetailTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableViewHeader =
      [[[NSBundle mainBundle] loadNibNamed:@"KnowDetailTableViewHeaderView"
                                     owner:self
                                   options:nil] firstObject];
  self.tableView.height -= tabbarHeight;

  //创建评论框
  [self creatBottomView];
  [self userLoadingView];
  //请求表头详细信息
  [self downMainNewsInfo];
  [self createTableFootView];
}

/** 表尾模块 */
- (void)createTableFootView {
  UIView *lineView = [[UIView alloc]
      initWithFrame:CGRectMake(16.0f, 0, windowWidth - 32.0f, 0.5f)];
  lineView.backgroundColor = [Globle colorFromHexRGB:lightCuttingLine];
  //向TA提问 按钮
  _footLabel =
      [[clickLabel alloc] initWithFrame:CGRectMake(0, 0, windowWidth, 100)];
  _footLabel.textAlignment = NSTextAlignmentCenter;
  _footLabel.text = @"还没有评论,快来抢沙发！";
  _footLabel.backgroundColor = [UIColor clearColor];
  _footLabel.textColor = [UIColor grayColor];
  _footLabel.highlightedTextColor = [Globle colorFromHexRGB:@"0077dc"];
  _footLabel.highlightedColor = [UIColor clearColor];
  _footLabel.font = [UIFont systemFontOfSize:15];
  [_footLabel addTarget:self action:@selector(Summit_btn_click)];
  [_footLabel addSubview:lineView];
  self.tableView.tableFooterView = nil;
}

- (void)Summit_btn_click {
  _commentBox.titleName.text =
      [NSString stringWithFormat:@"说说你对主贴的看法"];
  _iscommentBox = YES;
  //让textview，获得第一相应者
  _commentBox.hidden = NO;
  [_commentBox get_becomefirstResponder];
}

- (void)userLoadingView { //我要提问的 @“提交”是，屏蔽界面
  _userLoadingView = [[UserLoadingView alloc] initWithFrame:self.view.bounds];
  _userLoadingView.hidden = YES;
  _userLoadingView.alter_lable.text = @"正在提交……";
  _userLoadingView.userInteractionEnabled = YES;
  [self.view addSubview:_userLoadingView];
}

#pragma mark - 财知道 ，新闻正文页，包括用户基本信息，新闻详情信息，
//下载文章详情内容
- (void)downMainNewsInfo {
  if (self.talkId) {
    KnowDetailItem *item = [FileChangelUtil loadKnowDetailInfo:self.talkId];
    if (item) {
      self.headerItem = item;
      //访问成功
      [self.dataArray.array removeAllObjects];
      self.loading.hidden = YES;
      [_tableViewHeader getContentWithText:self.headerItem];
      self.tableView.tableHeaderView = _tableViewHeader;
    }
  }
  if ([FPYouguUtil isExistNetwork]) {
    [self downloadDetail];
  } else {
    if (self.headerItem) {
      self.loading.hidden = YES;
    } else {
      self.loading.hidden = NO;
    }
    [self.loading animationNoNetWork];
    _footLabel.hidden = YES;
    _bottomView.hidden = YES;
  }
}

- (void)downloadDetail {
  self.loading.hidden = NO;
  [self.loading animationStart];
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak KnowDetailTableViewController *weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    KnowDetailTableViewController *strongSelf = weakSelf;
    if (strongSelf) {
      //            [self.tableView tableViewDidFinishedLoading];
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onSuccess = ^(NSObject *obj) {
    KnowDetailTableViewController *strongSelf = weakSelf;
    if (strongSelf) {
      KnowDetailItem *object = (KnowDetailItem *)obj;
      [FileChangelUtil saveKnowDetailInfo:object andTalkID:self.talkId];
      self.loading.hidden = YES;
      self.headerItem = object;
      [_tableViewHeader getContentWithText:self.headerItem];
      self.tableView.tableHeaderView = _tableViewHeader;
      self.dataArray.dataComplete = NO;
      //            [self requestData];
    }
  };
  [KnowDetailItem getKnowDetailWithTalkId:self.talkId withCallback:callBack];
}

- (void)setHeaderItem:(KnowDetailItem *)headerItem {
  _headerItem = headerItem;
  [self creatNewsItem];
}

- (void)creatNewsItem {
  if (_headerItem) {
    NSString *title = self.headerItem.title;
    if (!title || title.length == 0) {
      title = _headerItem.summary;
    }
    if (title.length > 20) {
      title = [title substringToIndex:18];
    }
    if (!_newsItem) {
      _newsItem = [MyCollectItem creatMyCollectWithObject:self.talkId
                                                  AndType:2
                                                 andTitle:title];
    } else {
      _newsItem.title = title;
    }
  }
}

- (void)creatBottomView { //底部评论模块
  KnowBottomView *posts_list_CommentView = [[KnowBottomView alloc]
      initWithFrame:CGRectMake(0, self.view.height - tabbarHeight, windowWidth,
                               tabbarHeight)];
  posts_list_CommentView.delegate = self;
  posts_list_CommentView.autoresizingMask =
      UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:posts_list_CommentView];
  [self creatCommentBox];
}

- (void)CommentsTextOnPosts:(NSString *)text {
  _userLoadingView.hidden = NO;
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      YouGu_defaults_double(@"0", @"Start_Login_Sign");
      HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
      __weak KnowDetailTableViewController *weakSelf = self;
      callBack.onCheckQuitOrStopProgressBar = ^{
        KnowDetailTableViewController *strongSelf = weakSelf;
        if (strongSelf) {
          _userLoadingView.hidden = YES;
          return NO;
        } else {
          return YES;
        }
      };
      callBack.onSuccess = ^(NSObject *obj) {
        KnowDetailTableViewController *strongSelf = weakSelf;
        if (strongSelf) {
          if (_iscommentBox) {
            YouGu_animation_Did_Start(@"帖子评论成功");
          } else {
            YouGu_animation_Did_Start(@"帖子回复成功");
          }
          _commentBox.rightBtn.userInteractionEnabled = NO;
          _commentBox.mainTextview.text = nil;
          //                    self.refrashIndex = 0;
          //                    [self requestData];
          [[NSNotificationCenter defaultCenter]
              postNotificationName:@"RefrashKnowFirstList"
                            object:self.talkId];
        }
      };
      callBack.onError = ^(BaseRequestObject *err, NSException *ex) {
        if ([err.status isEqualToString:@"0410"]) {
          //            提问成功，审核中
          _commentBox.rightBtn.userInteractionEnabled = NO;
          _commentBox.mainTextview.text = nil;
        }
        [BaseRequester defaultErrorHandler](err, ex);
      };
      if (_iscommentBox) {
        [UserCommentKnowInfo commentTalk:self.talkId
                             andSlaveRid:self.headerItem.userListItem.userId
                            andsalveName:self.headerItem.userListItem.nickName
                              andContext:text
                            withCallback:callBack];

      } else {
        if ([self.dataArray.array count] > _selectedIndex) {
          KnowDetailCommentItem *item = self.dataArray.array[_selectedIndex];
          [UserCommentKnowInfo commentTalk:self.talkId
                               andSlaveRid:item.userListItem.userId
                              andsalveName:item.userListItem.nickName
                                andContext:text
                              withCallback:callBack];
        } else {
          NSLog(@"财知道回复评论时，数据越界");
        }
      }
    } else {
      _userLoadingView.hidden = YES;
      _commentBox.hidden = NO;
      [_commentBox get_becomefirstResponder];
    }
  }];
}

#pragma mark - loading 代理方法
- (void)refreshNewInfo {
  if ([FPYouguUtil isExistNetwork]) {
    [self downloadDetail];
  }
}

#pragma mark - 评论，代理方法
- (void)C_button_click:(UIButton *)sender {
  _commentBox.titleName.text =
      [NSString stringWithFormat:@"说说你对主贴的看法"];
  _iscommentBox = YES;
  //    让textview，获得第一相应
  _commentBox.hidden = NO;
  [_commentBox get_becomefirstResponder];
}

#pragma mark - 评论独立界面，第三方分享界面，设置更多节目
//创建评论框
- (void)creatCommentBox {
  _commentBox = [[[NSBundle mainBundle] loadNibNamed:@"CommentBox"
                                               owner:self
                                             options:nil] firstObject];
  _commentBox.delegate = self;
  _commentBox.userInteractionEnabled = YES;
  _commentBox.hidden = YES;
  [self.view addSubview:_commentBox];
  [self.view bringSubviewToFront:_commentBox];
}

/** 请求最新数据，此方法子类必须实现 */
- (void)requestDataListWithRefreshType:(RefreshType)refreshType
                         withDataArray:(DataArray *)existDataList
                          withCallBack:(HttpRequestCallBack *)callback {

  [KnowDetailCommentList
      getKnowDetailCommentListWithDic:
          [self getRequestParamertsWithRefreshType:refreshType]
                         withCallback:callback];
}

- (void)reviewBtnClick:(UIButton *)sender {
  if (self.dataArray.array.count > sender.tag - 2000) {
    //       表示点击了第几个用户的头像
    _selectedIndex = (int)sender.tag - 2000;
    KnowDetailCommentItem *item = self.dataArray.array[_selectedIndex];
    _iscommentBox = NO;
    _commentBox.titleName.text =
        [NSString stringWithFormat:@"回复:%@", item.userListItem.nickName];
    _commentBox.hidden = NO;
    [_commentBox get_becomefirstResponder];
  }
}

#pragma mark - 重写父类方法部分
- (NSDictionary *)getRequestParamertsWithRefreshType:(RefreshType)refreshType {
  NSString *start = @"0";

  if (refreshType == RefreshTypeLoaderMore) {
    start = [@((self.dataArray.array.count + 19) / 20) stringValue];
  }

  return @{ @"talkId" : _talkId, @"start" : start };
}

- (BOOL)isDataValidWithResponseObject:(NSObject<Collectionable> *)latestData
                withRequestParameters:(NSDictionary *)parameters
                      withRefreshType:(RefreshType)refreshType {
  if (refreshType == RefreshTypeLoaderMore) {
    if (((self.dataArray.array.count + 19) / 20) !=
        [parameters[@"start"] integerValue]) {
      return NO;
    }
  }
  return YES;
}

/** 返回表格数据适配器，此方法子类必须实现 */
- (BaseTableAdapter *)getBaseTableAdaperWithDataList:(DataArray *)dataList {
  if (_tableAdapter == nil) {
    _tableAdapter = [[KnowDetailTableAdapter alloc]
        initWithTableViewController:self
                      withDataArray:self.dataArray];
    UINib *cellNib = [UINib nibWithNibName:_tableAdapter.nibName bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:_tableAdapter.nibName];
    //        ((KnowDetailTableAdapter *)_tableAdapter).channlid =
    //        self.channlid;
  }
  return _tableAdapter;
}

- (NSString *)headerViewKey {
  return [
      [NSString stringWithFormat:@"KnowDetailViewController_%@", _talkId] copy];
}

- (void)bindRequestObject:(NSObject<Collectionable> *)latestData
    withRequestParameters:(NSDictionary *)parameters
          withRefreshType:(RefreshType)refreshType {
  [super bindRequestObject:latestData
      withRequestParameters:parameters
            withRefreshType:refreshType];
  if (self.dataArray.array.count == 0) {
    self.tableView.tableFooterView = _footLabel;
  } else {
    self.tableView.tableFooterView = nil;
  }
}

@end

/**
 *  titleTableViewController
 */
@implementation KnowDetailTitleTableViewController

- (id)initWithTalkId:(NSString *)talkid {

  if (self = [super init]) {
    self.talkId = talkid;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.topNavView.mainLableString = @"财知道";

  [self creatAddTopBtn];

  _tableVC = [[KnowDetailTableViewController alloc]
      initWithFrame:self.clientView.bounds];
  _tableVC.talkId = _talkId;
  [self.clientView addSubview:_tableVC.view];
  [self addChildViewController:_tableVC];
  [_tableVC refreshButtonPressDown];
}

//分享按钮
- (void)creatAddTopBtn { //向TA提问 按钮
  button_At = [UIButton buttonWithType:UIButtonTypeCustom];
  button_At.frame = CGRectMake(windowWidth - 60.0f, 0, 60.0f, 50.0f);
  [button_At setImage:[UIImage imageNamed:@"财知道_正文_分享"]
             forState:UIControlStateNormal];
  [button_At addTarget:self
                action:@selector(button_At_Click:)
      forControlEvents:UIControlEventTouchUpInside];
  button_At.imageEdgeInsets = UIEdgeInsetsMake(22.0f, 17.0f, 22.0f, 17.0f);
  UIImage *highlightImage =
      [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [button_At setBackgroundImage:highlightImage
                       forState:UIControlStateHighlighted];
  [self.topNavView addSubview:button_At];
}

#pragma mark - NEWS_Nav_View 自定义导航条 点击函数
- (void)button_At_Click:(UIButton *)sender {
  //    判断是否有网络
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  [self.view endEditing:NO];
  if (_tableVC.headerItem) {
    FPthirdShareView *shareView =
        [[[NSBundle mainBundle] loadNibNamed:@"FPthirdShareView"
                                       owner:self
                                     options:nil] firstObject];
    shareView.shareTitle = _tableVC.headerItem.title;
    shareView.shareContent = _tableVC.headerItem.summary;
    shareView.shareWebUrl = _tableVC.headerItem.rotShareUrl;
    shareView.type = 2;
    bool iSCollect =
        [[NewsWithDidCollect sharedManager] isCollectWithNewsID:_tableVC.newsItem];
    shareView.isCollect = iSCollect;
    shareView.delegate = self;
    shareView.userInteractionEnabled = YES;
    [self.view addSubview:shareView];
  } else {
    YouGu_animation_Did_Start(@"该帖已被删除");
  }
}
@end

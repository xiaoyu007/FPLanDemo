//
//  KnowDetailViewController.m
//  优顾理财
//
//  Created by Mac on 14-4-4.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//
#import "KnowDetailViewController.h"
#import "Json+Data_Nsstring.h"
#import "KnowCommentViewTableViewCell.h"
//数据库
#import "SQLDataHtmlstring.h"
//用户和他人主页
#import "UserDetailViewController.h"
//财知道跳资讯
#import "NewsDetailViewController.h"
#import "NoNetWorkViewController.h"
//用户评论登录界面
#import "ObjectJsonMappingUtil.h"
#import "PraiseObject.h"

@implementation KnowDetailViewController

- (id)initWithTalkId:(NSString *)talkid {
  NSString *key =
      [NSString stringWithFormat:@"KnowDetailViewController_%@", talkid];
  self = [super initWithRefreshLable:key];
  if (self) {
    self.talkId = talkid;
  }
  return self;
}
- (void)viewWillAppear:(BOOL)animated {
  if ([YouGu_defaults(@"Start_Login_Sign") intValue] == 1) {
    if (_commentBox != nil && [_commentBox.titleName.text length] > 0) {
      _commentBox.hidden = NO;
      [_commentBox get_becomefirstResponder];
    }
  }
  [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if (self.dataArray.array.count > 0) {
    [self.tableView reloadData];
  }
}
/** 注册NibCell **/
- (void)registerNibCell {
  UINib *cellNib = [UINib
      nibWithNibName:NSStringFromClass([KnowCommentViewTableViewCell class])
              bundle:nil];
  [self.tableView registerNib:cellNib
       forCellReuseIdentifier:@"KnowCommentViewTableViewCell"];
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.topNavView.mainLableString = @"财知道";
  selectedIndex = 0;
  refrash_is_have = NO;

  [self creatAddTopBtn];
  [self creatTableViewHeaderView];
  [self createTableFootView];
  [self creatBottomView];
  [self userLoadingView];
  [self registerNibCell];
  self.tableView.height -= 50;
  ///请求主贴信息
  [self downMainNewsInfo];
}

#pragma mark - NEWS_Nav_View 自定义导航条 点击函数
- (void)button_At_Click:(UIButton *)sender {
  //    判断是否有网络
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  [self.view endEditing:NO];
  if (self.headerItem) {
    FPthirdShareView *shareView =
        [[[NSBundle mainBundle] loadNibNamed:@"FPthirdShareView"
                                       owner:self
                                     options:nil] firstObject];
    shareView.shareTitle = self.headerItem.title;
    shareView.shareContent = self.headerItem.summary;
    shareView.shareWebUrl = self.headerItem.rotShareUrl;
    shareView.type = 2;
    bool iSCollect =
        [[NewsWithDidCollect sharedManager] isCollectWithNewsID:self.newsItem];
    shareView.isCollect = iSCollect;
    shareView.delegate = self;
    shareView.userInteractionEnabled = YES;
    [self.view addSubview:shareView];
  } else {
    YouGu_animation_Did_Start(@"该帖已被删除");
  }
}
#pragma mark - 初始化UI界面
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

- (void)userLoadingView { //我要提问的 @“提交”是，屏蔽界面
  User_loading = [[UserLoadingView alloc] initWithFrame:self.childView.bounds];
  User_loading.hidden = YES;
  User_loading.alter_lable.text = @"正在提交……";
  User_loading.userInteractionEnabled = YES;
  [self.childView addSubview:User_loading];
}

- (void)creatTableViewHeaderView {
  self.tableViewHeader =
      [[[NSBundle mainBundle] loadNibNamed:@"KnowDetailTableViewHeaderView"
                                     owner:self
                                   options:nil] firstObject];
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
  iscommentBox = YES;
  //让textview，获得第一相应者
  _commentBox.hidden = NO;
  [_commentBox get_becomefirstResponder];
}

#pragma mark - 评论，代理方法
- (void)C_button_click:(UIButton *)sender {
  _commentBox.titleName.text =
      [NSString stringWithFormat:@"说说你对主贴的看法"];
  iscommentBox = YES;
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
// _commentBox  代理
- (void)CommentsTextOnPosts:(NSString *)text {
  User_loading.hidden = NO;
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      YouGu_defaults_double(@"0", @"Start_Login_Sign");
      HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
      __weak KnowDetailViewController *weakSelf = self;
      callBack.onCheckQuitOrStopProgressBar = ^{
        KnowDetailViewController *strongSelf = weakSelf;
        if (strongSelf) {
          User_loading.hidden = YES;
          return NO;
        } else {
          return YES;
        }
      };
      callBack.onSuccess = ^(NSObject *obj) {
        KnowDetailViewController *strongSelf = weakSelf;
        if (strongSelf) {
          if (iscommentBox) {
            YouGu_animation_Did_Start(@"帖子评论成功");
          } else {
            YouGu_animation_Did_Start(@"帖子回复成功");
          }
          _commentBox.rightBtn.userInteractionEnabled = NO;
          _commentBox.mainTextview.text = nil;
          self.refrashIndex = 0;
          [self requestData];
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
      if (iscommentBox) {
        [UserCommentKnowInfo commentTalk:self.talkId
                             andSlaveRid:self.headerItem.userListItem.userId
                            andsalveName:self.headerItem.userListItem.nickName
                              andContext:text
                            withCallback:callBack];

      } else {
        if ([self.dataArray.array count] > selectedIndex) {
          KnowDetailCommentItem *item = self.dataArray.array[selectedIndex];
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
      User_loading.hidden = YES;
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
    [self.tableView tableViewDidFinishedLoading];
    _footLabel.hidden = YES;
    _bottomView.hidden = YES;
  }
}
//每次进来都去下载
- (void)downloadDetail {
  self.loading.hidden = NO;
  [self.loading animationStart];
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak KnowDetailViewController *weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    KnowDetailViewController *strongSelf = weakSelf;
    if (strongSelf) {
      [self.tableView tableViewDidFinishedLoading];
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onSuccess = ^(NSObject *obj) {
    KnowDetailViewController *strongSelf = weakSelf;
    if (strongSelf) {
      KnowDetailItem *object = (KnowDetailItem *)obj;
      [FileChangelUtil saveKnowDetailInfo:object andTalkID:self.talkId];
      self.loading.hidden = YES;
      self.headerItem = object;
      [_tableViewHeader getContentWithText:self.headerItem];
      self.tableView.tableHeaderView = _tableViewHeader;
      self.refrashIndex = 0;
      self.dataArray.dataComplete = NO;
      [self requestData];
    }
  };
  [KnowDetailItem getKnowDetailWithTalkId:self.talkId withCallback:callBack];
}
#pragma mark - 数据请求
- (void)returnBlock:(NSObject *)obj {
  KnowDetailCommentList *object = (KnowDetailCommentList *)obj;
  refrash_is_have = YES;
  self.loading.hidden = YES;

  if (self.headerItem) {
    if (self.refrashIndex == 0) {
      [self.dataArray.array removeAllObjects];
    }
    if (object.listArray.count > 0) {
      [self.dataArray.array addObjectsFromArray:object.listArray];
      self.tableView.tableFooterView = nil;
      //如果数据连一页都不到，则已全部请求完成
      if (object.listArray.count < 20) {
        self.dataArray.dataComplete = YES;
        self.tableView.footerView.state = kPRStateHitTheEnd;
      }
    } else {
      self.dataArray.dataComplete = YES;
      self.tableView.footerView.state = kPRStateHitTheEnd;
      if (self.dataArray.array.count == 0) {
        self.tableView.tableFooterView = _footLabel;
      } else {
        self.tableView.tableFooterView = nil;
      }
    }
    [_tableViewHeader getContentWithText:self.headerItem];
    self.tableView.tableHeaderView = _tableViewHeader;
    [self.tableView reloadData];
  }
}

- (void)requestData {
  refrash_is_have = NO;
  HttpRequestCallBack *callBack = [super getHttpCallBack];
  [KnowDetailCommentList
      getKnowDetailCommentListWithtalkId:self.talkId
                                andStart:[@(self.refrashIndex * 20) stringValue]
                            withCallback:callBack];
}
#pragma mark - 计算cell的高度，和，html的形成
//计算cell的高度
- (CGFloat)set_Cell_Height:(NSInteger)row {
  RTLabel *rtLabel = [KnowCommentViewTableViewCell textLabel];
  [rtLabel setText:[self set_html_text:row]];
  CGSize optimumSize = [rtLabel optimumSize];
  return optimumSize.height + 2;
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

//组成html，的文本，
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

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 60 + [self set_Cell_Height:indexPath.row];
}
- (NSInteger)tableView:(UITableView *)tableView
    indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 1;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  return self.dataArray.array.count;
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
    __weak KnowDetailViewController *weakSelf = self;
    callBack.onSuccess = ^(NSObject *obj) {
      KnowDetailViewController *strongSelf = weakSelf;
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

- (void)reviewBtnClick:(UIButton *)sender {
  if (self.dataArray.array.count > sender.tag - 2000) {
    //       表示点击了第几个用户的头像
    selectedIndex = (int)sender.tag - 2000;
    KnowDetailCommentItem *item = self.dataArray.array[selectedIndex];
    iscommentBox = NO;
    _commentBox.titleName.text =
        [NSString stringWithFormat:@"回复:%@", item.userListItem.nickName];
    _commentBox.hidden = NO;
    [_commentBox get_becomefirstResponder];
  }
}

#pragma mark RTLabel delegate
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL *)url {
  NewsDetailViewController *detailVC = [[NewsDetailViewController alloc]
      initWithChannlId:self.headerItem.rotNewsChannlid
             andNewsId:self.headerItem.rotNewsId
               Andxgsj:self.headerItem.rotNewsCreatTime];
  [AppDelegate pushViewControllerFromRight:detailVC];

  [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView reloadData];
}

#pragma 财知道主贴收藏
//收藏，代理
- (BOOL)Collect_NEWS:(BOOL)is_collect {
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      [self Collect_date];
    }
  }];
  return YES;
}
//收藏 数据
- (void)Collect_date {
  if (self.headerItem) {
    if (_newsItem) {
      if (![[NewsWithDidCollect sharedManager] isCollectWithNewsID:_newsItem]) {
        //实名，收藏新闻
        HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
        __weak KnowDetailViewController *weakSelf = self;
        callBack.onSuccess = ^(NSObject *obj) {
          KnowDetailViewController *strongSelf = weakSelf;
          if (strongSelf) {
            NewsCollectRequest *collectObject = (NewsCollectRequest *)obj;
            if (collectObject && collectObject.fid) {
              //财知道帖子收藏
              _newsItem.fid = collectObject.fid;
              [[NewsWithDidCollect sharedManager] addNewsId:_newsItem];
              //提示语，动画
              YouGu_animation_Did_Start(@"收藏成功");
            }
          }
        };
        [NewsCollectRequest getNewsCollectWithNewsId:self.talkId
                                        andNewsTitle:_newsItem.title
                                             andType:@"2"
                                        withCallback:callBack];
      } else {
        if (_newsItem && _newsItem.fid.length > 0) {
          //实名 ，取消收藏
          HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
          __weak KnowDetailViewController *weakSelf = self;
          callBack.onSuccess = ^(NSObject *obj) {
            KnowDetailViewController *strongSelf = weakSelf;
            if (strongSelf) { //取消收藏
              [[NewsWithDidCollect sharedManager] removeWithId:_newsItem];
            }
          };
          [NewsCollectRequest getNewsCollectWithFid:_newsItem.fid
                                       withCallback:callBack];
        } else { //取消收藏
          [[NewsWithDidCollect sharedManager] removeWithId:_newsItem];
        }
        YouGu_animation_Did_Start(@"已取消收藏");
      }
    }
  }
}
#pragma mark - 注销
- (void)dealloc {
  [self.view removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

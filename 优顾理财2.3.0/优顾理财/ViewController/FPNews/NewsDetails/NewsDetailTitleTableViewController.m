//
//  NewsDetailTitleTableViewController.m
//  优顾理财
//
//  Created by Yuemeng on 15/9/11.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "NewsDetailTitleTableViewController.h"
#import "CommentTableViewCell.h"
#import "RelatedArticlesTableViewCell.h"
#import "QAMyTalkRequestItem.h"
#import "UserDetailViewController.h"
#import "FPthirdShareView.h"
#import "NewsDetailNetWorkObject.h"
#import "FPwebViewController.h"

@implementation NewsDetailTableAdapter

//表格组个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

//各个组行个数
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
    return _relatedArray.count;
  } else {
    return self.dataArray.array.count;
  }
}

//头高度
- (CGFloat)tableView:(UITableView *)tableView
    heightForHeaderInSection:(NSInteger)section {
  if (_relatedArray.count == 0 && section == 0) {
    return 0.01f;
  }
  return 26.0f;
}

- (UIView *)tableView:(UITableView *)tableView
    viewForHeaderInSection:(NSInteger)section {

  if (!self.baseTableViewController.loading) {
    return nil;
  } else if (section == 0 && _relatedArray.count > 0 && !sectionView1) {
    sectionView1 = [[[NSBundle mainBundle] loadNibNamed:@"NewsHeaderView"
                                                  owner:self
                                                options:nil] firstObject];
    sectionView1.lableName.text = @"相关文章";
    return sectionView1;
  } else if (section == 1 && !sectionView2) {
    sectionView2 = [[[NSBundle mainBundle] loadNibNamed:@"NewsHeaderView"
                                                  owner:self
                                                options:nil] firstObject];
    sectionView2.lableName.text = @"用户评论";
    return sectionView2;
  }

  return nil;
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    return 30;
  } else if (indexPath.section == 1) {
    CGFloat height = [self set_Cell_Height:indexPath.row];
    return 60 + height;
  }
  return 0;
}

- (CGFloat)set_Cell_Height:(NSInteger)row {
  NewsOnlyCommentObject *onlyObject = self.dataArray.array[row];
  RTLabel *rtLabel = [CommentTableViewCell textLabel];
  [rtLabel setText:onlyObject.content];
  CGSize optimumSize = [rtLabel optimumSize];
  return optimumSize.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    static NSString *CellIdentifier1 = @"RelatedArticlesTableViewCell";
    RelatedArticlesTableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    NewsonlyRelatedObject *relatedObject = _relatedArray[indexPath.row];
    cell.titleLable.text = relatedObject.title;
    return cell;
  } else if (indexPath.section == 1) {
    static NSString *CellIdentifier2 = @"CommentTableViewCell";
    CommentTableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
    NewsOnlyCommentObject *onlyObject = self.dataArray.array[indexPath.row];
    cell.userName.text = onlyObject.userListItem.nickName;
    cell.userBtn.tag = 1000 + indexPath.row;
    cell.praiseAntiLabel.hidden = YES;
    [cell.userBtn addTarget:self
                     action:@selector(userClickBtn:)
           forControlEvents:UIControlEventTouchUpInside];
    cell.timeLable.text = onlyObject.creattime;
    cell.userPicHeaderImage.tag = 1000 + indexPath.row;
    cell.userPicHeaderImage.delegate = self;
    [cell.userPicHeaderImage
        downloadPic:onlyObject.userListItem.headPic
           andVtype:[onlyObject.userListItem.vipType boolValue]];
    cell.praiseNum = [onlyObject.praiseNum intValue];
    BOOL Ispraise =
        [[PraiseObject sharedManager] isDonePraise:onlyObject.commentId];
    [cell praiseBtnStatus:Ispraise];
    cell.praiseBtn.tag = 3000 + indexPath.row;
    [cell.praiseBtn addTarget:self
                       action:@selector(praiseClickBtn:)
             forControlEvents:UIControlEventTouchUpInside];
    // cell的具体内容
    [cell.commentLable setText:onlyObject.content];
    cell.reviewBtn.tag = 2000 + indexPath.row;

    if ([onlyObject.userListItem.userId isEqualToString:YouGu_User_USerid]) {
      [cell.reviewBtn setImage:[UIImage imageNamed:@"垃圾桶"]
                      forState:UIControlStateNormal];
      cell.reviewBtn.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 8, 7);
      _selectedIndex = cell.reviewBtn.tag;
    } else {
      [cell.reviewBtn setImage:[UIImage imageNamed:@"评论小图标"]
                      forState:UIControlStateNormal];
      cell.reviewBtn.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 8, 7);
    }

    [cell.reviewBtn addTarget:self
                       action:@selector(reviewBtnClick:)
             forControlEvents:UIControlEventTouchUpInside];
    return cell;
  }
  return nil;
}

- (void)userClickBtn:(UIButton *)sender {
  [self picBtnClick:sender.tag];
}

- (void)reviewBtnClick:(UIButton *)button {
  _reviewExist = NO;
  NewsOnlyCommentObject *onlyObject = self.dataArray.array[button.tag - 2000];
  if (button.tag - 2000 < self.dataArray.array.count) {
    if ([onlyObject.userListItem.userId isEqualToString:YouGu_User_USerid]) {
      [self showAlertView];
    } else {
      NewsOnlyCommentObject *onlyObject =
          self.dataArray.array[button.tag - 2000];
      NewsDetailTableViewController *superTableVC =
          (NewsDetailTableViewController *)self.baseTableViewController;
      superTableVC.commentBox.titleName.text = [NSString
          stringWithFormat:@"回复:%@", onlyObject.userListItem.nickName];
      superTableVC.becommentName = onlyObject.userListItem.nickName;
      superTableVC.commentBox.hidden = NO;
      superTableVC.becommentId = onlyObject.userListItem.userId;
      [superTableVC.commentBox get_becomefirstResponder];
    }
  }
}

- (void)showAlertView {

  UIAlertView *alertView =
      [[UIAlertView alloc] initWithTitle:@"删除提示"
                                 message:@"确定要删除此条目"
                                delegate:self
                       cancelButtonTitle:@"删除"
                       otherButtonTitles:@"取消", nil];
  [alertView show];
}

- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 0) {
    HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
    __weak NewsDetailTableAdapter *weakSelf = self;
    callBack.onSuccess = ^(NSObject *obj) {
      NewsDetailTableAdapter *strongSelf = weakSelf;
      if (strongSelf) {
        if (_selectedIndex - 2000 < [self.dataArray.array count]) {
          //数组清除对应数据
          [self.dataArray.array removeObjectAtIndex:_selectedIndex - 2000];

          double delayInSeconds = 0.5;
          dispatch_time_t popTime =
              dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
          dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
            [strongSelf.baseTableViewController refreshNewInfo];
              [strongSelf.baseTableViewController refreshButtonPressDown];
            [((NewsDetailTableViewController *)self.baseTableViewController)
                    .newsBottomView
                getlistNum:[@(self.dataArray.array.count) stringValue]];
            sectionView2.commentNum = (int)self.dataArray.array.count;
          });
        }
      }
    };

    NewsOnlyCommentObject *item =
        [self.dataArray.array objectAtIndex:_selectedIndex - 2000];
    [QAMyTalkRequestItem delegateNewsTalkWithTalkId:item.commentId
                                       withCallback:callBack];
  }
}

- (void)picBtnClick:(NSInteger)index {
  if (self.dataArray.array.count > index - 1000) {
    NewsOnlyCommentObject *onlyObject = self.dataArray.array[index - 1000];
    if ([onlyObject.userListItem.userId intValue] > 0) {
      UserDetailViewController *userVC = [[UserDetailViewController alloc]
          initWithUserListItem:onlyObject.userListItem];
      [AppDelegate pushViewControllerFromRight:userVC];
    } else {
      NSLog(@"新闻详情页评论用户的uid不对");
    }
  }
}

- (void)praiseClickBtn:(UIButton *)button {

  if (button.selected == YES) { //提示语，动画
    YouGu_animation_Did_Start(@"您已赞过了");
    return;
  } else {
    NewsOnlyCommentObject *onlyObject = self.dataArray.array[button.tag - 3000];
    HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
    __weak NewsDetailTableAdapter *weakSelf = self;
    callBack.onSuccess = ^(NSObject *obj) {
      NewsDetailTableAdapter *strongSelf = weakSelf;
      if (strongSelf) {
        button.selected = YES;
        [[PraiseObject sharedManager] addPraise:1
                                      andTalkId:onlyObject.commentId];
        onlyObject.praiseNum = [NSString
            stringWithFormat:@"%d", [onlyObject.praiseNum intValue] + 1];
      }
    };
    [NewsCommentpraiseRequest
        getNewsCommentPraiseRequest:((NewsDetailTableViewController *)
                                         self.baseTableViewController)
                                        .channlId
                          AndNewsid:((NewsDetailTableViewController *)
                                         self.baseTableViewController)
                                        .newsId
                         andReplyid:onlyObject.commentId
                       withCallback:callBack];
  }
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    NewsonlyRelatedObject *relateObject = _relatedArray[indexPath.row];
    NewsDetailTitleTableViewController *detailVC =
        [[NewsDetailTitleTableViewController alloc]
            initWithChannlId:relateObject.channlid
                   andNewsId:relateObject.newsId
                     Andxgsj:@"2"];
    [AppDelegate pushViewControllerFromRight:detailVC];
    [tableView reloadRowsAtIndexPaths:@[ indexPath ]
                     withRowAnimation:UITableViewRowAnimationNone];
  }
}

@end

/**
 *  tableViewController
 */
@implementation NewsDetailTableViewController

#pragma mark - pv, 选择正确的pvjiem
- (void)viewWillAppear:(BOOL)animated {
  NSString *start_login_sign = YouGu_defaults(@"Start_Login_Sign");
  if ([start_login_sign intValue] == 1) {
    if ([_commentBox.titleName.text length] > 0) {
      _commentBox.hidden = NO;
      [_commentBox get_becomefirstResponder];
    }
  }
  [super viewWillAppear:animated];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  _reviewExist = YES;
  _newsCollectItem =
      [MyCollectItem creatMyCollectWithObject:_newsId AndType:1 andTitle:@""];

  _relatedArray = [[NSMutableArray alloc] initWithCapacity:0];
  [self creatBottomView];
  [self creatTableViewHeader];
  [self creatTableFooterView];
  [self creatCommentBox];
  [self refreshNewInfo];
}

- (void)creatBottomView {
  //    自定义bottom
  _newsBottomView = [[[NSBundle mainBundle] loadNibNamed:@"NewsDetailBottomView"
                                                   owner:self
                                                 options:nil] firstObject];
  _newsBottomView.frame =
      CGRectMake(0, self.view.height - tabbarHeight, windowWidth, tabbarHeight);
  _newsBottomView.newsId = _newsId;
  _newsBottomView.channlId = _channlId;
  BOOL IsCollect =
      [[NewsWithDidCollect sharedManager] isCollectWithNewsID:_newsCollectItem];
  [_newsBottomView getCollectStatus:IsCollect];
  _newsBottomView.delegate = self;
  _newsBottomView.autoresizingMask =
      UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:_newsBottomView];
}

- (void)creatTableViewHeader {
  _webView = [[UIWebView alloc]
      initWithFrame:CGRectMake(0, 0, windowWidth, self.view.height - 50)];
  _webView.dataDetectorTypes = UIDataDetectorTypeNone;
  _webView.delegate = self;
  //防止头部和底部，在往外滑动
  [(UIScrollView *)[_webView subviews][0] setBounces:NO];
  ((UIScrollView *)[_webView subviews][0]).decelerationRate = 1.0;
  ((UIScrollView *)[_webView subviews][0]).scrollEnabled = NO;
  _webView.backgroundColor = [UIColor redColor];
  [_webView setOpaque:NO];
}

- (void)creatTableFooterView {
  _num = 0;
  //    向TA提问 按钮
  _clickLabel =
      [[clickLabel alloc] initWithFrame:CGRectMake(0, 0, windowWidth, 50)];
  _clickLabel.font = [UIFont systemFontOfSize:15];
  _clickLabel.textAlignment = NSTextAlignmentCenter;
  _clickLabel.text = @"还没有评论,快来抢沙发！";
  _clickLabel.backgroundColor = [UIColor clearColor];
  _clickLabel.textColor = [UIColor grayColor];
  _clickLabel.highlightedTextColor = [Globle colorFromHexRGB:@"0077dc"];
  _clickLabel.highlightedColor = [UIColor clearColor];
  [_clickLabel addTarget:self action:@selector(getReviewView)];
  self.tableView.tableFooterView = _clickLabel;
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
  __block NSString *content = text;
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      //判断用户是否以游客身份，评论
      YouGu_defaults_double(@"0", @"Start_Login_Sign");
      NSString *beUserid = @"-1";
      if (_reviewExist == NO) {
        content = [NSString
            stringWithFormat:@"##回复%@##:%@", _becommentName, content];
        beUserid = _becommentId;
      }
      HttpRequestCallBack *callback = [[HttpRequestCallBack alloc] init];
      __weak NewsDetailTableViewController *weakSelf = self;

      callback.onSuccess = ^(NSObject *obj) {
        NewsDetailTableViewController *strongSelf = weakSelf;
        if (strongSelf) {
          _commentBox.rightBtn.userInteractionEnabled = NO;
          _commentBox.mainTextview.text = nil;
          if (_reviewExist) { //提示语，动画
            YouGu_animation_Did_Start(@"评论成功");
          } else { //提示语，动画
            YouGu_animation_Did_Start(@"回复评论成功");
          }
          _commentNum =
              [NSString stringWithFormat:@"%d", [_commentNum intValue] + 1];
          self.isPush = YES;
          [strongSelf refreshButtonPressDown];
        }
      };
      callback.onError = ^(BaseRequestObject *obj, NSException *exc) {
        NewsDetailTableViewController *strongSelf = weakSelf;
        if (strongSelf) {
          if (obj.status &&
              [obj.status isEqualToString:@"0410"]) { //提问成功，审核中
            _commentBox.rightBtn.userInteractionEnabled = NO;
            _commentBox.mainTextview.text = nil;
            YouGu_animation_Did_Start(@"评论成功，待审核中");
          }
          [BaseRequester defaultErrorHandler](obj, exc);
        }
      };
      [NewsReviewRequest getRequestWithReply:_channlId
                                   andNewsId:_newsId
                                  andContent:content
                                 andBeUserid:beUserid
                                withCallback:callback];
    }
  }];
}

- (void)getReviewView {
  _commentBox.titleName.text =
      [NSString stringWithFormat:@"说说你对主贴的看法"];
  _commentBox.hidden = NO;
  [_commentBox get_becomefirstResponder];
}

- (void)refreshNewInfo {
  [self Loading_data];

  //如果不是离线阅读，进行网络请求
  if (!_isOfflineRead) {
    //    获取赞和评论个数
    [self getpraiseAndCommentNum];
    //    相关文章
    [self getRelatedRequest];
  }
}

#pragma mark -
- (void)requestDataListWithRefreshType:(RefreshType)refreshType
                         withDataArray:(DataArray *)existDataList
                          withCallBack:(HttpRequestCallBack *)callback {

  [NewsCommentListRequest
      getRequestWithDic:[self getRequestParamertsWithRefreshType:refreshType]
           withCallback:callback];
}

- (NSDictionary *)getRequestParamertsWithRefreshType:(RefreshType)refreshType {
  NSString *start = @"0";

  if (refreshType == RefreshTypeLoaderMore) {
    start = [@((self.dataArray.array.count + 19) / 20) stringValue];
  }

  return @{ @"channlid" : _channlId, @"newsid" : _newsId, @"start" : start };
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
    _tableAdapter = [[NewsDetailTableAdapter alloc]
        initWithTableViewController:self
                      withDataArray:self.dataArray];
    [self registerNibCell];
    //        ((SpecialTopicTableAdapter *)_tableAdapter).channlid =
    //        self.channlid;
  }
  return _tableAdapter;
}

#pragma mark - 注册NibCell
- (void)registerNibCell {
  UINib *cellNib = [UINib
      nibWithNibName:NSStringFromClass([RelatedArticlesTableViewCell class])
              bundle:nil];
  [self.tableView registerNib:cellNib
       forCellReuseIdentifier:@"RelatedArticlesTableViewCell"];

  UINib *commentCellNib =
      [UINib nibWithNibName:NSStringFromClass([CommentTableViewCell class])
                     bundle:nil];
  [self.tableView registerNib:commentCellNib
       forCellReuseIdentifier:@"CommentTableViewCell"];
}

- (NSString *)headerViewKey {
  return [[NSString stringWithFormat:@"NewsDetailVC_%@", _newsId] copy];
}

#pragma mark - bottom 底部 Delegate
- (void)BtnClickedWithIndex:(NewsBotttomStatus)index {
  switch (index) {
  case Newspraise: {
    //赞状态变化
    if (_praiseCallback) {
      _praiseCallback(YES);
    }
  } break;
  case NewsReview: {
    _reviewExist = YES;
    [self getReviewView];
  } break;
  case NewsList: {
    [self getNewsList];
  } break;
  case Newscollect: {
    if (_headerTableViewData) {
      [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
        if (logonSuccess) {
          [_newsBottomView collectBtnClick:logonSuccess];
          [_newsBottomView
              CollectNewsWithTitle:self.headerTableViewData.newsTitle];
        }
      }];
    } else {
      NSLog(@"文章还没加载出来");
    }
  } break;
  case NewsThirdShare: { //分享时使用

    if (![FPYouguUtil isExistNetwork]) {
      YouGu_animation_Did_Start(networkFailed);
      return;
    }
    FPthirdShareView *shareView =
        [[[NSBundle mainBundle] loadNibNamed:@"FPthirdShareView"
                                       owner:self
                                     options:nil] firstObject];
    shareView.shareTitle = self.headerTableViewData.newsTitle;
    shareView.shareContent = self.headerTableViewData.newsIntroduction;
    shareView.shareWebUrl = self.headerTableViewData.webUrl;
    shareView.type = 1;
    shareView.userInteractionEnabled = YES;
    [self.view addSubview:shareView];
  } break;
  default:
    break;
  }
}

//跳转到评论列表
- (void)getNewsList {
  if ([self.dataArray.array count] > 0) {
    [self.tableView
        scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]
              atScrollPosition:UITableViewScrollPositionTop
                      animated:NO];
  } else {
    self.tableView.contentOffset =
        CGPointMake(self.tableView.contentOffset.x,
                    self.tableView.contentSize.height - self.tableView.height);
  }
}

#pragma mark - 网络数据请求
- (void)Loading_data {
  if (_newsId) {
    NewsDetailRequest *item = [FileChangelUtil loadNewsDetailInfo:_newsId];
    if (item) {
      _newsCollectItem.title = item.newsTitle;
      _newsBottomView.IsCollect = [[NewsWithDidCollect sharedManager]
          isCollectWithNewsID:_newsCollectItem];
      self.headerTableViewData = item;
      [self refrashWebview:self.headerTableViewData];
      if (self.loading) {
        [self.tableView reloadData];
      }

      if ([self.xgsjTime isEqualToString:@"1"] ||
          [self.xgsjTime isEqualToString:item.xgsjTime]) {
        //标记已读
        NewsWithItem *newsItem = [[NewsWithItem alloc]
            initWithNewsId:[@([_newsId intValue]) stringValue]
                   andType:1];
        [[NewsIdWithDidRead sharedManager] addNewsId:newsItem];
        //        [FileChangelUtil saveNewsIDWithId:newsId];
        return;
      }
    }

    //如果是离线阅读，不进行网络请求
    if (!_isOfflineRead) {
      if (![self.xgsjTime isEqualToString:@"1"]) {
        ///从趣理财过来，不做网络请求
        if (![FPYouguUtil isExistNetwork]) {
          if (!item) {
            self.loading.hidden = NO;
            [self.loading animationNoNetWork];
          }
          return;
        }
        HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
        __weak NewsDetailTableViewController *weakSelf = self;

        callBack.onSuccess = ^(NSObject *obj) {
          NewsDetailTableViewController *strongSelf = weakSelf;
          if (strongSelf) {
            NewsDetailRequest *detailObject = (NewsDetailRequest *)obj;
            //保存新闻信息
            [FileChangelUtil saveNewsDetailInfo:detailObject andNewId:_newsId];
            //标记已读
            NewsWithItem *newsItem =
                [[NewsWithItem alloc] initWithNewsId:_newsId andType:1];
            [[NewsIdWithDidRead sharedManager] addNewsId:newsItem];

            self.headerTableViewData = detailObject;
            _newsCollectItem.title = detailObject.newsTitle;
            _newsBottomView.IsCollect = [[NewsWithDidCollect sharedManager]
                isCollectWithNewsID:_newsCollectItem];
            [self refrashWebview:self.headerTableViewData];
          }
        };
        [NewsDetailRequest getNewsDetailWithChannlid:_channlId
                                           AndNewsid:_newsId
                                        withCallback:callBack];
      }
    }
  }
}

- (void)refrashWebview:(NewsDetailRequest *)detailObject {
  if (!detailObject) {
    return;
  }
  if (detailObject.Photo_position == 233 && detailObject.originalUrl &&
      [detailObject.webUrl length] > 0) {
    _getTitleBlock(detailObject.originalUrl);
  }
  NSString *htmlStr = detailObject.webViewHtml;
  htmlStr =
      [htmlStr stringByReplacingOccurrencesOfString:@"${body_text_fontsize}"
                                         withString:YouGu_Font_text_Model];
  NSString *path = pathInCacheDirectory(@"Logo_PIC.xmly/");
  NSURL *baseURL = [NSURL fileURLWithPath:path];
  if (!YouGu_Wifi_Image) {
    htmlStr = [self flattenHTML:htmlStr trimWhiteSpace:NO];
  }
  [_webView loadHTMLString:htmlStr baseURL:baseURL];
}

- (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim {
  NSScanner *theScanner = [NSScanner scannerWithString:html];
  NSString *text = nil;

  while ([theScanner isAtEnd] == NO) {
    // find start of tag
    [theScanner scanUpToString:@"<a " intoString:NULL];
    // find end of tag
    [theScanner scanUpToString:@"</a>" intoString:&text];
    // replace the found tag with a space
    //(you can filter multi-spaces out later if you wish)
    html = [html stringByReplacingOccurrencesOfString:
                     [NSString stringWithFormat:@"%@</a>", text]
                                           withString:@""];
  }

  return trim ? [html stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]]
              : html;
}

#pragma mark - web_view  delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.loading.hidden = YES;
    CGRect frame = webView.frame;
    NSString *height_str =
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"];
    float height = [height_str floatValue];
    CGSize size = CGSizeMake(WIDTH_OF_SCREEN, height);
    frame.size = size;
    webView.frame = frame;
    //  header_tableView.height = height + 5;
    self.tableView.tableHeaderView = _webView;
    //  self.tableView.tableHeaderView = _headView;
    
    if (self.loading) {
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    }
}

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    return [NewsDetailNetWorkObject webviewStartLoadWithRequest:request
                                               andPhotoPosition:self.headerTableViewData.Photo_position
                                                    andDelegate:self];
}

- (void)willCreatWebview:(NSString *)urlstring {
    if (![FPYouguUtil isExistNetwork]) {
        YouGu_animation_Did_Start(networkFailed);
        return;
    }
    FPwebViewController *webVC =
    [[FPwebViewController alloc] initWithPathurl:urlstring andTitle:urlstring];
    [AppDelegate pushViewControllerFromRight:webVC];
}

#pragma mark - 更新赞数和评论数
//获取赞数和评论数
- (void)getpraiseAndCommentNum {
  if (!self.praiseNum) {
    HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
    __weak NewsDetailTableViewController *weakSelf = self;
    callBack.onSuccess = ^(NSObject *obj) {
      NewsDetailTableViewController *strongSelf = weakSelf;
      if (strongSelf) {
        NewspraiseNumAndCommentNumRequest *praiseObject =
            (NewspraiseNumAndCommentNumRequest *)obj;
        [_newsBottomView addpraiseNum:praiseObject.praiseNum];
        //      [newsBottomView getlistNum:praiseObject.commentNum];
      }
    };
    [NewspraiseNumAndCommentNumRequest
        getPraiseNumAndCommentNumWithChannlid:_channlId
                                    AndNewsId:_newsId
                                 withCallback:callBack];
  } else {
    [_newsBottomView addpraiseNum:self.praiseNum];
  }
}

//获取文章的相关链接
- (void)getRelatedRequest {
  //有离线状态，去掉了无网提示
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak NewsDetailTableViewController *weakSelf = self;

  callBack.onSuccess = ^(NSObject *obj) {
    NewsDetailTableViewController *strongSelf = weakSelf;
    if (strongSelf) {
      NewsRelatedArticlesRequest *relatedObject =
          (NewsRelatedArticlesRequest *)obj;
      if (relatedObject.listArray.count > 0) {
        [_relatedArray removeAllObjects];
        [_relatedArray addObjectsFromArray:relatedObject.listArray];
        if (self.loading) {
          [self.tableView reloadData];
        }
      }
    }
  };
  [NewsRelatedArticlesRequest getRelatedArticlesWithNewsid:_newsId
                                              withCallback:callBack];
}

//刷新数据
- (void)requestData {
  [self refreshButtonPressDown];
}

@end

/**
 *  titleTableViewController
 */
@implementation NewsDetailTitleTableViewController

- (id)initWithChannlId:(NSString *)localChannlid
             andNewsId:(NSString *)localNewsid
               Andxgsj:(NSString *)time {
  if (self = [super init]) {
    _channlId = localChannlid;
    _newsId = localNewsid;
    _xgsjTime = time;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.topNavView.mainLableString = @"优顾理财";

  _tableVC = [[NewsDetailTableViewController alloc]
      initWithFrame:self.clientView.bounds];
  _tableVC.channlId = _channlId;
  _tableVC.newsId = _newsId;
  _tableVC.xgsjTime = _xgsjTime;
  _tableVC.praiseCallback = _praiseCallback;
  _tableVC.isOfflineRead = _isOfflineRead;
  _tableVC.praiseNum = _praiseNum;

  __weak NewsDetailTitleTableViewController *weakSelf = self;
  _tableVC.getTitleBlock = ^(NSString *title) {
    weakSelf.topNavView.mainLableString = title;
  };

  [self.clientView addSubview:_tableVC.view];
  [self addChildViewController:_tableVC];
  [_tableVC refreshButtonPressDown];
}

@end

//
//  NewsDetailViewController1.m
//  优顾理财
//
//  Created by Mac on 15/8/26.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "CommentBox.h"
#import "PullingRefreshTableView.h"
#import "NewsDetailBottomView.h"
#import "CommentTableViewCell.h"
#import "RelatedArticlesTableViewCell.h"
#import "NewsHeaderView.h"
#import "FPwebViewController.h"
#import "MWPhotoBrowser.h"
#import "FPthirdShareView.h"
#import "PraiseObject.h"
#import "UserDetailViewController.h"
#import "NewsDetailNetWorkObject.h"
#import "QAMyTalkRequestItem.h"

@interface NewsDetailViewController () <CommentBoxDelegate, NewsDetailBottomViewDelegate, UITableViewDataSource, UITableViewDelegate,
                                        PullingRefreshTableViewDelegate, UIWebViewDelegate, MWPhotoBrowserDelegate> {
  ///是否显示评论框
  BOOL reviewExist;
  ///被评论用户的id
  NSString *becommentId;
  NSString *becommentName;
  ///加载页数
  int num;
  ///评论数
  NSString *commentNum;
  ///自定义底部评论按钮框
  NewsDetailBottomView *newsBottomView;
  ///抢沙发label
  clickLabel *foor_tableview;

  NewsHeaderView *sectionView1;
  NewsHeaderView *sectionView2;
  ///刷新是否结束
  BOOL refrashisFinished;
}
//@property(nonatomic, strong) PullingRefreshTableView* tableview;
@property(nonatomic, strong) NSMutableArray *relatedArray;
@property(nonatomic, strong) NSMutableArray *commentArray;
@property(nonatomic, strong) CommentBox *commentBox;
@property(nonatomic, strong) NewsDetailRequest *headerTableViewData;
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) UIView *headView;

@end

@implementation NewsDetailViewController
#pragma mark - 初始化
- (id)initWithChannlId:(NSString *)localChannlid
             andNewsId:(NSString *)localNewsid
               Andxgsj:(NSString *)time {
  NSString *refreshLable = [NSString stringWithFormat:@"NewsDetailVC_%@", localNewsid];
  self = [super initWithRefreshLable:refreshLable];
  if (self) {
    channlId = localChannlid;
    newsId = localNewsid;
    _xgsjTime = time;
  }
  return self;
}

//底部赞、评论、收藏等按钮
- (void)creatBottomView {
  //    自定义bottom
  newsBottomView = [[[NSBundle mainBundle] loadNibNamed:@"NewsDetailBottomView"
                                                  owner:self
                                                options:nil] firstObject];
  newsBottomView.frame = CGRectMake(0, self.view.height - tabbarHeight, windowWidth, tabbarHeight);
  newsBottomView.newsId = newsId;
  newsBottomView.channlId = channlId;
  BOOL IsCollect = [[NewsWithDidCollect sharedManager] isCollectWithNewsID:_newsCollectItem];
  [newsBottomView getCollectStatus:IsCollect];
  newsBottomView.delegate = self;
  newsBottomView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:newsBottomView];
}

- (void)creatTableView {
  num = 0;
  //  [self.tableView My_add_hidden_header_view];
  [self creatTableViewHeader];
  //    向TA提问 按钮
  foor_tableview = [[clickLabel alloc] initWithFrame:CGRectMake(0, 0, windowWidth, 50)];
  foor_tableview.font = [UIFont systemFontOfSize:15];
  foor_tableview.textAlignment = NSTextAlignmentCenter;
  foor_tableview.text = @"还没有评论,快来抢沙发！";
  foor_tableview.backgroundColor = [UIColor clearColor];
  foor_tableview.textColor = [UIColor grayColor];
  foor_tableview.highlightedTextColor = [Globle colorFromHexRGB:@"0077dc"];
  foor_tableview.highlightedColor = [UIColor clearColor];
  [foor_tableview addTarget:self action:@selector(getReviewView)];
  self.tableView.tableFooterView = foor_tableview;
  [self registerNibCell];
}

#pragma mark - 注册NibCell
- (void)registerNibCell {
  UINib *cellNib =
      [UINib nibWithNibName:NSStringFromClass([RelatedArticlesTableViewCell class]) bundle:nil];
  [self.tableView registerNib:cellNib forCellReuseIdentifier:@"RelatedArticlesTableViewCell"];

  UINib *commentCellNib =
      [UINib nibWithNibName:NSStringFromClass([CommentTableViewCell class]) bundle:nil];
  [self.tableView registerNib:commentCellNib forCellReuseIdentifier:@"CommentTableViewCell"];
}

- (void)creatTableViewHeader {
  _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, self.childView.height - 50)];
  _webView.dataDetectorTypes = UIDataDetectorTypeNone;
  _webView.delegate = self;
  //防止头部和底部，在往外滑动
  [(UIScrollView *)[_webView subviews][0] setBounces:NO];
  ((UIScrollView *)[_webView subviews][0]).decelerationRate = 1.0;
  ((UIScrollView *)[_webView subviews][0]).scrollEnabled = NO;
  _webView.backgroundColor = [UIColor redColor];
  [_webView setOpaque:NO];

  //  _headView = [[UIView alloc]initWithFrame:_webView.frame];
  //  _headView.backgroundColor = [UIColor yellowColor];
}
#pragma mark - 评论独立界面，第三方分享界面，设置更多节目
//创建评论框
- (void)creatCommentBox {
  _commentBox =
      [[[NSBundle mainBundle] loadNibNamed:@"CommentBox" owner:self options:nil] firstObject];
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
    if (logonSuccess) { //[YouGu_defaults(@"visitor_User") intValue] == 0
      //判断用户是否以游客身份，评论
      YouGu_defaults_double(@"0", @"Start_Login_Sign");
      NSString *beUserid = @"-1";
      if (reviewExist == NO) {
        content = [NSString stringWithFormat:@"##回复%@##:%@", becommentName, content];
        beUserid = becommentId;
      }
      HttpRequestCallBack *callback = [[HttpRequestCallBack alloc] init];
      __weak NewsDetailViewController *weakSelf = self;

      callback.onSuccess = ^(NSObject *obj) {
        NewsDetailViewController *strongSelf = weakSelf;
        if (strongSelf) {
          _commentBox.rightBtn.userInteractionEnabled = NO;
          _commentBox.mainTextview.text = nil;
          if (reviewExist) { //提示语，动画
            YouGu_animation_Did_Start(@"评论成功");
          } else { //提示语，动画
            YouGu_animation_Did_Start(@"回复评论成功");
          }
          commentNum = [NSString stringWithFormat:@"%d", [commentNum intValue] + 1];
          self.refrashIndex = 0;
          self.isPush = YES;
          [strongSelf getCommentList];
        }
      };
      callback.onError = ^(BaseRequestObject *obj, NSException *exc) {
        NewsDetailViewController *strongSelf = weakSelf;
        if (strongSelf) {
          if (obj.status && [obj.status isEqualToString:@"0410"]) { //提问成功，审核中
            _commentBox.rightBtn.userInteractionEnabled = NO;
            _commentBox.mainTextview.text = nil;
            YouGu_animation_Did_Start(@"评论成功，待审核中");
          }
          [BaseRequester defaultErrorHandler](obj, exc);
        }
      };
      [NewsReviewRequest getRequestWithReply:channlId
                                   andNewsId:newsId
                                  andContent:content
                                 andBeUserid:beUserid
                                withCallback:callback];
    }
  }];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  reviewExist = YES;
  // Do any additional setup after loading the view from its nib.
  _relatedArray = [[NSMutableArray alloc] initWithCapacity:0];
  _commentArray = [[NSMutableArray alloc] initWithCapacity:0];
  self.view.backgroundColor = [Globle colorFromHexRGB:customBGColor];
  self.topNavView.mainLableString = @"优顾理财";
  self.loading.hidden = NO;
  _newsCollectItem = [MyCollectItem creatMyCollectWithObject:newsId AndType:1 andTitle:@""];

  self.loading.height -= 50;
  [self creatTableView];
  [self creatBottomView];
  [self creatCommentBox];
  self.tableView.hidden = YES;
  self.tableView.height -= 50;
  self.tableView.headerView.hidden = YES;
  self.tableView.headerView = nil;
  [self refreshNewInfo];
}

- (void)refreshNewInfo {
  [self Loading_data];

  //如果不是离线阅读，进行网络请求
  if (!_isOfflineRead) {
    //    获取赞和评论个数
    [self getpraiseAndCommentNum];
    //    相关文章
    [self getRelatedRequest];
    //    用户评论
    [self getCommentList];
  }
}

- (void)refrashWebview:(NewsDetailRequest *)detailObject {
  if (!detailObject) {
    return;
  }
  if (detailObject.Photo_position == 233 && detailObject.originalUrl && [detailObject.webUrl length] > 0) {
    self.topNavView.mainLableString = detailObject.originalUrl;
  }
  NSString *htmlStr = detailObject.webViewHtml;
  htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"${body_text_fontsize}"
                                               withString:YouGu_Font_text_Model];
  NSString *path = pathInCacheDirectory(@"Logo_PIC.xmly/");
  NSURL *baseURL = [NSURL fileURLWithPath:path];
  if (!YouGu_Wifi_Image ) {
    htmlStr = [self flattenHTML:htmlStr trimWhiteSpace:NO];
  }
  [_webView loadHTMLString:htmlStr baseURL:baseURL];
}

-(NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim
{
  NSScanner *theScanner = [NSScanner scannerWithString:html];
  NSString *text = nil;
  
  while ([theScanner isAtEnd] == NO) {
    // find start of tag
    [theScanner scanUpToString:@"<a " intoString:NULL] ;
    // find end of tag
    [theScanner scanUpToString:@"</a>" intoString:&text] ;
    // replace the found tag with a space
    //(you can filter multi-spaces out later if you wish)
    html = [html stringByReplacingOccurrencesOfString:
            [ NSString stringWithFormat:@"%@</a>", text]
                                           withString:@""];
  }
  
  return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
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

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
  return _photos.count;
}
- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
  if (index < _photos.count)
    return _photos[index];
  return nil;
}
#pragma mark
#pragma mark UITableViewDataSource
//表格组个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}
//各个组行个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
    return _relatedArray.count;
  } else {
    return _commentArray.count;
  }
}
//头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (_relatedArray.count == 0 && section == 0) {
    return 0.01f;
  }
  return 26.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  if (!self.loading) {
    return nil;
  }
  if (section == 0 && _relatedArray.count > 0) {
    if (!sectionView1) {
      sectionView1 = [[[NSBundle mainBundle] loadNibNamed:@"NewsHeaderView"
                                                    owner:self
                                                  options:nil] firstObject];
      sectionView1.lableName.text = @"相关文章";
    }
    return sectionView1;
  }
  if (section == 1) {
    if (!sectionView2) {
      sectionView2 = [[[NSBundle mainBundle] loadNibNamed:@"NewsHeaderView"
                                                    owner:self
                                                  options:nil] firstObject];
      sectionView2.lableName.text = @"用户评论";
    }
    return sectionView2;
  }
  return nil;
}
//各个组里行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    return 30;
  } else if (indexPath.section == 1) {
    CGFloat height = [self set_Cell_Height:indexPath.row];
    return 60 + height;
  }
  return 0;
}
//计算cell的高度
- (CGFloat)set_Cell_Height:(NSInteger)row {
  NewsOnlyCommentObject *onlyObject = _commentArray[row];
  RTLabel *rtLabel = [CommentTableViewCell textLabel];
  [rtLabel setText:onlyObject.content];
  CGSize optimumSize = [rtLabel optimumSize];
  return optimumSize.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    static NSString *CellIdentifier1 = @"RelatedArticlesTableViewCell";
    RelatedArticlesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    NewsonlyRelatedObject *relatedObject = _relatedArray[indexPath.row];
    cell.titleLable.text = relatedObject.title;
    return cell;
  } else if (indexPath.section == 1) {
    static NSString *CellIdentifier2 = @"CommentTableViewCell";
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
    NewsOnlyCommentObject *onlyObject = _commentArray[indexPath.row];
    cell.userName.text = onlyObject.userListItem.nickName;
    cell.userBtn.tag = 1000 + indexPath.row;
    cell.praiseAntiLabel.hidden = YES;
    [cell.userBtn addTarget:self
                     action:@selector(userClickBtn:)
           forControlEvents:UIControlEventTouchUpInside];
    cell.timeLable.text = onlyObject.creattime;
    cell.userPicHeaderImage.tag = 1000 + indexPath.row;
    cell.userPicHeaderImage.delegate = self;
    [cell.userPicHeaderImage downloadPic:onlyObject.userListItem.headPic
                                andVtype:[onlyObject.userListItem.vipType boolValue]];
    cell.praiseNum = [onlyObject.praiseNum intValue];
    BOOL Ispraise = [[PraiseObject sharedManager] isDonePraise:onlyObject.commentId];
    [cell praiseBtnStatus:Ispraise];
    cell.praiseBtn.tag = 3000 + indexPath.row;
    [cell.praiseBtn addTarget:self
                       action:@selector(praiseClickBtn:)
             forControlEvents:UIControlEventTouchUpInside];
    // cell的具体内容
    [cell.commentLable setText:onlyObject.content];
    cell.reviewBtn.tag = 2000 + indexPath.row;
  
    if ([onlyObject.userListItem.userId isEqualToString:YouGu_User_USerid]) {
      [cell.reviewBtn setImage:[UIImage imageNamed:@"垃圾桶"] forState:UIControlStateNormal];
      cell.reviewBtn.imageEdgeInsets = UIEdgeInsetsMake(6,6,8,7);
      selectedIndex = cell.reviewBtn.tag;
    }else{
      [cell.reviewBtn setImage:[UIImage imageNamed:@"评论小图标"] forState:UIControlStateNormal];
      cell.reviewBtn.imageEdgeInsets = UIEdgeInsetsMake(6,6,8,7);
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
  reviewExist = NO;
  NewsOnlyCommentObject *onlyObject = _commentArray[button.tag-2000];
  if (button.tag - 2000 < _commentArray.count) {
    if ([onlyObject.userListItem.userId isEqualToString:YouGu_User_USerid]) {
      [self showAlertView];
    }else{
    NewsOnlyCommentObject *onlyObject = _commentArray[button.tag - 2000];
    _commentBox.titleName.text = [NSString stringWithFormat:@"回复:%@", onlyObject.userListItem.nickName];
    becommentName = onlyObject.userListItem.nickName;
    _commentBox.hidden = NO;
    becommentId = onlyObject.userListItem.userId;
    [_commentBox get_becomefirstResponder];
  }
  }
}
-(void)showAlertView{

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
  if (buttonIndex==0) {
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak NewsDetailViewController *weakSelf = self;
  callBack.onSuccess = ^(NSObject *obj) {
    NewsDetailViewController *strongSelf = weakSelf;
    if (strongSelf) {
      if (selectedIndex-2000 < [_commentArray count]) {
        //数组清除对应数据
        [_commentArray removeObjectAtIndex:selectedIndex-2000];
        
        double delayInSeconds = 0.5;
        dispatch_time_t popTime =
        dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
          [strongSelf refreshNewInfo];
          [strongSelf.tableView reloadData];
          [newsBottomView getlistNum:[@(_commentArray.count) stringValue]];
          sectionView2.commentNum = (int)_commentArray.count;
        });

      }
    }
  };

      NewsOnlyCommentObject *item =
      [_commentArray objectAtIndex:selectedIndex-2000];
      [QAMyTalkRequestItem delegateNewsTalkWithTalkId:item.commentId
                                         withCallback:callBack];
  }
}
- (void)picBtnClick:(NSInteger)index {
  if (_commentArray.count > index - 1000) {
    NewsOnlyCommentObject *onlyObject = _commentArray[index - 1000];
    if ([onlyObject.userListItem.userId intValue] > 0) {
      UserDetailViewController *userVC =
          [[UserDetailViewController alloc] initWithUserListItem:onlyObject.userListItem];
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
    NewsOnlyCommentObject *onlyObject = _commentArray[button.tag - 3000];
    HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
    __weak NewsDetailViewController *weakSelf = self;
    callBack.onSuccess = ^(NSObject *obj) {
      NewsDetailViewController *strongSelf = weakSelf;
      if (strongSelf) {
        button.selected = YES;
        [[PraiseObject sharedManager] addPraise:1 andTalkId:onlyObject.commentId];
        onlyObject.praiseNum = [NSString stringWithFormat:@"%d", [onlyObject.praiseNum intValue] + 1];
      }
    };
    [NewsCommentpraiseRequest getNewsCommentPraiseRequest:channlId
                                                AndNewsid:newsId
                                               andReplyid:onlyObject.commentId
                                             withCallback:callBack];
  }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    NewsonlyRelatedObject *relateObject = _relatedArray[indexPath.row];
    NewsDetailViewController *detailVC =
        [[NewsDetailViewController alloc] initWithChannlId:relateObject.channlid
                                                 andNewsId:relateObject.newsId
                                                   Andxgsj:@"2"];
    [AppDelegate pushViewControllerFromRight:detailVC];
    [tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
  }
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
    reviewExist = YES;
    [self getReviewView];
  } break;
  case NewsList: {
    [self getNewsList];
  } break;
  case Newscollect: {
    if (_headerTableViewData) {
      [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
        if (logonSuccess) {
          [newsBottomView collectBtnClick:logonSuccess];
          [newsBottomView CollectNewsWithTitle:self.headerTableViewData.newsTitle];
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
    FPthirdShareView *shareView = [[[NSBundle mainBundle] loadNibNamed:@"FPthirdShareView"
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
///评论
- (void)getReviewView {
  _commentBox.titleName.text = [NSString stringWithFormat:@"说说你对主贴的看法"];
  _commentBox.hidden = NO;
  [_commentBox get_becomefirstResponder];
}
//跳转到评论列表
- (void)getNewsList {
  if ([_commentArray count] > 0) {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:NO];
  } else {
    self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x,
                                               self.tableView.contentSize.height - self.tableView.height);
  }
}
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
#pragma mark - 网络数据请求
- (void)Loading_data {
  if (newsId) {
    NewsDetailRequest *item = [FileChangelUtil loadNewsDetailInfo:newsId];
    if (item) {
      _newsCollectItem.title = item.newsTitle;
      newsBottomView.IsCollect = [[NewsWithDidCollect sharedManager] isCollectWithNewsID:_newsCollectItem];
      [self.tableView tableViewDidFinishedLoading];
      self.headerTableViewData = item;
      [self refrashWebview:self.headerTableViewData];
      if (self.loading) {
        [self.tableView reloadData];
      }

      if ([self.xgsjTime isEqualToString:@"1"] || [self.xgsjTime isEqualToString:item.xgsjTime]) {
        //标记已读
        NewsWithItem *newsItem =
            [[NewsWithItem alloc] initWithNewsId:[@([newsId intValue]) stringValue] andType:1];
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
        __weak NewsDetailViewController *weakSelf = self;

        callBack.onSuccess = ^(NSObject *obj) {
          NewsDetailViewController *strongSelf = weakSelf;
          if (strongSelf) {
            NewsDetailRequest *detailObject = (NewsDetailRequest *)obj;
            //保存新闻信息
            [FileChangelUtil saveNewsDetailInfo:detailObject andNewId:newsId];
            //标记已读
            NewsWithItem *newsItem = [[NewsWithItem alloc] initWithNewsId:newsId andType:1];
            [[NewsIdWithDidRead sharedManager] addNewsId:newsItem];
            //            [FileChangelUtil saveNewsIDWithId:newsId];

            self.headerTableViewData = detailObject;
            _newsCollectItem.title = detailObject.newsTitle;
            newsBottomView.IsCollect = [[NewsWithDidCollect sharedManager] isCollectWithNewsID:_newsCollectItem];
            [self refrashWebview:self.headerTableViewData];
          }
        };
        [NewsDetailRequest getNewsDetailWithChannlid:channlId
                                           AndNewsid:newsId
                                        withCallback:callBack];
      }
    }
  }
}
#pragma mark - 更新赞数和评论数
//获取赞数和评论数
- (void)getpraiseAndCommentNum {
  if (!self.praiseNum) {
    HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
    __weak NewsDetailViewController *weakSelf = self;
    callBack.onSuccess = ^(NSObject *obj) {
      NewsDetailViewController *strongSelf = weakSelf;
      if (strongSelf) {
        NewspraiseNumAndCommentNumRequest *praiseObject = (NewspraiseNumAndCommentNumRequest *)obj;
        [newsBottomView addpraiseNum:praiseObject.praiseNum];
        //      [newsBottomView getlistNum:praiseObject.commentNum];
      }
    };
    [NewspraiseNumAndCommentNumRequest getPraiseNumAndCommentNumWithChannlid:channlId
                                                                   AndNewsId:newsId
                                                                withCallback:callBack];
  } else {
    [newsBottomView addpraiseNum:self.praiseNum];
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
  __weak NewsDetailViewController *weakSelf = self;

  callBack.onSuccess = ^(NSObject *obj) {
    NewsDetailViewController *strongSelf = weakSelf;
    if (strongSelf) {
      NewsRelatedArticlesRequest *relatedObject = (NewsRelatedArticlesRequest *)obj;
      if (relatedObject.listArray.count > 0) {
        [_relatedArray removeAllObjects];
        [_relatedArray addObjectsFromArray:relatedObject.listArray];
        if (self.loading) {
          [self.tableView reloadData];
        }
      }
    }
  };
  [NewsRelatedArticlesRequest getRelatedArticlesWithNewsid:newsId withCallback:callBack];
}

//刷新数据
- (void)requestData {
  [self getCommentList];
}
- (void)returnBlock:(NSObject *)obj {
  NewsCommentListRequest *commentObject = (NewsCommentListRequest *)obj;
  if (commentObject.commentList.count > 0) {
    if (self.refrashIndex == 0) {
      [_commentArray removeAllObjects];
    }
    [_commentArray addObjectsFromArray:commentObject.commentList];
    sectionView2.commentNum = (int)_commentArray.count;
    [newsBottomView getlistNum:[@(_commentArray.count) stringValue]];
    if (self.loading) {
      [self.tableView reloadData];
      if (_isPush) {
        [self getNewsList];
      }
    }
  } else if (commentObject.commentList.count == 0) {
    self.tableView.tableFooterView = foor_tableview;
    self.dataArray.dataComplete = YES;
    self.tableView.footerView.state = kPRStateHitTheEnd;
  }
  if (_commentArray.count == 0) {
    self.tableView.tableFooterView = foor_tableview;
  } else {
    self.tableView.tableFooterView = nil;
  }
}
//获取新闻的评论列表
- (void)getCommentList {
  //有离线状态，去掉了无网提示
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  HttpRequestCallBack *callBack = [super getHttpCallBack];
  [NewsCommentListRequest getRequestWithCommentList:channlId
                                          AndNewsId:newsId
                                        AndStartNum:[@(self.refrashIndex * 20) stringValue]
                                       withCallback:callBack];
}
@end

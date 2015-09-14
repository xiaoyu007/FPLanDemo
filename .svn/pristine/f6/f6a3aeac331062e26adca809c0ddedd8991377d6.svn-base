//
//  FPwebViewController.m
//  优顾理财
//
//  Created by Mac on 15/7/13.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPwebViewController.h"
#define HZFSystemVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
#define HZUIColorFromRGB(colorRed, colorGreen, colorBlue) \
  [UIColor colorWithRed:(colorRed) / 255.0                \
                  green:(colorGreen) / 255.0              \
                   blue:(colorBlue) / 255.0               \
                  alpha:1.0]
#define HZPNGIMAGE(NAME)            \
  [UIImage imageWithContentsOfFile: \
               [[NSBundle mainBundle] pathForResource:(NAME)ofType:@"png"]]

#define HZ_App_Frame_Height [[UIScreen mainScreen] applicationFrame].size.height
#define HZ_App_Frame_Width [[UIScreen mainScreen] applicationFrame].size.width

#define kNavBarHeight 44
#define kTooBarHeight 49
CGFloat const HZProgressBarHeight = 2.5;
NSInteger const HZProgresstagId = 222122323;

@implementation XToolBar
- (UIImage*)createImage:(UIColor*)color {
  CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);

  UIImage* theImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return theImage;
}
- (void)drawRect:(CGRect)rect {
}
@end
@interface FPwebViewController () {
  XToolBar* toolBar;
}
@property(nonatomic, strong) UIWebView* webView;
///1.新闻正文，跳转， 2.头页，跳转
@property(nonatomic) int type;
@property(strong, nonatomic) NSURL* URL;
@property(nonatomic, strong) NSString* pathUrl;
@property(nonatomic, strong) NSString* titleName;

@property(strong, nonatomic) UIBarButtonItem* stopLoadingButton;
@property(strong, nonatomic) UIBarButtonItem* reloadButton;
@property(strong, nonatomic) UIBarButtonItem* backButton;
@property(strong, nonatomic) UIBarButtonItem* forwardButton;
@end
@implementation FPwebViewController
- (id)initWithPathurl:(NSString*)pathurl {
  self = [super init];
  if (self) {
    self.type = 1;
    self.pathUrl = pathurl;
    self.URL = [NSURL URLWithString:pathurl];
  }
  return self;
}
- (id)initWithPathurl:(NSString*)pathurl andTitle:(NSString*)title {
  self = [super init];
  if (self) {
    self.type = 2;
    self.pathUrl = pathurl;

    self.URL = [NSURL URLWithString:pathurl];
    if (title) {
      self.titleName = title;
    }
  }
  return self;
}
- (void)load {
  if ([FPYouguUtil isExistNetwork]) {
    NSURLRequest* request = [NSURLRequest requestWithURL:self.URL];
    [self.webView loadRequest:request];
  } else {
    [self.loading animationNoNetWork];
  }
}
- (void)clear {
  [self.webView loadHTMLString:@"" baseURL:nil];
}
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [MobClick beginLogPageView:@"Extension_interface_view"];
  [[PV_view_sql sharedManager] PV_DB_DATA:@"Extension_interface_view"];
  if (self.URL) {
    [self load];
  }
}
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self clear];
  [self.webView stopLoading];
  self.webView.delegate = nil;
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
  [MobClick endLogPageView:@"Extension_interface_view"];
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.topNavView.mainLableString = self.titleName;
  // Do any additional setup after loading the view from its nib.
  _webView = [[UIWebView alloc]
      initWithFrame:CGRectMake(0, 0, 320, self.childView.height - kTooBarHeight)];
  _webView.backgroundColor = [UIColor clearColor];
  _webView.delegate = self;
  _webView.scalesPageToFit = YES;
  _webView.dataDetectorTypes = UIDataDetectorTypeNone;
  //    防止头部和底部，在往外滑动
  [(UIScrollView*) [_webView subviews][0] setBounces:YES];
  ((UIScrollView*) [_webView subviews][0]).decelerationRate = 1.0;
  [self.childView addSubview:_webView];
  [self setupToolBarItems];
}
- (UIImage*)leftTriangleImage {
  static UIImage* image;
  static dispatch_once_t predicate;
  dispatch_once(&predicate, ^{
    CGSize size = CGSizeMake(14.0f, 16.0f);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.0f, 8.0f)];
    [path addLineToPoint:CGPointMake(14.0f, 0.0f)];
    [path addLineToPoint:CGPointMake(14.0f, 16.0f)];
    [path closePath];
    [path fill];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  });
  return image;
}
- (UIImage*)rightTriangleImage {
  static UIImage* rightTriangleImage;
  static dispatch_once_t predicate;
  dispatch_once(&predicate, ^{
    UIImage* leftTriangleImage = [self leftTriangleImage];
    CGSize size = leftTriangleImage.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat x_mid = size.width / 2.0f;
    CGFloat y_mid = size.height / 2.0f;
    CGContextTranslateCTM(context, x_mid, y_mid);
    CGContextRotateCTM(context, M_PI);
    [leftTriangleImage drawAtPoint:CGPointMake((x_mid * -1), (y_mid * -1))];

    rightTriangleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  });
  return rightTriangleImage;
}
- (void)setupToolBarItems {
  toolBar = [[XToolBar alloc]
      initWithFrame:CGRectMake(0,self.childView.height - kTooBarHeight,
                               self.childView.width, kTooBarHeight)];
  [toolBar setBarStyle:UIBarStyleBlackTranslucent];
  toolBar.backgroundColor = [UIColor clearColor];
  [self.childView addSubview:toolBar];

  self.stopLoadingButton = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                           target:self.webView
                           action:@selector(stopLoading)];
  self.reloadButton = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                           target:self.webView
                           action:@selector(reload)];
  self.backButton =
      [[UIBarButtonItem alloc] initWithImage:[self leftTriangleImage]
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(goBack)];
  self.forwardButton =
      [[UIBarButtonItem alloc] initWithImage:[self rightTriangleImage]
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(goForward)];
  self.backButton.enabled = NO;
  self.forwardButton.enabled = NO;

  UIBarButtonItem* actionButton = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                           target:self
                           action:@selector(action:)];

  UIBarButtonItem* space_ = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                           target:nil
                           action:nil];
  space_.width = 38.0f;

  self.toolbarItems = @[
    space_,
    self.stopLoadingButton,
    space_,
    self.backButton,
    space_,
    self.forwardButton,
    space_,
    actionButton,
    space_
  ];
  [toolBar setItems:self.toolbarItems animated:YES];
}
- (void)goBack {
  [self.webView goBack];
}
- (void)goForward {
  [self.webView goForward];
}
#pragma mark - Button actions
- (void)action:(id)sender {
  UIActionSheet* moreSheet = [[UIActionSheet alloc]
               initWithTitle:nil
                    delegate:self
           cancelButtonTitle:@"取消"
      destructiveButtonTitle:nil
           otherButtonTitles:@"用Safari打开", @"复制链接", nil];
  [moreSheet showInView:self.view];
}
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet*)actionSheet
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  switch (buttonIndex) {
    case 0:
      [[UIApplication sharedApplication] openURL:self.URL];
      break;
    case 1: {
      UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
      pasteboard.string = self.URL.absoluteString;
    } break;
    default:
      break;
  }
}
#pragma mark
#pragma mark - webview 代理
- (void)webViewDidFinishLoad:(UIWebView*)webView {
  [self finishLoad];
  self.loading.hidden = YES;
  [webView stringByEvaluatingJavaScriptFromString:
               @"document.documentElement.style.webkitTouchCallout='none';"];
  if (self.type == 1) {
    self.titleName =
    [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.topNavView.mainLableString = self.titleName;
  }
  
}
#pragma mark - Web view delegate
- (BOOL)webView:(UIWebView*)webView
    shouldStartLoadWithRequest:(NSURLRequest*)request
                navigationType:(UIWebViewNavigationType)navigationType {
  if ([[request.URL absoluteString] hasPrefix:@"sms:"]) {
    [[UIApplication sharedApplication] openURL:request.URL];
    return NO;
  }
  if ([[request.URL absoluteString] hasPrefix:@"http://www.youtube.com/v/"] ||
      [[request.URL absoluteString] hasPrefix:@"http://itunes.apple.com/"] ||
      [[request.URL absoluteString] hasPrefix:@"https://itunes.apple.com/"] ||
      [[request.URL absoluteString] hasPrefix:@"http://phobos.apple.com/"]) {
    [[UIApplication sharedApplication] openURL:request.URL];
    return NO;
  }
  return YES;
}
- (void)webViewDidStartLoad:(UIWebView*)webView {
  self.loading.hidden = NO;
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
  [self toggleState];
}
- (void)webView:(UIWebView*)webView didFailLoadWithError:(NSError*)error {
  self.loading.hidden = YES;
  [self finishLoad];
}
- (void)toggleState {
  self.backButton.enabled = self.webView.canGoBack;
  self.forwardButton.enabled = self.webView.canGoForward;
  NSMutableArray* toolbarItems = [self.toolbarItems mutableCopy];
  if (self.webView.loading) {
    toolbarItems[1] = self.stopLoadingButton;
  } else {
    toolbarItems[1] = self.reloadButton;
  }
  NSArray* arry = [toolbarItems copy];
  self.toolbarItems = arry;
  [toolBar setItems:self.toolbarItems animated:YES];
}
- (void)finishLoad {
  [self toggleState];
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
  [self.view endEditing:NO];
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
@end

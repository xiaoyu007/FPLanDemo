//
//  EScrollerView.m
//  icoiniPad
//
//  Created by Ethan on 12-11-24.
//
//

#import "EScrollerView.h"
#import "YGImageDown.h"
#import "UIImageView+WebCache.h"

@implementation EScrollerView
- (void)dealloc {
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _header_array = [[NSMutableArray alloc] initWithCapacity:0];
    [self creatMainView];
  }
  return self;
}
-(void)creatMainView
{
  
//  self.userInteractionEnabled = YES;
  _scrollView = [[UIScrollView alloc]
                initWithFrame:CGRectMake(0, 0, self.frame.size.width,
                                         self.frame.size.height)];
  _scrollView.pagingEnabled = YES;
  _scrollView.showsHorizontalScrollIndicator = NO;
  _scrollView.showsVerticalScrollIndicator = NO;
  _scrollView.scrollsToTop = NO;
  _scrollView.delegate = self;
  _scrollView.scrollEnabled = NO;
  [self addSubview:self.scrollView];
  
  //说明文字层
  _noteView = [[UIView alloc]
                      initWithFrame:CGRectMake(0, self.bounds.size.height - 26,
                                               self.bounds.size.width, 26)];
  _noteView.layer.masksToBounds = YES;
  [_noteView
   setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
  [self addSubview:self.noteView];
//  [self bringSubviewToFront:self.noteView];

  _noteTitle = [[UILabel alloc]
               initWithFrame:CGRectMake(5, 1, self.frame.size.width - 15, 24)];
  _noteTitle.font = [UIFont fontWithName:@"BodoniSvtyTwoITCTT-Bold" size:15];
  [_noteTitle setBackgroundColor:[UIColor clearColor]];
  _noteTitle.textColor = [UIColor whiteColor];
  _noteTitle.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
  [self.noteView addSubview:self.noteTitle];

  self.pageControl = [[UIPageControl alloc]
                      initWithFrame:CGRectMake(self.frame.size.width, 0,0, 26)];
  self.pageControl.currentPage = 0;
  [self.noteView addSubview:self.pageControl];
}

- (void)change_images:(NSMutableArray*)array {
  if ([array count] > 0) {
    [self.scrollView removeAllSubviews];
    [self.header_array removeAllObjects];
    
    NSMutableArray* tempArray = [NSMutableArray arrayWithArray:array];
    NewsInChannelItem* item = array[array.count - 1];
    [tempArray insertObject:item atIndex:0];
    [tempArray addObject:array[0]];
    [self.header_array addObjectsFromArray:tempArray];

    NSUInteger pageCount = self.header_array.count;
    //        白色选择页
    float pageControlWidth = (pageCount - 2) * 10.0f + 40.f;
    self.scrollView.contentSize =
    CGSizeMake(self.frame.size.width * pageCount, self.frame.size.height);
    for (int i = 0; i < pageCount; i++) {
      [self have_not_image:i];
    }
    if ([self.header_array count] > 3) {
      self.scrollView.scrollEnabled = YES;
      self.pageControl.hidden = NO;
      self.pageControl.left = self.frame.size.width - pageControlWidth;
      self.pageControl.width = pageControlWidth;
      self.pageControl.numberOfPages = pageCount - 2;
    } else {
      self.scrollView.scrollEnabled = NO;
      self.pageControl.hidden = YES;
    }
    NewsInChannelItem* itemObject = self.header_array[1];
    [self.noteTitle setText:itemObject.title];
    [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0)];
  }
}
//无图模式
- (void)have_not_image:(int)i {
  NewsInChannelItem* item = self.header_array[i];

  UIImageView* imgView = [[UIImageView alloc] init];
  imgView.backgroundColor = [UIColor clearColor];
  [imgView setFrame:CGRectMake(self.frame.size.width * i, 0,
                               self.frame.size.width, self.frame.size.height)];
  if ([item.picImage hasPrefix:@"http://"]) {
    [imgView setImageWithURL:[NSURL URLWithString:item.picImage] placeholderImage:[UIImage imageNamed:@"首页默认图.png"]];
  }
  imgView.tag = i;
  UITapGestureRecognizer* Tap =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(imagePressed:)];
  [Tap setNumberOfTapsRequired:1];
  [Tap setNumberOfTouchesRequired:1];
  imgView.userInteractionEnabled = YES;
  [imgView addGestureRecognizer:Tap];

  [self.scrollView addSubview:imgView];
}
//裁剪图片uiimage
- (UIImage*)imageFromImage:(UIImage*)image inRect:(CGRect)rect {
  CGSize oldSize = CGSizeMake(320, 160);
  // Create a graphics image context
  UIGraphicsBeginImageContext(oldSize);

  // Tell the old image to draw in this new context, with the desired
  // new size
  [image drawInRect:rect];

  // Get the new image from the context
  UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();

  // End the context
  UIGraphicsEndImageContext();

  // Return the new image.
  return newImage;
}

- (void)scrollViewDidScroll:(UIScrollView*)sender {
  if ([self.header_array count] >=3) {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page =
        floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentPageIndex = page;

    self.pageControl.currentPage = (page - 1);

    int titleIndex = page;
    if (titleIndex > [self.header_array count] - 2) {
      titleIndex = 1;
    }
    if (titleIndex <= 0) {
      titleIndex = (int)[self.header_array count] - 2;
    }
    NewsInChannelItem* newsObject =
        self.header_array[titleIndex];
    [self.noteTitle setText:newsObject.title];
  }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView*)_scrollView {
  if ([self.header_array count] >= 3) {
    if (currentPageIndex == 0) {
      [self.scrollView
          setContentOffset:CGPointMake(([self.header_array count] - 2) *
                                           self.frame.size.width,
                                       0)];
    }
    if (currentPageIndex == ([self.header_array count] - 1)) {
      [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    }
  }
}

- (void)imagePressed:(UITapGestureRecognizer*)sender {
  if ([_delegate respondsToSelector:@selector(EScrollerViewDidClicked:)]) {
    [_delegate EScrollerViewDidClicked:sender.view.tag - 1];
  }
}
@end

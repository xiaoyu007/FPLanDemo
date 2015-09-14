//
//  Login_View.m
//  优顾理财
//
//  Created by Mac on 14/11/5.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

@implementation Login_View
@synthesize top_imageView;
@synthesize title_label;
@synthesize btn_Main;
@synthesize shadow_View;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame withImage:(NSString *)iconName {
  self = [super initWithFrame:frame];
  if (self) {
    btn_Main = [[UIButton alloc] initWithFrame:self.bounds];
    btn_Main.userInteractionEnabled = YES;
    [self addSubview:btn_Main];
    UIImage *higlightImage =
        [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
    [btn_Main setBackgroundImage:higlightImage
                        forState:UIControlStateHighlighted];

    //自适应图片
    UIImage *iconImage = [UIImage imageNamed:iconName];
    CGSize imageSize = iconImage.size;
    top_imageView = [[UIImageView alloc]
        initWithFrame:CGRectMake(
                          (frame.size.width - imageSize.width / 2.0f) / 2.0f,
                          (frame.size.height - 20 - imageSize.height / 2.0f) /
                              2.0f,
                          imageSize.width / 2.0f, imageSize.height / 2.0f)];
    top_imageView.userInteractionEnabled = NO;
    [self addSubview:top_imageView];

    title_label =
        [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 20,
                                                  self.size.width, 14)];
    title_label.userInteractionEnabled = NO;
    title_label.backgroundColor = [UIColor clearColor];
    title_label.textAlignment = NSTextAlignmentCenter;
    title_label.textColor = [UIColor whiteColor];
    title_label.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:title_label];

    shadow_View = [[UIView alloc] initWithFrame:self.bounds];
    shadow_View.userInteractionEnabled = YES;

    shadow_View.backgroundColor = [Globle colorFromHexRGB:@"111111"];
    shadow_View.alpha = 0.6;
    shadow_View.hidden = YES;
    [self addSubview:shadow_View];
  }

  return self;
}

@end

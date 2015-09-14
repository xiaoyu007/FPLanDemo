//
//  Click_Label.m
//  优顾理财
//
//  Created by Mac on 14-3-21.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//
//该类是自己封装的可以接受点击事件的控件

@implementation clickLabel
@synthesize imgView;
@synthesize NormalbackgroundColor;
@synthesize imgHighlightedColor;
@synthesize normalTextColor;


- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self setup];
  }
  return self;
}

- (id)init {
  if (self = [super init]) {
    [self setup];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    [self setup];
  }
  return self;
}

- (void)setImg_View:(UIImage *)img andFrame:(CGRect)frame {
  imgView.image = img;
  imgView.frame = frame;
}

- (void)setText:(NSString *)text andCenter:(CGPoint)center {
  [super setText:text];
  CGSize fontSize = [self.text sizeWithFont:self.font
                                   forWidth:200
                              lineBreakMode:NSLineBreakByTruncatingTail];
  [self setNumberOfLines:0];
  [self setFrame:CGRectMake(0, 0, fontSize.width, fontSize.height)];
  [self setCenter:center];
}

//专题名字过长，调整
- (void)adject_title_label_1:(NSString *)text {
  self.text = text;
  CGFloat width = [text sizeWithFont:self.font
                      constrainedToSize:CGSizeMake(220, self.height)
                          lineBreakMode:NSLineBreakByCharWrapping].width;
  self.width = width + 2;
}

- (void)setup {
  [self setUserInteractionEnabled:YES];
  _actionView = [[UIControl alloc] initWithFrame:self.bounds];
  [_actionView setBackgroundColor:[UIColor clearColor]];
  [_actionView addTarget:self
                  action:@selector(appendHighlightedColor)
        forControlEvents:UIControlEventTouchDown];
  [_actionView
             addTarget:self
                action:@selector(removeHighlightedColor)
      forControlEvents:UIControlEventTouchCancel | UIControlEventTouchUpInside |
                       UIControlEventTouchDragOutside |
                       UIControlEventTouchUpOutside];
  [self addSubview:_actionView];
  [self sendSubviewToBack:_actionView];

  imgView = [[UIImageView alloc] init];
  [self addSubview:imgView];
  
  self.imgHighlightedColor = [UIColor clearColor];
}

- (void)addTarget:(id)target action:(SEL)action {
  _actionView.tag = self.tag;
  [_actionView addTarget:target
                  action:action
        forControlEvents:UIControlEventTouchUpInside];
}

- (void)appendHighlightedColor {
  self.backgroundColor = buttonHighLightColor;

  imgView.backgroundColor = self.imgHighlightedColor;

  self.normalTextColor = self.textColor;
  self.textColor = self.highlightedTextColor;
}

- (void)removeHighlightedColor {
  self.textColor = self.normalTextColor;
  imgView.backgroundColor = [UIColor clearColor];
  if (self.NormalbackgroundColor) {
    self.backgroundColor = self.NormalbackgroundColor;
  } else {
    self.backgroundColor = [UIColor clearColor];
  }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

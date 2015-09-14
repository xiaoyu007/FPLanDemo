//
//  HeaderView.m
//  定制header
//
//  Created by Mac on 15/3/24.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//
/*
 功能介绍：该类是对“我的自选”类中tableHeaderView的封装,
 实现原理：把表头分成上下两部分，上部分显示基金的类别，下部分显示基金的具体条目。
         上部分为一个label，下部分是在一个label（A）上添加所需数目的label（B）用于展示具体条目。
          B与B之间的空隙所漏出的A的颜色即为分割线的颜色
 */
#import "YGTableHeaderView.h"

///分类名称控件的背景色
#define CATEGORY_NAME_LABEL_BG_CORLOR                                          \
  [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f]

///表头分割线的背景色（即表头背景色）
#define BREAK_LINE_BG_CORLOR                                                   \
  [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f]

//表头分割线的宽度
#define BREAK_LINE_WIDTH 1.0f

///表头中字体颜色
#define FONT_CORLOR                                                            \
  [UIColor colorWithRed:0.52f green:0.57f blue:0.62f alpha:1.00f]

///表头中字体的大小
#define YG_FONT_NUM 14

@implementation YGTableHeaderView
//为什么要先初始化父类
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  return self;
}

- (UIView *)creatTableHeaderViewWithCategoryName:(NSString *)categoryName
                                    andItemNames:(NSArray *)itemNames {
  //表头下半部分条目个数
  NSUInteger itemNum = [itemNames count];

  //表头上半部分
  UILabel *bgView0 = [[UILabel alloc]
      initWithFrame:CGRectMake(0, 0, self.frame.size.width,
                               self.frame.size.height * 3 / 7)];
  bgView0.backgroundColor = CATEGORY_NAME_LABEL_BG_CORLOR;
  bgView0.text = categoryName;
  bgView0.textColor = FONT_CORLOR;
  bgView0.font = [UIFont systemFontOfSize:YG_FONT_NUM];
  [self addSubview:bgView0];

  //表头下半部分
  UILabel *bgView1 = [[UILabel alloc]
      initWithFrame:CGRectMake(0, self.frame.size.height * 3 / 7,
                               self.frame.size.width,
                               self.frame.size.height * 4 / 7)];
  bgView1.backgroundColor = BREAK_LINE_BG_CORLOR;
  [self addSubview:bgView1];

  //表头下半部分中的各条目
  for (int i = 0; i < itemNum; i++) {
    int squareWidth =
        (self.frame.size.width - (itemNum + 1) * BREAK_LINE_WIDTH) / itemNum;

    UILabel *label = [[UILabel alloc]
        initWithFrame:CGRectMake(BREAK_LINE_WIDTH * (i + 1) + squareWidth * i,
                                 self.frame.size.height * 3 / 7, squareWidth,
                                 self.frame.size.height * 4 / 7 -
                                     BREAK_LINE_WIDTH)];
    label.backgroundColor = [UIColor whiteColor];
    label.text = itemNames[i];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = FONT_CORLOR;
    label.font = [UIFont systemFontOfSize:YG_FONT_NUM];
    [self addSubview:label];
  }
  return self;
}
@end

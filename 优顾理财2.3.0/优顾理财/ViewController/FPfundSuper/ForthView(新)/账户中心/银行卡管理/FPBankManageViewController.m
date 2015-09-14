//
//  BankManageViewController.m
//  优顾理财
//
//  Created by jhss on 15-4-13.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPBankManageViewController.h"
#import "FPAddBankCardViewController.h"
#import "FPBankManagerTableViewCell.h"
#import "UIImageView+WebCache.h"


@implementation FPBankManageViewController {

  IBOutlet UIButton *navBtn;
  IBOutlet UIButton *addBtn;
  UITableView *_tableView;
  UIView *cellView;
}
-(void)remove_to_before_VC{
  [self removeFromParentViewController];
}
- (void)viewDidLoad {
  [super viewDidLoad];
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(remove_to_before_VC) name:@"remove_to_before_VC" object:nil];
  
  self.childView.userInteractionEnabled = NO;
  [navBtn addTarget:self
                action:@selector(navigationBtn)
      forControlEvents:UIControlEventTouchUpInside];
  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"]
          forState:UIControlStateNormal];
  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"]
          forState:UIControlStateHighlighted];
  navBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);

  UIImage *highlightImage = [FPYouguUtil
      createImageWithColor:[Globle colorFromHexRGB:@"000000" withAlpha:0.1f]];
  [navBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];

  UIImage *highLightImage = [FPYouguUtil
      createImageWithColor:[Globle colorFromHexRGB:@"000000" withAlpha:0.1f]];
  [addBtn setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
  addBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
  _tableView = [[UITableView alloc]
                initWithFrame:CGRectMake(0, 71, windowWidth, windowHeight)];
  _tableView.delegate = self;
  _tableView.dataSource = self;
  
  [self.view addSubview:_tableView];

  ///设置表尾
  UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowWidth, windowHeight-_mutBankArray.count*50)];
  footerView.backgroundColor = [UIColor whiteColor];
  
  _tableView.tableFooterView = footerView;
  cellView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, windowWidth-30, 0.5)];
  cellView.backgroundColor = [Globle colorFromHexRGB:@"cfcfcf"];
  [footerView addSubview:cellView];
  
  if (_mutBankArray.count == 1) {
    // 隐藏cell的分割线
    cellView.hidden = YES;
  }
  if (_mutBankArray.count>1) {
    cellView.hidden = NO;
  }
}
#pragma mark--tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return _mutBankArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  static NSString *indent = @"cell";
  FPBankManagerTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:indent];

  if (!cell) {
    cell = [[FPBankManagerTableViewCell alloc]
          initWithStyle:UITableViewCellStyleDefault
        reuseIdentifier:indent];
  }

  FPCountCenterDeatilItem *item = _mutBankArray[indexPath.row];
  cell.bankNameLabel.text = item.name;

  NSString *str = [item.bankacco substringFromIndex:item.bankacco.length - 4];
  cell.bankNum.text = [NSString stringWithFormat:@"尾号%@", str];

  //网络获取
  [cell.bankImageView
      setImageWithURL:
          [NSURL URLWithString:
                     [NSString stringWithFormat:@"%@%@",
                                                IP_HTTP,item.logo]]];
  
  [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 15)];
cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
  return cell;
}
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {

  return 50;
}

//返回按钮事件
- (void)navigationBtn {
  [self.navigationController popViewControllerAnimated:YES];
}
//添加按钮事件
- (IBAction)addBtn:(id)sender {
  FPAddBankCardViewController *addBankVC =
      [[FPAddBankCardViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:addBankVC];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end

//
//  UIViewController+RecursiveDescription.m
//  SimuStock
//
//  Created by Mac on 15/2/13.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

@implementation UIViewController (RecursiveDescription)

/** 打印当前的UIViewController的层次关系 */
- (NSString *)recursiveDescription {
  NSMutableString *description = [NSMutableString stringWithFormat:@"\n"];
  [self addDescriptionToString:description indentLevel:0];
  return description;
}

- (void)addDescriptionToString:(NSMutableString *)string
                   indentLevel:(NSInteger)indentLevel {
  NSString *padding = [@"" stringByPaddingToLength:indentLevel
                                         withString:@" "
                                    startingAtIndex:0];
  [string appendString:padding];
  //打印当前ViewController的名字和frame大小
  [string appendFormat:@"%@, %@", [self debugDescription],
                       NSStringFromCGRect(self.view.frame)];
  
  //打印所有子ViewController的信息，缩进增加1
  for (UIViewController *childController in self.childViewControllers) {
    [string appendFormat:@"\n%@>", padding];
    [childController addDescriptionToString:string indentLevel:indentLevel + 1];
  }
}

@end

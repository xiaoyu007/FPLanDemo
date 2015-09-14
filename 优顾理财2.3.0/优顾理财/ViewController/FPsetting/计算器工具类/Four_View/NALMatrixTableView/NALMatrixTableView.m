//
//  NALMatrixTableView.m
//  优顾理财
//
//  Created by Mac on 14/11/20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "NALMatrixTableView.h"
#import "NALLabelsMatrix.h"

@implementation NALMatrixTableView

- (id)initWithFrame:(CGRect)frame
            andArray:(NSArray *)array
    andColumnsWidths:(NSArray *)columns {
  self = [super initWithFrame:frame];
  if (self) {
    [self NaL_Matrix_array:array andColumnsWidths:columns];
  }
  return self;
}

- (void)NaL_Matrix_array:(NSArray *)array andColumnsWidths:(NSArray *)columns {
  if ([array count] > 0) {
    [self removeAllSubviews];
    self.height = [array count] * 30;
    NALLabelsMatrix *matrix_3 =
        [[NALLabelsMatrix alloc] initWithFrame:self.bounds
                              andColumnsWidths:columns];
    for (NSArray *mid_array in array) {
      [matrix_3 addRecord:mid_array];
      [self addSubview:matrix_3];
    }
  }
}
@end

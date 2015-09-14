//
//  LRGlowingButton.h
//
//  Created by Nikita Lutsenko on 3/13/13.
//  Copyright (c) 2013 lightroomapps. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 光晕效果 */
@interface LRGlowingButton : UIButton
/** '光晕' */
@property(nonatomic, assign) BOOL glowsWhenHighlighted;
/** 光晕色值 */
@property(nonatomic, retain) UIColor *highlightedGlowColor;

@end

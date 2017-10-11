//
//  HIDashLineButton.h
//  HIDashLineButton
//
//  Created by HIIgor on 16/3/17.
//  Copyright © 2016 HIIgor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HIDashLineButton : UIButton

+ (instancetype)dashLineBorderButtonWithPattern:(NSArray <NSNumber *>*)lineDashPattern strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)cornerRadius;
- (instancetype)initWithPattern:(NSArray <NSNumber *>*)lineDashPattern strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)cornerRadius;

@end

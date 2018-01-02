//
//  WBAppearance.m
//  CRInputViewSample
//
//  Created by chris on 2017/12/29.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "WBAppearance.h"

@interface WBAppearance()

@end

@implementation WBAppearance

- (UIEdgeInsets)growingTextViewEdgeInset
{
    return UIEdgeInsetsMake(10, 10, 54, 50);
}

- (UIReturnKeyType)returnKeyType
{
    return UIReturnKeyDone;
}

- (NSInteger)maxNumberOfLines
{
    return 4;
}

- (NSInteger)minNumberOfLines
{
    return 3;
}

- (NSAttributedString *)placeHolder
{
    return [[NSAttributedString alloc] initWithString:@"请输入文本"];
}

- (UIColor *)inputViewBackgroundColor
{
    return [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
}

- (UIFont *)inputFont
{
    return [UIFont systemFontOfSize:14.f];
}

- (UIColor *)textViewBackgroundColor
{
    return [UIColor yellowColor];
}

- (void)didSetupToolBar:(UIView *)toolBar
{
    self.actionBar = [[WBInputActionBar alloc] initWithFrame:CGRectZero];
    [toolBar addSubview:self.actionBar];
}


- (void)didResizeToolBar:(UIView *)toolBar
{
    CGFloat bottom = 0.f;
    CGFloat height  = 44.f;
    CGFloat left  = 0.f;
    CGFloat right = 0.f;
    
    CGFloat originX = left;
    CGFloat originY = toolBar.frame.size.height - bottom - height;
    CGFloat width   = toolBar.frame.size.width  - left - right;
    
    CGRect frame = {originX,originY,width,height};
    self.actionBar.frame = frame;
}

@end


@implementation WBInputActionBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

@end

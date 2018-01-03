//
//  WBAppearance.m
//  CRInputViewSample
//
//  Created by chris on 2017/12/29.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "WBAppearance.h"

#define WBA_UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define WBA_UIColorFromRGB(rgbValue) WBA_UIColorFromRGBA(rgbValue, 1.0)

@interface WBAppearance()

@end

@implementation WBAppearance

- (UIEdgeInsets)growingTextViewEdgeInset
{
    return UIEdgeInsetsMake(10, 10, 46, 50);
}

- (UIReturnKeyType)returnKeyType
{
    return UIReturnKeyDone;
}

- (CGFloat)textViewCornerRadius
{
    return 2.f;
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
    return [[NSAttributedString alloc] initWithString:@"写评论" attributes:@{NSForegroundColorAttributeName:WBA_UIColorFromRGB(0x9b9b9b)}];
}

- (UIColor *)inputViewBackgroundColor
{
    return WBA_UIColorFromRGBA(0x0,.3);
}


- (UIColor *)toolBarBackgroundColor
{
    return WBA_UIColorFromRGB(0xf9f9f9);
}

- (UIFont *)inputFont
{
    return [UIFont systemFontOfSize:14.f];
}

- (UIColor *)textViewBackgroundColor
{
    return [UIColor whiteColor];
}

- (void)didSetupToolBar:(UIView *)toolBar
{
    self.actionBar = [[WBInputActionBar alloc] initWithFrame:CGRectZero];
    self.actionBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
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
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    _forwardCheckbox = [UIButton buttonWithType:UIButtonTypeCustom];
    [_forwardCheckbox setImage:[self imageInBundle:@"wb_checkbox_unchecked"] forState:UIControlStateNormal];
    [_forwardCheckbox setImage:[self imageInBundle:@"wb_checkbox_checked"] forState:UIControlStateSelected];
    [_forwardCheckbox sizeToFit];
    [self addSubview:_forwardCheckbox];
    
    _forwardLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _forwardLabel.font = [UIFont systemFontOfSize:14.f];
    _forwardLabel.text = @"同时转发";
    _forwardLabel.textColor = WBA_UIColorFromRGB(0x9b9b9b);
    [_forwardLabel sizeToFit];
    [self addSubview:_forwardLabel];
    
    _picButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_picButton setImage:[self imageInBundle:@"wb_picture_normal"] forState:UIControlStateNormal];
    [_picButton setImage:[self imageInBundle:@"wb_picture_highlighted"] forState:UIControlStateHighlighted];
    [_picButton sizeToFit];
    [self addSubview:_picButton];
    
    
    _mentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_mentionButton setImage:[self imageInBundle:@"wb_mention_normal"] forState:UIControlStateNormal];
    [_mentionButton setImage:[self imageInBundle:@"wb_mention_highlighted"] forState:UIControlStateHighlighted];
    [_mentionButton sizeToFit];
    [self addSubview:_mentionButton];
    
    _trendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_trendButton setImage:[self imageInBundle:@"wb_trend_normal"] forState:UIControlStateNormal];
    [_trendButton setImage:[self imageInBundle:@"wb_trend_highlighted"] forState:UIControlStateHighlighted];
    [_trendButton sizeToFit];
    [self addSubview:_trendButton];
    
    _emoticonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_emoticonButton setImage:[self imageInBundle:@"wb_emoticon_normal"] forState:UIControlStateNormal];
    [_emoticonButton setImage:[self imageInBundle:@"wb_emoticon_highlighted"] forState:UIControlStateHighlighted];
    [_emoticonButton sizeToFit];
    [self addSubview:_emoticonButton];
    
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreButton setImage:[self imageInBundle:@"wb_more_normal"] forState:UIControlStateNormal];
    [_moreButton setImage:[self imageInBundle:@"wb_more_highlighted"] forState:UIControlStateHighlighted];
    [_moreButton sizeToFit];
    [self addSubview:_moreButton];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    //左对齐
    CGFloat left = 10;
    
    //转发视为一个控件
    CGFloat forwardGap = 8.f;
    CGFloat forwardWidth = CGRectGetWidth(self.forwardCheckbox.frame) + forwardGap + CGRectGetWidth(self.forwardLabel.frame);
    //算出所有控件的总宽
    CGFloat totalWidth = (forwardWidth + CGRectGetWidth(self.picButton.frame) + CGRectGetWidth(self.mentionButton.frame) + CGRectGetWidth(self.trendButton.frame) + CGRectGetWidth(self.emoticonButton.frame) + CGRectGetWidth(self.moreButton.frame));
    //剩余控件平局分配，作为控件间隔
    CGFloat componentsCount = 6;
    CGFloat gap = (self.frame.size.width - left - totalWidth)/(componentsCount);
    
    //根据gap 排版
    CGRect checkBoxFrame = {left, 0, self.forwardCheckbox.frame.size};
    self.forwardCheckbox.frame = checkBoxFrame;
    CGPoint checkBoxCenter = {CGRectGetMidX(self.forwardCheckbox.frame), CGRectGetMidY(self.bounds)};
    self.forwardCheckbox.center = checkBoxCenter;
    
    left = CGRectGetMaxX(self.forwardCheckbox.frame) + forwardGap;
    CGRect labelFrame = {left, 0, self.forwardLabel.frame.size};
    self.forwardLabel.frame  = labelFrame;
    CGPoint labelCenter = {CGRectGetMidX(self.forwardLabel.frame), CGRectGetMidY(self.bounds)};
    self.forwardLabel.center = labelCenter;
    
    left = CGRectGetMaxX(self.forwardLabel.frame) + gap;
    NSArray *components = @[self.picButton,self.mentionButton,self.trendButton,self.emoticonButton,self.moreButton];
    for(int i = 0; i < components.count; i++)
    {
        UIView *component = components[i];
        CGRect frame = {left, 0, component.frame.size};
        component.frame = frame;
        left = CGRectGetMaxX(component.frame) + gap;
        
        CGPoint center = {CGRectGetMidX(component.frame), CGRectGetMidY(self.bounds)};
        component.center = center;
    }
}



- (UIImage *)imageInBundle:(NSString *)imageName
{
    NSString *name = [@"WBAppearance.bundle" stringByAppendingPathComponent:imageName];
    return [UIImage imageNamed:name];
}

@end

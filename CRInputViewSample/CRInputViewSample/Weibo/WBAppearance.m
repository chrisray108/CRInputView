//
//  WBAppearance.m
//  CRInputViewSample
//
//  Created by chris on 2017/12/29.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "WBAppearance.h"
#import "CRInputView.h"

#define WBA_UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define WBA_UIColorFromRGB(rgbValue) WBA_UIColorFromRGBA(rgbValue, 1.0)

static UIImage * wb_imageInBundle(NSString *imageName)
{
    NSString *name = [@"WBAppearance.bundle" stringByAppendingPathComponent:imageName];
    return [UIImage imageNamed:name];
}



@interface WBAppearance()

@end

@implementation WBAppearance

- (UIEdgeInsets)growingTextViewEdgeInset
{
    return UIEdgeInsetsMake(13, 10, 46, 50);
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
    return 5;
}

- (NSInteger)minNumberOfLines
{
    return 4;
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

- (CGFloat)toolBarBottomPaddingWhenKeyboardHide
{
    UIView *toolBar = self.actionBar.superview;
    return - toolBar.frame.size.height;
}



- (void)didSetupToolBar:(UIView *)toolBar
{
    self.actionBar = [[WBInputActionBar alloc] initWithFrame:CGRectZero];
    self.actionBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.actionBar.forwardCheckbox addTarget:self action:@selector(forwardCheck:) forControlEvents:UIControlEventTouchUpInside];
    [self.actionBar.emoticonButton addTarget:self action:@selector(onEmoticon:) forControlEvents:UIControlEventTouchUpInside];
    [self.actionBar.moreButton addTarget:self action:@selector(onMore:) forControlEvents:UIControlEventTouchUpInside];

    [toolBar addSubview:self.actionBar];
    
    self.fullscreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.fullscreenButton setImage:wb_imageInBundle(@"wb_icon_fullscreen") forState:UIControlStateNormal];
    [self.fullscreenButton sizeToFit];
    [self.fullscreenButton addTarget:self action:@selector(fullscreen:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:self.fullscreenButton];
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendButton setTitleColor:WBA_UIColorFromRGB(0x9b9b9b) forState:UIControlStateDisabled];
    [self.sendButton setTitleColor:WBA_UIColorFromRGB(0xff8421) forState:UIControlStateNormal];
    [self.sendButton addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    self.sendButton.enabled = NO;
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [self.sendButton sizeToFit];
    self.sendButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [toolBar addSubview:self.sendButton];
    
    UIView *inputView = toolBar.superview;
    if (self.emoticonContainer) [inputView insertSubview:self.emoticonContainer atIndex:0];
    if (self.moreContainer) [inputView insertSubview:self.moreContainer atIndex:0];
}


- (void)didResizeToolBar:(UIView *)toolBar
{
    [self layoutActionBar:toolBar];
    [self layoutFullscreenButton:toolBar];
    [self layoutSendButton:toolBar];
    [self layoutContainer:self.moreContainer toolBar:toolBar];
    [self layoutContainer:self.emoticonContainer toolBar:toolBar];
}

- (void)didChangeTextView:(UITextView *)textView
{
    self.sendButton.enabled = textView.text.length;
}

- (BOOL)shouldBeginEditing:(UITextView *)textView
{
    [self hideContainer];
    return YES;
}

- (void)toolBarWillHide:(UIView *)toolBar
{
    [self hideContainer];
}


- (void)hideContainer
{
    self.moreContainer.hidden = YES;
    self.emoticonContainer.hidden = YES;
    for (UIButton *button in self.actionBar.subviews)
    {
        if ([button respondsToSelector:@selector(setSelected:)])
        {
            [button setSelected:NO];
        }
    }
}


- (void)send:(UIButton *)button
{
    UIView *toolBar   = self.sendButton.superview;
    CRInputView *inputView = (CRInputView *)toolBar.superview;
    [inputView send];
}

- (void)fullscreen:(UIButton *)button
{
    
}

- (void)forwardCheck:(UIButton *)button
{
    button.selected = !button.selected;
}

- (void)onMore:(UIButton *)button
{
    self.moreContainer.hidden = NO;
    [self toggleContainer:self.moreContainer toggleButton:button];
}

- (void)onEmoticon:(UIButton *)button
{
    self.emoticonContainer.hidden = NO;
    [self toggleContainer:self.emoticonContainer toggleButton:button];
}


- (void)toggleContainer:(UIView *)container toggleButton:(UIButton *)button
{
    for (UIButton *actionButton in self.actionBar.subviews)
    {
        if (actionButton != button && [actionButton respondsToSelector:@selector(setSelected:)])
        {
            [actionButton setSelected:NO];
        }
    }
    button.selected = !button.selected;
    
    CRInputView *inputView = (CRInputView *)container.superview;
    UIView *toolBar = self.actionBar.superview;
    
    if (button.selected)
    {
        [inputView insertSubview:container belowSubview:toolBar];
        [inputView resignFirstResponder];
        [UIView animateWithDuration:0.25 delay:0 options:7 animations:^{
            [inputView moveToolBarToBottom:container.frame.size.height];
        } completion:nil];
        [self moveContainer:container toBottom:0];
    }
    else
    {
        [inputView becomeFirstResponder];
        CGFloat bottom = toolBar.frame.size.height + container.frame.size.height;
        [self moveContainer:container toBottom:-bottom];
    }

}

- (void)moveContainer:(UIView *)container
             toBottom:(CGFloat)bottom
{
    //仿键盘动画
    [UIView animateWithDuration:0.25 delay:0 options:7 animations:^{
        CGPoint orign = {0, container.superview.bounds.size.height - bottom - container.bounds.size.height};
        CGRect frame = {orign, container.frame.size};
        container.frame = frame;
    } completion:nil];
}



- (void)layoutActionBar:(UIView *)toolBar
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


- (void)layoutFullscreenButton:(UIView *)toolBar
{
    CGFloat top    = 10.f;
    CGFloat right  = 22.f;
    CGRect frame = {CGRectGetMaxX(toolBar.frame) - right - CGRectGetWidth(self.fullscreenButton.frame), top, self.fullscreenButton.frame.size};
    self.fullscreenButton.frame = frame;
}

- (void)layoutSendButton:(UIView *)toolBar
{
    CGFloat gap  = 38.f;
    CGRect frame = {CGRectGetMinX(self.fullscreenButton.frame), CGRectGetMaxY(self.fullscreenButton.frame) + gap, self.sendButton.frame.size};
    self.sendButton.frame = frame;
}

- (void)layoutContainer:(UIView *)container
                toolBar:(UIView *)toolBar
{
    CGSize size  = [container sizeThatFits:CGSizeMake(toolBar.frame.size.width, CGFLOAT_MAX)];
    CGRect frame = {0,CGRectGetMaxY(toolBar.frame),size};
    container.frame = frame;
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
    [_forwardCheckbox setImage:wb_imageInBundle(@"wb_checkbox_unchecked") forState:UIControlStateNormal];
    [_forwardCheckbox setImage:wb_imageInBundle(@"wb_checkbox_checked") forState:UIControlStateSelected];
    [_forwardCheckbox sizeToFit];
    [self addSubview:_forwardCheckbox];
    
    _forwardLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _forwardLabel.font = [UIFont systemFontOfSize:14.f];
    _forwardLabel.text = @"同时转发";
    _forwardLabel.textColor = WBA_UIColorFromRGB(0x9b9b9b);
    [_forwardLabel sizeToFit];
    [self addSubview:_forwardLabel];
    
    _picButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_picButton setImage:wb_imageInBundle(@"wb_picture_normal") forState:UIControlStateNormal];
    [_picButton setImage:wb_imageInBundle(@"wb_picture_highlighted") forState:UIControlStateHighlighted];
    [_picButton sizeToFit];
    [self addSubview:_picButton];
    
    
    _mentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_mentionButton setImage:wb_imageInBundle(@"wb_mention_normal") forState:UIControlStateNormal];
    [_mentionButton setImage:wb_imageInBundle(@"wb_mention_highlighted") forState:UIControlStateHighlighted];
    [_mentionButton sizeToFit];
    [self addSubview:_mentionButton];
    
    _trendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_trendButton setImage:wb_imageInBundle(@"wb_trend_normal") forState:UIControlStateNormal];
    [_trendButton setImage:wb_imageInBundle(@"wb_trend_highlighted") forState:UIControlStateHighlighted];
    [_trendButton sizeToFit];
    [self addSubview:_trendButton];
    
    _emoticonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_emoticonButton setImage:wb_imageInBundle(@"wb_emoticon_normal") forState:UIControlStateNormal];
    [_emoticonButton setImage:wb_imageInBundle(@"wb_emoticon_highlighted") forState:UIControlStateHighlighted];
    [_emoticonButton sizeToFit];
    [self addSubview:_emoticonButton];
    
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreButton setImage:wb_imageInBundle(@"wb_more_normal") forState:UIControlStateNormal];
    [_moreButton setImage:wb_imageInBundle(@"wb_more_highlighted") forState:UIControlStateHighlighted];
    [_moreButton sizeToFit];
    [self addSubview:_moreButton];
    
}

    
- (void)layoutSubviews
{
    [super layoutSubviews];
    //左对齐，右对齐
    CGFloat left  = 10;
    CGFloat right = 10;
    
    //转发视为一个控件
    CGFloat forwardGap = 8.f;
    CGFloat forwardWidth = CGRectGetWidth(self.forwardCheckbox.frame) + forwardGap + CGRectGetWidth(self.forwardLabel.frame);
    //算出所有控件的总宽
    CGFloat totalWidth = (forwardWidth + CGRectGetWidth(self.picButton.frame) + CGRectGetWidth(self.mentionButton.frame) + CGRectGetWidth(self.trendButton.frame) + CGRectGetWidth(self.emoticonButton.frame) + CGRectGetWidth(self.moreButton.frame));
    //剩余控件平局分配，作为控件间隔
    CGFloat componentsCount = 6;
    CGFloat gap = (self.frame.size.width - left - right - totalWidth)/(componentsCount - 1);
    
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



@end




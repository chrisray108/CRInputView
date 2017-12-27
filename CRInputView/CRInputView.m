//
//  CRInputView.m
//  CRInputViewDemo
//
//  Created by chris on 2017/12/27.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "CRInputView.h"
#import "CRInputToolBar.h"

@interface CRInputView ()<CRInputToolBarDelegate>
{
    UIEdgeInsets _growingTextViewEdgeInset;
    UIColor *_toolBarBackgroundColor;
    UIColor *_inputViewBackgroundColor;
}

@property (nonatomic,strong) UIView *backgroundView;

@property (nonatomic,strong) CRInputToolBar *toolBar;

@end

@implementation CRInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        [self setupConstant];
        [self setupBackgroundView];
        [self setupToolBar];
        [self addListener];
    }
    return self;
}

- (void)dealloc
{
    [self removeListener];
}


- (void)didMoveToWindow
{
    [self moveToolBarToBottom:0];
}

- (void)setupConstant
{
    _growingTextViewEdgeInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _toolBarBackgroundColor = [UIColor lightGrayColor];
    _inputViewBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
}

- (void)addListener
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)removeListener
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)send
{
    NSString *text = self.toolBar.text;
    self.toolBar.text = @"";
    if ([self.action respondsToSelector:@selector(didSendText:)]) {
        [self.action didSendText:text];
    }
}

- (void)setupBackgroundView
{
    _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [_backgroundView addGestureRecognizer:gesture];
    _backgroundView.hidden = YES;
    [self addSubview:_backgroundView];
}

- (void)setupToolBar
{
    _toolBar = [[CRInputToolBar alloc] initWithFrame:CGRectZero];
    _toolBar.delegate = self;
    [self addSubview:_toolBar];
}

- (void)moveToolBarToBottom:(CGFloat)bottom
{
    CGPoint orign = {0, self.bounds.size.height - bottom - self.toolBar.bounds.size.height};
    CGRect frame = {orign, self.toolBar.frame.size};
    self.toolBar.frame = frame;
}



- (void)setAppearance:(id<CRInputAppearance>)appearance
{
    _appearance = appearance;
    self.toolBar.appearance = appearance;

    if ([self.appearance respondsToSelector:@selector(growingTextViewEdgeInset)])
    {
        _growingTextViewEdgeInset = [self.appearance growingTextViewEdgeInset];
    }
    CGFloat width  = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat height = self.toolBar.growingTextFrame.size.height + _growingTextViewEdgeInset.top + _growingTextViewEdgeInset.bottom;
    
    CGRect frame = {CGPointZero, width,height};
    self.toolBar.frame = frame;
    
    frame = UIEdgeInsetsInsetRect(self.toolBar.bounds, _growingTextViewEdgeInset);
    self.toolBar.growingTextFrame = frame;
    
    
    if ([self.appearance respondsToSelector:@selector(toolBarBackgroundColor)])
    {
        _toolBarBackgroundColor = [self.appearance toolBarBackgroundColor];
    }
    self.toolBar.backgroundColor = _toolBarBackgroundColor;
    
    if ([self.appearance respondsToSelector:@selector(inputViewBackgroundColor)])
    {
        _inputViewBackgroundColor = [self.appearance inputViewBackgroundColor];
    }
    _backgroundView.backgroundColor = _inputViewBackgroundColor;
}


- (void)onTap:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        [self.toolBar resignFirstResponder];
    }
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame   = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    BOOL isVisiable = endFrame.origin.y != [UIApplication sharedApplication].keyWindow.frame.size.height;
    self.backgroundView.hidden = !isVisiable;
    CGFloat keyboardHeight = isVisiable? endFrame.size.height: 0;
    [self moveToolBarToBottom:keyboardHeight];
}

#pragma mark - CRInputToolBarDelegate
- (void)toolBarWillChangeHeight:(CGFloat)height
{
    CRInputToolBar *toolBar = self.toolBar;
    CGFloat toolBarHeight = toolBar.frame.size.height - toolBar.growingTextFrame.size.height + height;
    CGFloat toolBarOriginY = toolBar.frame.origin.y + toolBar.growingTextFrame.size.height - height;
    
    CGRect frame = {{toolBar.frame.origin.x, toolBarOriginY}, {toolBar.frame.size.width, toolBarHeight}};
    self.toolBar.frame = frame;
}

- (BOOL)shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    UIReturnKeyType returnKeyType = UIReturnKeyDefault;
    if ([self.appearance respondsToSelector:@selector(returnKeyType)])
    {
        returnKeyType = [self.appearance returnKeyType];
    }
    if ([text isEqualToString:@"\n"] && (returnKeyType != UIReturnKeyDefault && returnKeyType != UIReturnKeyNext))
    {
        [self send];
        return NO;
    }
    return YES;
}

@end



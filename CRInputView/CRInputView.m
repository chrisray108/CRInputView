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
    CGFloat _toolBarBottomPaddingWhenKeyboardShow;
    CGFloat _toolBarBottomPaddingWhenKeyboardHide;
}

@property (nonatomic,strong) UIView *backgroundView;

@property (nonatomic,strong) CRInputToolBar *toolBar;

@end

@implementation CRInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        [self setupConstant];
    }
    return self;
}


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    self.frame = newSuperview.bounds;
    [self setupToolBar];
    [self callbackDidSetupToolBar];
    [self setupBackgroundView];
    
    [self setupAppearance];    
    [self moveToolBarToBottom:_toolBarBottomPaddingWhenKeyboardShow];
    [self callbackDidResizeToolBar];
}



- (void)willMoveToWindow:(nullable UIWindow *)newWindow
{
    if (newWindow)
    {
        [self addListener];
    }
    else
    {
        [self removeListener];
    }
}

- (void)setupConstant
{
    _growingTextViewEdgeInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _inputViewBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    _toolBarBackgroundColor   = [UIColor lightGrayColor];
    _toolBarBottomPaddingWhenKeyboardShow = 0;
    _toolBarBottomPaddingWhenKeyboardHide = 0;
}

- (void)addListener
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)removeListener
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (CGRect)toolBarFrame
{
    return self.toolBar.frame;
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
    [self insertSubview:_backgroundView atIndex:0];
}

- (void)setupToolBar
{
    _toolBar = [[CRInputToolBar alloc] initWithFrame:CGRectZero];
    _toolBar.delegate = self;
    _toolBar.appearance = self.appearance;
    [self addSubview:_toolBar];
}

- (BOOL)becomeFirstResponder
{
    return [self.toolBar becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [self.toolBar resignFirstResponder];
}



- (void)showKeyboard
{
    [self moveToolBarToBottom:_toolBarBottomPaddingWhenKeyboardShow];
    [self becomeFirstResponder];
}


- (void)hideKeyboard
{
    [self resignFirstResponder];
}


- (void)moveToolBarToBottom:(CGFloat)bottom
{
    CGPoint orign = {0, self.bounds.size.height - bottom - self.toolBar.bounds.size.height};
    CGRect frame = {orign, self.toolBar.frame.size};
    self.toolBar.frame = frame;
}



- (void)setupAppearance
{
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
    
    if ([self.appearance respondsToSelector:@selector(toolBarBottomPaddingWhenKeyboardShow)])
    {
        _toolBarBottomPaddingWhenKeyboardShow = [self.appearance toolBarBottomPaddingWhenKeyboardShow];
    }
    if ([self.appearance respondsToSelector:@selector(toolBarBottomPaddingWhenKeyboardHide)])
    {
        _toolBarBottomPaddingWhenKeyboardHide = [self.appearance toolBarBottomPaddingWhenKeyboardHide];
    }
}

- (void)onTap:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        [self resignFirstResponder];
    }
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame   = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    BOOL isVisiable = endFrame.origin.y != [UIApplication sharedApplication].keyWindow.frame.size.height;
    self.backgroundView.hidden = !isVisiable;
    CGFloat keyboardHeight = isVisiable? endFrame.size.height: _toolBarBottomPaddingWhenKeyboardHide;
    [self moveToolBarToBottom:keyboardHeight];
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if(self.backgroundView.hidden && !CGRectContainsPoint(self.toolBar.frame, point))
    {
       return nil;
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark - CRInputToolBarDelegate
- (void)textView:(UITextView *)textView willChangeHeight:(CGFloat)height
{
    CRInputToolBar *toolBar = self.toolBar;
    CGFloat toolBarHeight = toolBar.frame.size.height - toolBar.growingTextFrame.size.height + height;
    CGFloat toolBarOriginY = toolBar.frame.origin.y + toolBar.growingTextFrame.size.height - height;
    
    CGRect frame = {{toolBar.frame.origin.x, toolBarOriginY}, {toolBar.frame.size.width, toolBarHeight}};
    self.toolBar.frame = frame;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
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

- (void)textViewDidChange:(UITextView *)textView
{
    if ([self.appearance respondsToSelector:@selector(didChangeTextView:)])
    {
        [self.appearance didChangeTextView:textView];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.appearance respondsToSelector:@selector(shouldBeginEditing:)])
    {
        return [self.appearance shouldBeginEditing:textView];
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.appearance respondsToSelector:@selector(didEndEditing:)])
    {
        [self.appearance didEndEditing:textView];
    }
}

#pragma mark - Callback
- (void)callbackDidSetupToolBar
{
    if([self.appearance respondsToSelector:@selector(didSetupToolBar:)])
    {
        [self.appearance didSetupToolBar:self.toolBar];
    }
}

- (void)callbackDidResizeToolBar
{
    if([self.appearance respondsToSelector:@selector(didResizeToolBar:)])
    {
        [self.appearance didResizeToolBar:self.toolBar];
    }
}

@end



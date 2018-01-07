//
//  CRInputToolBar.m
//  CRInputViewDemo
//
//  Created by chris on 2017/12/27.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "CRInputToolBar.h"
#import "CRGrowingTextView.h"

@interface CRInputToolBar ()<CRGrowingTextViewDelegate>
{
    UIReturnKeyType _returnKeyType;
    NSInteger _maxNumberOfLines;
    NSInteger _minNumberOfLines;
    UIFont  *_inputFont;
    UIColor *_inputTextColor;
    UIColor *_textViewBackgroundColor;
    CGFloat _textViewCornerRadius;
    CGFloat _textViewBorderWidth;
    UIColor *_textViewBorderColor;
}

@property (nonatomic, strong) CRGrowingTextView *growingTextView;

@end

@implementation CRInputToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        [self setupConstant];
        [self setupGrowingTextView];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview)
    {
        [self setupAppearance];
    }
}

- (void)setupConstant
{
    _maxNumberOfLines = 6;
    _minNumberOfLines = 4;
    _inputFont      = [UIFont systemFontOfSize:14.0f];
    _inputTextColor = [UIColor blackColor];
    
    _textViewBackgroundColor  = [UIColor whiteColor];
    _textViewCornerRadius = 5.f;
    _textViewBorderWidth  = .5f;
    _textViewBorderColor  = [UIColor grayColor];
}

- (NSString *)text
{
    return self.growingTextView.text;
}

- (void)setText:(NSString *)text
{
    self.growingTextView.text = text;
}

- (CGRect)growingTextFrame
{
    return self.growingTextView.frame;
}

- (void)setGrowingTextFrame:(CGRect)growingTextFrame
{
    self.growingTextView.frame = growingTextFrame;
}

- (void)setupGrowingTextView
{
    _growingTextView = [[CRGrowingTextView alloc] initWithFrame:CGRectZero];
    _growingTextView.textViewDelegate = self;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGrowingTextView:)];
    [_growingTextView addGestureRecognizer:gesture];
    [self addSubview:_growingTextView];
}


- (void)onTapGrowingTextView:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded && !self.growingTextView.isFirstResponder)
    {
        [self.growingTextView becomeFirstResponder];
    }
}

- (BOOL)becomeFirstResponder
{
    return [self.growingTextView becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [self.growingTextView resignFirstResponder];
}

- (BOOL)isFirstResponder
{
    return [self.growingTextView isFirstResponder];
}

- (void)setupAppearance
{    
    if ([self.appearance respondsToSelector:@selector(returnKeyType)])
    {
        _returnKeyType  = [self.appearance returnKeyType];
    }
    if ([self.appearance respondsToSelector:@selector(maxNumberOfLines)])
    {
        _maxNumberOfLines = [self.appearance maxNumberOfLines];
    }
    if ([self.appearance respondsToSelector:@selector(minNumberOfLines)])
    {
        _minNumberOfLines = [self.appearance minNumberOfLines];
    }
    if ([self.appearance respondsToSelector:@selector(inputFont)])
    {
        _inputFont = [self.appearance inputFont];
    }
    if ([self.appearance respondsToSelector:@selector(textViewBackgroundColor)])
    {
        _textViewBackgroundColor = [self.appearance textViewBackgroundColor];
    }
    if ([self.appearance respondsToSelector:@selector(inputTextColor)])
    {
        _inputTextColor = [self.appearance inputTextColor];
    }
    if ([self.appearance respondsToSelector:@selector(textViewCornerRadius)])
    {
        _textViewCornerRadius = [self.appearance textViewCornerRadius];
    }
    if ([self.appearance respondsToSelector:@selector(textViewBorderWidth)])
    {
        _textViewBorderWidth = [self.appearance textViewBorderWidth];
    }
    if ([self.appearance respondsToSelector:@selector(textViewBorderColor)])
    {
        _textViewBorderColor = [self.appearance textViewBorderColor];
    }
    
    NSAttributedString *placeHolder = nil;
    if ([self.appearance respondsToSelector:@selector(placeHolder)])
    {
        placeHolder = [self.appearance placeHolder];
    }
    
    self.growingTextView.font = _inputFont;
    self.growingTextView.maxNumberOfLines = _maxNumberOfLines;
    self.growingTextView.minNumberOfLines = _minNumberOfLines;    
    self.growingTextView.placeholderAttributedText = placeHolder;
    self.growingTextView.returnKeyType = _returnKeyType;
    self.growingTextView.backgroundColor = _textViewBackgroundColor;
    self.growingTextView.textColor = _inputTextColor;
    self.growingTextView.layer.cornerRadius = _textViewCornerRadius;
    self.growingTextView.layer.borderWidth  = _textViewBorderWidth;
    self.growingTextView.layer.borderColor  = _textViewBorderColor.CGColor;

    
    CGRect frame = {CGPointZero,[_growingTextView intrinsicContentSize]};
    _growingTextView.frame = frame;

}


#pragma mark - CRGrowingTextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)replacementText
{
    BOOL should = YES;
    if ([self.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        should = [self.delegate textView:textView shouldChangeTextInRange:range replacementText:replacementText];
    }
    return should;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    BOOL should = YES;
    if ([self.delegate respondsToSelector:@selector(textViewShouldBeginEditing:)])
    {
        should = [self.delegate textViewShouldBeginEditing:textView];
    }
    return should;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(textViewDidEndEditing:)])
    {
        [self.delegate textViewDidEndEditing:textView];
    }
}


- (void)textViewDidChange:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(textViewDidChange:)])
    {
        [self.delegate textViewDidChange:textView];
    }
}

- (void)textView:(UITextView *)textView willChangeHeight:(CGFloat)height
{
    if ([self.delegate respondsToSelector:@selector(textView:willChangeHeight:)])
    {
        [self.delegate textView:textView willChangeHeight:height];
    }
}

- (void)textView:(UITextView *)textView didChangeHeight:(CGFloat)height
{
    if ([self.delegate respondsToSelector:@selector(textView:didChangeHeight:)]) {
        [self.delegate textView:textView didChangeHeight:height];
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

@end

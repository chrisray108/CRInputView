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
    UIFont *_inputFont;
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
    _inputFont = [UIFont systemFontOfSize:14.0f];
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
    _growingTextView.textColor = [UIColor blackColor];
    _growingTextView.backgroundColor = [UIColor whiteColor];
    _growingTextView.layer.cornerRadius = 5.f;
    _growingTextView.layer.borderWidth  = .5f;
    _growingTextView.layer.borderColor  = [UIColor grayColor].CGColor;
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
    CGRect frame = {CGPointZero,[_growingTextView intrinsicContentSize]};
    _growingTextView.frame = frame;

}


#pragma mark - CRGrowingTextViewDelegate
- (BOOL)shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)replacementText
{
    BOOL should = YES;
    if ([self.delegate respondsToSelector:@selector(shouldChangeTextInRange:replacementText:)]) {
        should = [self.delegate shouldChangeTextInRange:range replacementText:replacementText];
    }
    return should;
}


- (BOOL)textViewShouldBeginEditing:(CRGrowingTextView *)growingTextView
{
    BOOL should = YES;
    if ([self.delegate respondsToSelector:@selector(textViewShouldBeginEditing)]) {
        should = [self.delegate textViewShouldBeginEditing];
    }
    return should;
}

- (void)textViewDidEndEditing:(CRGrowingTextView *)growingTextView
{
    if ([self.delegate respondsToSelector:@selector(textViewDidEndEditing)]) {
        [self.delegate textViewDidEndEditing];
    }
}


- (void)textViewDidChange:(CRGrowingTextView *)growingTextView
{
    if ([self.delegate respondsToSelector:@selector(textViewDidChange)]) {
        [self.delegate textViewDidChange];
    }
}

- (void)willChangeHeight:(CGFloat)height
{
    if ([self.delegate respondsToSelector:@selector(toolBarWillChangeHeight:)]) {
        [self.delegate toolBarWillChangeHeight:height];
    }
}

- (void)didChangeHeight:(CGFloat)height
{
    if ([self.delegate respondsToSelector:@selector(toolBarDidChangeHeight:)]) {
        [self.delegate toolBarDidChangeHeight:height];
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

@end

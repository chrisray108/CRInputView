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


- (void)setupConstant
{
    _maxNumberOfLines = 6;
    _minNumberOfLines = 4;
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
    _growingTextView.font = [UIFont systemFontOfSize:14.0f];
    _growingTextView.textColor = [UIColor blackColor];
    _growingTextView.backgroundColor = [UIColor whiteColor];
    _growingTextView.layer.cornerRadius = 5.f;
    _growingTextView.layer.borderWidth = .5f;
    _growingTextView.layer.borderColor = [UIColor grayColor].CGColor;
    _growingTextView.textViewDelegate = self;
    [self addSubview:_growingTextView];
}

- (BOOL)resignFirstResponder
{
    [super resignFirstResponder];
    return [self.growingTextView resignFirstResponder];
}

- (void)setAppearance:(id<CRInputAppearance>)appearance
{
    _appearance = appearance;
    
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
    NSAttributedString *placeHolder = nil;
    if ([self.appearance respondsToSelector:@selector(placeHolder)])
    {
        placeHolder = [self.appearance placeHolder];
    }
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
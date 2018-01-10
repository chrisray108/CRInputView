//
//  CRGrowingTextView.h
//  CRInputView
//
//  Created by chris on 16/3/27.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CRGrowingTextView;

@protocol CRGrowingTextViewDelegate <NSObject>
@optional

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)replacementText;

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)range;

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)range;

- (void)textViewDidBeginEditing:(UITextView *)textView;

- (void)textViewDidChangeSelection:(UITextView *)textView;

- (void)textViewDidEndEditing:(UITextView *)textView;

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;

- (BOOL)textViewShouldEndEditing:(UITextView *)textView;

- (void)textViewDidChange:(UITextView *)textView;

- (void)textView:(UITextView *)textView willChangeHeight:(CGFloat)height;

- (void)textView:(UITextView *)textView didChangeHeight:(CGFloat)height;

@end

@interface CRGrowingTextView : UIScrollView<UITextInput, UIContentSizeCategoryAdjusting>

@property (nonatomic,weak) id<CRGrowingTextViewDelegate> textViewDelegate;

@property (nonatomic,assign) NSInteger minNumberOfLines;

@property (nonatomic,assign) NSInteger maxNumberOfLines;

@property (nonatomic,strong) UIView *inputView;

@end

@interface CRGrowingTextView(TextView)

@property (nonatomic,copy)   NSAttributedString *placeholderAttributedText;

@property (nonatomic,copy)   NSString *text;

@property (nonatomic,strong) UIFont *font;

@property (nonatomic,strong) UIColor *textColor;

@property (nonatomic,assign) NSTextAlignment textAlignment;

@property (nonatomic,assign) NSRange selectedRange;

@property (nonatomic,assign) UIDataDetectorTypes dataDetectorTypes;

@property (nonatomic,assign) BOOL editable;

@property (nonatomic,assign) BOOL selectable;

@property (nonatomic,assign) BOOL allowsEditingTextAttributes;

@property (nonatomic,copy)   NSAttributedString *attributedText;

@property (nonatomic,strong) UIView *textViewInputAccessoryView;

@property (nonatomic,assign) BOOL clearsOnInsertion;

@property (nonatomic,readonly) NSTextContainer *textContainer;

@property (nonatomic,assign)   UIEdgeInsets textContainerInset;

@property (nonatomic,readonly) NSLayoutManager *layoutManger;

@property (nonatomic,readonly) NSTextStorage *textStorage;

@property (nonatomic, copy)    NSDictionary<NSString *, id> *linkTextAttributes;

@property (nonatomic,assign)  UIReturnKeyType returnKeyType;

- (void)scrollRangeToVisible:(NSRange)range;

@end

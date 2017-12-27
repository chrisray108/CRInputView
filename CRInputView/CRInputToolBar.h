//
//  CRInputToolBar.h
//  CRInputViewDemo
//
//  Created by chris on 2017/12/27.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "CRInputDefine.h"

@protocol CRInputToolBarDelegate <NSObject>

@optional

- (BOOL)textViewShouldBeginEditing;

- (void)textViewDidEndEditing;

- (BOOL)shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)replacementText;

- (void)textViewDidChange;

- (void)toolBarWillChangeHeight:(CGFloat)height;

- (void)toolBarDidChangeHeight:(CGFloat)height;

@end

@interface CRInputToolBar : UIView

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) CGRect growingTextFrame;

@property (nonatomic, weak) id<CRInputAppearance> appearance;

@property (nonatomic, weak) id<CRInputToolBarDelegate> delegate;

@end

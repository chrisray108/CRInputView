//
//  CRInputView.h
//  CRInputViewDemo
//
//  Created by chris on 2017/12/27.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "CRInputDefine.h"

@interface CRInputView : UIView

@property (nonatomic, weak) id<CRInputAppearance> appearance;

@property (nonatomic, weak) id<CRInputAction> action;


/**
 *  弹出键盘
 */
- (void)showKeyboard;

/**
 *  隐藏键盘
 */
- (void)hideKeyboard;


/**
 *  将输入栏挪到指定高度
 */
- (void)moveToolBarToBottom:(CGFloat)bottom;

/**
 *  输入栏颜色
 */
- (void)send;

@end

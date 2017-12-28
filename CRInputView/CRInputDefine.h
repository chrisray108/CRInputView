//
//  CRInputDefine.h
//  CRInputViewDemo
//
//  Created by chris on 2017/12/27.
//  Copyright © 2017年 chris. All rights reserved.
//

#ifndef CRInputDefine_h
#define CRInputDefine_h
#import <UIKit/UIKit.h>

@protocol CRInputAppearance<NSObject>

@optional


/**
    结构图
    Inputview

            +----------------+-----------------------------------------+
            |                ^                                         |
            |InputToolbar    |                                         |
            |                |                                         |
            |                |edgeInset.top                            |
            |         +-------------------------------------+          |
            |         |                                     |          |
            |         | GrowingTextView                     |          |
            |         |                                     |          |
      edgeInset.left  |                                     |      edgeInset.right
            |^--------+                                     +----------+
            |         |                                     |          |
            |         |                                     |          |
            |         +-------------------------------------+          |
            |                |edgeInset.bottom                         |
            |                |                                         |
            |                |                                         |
            |                |                                         |
            +----------------v-----------------------------------------+
            |                                                          |
            |                                                          |
            | Keyboard                                                 |
            |                                                          |
            |                                                          |
            |                                                          |
            |                                                          |
            |                                                          |
            +----------------------------------------------------------+
*/


/**
 *  输入栏颜色
 */
- (UIColor *)toolBarBackgroundColor;

/**
 *  键盘弹出后整个页面的背景色
 */
- (UIColor *)inputViewBackgroundColor;

/**
 *  输入框距整个输入栏的边距，改变输入框大小请改变 minNumberOfLines 的值，
 *  输入栏的大小会根据给定边距自动计算
 */
- (UIEdgeInsets)growingTextViewEdgeInset;

/**
 *  键盘返回按钮样式
 */
- (UIReturnKeyType)returnKeyType;

/**
 *  输入框最大行数，超过这个行数输入框将不会继续变大
 */
- (NSInteger)maxNumberOfLines;

/**
 *  输入框最小行数，改变这个行数会改变输入框的初始大小
 */
- (NSInteger)minNumberOfLines;

/**
 *  输入框初始占位提示文本
 */
- (NSAttributedString *)placeHolder;

/**
 *  输入框字体
 */
- (UIFont *)inputFont;

/**
 *  当键盘要弹起时，输入框距离底部的距离
 */
- (CGFloat)toolBarBottomPaddingWhenKeyboardShow;

/**
 *  当键盘要收起时，输入框距离底部的距离
 */
- (CGFloat)toolBarBottomPaddingWhenKeyboardHide;

@end


@protocol CRInputAction<NSObject>

@optional

/**
 *  已发送的文字的回调
 */

- (void)didSendText:(NSString *)text;

@end


#endif /* CRInputDefine_h */

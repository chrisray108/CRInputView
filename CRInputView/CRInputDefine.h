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


@protocol CRInputHierarchy<NSObject>

/**
 *  输入栏初始化完成后的回调，可以在这个回调里为 toolBar 添加一些自定义视图
 */
- (void)didSetupToolBar:(UIView *)toolBar;

/**
 *  *  已经重置输入栏的大小和位置，实现这个回调做一些自己视图的布局
 */
- (void)didResizeToolBar:(UIView *)toolBar;


@end




@protocol CRInputAppearance<CRInputHierarchy>

@optional
/**
 *  键盘弹出后整个页面的背景色
 */
- (UIColor *)inputViewBackgroundColor;

/**
 *  输入栏颜色
 */
- (UIColor *)toolBarBackgroundColor;

/**
 *  键盘输入框内部背景色
 */
- (UIColor *)textViewBackgroundColor;

/**
 *  键盘输入框圆角弧度
 */
- (CGFloat)textViewCornerRadius;

/**
 *  键盘输入框框边的宽度
 */
- (CGFloat)textViewBorderWidth;


/**
 *  键盘输入框框颜色
 */
- (UIColor *)textViewBorderColor;


/**
 *  输入的字体
 */
- (UIFont *)inputFont;

/**
 *  输入的字体颜色
 */
- (UIColor *)inputTextColor;


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

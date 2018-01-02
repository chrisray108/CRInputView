//
//  CRInputView.h
//  CRInputViewDemo
//
//  Created by chris on 2017/12/27.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "CRInputDefine.h"
#import "CRInputToolBar.h"

/**
 *  输入控件
 */
@interface CRInputView : UIView

/**
 *  外观控制器
 */
@property (nonatomic, weak) id<CRInputAppearance> appearance;

/**
 *  动作反馈
 */
@property (nonatomic, weak) id<CRInputAction> action;


/**
 *  输入栏控件位置大小
 */
@property (nonatomic, assign,readonly) CGRect toolBarFrame;


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





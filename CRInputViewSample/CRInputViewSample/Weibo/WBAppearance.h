//
//  Appearance.h
//  CRInputViewSample
//
//  Created by chris on 2017/12/29.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "CRInputDefine.h"

@interface WBInputActionBar : UIView

/*转发选择框*/
@property(nonatomic, strong) UIButton *forwardCheckbox;

/*转发提示文案*/
@property(nonatomic, strong) UILabel  *forwardLabel;

/*图片按钮*/
@property(nonatomic, strong) UIButton *picButton;

/* @ 按钮*/
@property(nonatomic, strong) UIButton *mentionButton;

/* # 按钮*/
@property(nonatomic, strong) UIButton *trendButton;

/*表情按钮*/
@property(nonatomic, strong) UIButton *emoticonButton;

/*更多按钮*/
@property(nonatomic, strong) UIButton *moreButton;

@end



@interface WBAppearance : NSObject<CRInputAppearance>

/*输入动作条*/
@property(nonatomic, strong) WBInputActionBar *actionBar;

/*发送按钮*/
@property(nonatomic, strong) UIButton *sendButton;

/*全屏按钮*/
@property(nonatomic, strong) UIButton *fullscreenButton;

/*表情面板，默认为nil*/
@property(nonatomic, strong) UIView *emoticonContainer;

/*更多面板，默认为nil*/
@property(nonatomic, strong) UIView *moreContainer;

@end







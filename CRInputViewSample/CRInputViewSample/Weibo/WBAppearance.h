//
//  Appearance.h
//  CRInputViewSample
//
//  Created by chris on 2017/12/29.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "CRInputDefine.h"

@interface WBInputActionBar : UIView

/*是否选中转发*/
- (BOOL)isforward;

@end


@protocol WBAppearanceEventDelegate<NSObject>

- (void)onEventTouchPictureButton:(UIButton *)button;

- (void)onEventTouchFullscreenButton:(UIButton *)button;

- (void)onEventTouchMentionButton:(UIButton *)button;

- (void)onEventTouchTrendButton:(UIButton *)button;

@end


@interface WBAppearance : NSObject<CRInputAppearance>

/*事件代理*/
@property(nonatomic, weak) id<WBAppearanceEventDelegate> eventDelegate;

/*输入动作条*/
@property(nonatomic, strong) WBInputActionBar *actionBar;

/*表情面板，默认为nil*/
@property(nonatomic, strong) UIView *emoticonContainer;

/*更多面板，默认为nil*/
@property(nonatomic, strong) UIView *moreContainer;

@end







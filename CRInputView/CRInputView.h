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

- (void)moveToolBarToBottom:(CGFloat)bottom;

- (void)send;

@end

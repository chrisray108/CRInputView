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

- (CGSize)toolBarSize;

- (UIColor *)toolBarBackgroundColor;

- (UIEdgeInsets)growingTextViewEdgeInset;

- (UIReturnKeyType)returnKeyType;

- (NSInteger)maxNumberOfLines;

- (NSInteger)minNumberOfLines;

- (NSAttributedString *)placeHolder;

@end


@protocol CRInputAction<NSObject>

@optional

- (void)didSendText:(NSString *)text;

@end


#endif /* CRInputDefine_h */

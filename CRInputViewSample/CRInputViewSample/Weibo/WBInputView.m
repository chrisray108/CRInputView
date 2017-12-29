//
//  WBInputView.m
//  CRInputViewSample
//
//  Created by chris on 2017/12/29.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "WBInputView.h"

@interface WBInputView()

@property (nonatomic,strong) UIView *actionBar;


@end

@implementation WBInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _actionBar = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_actionBar];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end

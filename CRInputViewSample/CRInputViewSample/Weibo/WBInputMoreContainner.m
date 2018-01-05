//
//  WBInputMoreContainner.m
//  CRInputViewSample
//
//  Created by chris on 2018/1/5.
//  Copyright © 2018年 chris. All rights reserved.
//

#import "WBInputMoreContainner.h"

@implementation WBInputMoreContainner

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(size.width, 300);
}

- (void)moveToBottom:(CGFloat)bottom
{
    //仿键盘动画
    [UIView animateWithDuration:0.25 delay:0 options:7 animations:^{
        CGPoint orign = {0, self.superview.bounds.size.height - bottom - self.bounds.size.height};
        CGRect frame = {orign, self.frame.size};
        self.frame = frame;
    } completion:nil];    
}


@end

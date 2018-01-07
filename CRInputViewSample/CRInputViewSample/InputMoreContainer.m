//
//  InputMoreContainer.m
//  CRInputViewSample
//
//  Created by chris on 2018/1/7.
//  Copyright © 2018年 chris. All rights reserved.
//

#import "InputMoreContainer.h"

@implementation InputMoreContainer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


/*需要告诉组件自己的大小，仅必须实现这一个方法*/
- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(size.width, 300);
}


@end

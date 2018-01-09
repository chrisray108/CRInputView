//
//  InputMoreContainer.m
//  CRInputViewSample
//
//  Created by chris on 2018/1/7.
//  Copyright © 2018年 chris. All rights reserved.
//

#import "InputMoreContainer.h"

/*这个是上层自己定制的一个容器类，用来展示更多的面板，这里只是一个例子*/

@interface InputMoreContainer()

@property (nonatomic,strong) UILabel *label;

@end

@implementation InputMoreContainer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _label = [[UILabel alloc] init];
        _label.text = @"更  多  按  钮";
        _label.font = [UIFont boldSystemFontOfSize:25.f];
        [_label sizeToFit];
        [self addSubview:_label];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


/*需要告诉组件自己的大小，仅必须实现这一个方法*/
- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(size.width, 300);
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _label.center = CGPointMake(self.bounds.size.width * .5f, self.bounds.size.height * .5f);
}


@end

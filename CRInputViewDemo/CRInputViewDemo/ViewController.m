//
//  ViewController.m
//  CRInputViewDemo
//
//  Created by chris on 2017/12/27.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "ViewController.h"
#import "CRInputView.h"
@interface ViewController ()<CRInputAppearance,CRInputAction>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CRInputView *inputView  = [[CRInputView alloc] initWithFrame:CGRectZero];
    inputView.appearance = self;
    inputView.action = self;
    [self.view addSubview:inputView];
}


#pragma mark - CRInputAppearance
- (UIEdgeInsets)growingTextViewEdgeInset
{
    return UIEdgeInsetsMake(10, 10, 50, 80);
}

- (UIReturnKeyType)returnKeyType
{
    return UIReturnKeyDone;
}

- (NSInteger)maxNumberOfLines
{
    return 4;
}

- (NSInteger)minNumberOfLines
{
    return 3;
}

- (NSAttributedString *)placeHolder
{
    return [[NSAttributedString alloc] initWithString:@"请输入文本"];
}

- (UIColor *)inputViewBackgroundColor
{
    return [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
}

- (UIFont *)inputFont
{
    return [UIFont systemFontOfSize:11.f];
}


#pragma mark - CRInputAction
- (void)didSendText:(NSString *)text
{
    NSLog(@"did send text %@",text);
}


@end

//
//  ViewController.m
//  CRInputViewSample
//
//  Created by chris on 2017/12/29.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "ViewController.h"
#import "CRInputView.h"
#import "WBAppearance.h"
#import "InputMoreContainer.h"
#import "InputEmoticonContainer.h"

@interface ViewController ()<CRInputAction>

@property (nonatomic,strong) WBAppearance *weiboAppearance;

@property (nonatomic,strong) CRInputView *inputTextView;

@end

@implementation ViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    //微博外观初始化
    _weiboAppearance = [[WBAppearance alloc] init];
    //外观安装额外表情菜单
    _weiboAppearance.emoticonContainer = [[InputEmoticonContainer alloc] initWithFrame:CGRectZero];
    //外观安装额外更多菜单
    _weiboAppearance.moreContainer = [[InputMoreContainer alloc] initWithFrame:CGRectZero];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setUpInputTextView];
}


- (void)setupNav
{
    self.navigationItem.title = @"长按出键盘";
    UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpress:)];
    [self.navigationController.navigationBar addGestureRecognizer:gestureRecognizer];
}

- (void)setUpInputTextView
{
    self.inputTextView  = [[CRInputView alloc] initWithFrame:CGRectZero];
    self.inputTextView.appearance = self.weiboAppearance;
    self.inputTextView.action = self;
    self.inputTextView.hidden = YES;
    [self.view addSubview:self.inputTextView];
}

- (void)longpress:(UIGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        [self.inputTextView showKeyboard];
        self.inputTextView.hidden = NO;
    }
}



#pragma mark - CRInputAppearance

#pragma mark - CRInputAction
- (void)didSendText:(NSString *)text
{
    NSLog(@"did send text %@",text);
}


@end

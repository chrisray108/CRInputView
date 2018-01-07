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

@interface ViewController ()<CRInputAction,WBAppearanceEventDelegate>

@property (nonatomic,strong) WBAppearance *weiboAppearance;

@property (nonatomic,strong) CRInputView *inputTextView;

@end

@implementation ViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpAppearance];
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

- (void)setUpAppearance
{
    //微博外观初始化
    _weiboAppearance = [[WBAppearance alloc] init];
    //微博外观事件代理
    _weiboAppearance.eventDelegate = self;
    //外观安装额外表情菜单
    _weiboAppearance.emoticonContainer = [[InputEmoticonContainer alloc] initWithFrame:CGRectZero];
    //外观安装额外更多菜单
    _weiboAppearance.moreContainer = [[InputMoreContainer alloc] initWithFrame:CGRectZero];
  
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


#pragma mark - WBAppearanceEventDelegate
- (void)onEventTouchPictureButton:(UIButton *)button
{
    NSLog(@"onEventTouchPictureButton");
}

- (void)onEventTouchFullscreenButton:(UIButton *)button
{
    NSLog(@"onEventTouchFullscreenButton");
}

- (void)onEventTouchMentionButton:(UIButton *)button
{
    NSLog(@"onEventTouchMentionButton");
}

- (void)onEventTouchTrendButton:(UIButton *)button
{
    NSLog(@"onEventTouchTrendButton");
}

#pragma mark - CRInputAction
- (void)didSendText:(NSString *)text
{
    NSString *forward = self.weiboAppearance.actionBar.isforward? @"YES" : @"NO";
    NSLog(@"did send text %@ should foward:%@",text,forward);
}


@end

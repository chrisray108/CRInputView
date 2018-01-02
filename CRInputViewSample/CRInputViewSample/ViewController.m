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

@interface ViewController ()<CRInputAction>

@property (nonatomic,strong) WBAppearance *weiboAppearance;

@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        //微博外观初始化
        _weiboAppearance = [[WBAppearance alloc] init];
    }
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    //微博外观初始化
    _weiboAppearance = [[WBAppearance alloc] init];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    
    CRInputView *inputView  = [[CRInputView alloc] initWithFrame:CGRectZero];
    inputView.appearance = self.weiboAppearance;
    inputView.action = self;
    [self.view addSubview:inputView];
}

- (void)setupNav
{
    self.navigationItem.title = @"ViewController";
}



#pragma mark - CRInputAppearance

#pragma mark - CRInputAction
- (void)didSendText:(NSString *)text
{
    NSLog(@"did send text %@",text);
}


@end

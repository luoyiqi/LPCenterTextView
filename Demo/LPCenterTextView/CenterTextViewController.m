//
//  CenterTextViewController.m
//  LPCenterTextView
//
//  Created by Han Shuai on 15/11/29.
//  Copyright © 2015年 Loopeer. All rights reserved.
//

#import "CenterTextViewController.h"
#import "LPCenterTextView.h"
#import "Masonry.h"

@implementation CenterTextViewController {
    UIImageView *_userAvatar;
    LPCenterTextView *_infoView;
    UIView *_bottomView;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"多行居中文本";
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    _userAvatar = [[UIImageView alloc] init];
    _userAvatar.contentMode = UIViewContentModeScaleAspectFill;
    _userAvatar.image = [UIImage imageNamed:@"userAvatar"];
    [self.view addSubview:_userAvatar];
    
    _infoView = [[LPCenterTextView alloc] init];
    _infoView.numberOfLine = 0;
    _infoView.contentFont = [UIFont systemFontOfSize:14];
    _infoView.contentColor = [UIColor lightGrayColor];
    [_infoView setTextColor:[UIColor blackColor] InIndex:0];
    [self.view addSubview:_infoView];
    
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_bottomView];
    
    [self refreshConstraints];
}


- (void)updateViewConstraints {
    
    [_userAvatar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(110);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(15);
    }];
    
    [_infoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_userAvatar.mas_bottom);
    }];
    
    [_bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_infoView.mas_bottom);
        make.height.mas_equalTo(100);
    }];
    
    [super updateViewConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self suitIOS7];
    
    [_infoView setText:@"小王子" forLabel:0];
    [_infoView setText:nil forLabel:1];
    [_infoView setText:@"羽毛球 排球 游泳 健身 做饭 啦拉拉" forLabel:2];
    [_infoView setText:@"loopeer CEO" forLabel:3];
    [_infoView refresh];
    
    [self refreshConstraints];
}

#pragma mark - private

- (void)suitIOS7 {
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
}

- (void)refreshConstraints {
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [self.view layoutIfNeeded];
    [self.view layoutSubviews];
}


@end

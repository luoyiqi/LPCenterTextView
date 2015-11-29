//
//  LeftImageViewController.m
//  LPCenterTextView
//
//  Created by Han Shuai on 15/11/29.
//  Copyright © 2015年 Loopeer. All rights reserved.
//

#import "LeftImageViewController.h"
#import "LPCenterTextView.h"
#import "Masonry.h"

@implementation LeftImageViewController {
    UILabel *_titleLabel;
    LPCenterTextView *_infoView;
    UIView *_bottomView;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"带有左图标";
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.text = @"大标题";
    [self.view addSubview:_titleLabel];
    
    _infoView = [[LPCenterTextView alloc] init];
    _infoView.numberOfLine = 0;
    _infoView.contentFont = [UIFont systemFontOfSize:15];
    _infoView.contentColor = [UIColor grayColor];
    _infoView.leftOffset = 35;
    _infoView.rightOffset = -12;
    _infoView.imageLeftOffset = 12;
    _infoView.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_infoView];
    
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_bottomView];
    
    [self refreshConstraints];
}

- (void)updateViewConstraints {
    
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.top.equalTo(self.view).offset(10);
    }];
    
    [_infoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_titleLabel.mas_bottom);
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
    
    [_infoView setText:@"name" andImage:[UIImage imageNamed:@"3"] forLabel:0];
    [_infoView setText:nil andImage:[UIImage imageNamed:@"4"] forLabel:1];
    [_infoView setText:@"ios工程师ios工程师ios工程师ios工程师ios工程师ios工程师" andImage:[UIImage imageNamed:@"1"] forLabel:2];
    [_infoView setText:@"XXX@XXX.com" andImage:[UIImage imageNamed:@"2"] forLabel:3];
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

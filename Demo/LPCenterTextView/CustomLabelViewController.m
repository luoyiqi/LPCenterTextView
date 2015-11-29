//
//  CustomLabelViewController.m
//  LPCenterTextView
//
//  Created by Han Shuai on 15/11/29.
//  Copyright © 2015年 Loopeer. All rights reserved.
//

#import "CustomLabelViewController.h"
#import "LPCenterTextView.h"
#import "Masonry.h"
#import "NSString+LPKit.h"


@implementation CustomLabelViewController {
    UILabel *_titleLabel;
    LPCenterTextView *_mainView;
    UILabel *_tagLabel;
    UIView *_bottomView;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"带有右view";
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
    
    LPCenterTextFeature *firstLabelFeature = [[LPCenterTextFeature alloc] init];
    firstLabelFeature.contentFont = [UIFont systemFontOfSize:15];
    firstLabelFeature.contentColor = [UIColor blackColor];
    firstLabelFeature.numberOfLine = 0;
    
    LPCenterTextFeature *secondLabelFeature = [[LPCenterTextFeature alloc] init];
    secondLabelFeature.contentFont = [UIFont systemFontOfSize:12];
    secondLabelFeature.contentColor = [UIColor whiteColor];
    secondLabelFeature.backgroundColor = [UIColor brownColor];
    secondLabelFeature.wrapContent = YES;
    
    _tagLabel = [[UILabel alloc] init];
    _tagLabel.layer.cornerRadius = 3;
    _tagLabel.layer.masksToBounds = YES;
    _tagLabel.font = [UIFont systemFontOfSize:12];
    _tagLabel.textColor = [UIColor whiteColor];
    _tagLabel.backgroundColor = [UIColor brownColor];
    
    _mainView = [[LPCenterTextView alloc] init];
    _mainView.contentFont = [UIFont systemFontOfSize:12];
    _mainView.contentColor = [UIColor grayColor];
    _mainView.leftOffset = 12;
    _mainView.rightOffset = 50;
    _mainView.textAlignment = NSTextAlignmentLeft;
    [_mainView addTextFeature:firstLabelFeature forLabel:0];
    [_mainView addTextFeature:secondLabelFeature forLabel:1];
    [_mainView setRightView:_tagLabel InIndex:3];
    [self.view addSubview:_mainView];
    
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
    
    [_mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_titleLabel.mas_bottom);
    }];
    
    [_bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_mainView.mas_bottom);
        make.height.mas_equalTo(100);
    }];
    
    [super updateViewConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self suitIOS7];
    
    [_mainView setText:@"第一个label" forLabel:0];
    [_mainView setText:@" 第二个label " forLabel:1];
    [_mainView setText:nil forLabel:2];
    [_mainView setText:@"第四个label" forLabel:3];
    _tagLabel.text = @" 自定义右View ";
    [_mainView refresh];

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

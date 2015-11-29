//
//  ViewController.m
//  LPCenterTextView
//
//  Created by Han Shuai on 15/11/29.
//  Copyright © 2015年 Loopeer. All rights reserved.
//

#import "ViewController.h"
#import "CenterTextViewController.h"
#import "LeftImageViewController.h"
#import "CustomLabelViewController.h"
#import "Masonry.h"

static NSString *const reuseIdentifier = @"cellIdentifier";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController {
    UITableView *_mTableView;
    NSArray *_nameArray;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"LPCenterTextView";
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor greenColor];
    
    _mTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.tableFooterView = [[UIView alloc] init];
    [_mTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_mTableView];
    [self refreshConstraints];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    [_mTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self suitIOS7];
    
    _nameArray = @[@"多行居中文本", @"带有左图标", @"带有右view"];
    [_mTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _nameArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0: {
            CenterTextViewController *centerTextViewController = [[CenterTextViewController alloc] init];
            [self.navigationController pushViewController:centerTextViewController animated:YES];
        }
            break;
        case 1: {
            LeftImageViewController *leftImageViewController = [[LeftImageViewController alloc] init];
            [self.navigationController pushViewController:leftImageViewController animated:YES];
        }
            break;
        case 2: {
            CustomLabelViewController *customLabelViewController = [[CustomLabelViewController alloc] init];
            [self.navigationController pushViewController:customLabelViewController animated:YES];
        }
            break;
        default:
            break;
    }
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

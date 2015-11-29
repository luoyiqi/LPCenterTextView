//
//  ViewController.m
//  LPCenterTextView
//
//  Created by Han Shuai on 15/11/29.
//  Copyright © 2015年 Loopeer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end

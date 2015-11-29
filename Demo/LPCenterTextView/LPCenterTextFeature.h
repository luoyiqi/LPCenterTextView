//
//  LPCenterTextFeature.h
//
//  Created by Han Shuai on 15/11/17.
//  Copyright © 2015年 Loopeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class LPCenterTextView;


@interface LPCenterTextFeature : NSObject


@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) UIFont *contentFont;
@property (nonatomic, strong) UIColor *contentColor;
@property (nonatomic, assign) NSInteger lineSpace;
@property (nonatomic, assign) NSInteger numberOfLine;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, assign) BOOL wrapContent;

//左边图片
@property (nonatomic, strong) UIImage *image;
//右边自定义view
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, assign) CGFloat customViewLeftOffset;


//位置
@property (nonatomic, assign) NSInteger Id;

//用于返回统一值
@property (nonatomic, weak) LPCenterTextView *centerTextView;

//排序用
- (NSComparisonResult)compareFeature:(LPCenterTextFeature *)feature;

@end

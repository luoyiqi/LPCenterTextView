//
//  LPCenterTextView.h
//
//  Created by Han Shuai on 15/11/17.
//  Copyright © 2015年 Loopeer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPCenterTextFeature.h"

@interface LPCenterTextView : UIView


@property (nonatomic, assign) CGFloat horizonOffset;
@property (nonatomic, assign) CGFloat topOffset;
@property (nonatomic, assign) CGFloat bottomOffset;

@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) CGFloat leftOffset;
@property (nonatomic, assign) CGFloat rightOffset;
@property (nonatomic, assign) CGFloat imageLeftOffset;

//for label
@property (nonatomic, strong) UIFont *contentFont;
@property (nonatomic, strong) UIColor *contentColor;
@property (nonatomic, assign) NSInteger lineSpace;
@property (nonatomic, assign) NSInteger numberOfLine;


- (void)addTextFeature:(LPCenterTextFeature *)textFeature forLabel:(NSInteger)labelIndex;
- (void)setText:(NSString *)content forLabel:(NSInteger)labelIndex;
- (void)setText:(NSString *)content andImage:(UIImage *)image forLabel:(NSInteger)labelIndex;


- (void)setTextColor:(UIColor *)color InIndex:(NSInteger)labelIndex;
- (void)setRightView:(UIView *)rightView InIndex:(NSInteger)labelIndex;
- (void)setFont:(UIFont *)font InIndex:(NSInteger)labelIndex;
- (void)setNumberOfLine:(NSInteger)numberOfLine InIndex:(NSInteger)labelIndex;

- (void)refresh;

@end

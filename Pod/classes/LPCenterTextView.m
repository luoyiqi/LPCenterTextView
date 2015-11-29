//
//  LPCenterTextView.m
//
//  Created by Han Shuai on 15/11/17.
//  Copyright © 2015年 Loopeer. All rights reserved.
//

#import "LPCenterTextView.h"
#import "Masonry.h"
#import "NSString+LPKit.h"

static const int labelStartTag = 1943;
static const int imageViewStartTag = 2849;
static const int rightViewStartTag = 3243;

@implementation LPCenterTextView {
    NSMutableArray *_featureArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultValues];
    }
    return self;
}

- (void)updateConstraints {
    if (_featureArray.count == 0) {
        [super updateConstraints];
        return;
    }
    
    __block MASConstraint *bottomContrainst;
    __block UIView *precedingView = nil;
    
    for (LPCenterTextFeature *feature in _featureArray) {
        if ([NSString isStringEmpty:feature.content]) {
            continue;
        }
        
        UILabel *behindLabel = [self viewWithTag:labelStartTag + feature.Id];
        UIImageView *iconImageView = [self viewWithTag:imageViewStartTag + feature.Id];
        UIView *rightView = [self viewWithTag:rightViewStartTag + feature.Id];
        
        if (bottomContrainst) {
            [bottomContrainst uninstall];
        }
        
        [behindLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            if (precedingView) {
                make.top.equalTo(precedingView.mas_bottom).offset(feature.lineSpace);
            } else {
                make.top.equalTo(self).offset(_topOffset);
            }
            make.left.equalTo(self).offset(_leftOffset);
            if (!feature.wrapContent) {
                make.right.equalTo(self).offset(_rightOffset);
            }
            bottomContrainst = make.bottom.equalTo(self).offset(-_bottomOffset);
        }];
        
        if (iconImageView) {
            [iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(iconImageView.image.size.width);
                make.height.mas_equalTo(iconImageView.image.size.height);
                make.top.equalTo(behindLabel).offset(3);
                make.left.equalTo(self).offset(_imageLeftOffset);
            }];
        }
        
        if (rightView) {
            [rightView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(behindLabel);
                make.left.equalTo(behindLabel.mas_right).offset(feature.customViewLeftOffset);
            }];
        }
        
        precedingView = behindLabel;
    }
    
    [super updateConstraints];
}

#pragma mark - public methods

- (void)refresh {
    [self removeAllSubviews];
    
    _featureArray = [[_featureArray sortedArrayUsingSelector:@selector(compareFeature:)] mutableCopy];
    for (LPCenterTextFeature *feature in _featureArray) {
        if ([NSString isStringEmpty:feature.content]) {
            continue;
        }
        
        UILabel *newLabel = [[UILabel alloc] init];
        newLabel.font = feature.contentFont;
        newLabel.textColor = feature.contentColor;
        newLabel.numberOfLines = feature.numberOfLine;
        newLabel.textAlignment = self.textAlignment;
        newLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        newLabel.text = feature.content;
        newLabel.tag = labelStartTag + feature.Id;
        newLabel.backgroundColor = feature.backgroundColor;
        [self addSubview:newLabel];
        
        if (feature.image) {
            UIImageView *iconImageView = [[UIImageView alloc] init];
            iconImageView.contentMode = UIViewContentModeCenter;
            iconImageView.image = feature.image;
            iconImageView.tag = imageViewStartTag + feature.Id;
            [self addSubview:iconImageView];
        }
        
        if (feature.rightView) {
            feature.rightView.tag = rightViewStartTag + feature.Id;
            [self addSubview:feature.rightView];
        }
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
    [self layoutSubviews];
}

- (void)setTextColor:(UIColor *)color InIndex:(NSInteger)labelIndex {
    for (LPCenterTextFeature *feature in _featureArray) {
        if (feature.Id == labelIndex) {
            feature.contentColor = color;
            return;
        }
    }
    
    LPCenterTextFeature *feature = [[LPCenterTextFeature alloc] init];
    feature.contentColor = color;
    feature.centerTextView = self;
    feature.Id = labelIndex;
    [_featureArray addObject:feature];
}

- (void)setRightView:(UIView *)rightView InIndex:(NSInteger)labelIndex {
    for (LPCenterTextFeature *feature in _featureArray) {
        if (feature.Id == labelIndex) {
            feature.rightView = rightView;
            return;
        }
    }
    
    LPCenterTextFeature *feature = [[LPCenterTextFeature alloc] init];
    feature.rightView = rightView;
    feature.centerTextView = self;
    feature.Id = labelIndex;
    [_featureArray addObject:feature];
}

- (void)setFont:(UIFont *)font InIndex:(NSInteger)labelIndex {
    for (LPCenterTextFeature *feature in _featureArray) {
        if (feature.Id == labelIndex) {
            feature.contentFont = font;
            return;
        }
    }
    
    LPCenterTextFeature *feature = [[LPCenterTextFeature alloc] init];
    feature.contentFont = font;
    feature.centerTextView = self;
    feature.Id = labelIndex;
    [_featureArray addObject:feature];
}

- (void)setNumberOfLine:(NSInteger)numberOfLine InIndex:(NSInteger)labelIndex {
    for (LPCenterTextFeature *feature in _featureArray) {
        if (feature.Id == labelIndex) {
            feature.numberOfLine = numberOfLine;
            return;
        }
    }
    
    LPCenterTextFeature *feature = [[LPCenterTextFeature alloc] init];
    feature.numberOfLine = numberOfLine;
    feature.centerTextView = self;
    feature.Id = labelIndex;
    [_featureArray addObject:feature];
}

- (void)addTextFeature:(LPCenterTextFeature *)textFeature forLabel:(NSInteger)labelIndex {
    textFeature.centerTextView = self;
    textFeature.Id = labelIndex;
    
    [_featureArray addObject:textFeature];
}

- (void)setText:(NSString *)content forLabel:(NSInteger)labelIndex {
    [self setText:content andImage:nil forLabel:labelIndex];
}

- (void)setText:(NSString *)content andImage:(UIImage *)image forLabel:(NSInteger)labelIndex {
    if ([NSString isStringEmpty:content]) {
        return;
    }
    
    for (LPCenterTextFeature *feature in _featureArray) {
        if (feature.Id == labelIndex) {
            feature.content = content;
            feature.image = image;
            return;
        }
    }
    
    LPCenterTextFeature *feature = [[LPCenterTextFeature alloc] init];
    feature.centerTextView = self;
    feature.Id = labelIndex;
    feature.content = content;
    feature.image = image;
    [_featureArray addObject:feature];
}

#pragma mark - private methods

- (void)defaultValues {
    _featureArray = [NSMutableArray array];
    
    _numberOfLine = 1;
    _lineSpace = 4;
    _horizonOffset = 12;
    _topOffset = 5;
    _bottomOffset = 5;
    _imageLeftOffset = 12;
    _textAlignment = NSTextAlignmentCenter;
    _leftOffset = _horizonOffset;
    _rightOffset = -_horizonOffset;
}

- (void)removeAllSubviews {
    for(UIView *view in [self subviews]){
        [view removeFromSuperview];
    }
}

#pragma mark - accessors

- (void)setHorizonOffset:(CGFloat)horizonOffset {
    _horizonOffset = horizonOffset;
    _leftOffset = horizonOffset;
    _rightOffset = -horizonOffset;
    
    [self refresh];
}

@end

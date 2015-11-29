//
//  LPCenterTextFeature.m
//
//  Created by Han Shuai on 15/11/17.
//  Copyright © 2015年 Loopeer. All rights reserved.
//

#import "LPCenterTextFeature.h"
#import "LPCenterTextView.h"

@implementation LPCenterTextFeature

- (instancetype)init {
    self = [super init];
    if (self) {
        [self defaultValues];
    }
    return self;
}

- (void)setRightView:(UIView *)rightView {
    _rightView = rightView;
    if (rightView) {
        _wrapContent = YES;
    }
}

- (UIFont *)contentFont {
    if (!_contentFont) {
        if (_centerTextView && _centerTextView.contentFont) {
            _contentFont = _centerTextView.contentFont;
        } else {
            _contentFont = [UIFont systemFontOfSize:16];
        }
    }
    
    return _contentFont;
}

- (UIColor *)contentColor {
    if (!_contentColor) {
        if (_centerTextView && _centerTextView.contentColor) {
            _contentColor = _centerTextView.contentColor;
        } else {
            _contentColor = [UIColor blackColor];
        }
    }
    
    return _contentColor;
}

- (NSInteger)numberOfLine {
    if (_centerTextView.numberOfLine != 1 && _numberOfLine == 1) {
        return _centerTextView.numberOfLine;
    }
    return _numberOfLine;
}

- (NSInteger)lineSpace {
    if (_lineSpace == 7 && _centerTextView.lineSpace != 7) {
        return _centerTextView.lineSpace;
    }
    return _lineSpace;
}

- (void)defaultValues {
    _numberOfLine = 1;
    _lineSpace = 7;
    _customViewLeftOffset = 8;
    _backgroundColor = [UIColor clearColor];
}

- (NSComparisonResult)compareFeature:(LPCenterTextFeature *)feature {
    if (_Id < feature.Id) {
        return NSOrderedAscending;
    }
    return NSOrderedDescending;
}

@end

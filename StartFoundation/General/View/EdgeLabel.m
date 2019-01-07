//
//  EdgeLabel.m
//  iShanggang
//
//  Created by lijun on 2018/12/7.
//  Copyright © 2018 aishanggang. All rights reserved.
//

#import "EdgeLabel.h"

@implementation EdgeLabel

- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}

-(CGSize )intrinsicContentSize {
   
    CGSize size = [super intrinsicContentSize];
    size.width  += _textInsets.left + _textInsets.right;
    size.height += _textInsets.top + _textInsets.bottom;
    
    return size;
}

@end

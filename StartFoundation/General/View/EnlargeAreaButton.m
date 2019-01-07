//
//  EnlargeAreaButton.m
//  FJSLoan
//
//  Created by 鲍晓飞 on 17/3/29.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "EnlargeAreaButton.h"

@implementation EnlargeAreaButton

/*
 为了扩大uibutton的点击范围
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}



@end

//
//  ISG_Button.m
//  iShanggang
//
//  Created by lijun on 2018/8/8.
//  Copyright © 2018年 aishanggang. All rights reserved.
//

#import "ISG_Button.h"

@implementation ISG_Button

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat space = self.spaceBetweenTitleAndImage;
    CGFloat titleWBefore = self.titleLabel.width;//titleLabel的宽度

    if (self.imageAlignment == SJImageAlignmentTop || self.imageAlignment == SJImageAlignmentBottom) {
        self.titleLabel.width = self.width;
        
        self.titleLabel.left = 0;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }

    CGFloat titleW = self.titleLabel.width;//titleLabel的宽度
    CGFloat titleH = self.titleLabel.height;//titleLabel的高度
    
    CGFloat imageW = self.imageView.width;//imageView的宽度
    CGFloat imageH = self.imageView.height;//imageView的高度
    
    CGFloat btnCenterX = CGRectGetWidth(self.bounds)/2;//按钮中心点X的坐标（以按钮左上角为原点的坐标系）
    CGFloat imageCenterX = btnCenterX - titleW/2;//imageView中心点X的坐标（以按钮左上角为原点的坐标系）
    CGFloat titleCenterX = btnCenterX + imageW/2;//titleLabel中心点X的坐标（以按钮左上角为原点的坐标系）
    
    [self setBtnBorderType:self.borderType];
    
    switch (self.imageAlignment)
    {
        case SJImageAlignmentTop:
        {
            imageCenterX = btnCenterX - titleWBefore/2;//imageView中心点X的坐标（以按钮左上角为原点的坐标系）
            
            self.titleEdgeInsets = UIEdgeInsetsMake(imageH/2+ space/2, -(titleCenterX-btnCenterX), -(imageH/2 + space/2), titleCenterX-btnCenterX);
            self.imageEdgeInsets = UIEdgeInsetsMake(-(titleH/2 + space/2), btnCenterX-imageCenterX, titleH/2+ space/2, -(btnCenterX-imageCenterX));
        }
            break;
        case SJImageAlignmentLeft:
        {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, space/2, 0,  -space/2);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -space/2, 0, space/2);
        }
            break;
        case SJImageAlignmentBottom:
        {
            self.titleEdgeInsets = UIEdgeInsetsMake(-(imageH/2+ space/2), -(titleCenterX-btnCenterX), imageH/2 + space/2, titleCenterX-btnCenterX);
            self.imageEdgeInsets = UIEdgeInsetsMake(titleH/2 + space/2, btnCenterX-imageCenterX,-(titleH/2+ space/2), -(btnCenterX-imageCenterX));
        }
            break;
        case SJImageAlignmentRight:
        {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageW + space/2), 0, imageW + space/2);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleW+space/2, 0, -(titleW+space/2));
        }
            break;
        default:
            break;
    }
}

- (void)setBtnBorderType:(UIViewBorderLineType)borderType {
    
    CGFloat border = 1;
    CALayer *lineLayer = [CALayer layer];
    lineLayer.backgroundColor = [UIColor blackColor].CGColor;
    switch (borderType) {
        case UIViewBorderLineTypeTop:{
            lineLayer.frame = CGRectMake(0, 0, self.width, border);
            break;
        }
        case UIViewBorderLineTypeRight:{
            lineLayer.frame = CGRectMake(self.width + 6, 0, border, self.height);
            break;
        }
        case UIViewBorderLineTypeBottom:{
            lineLayer.frame = CGRectMake(0, self.height, self.width,border);
            break;
        }
        case UIViewBorderLineTypeLeft:{
            lineLayer.frame = CGRectMake(-5, self.height/4, border, self.height/2);
            break;
        }

    }
    
    [self.layer addSublayer:lineLayer];
}

@end

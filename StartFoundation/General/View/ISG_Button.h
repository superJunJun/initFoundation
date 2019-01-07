//
//  ISG_Button.h
//  iShanggang
//
//  Created by lijun on 2018/8/8.
//  Copyright © 2018年 aishanggang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIViewBorderLineType) {
    UIViewBorderLineTypeTop = 1000,
    UIViewBorderLineTypeRight,
    UIViewBorderLineTypeBottom,
    UIViewBorderLineTypeLeft,
};

typedef NS_ENUM(NSUInteger, SJImageAlignment) {
    /**
     *  图片在左，默认
     */
    SJImageAlignmentLeft = 0,
    /**
     *  图片在上
     */
    SJImageAlignmentTop,
    /**
     *  图片在下
     */
    SJImageAlignmentBottom,
    /**
     *  图片在右
     */
    SJImageAlignmentRight,
};

@interface ISG_Button : UIButton
/**
 *  按钮中图片的位置
 */
@property(nonatomic,assign)SJImageAlignment imageAlignment;
/**
 *  按钮中图片与文字的间距
 */
@property(nonatomic,assign)CGFloat spaceBetweenTitleAndImage;

/**
 设置单边boder
 */
@property(nonatomic,assign)UIViewBorderLineType borderType;

@end

//
//  LJLocationHelper.h
//  iShanggang
//
//  Created by  bxf on 2017/6/10.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LJLocationHelper;
@class ISGLocationInfoModel;
@protocol LJLocationHelperDelegate <NSObject>


/**
 定位成功回调

 @param helper self
 @param model 定位model
 */
- (void)locationHelper:(LJLocationHelper *)helper successWithModel:(ISGLocationInfoModel *)model;

@end

@interface LJLocationHelper : NSObject

@property (nonatomic, assign) id<LJLocationHelperDelegate>delegate;
- (void)startLocation;

@end

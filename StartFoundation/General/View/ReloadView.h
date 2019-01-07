//
//  ReloadView.h
//  iShanggang
//
//  Created by lijun on 2018/8/23.
//  Copyright © 2018年 aishanggang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^RefreshBtnBlock)(void);

@interface ReloadView : UIView

@property (nonatomic, copy)RefreshBtnBlock refreshBlock;

@end

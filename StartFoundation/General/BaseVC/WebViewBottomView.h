//
// WebViewBottomView.h
//  StartFoundation
//
//  Created by 李君 on 2019/1/4.
//  Copyright © 2019 李君. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WebBottomViewClickBlcok)(NSString *type);

@interface WebViewBottomView : UIView

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *forwardBtn;
@property (nonatomic, copy  ) WebBottomViewClickBlcok btnBlcok;

@end


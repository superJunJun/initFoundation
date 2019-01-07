//
//  ISGTitleMenuView.h
//  test
//
//  Created by  bxf on 2017/6/23.
//  Copyright © 2017年  bxf. All rights reserved.

// 标题菜单view，比如登录页 密码登陆、验证码登录tab

#import <UIKit/UIKit.h>
@class MenuView;
@protocol MenuViewDelegate <NSObject>

- (void)menuView:(MenuView *)menuView didSelectedIndex:(NSInteger)index;

@end

@interface MenuView : UIView

@property(nonatomic, assign) NSUInteger selectedIndex;
@property(nonatomic, strong) UIColor *selectedColor;
@property(nonatomic, strong) UIColor *unselectedColor;
@property(nonatomic, strong) UIView *menuView;
@property(nonatomic, strong,readonly) NSMutableArray *titles;//array of NSString
@property (nonatomic, assign) id<MenuViewDelegate>delegate;

- (instancetype)initWithMenuViewWithFrame:(CGRect)rect titles:(NSArray *)titleArr;
//+ (instancetype)menuViewControllerWithTitles:(NSArray *)titleArr;


@end

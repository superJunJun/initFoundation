//
//  ISGTitleMenuView.m
//  test
//
//  Created by  bxf on 2017/6/23.
//  Copyright © 2017年  bxf. All rights reserved.
//

#import "MenuView.h"

//static const CGFloat kMaximumNumberChildControllers = 6;

@interface MenuView()<UIScrollViewDelegate>{
    
    UIScrollView *_scrollView;
    UIView *_lineView;
}

@end

@implementation MenuView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithMenuViewWithFrame:(CGRect)rect titles:(NSArray *)titleArr {
    
    self = [self initWithFrame:rect];
    if (self) {
        
        NSAssert(titleArr.count != 0, @"titleArr 不能为空");
        [titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSString class]]) {
                
                [self.titles addObject:obj];
            }
        }];
        
        [self addContent];
    }
    return  self;
}

- (void)commonInit{
    
    self.backgroundColor = [UIColor whiteColor];
    _titles = [[NSMutableArray alloc] init];
    
    _unselectedColor = [UIColor grayColor];
    _selectedColor = [UIColor redColor];
    _selectedIndex = 1;
}

- (void)addContent {
    
    [self addSubview:self.menuView];
}

// 动态适配，最多6个
- (UIView *)menuView {
    
    if (!_menuView) {
        
        _menuView = [[UIView alloc] initWithFrame:self.bounds];
        CGFloat barViewWidth = self.frame.size.width;
        CGFloat itemWidth = barViewWidth/_titles.count ;
        NSUInteger itemCount = [self.titles count];
        CGFloat itemMargin = (barViewWidth - itemCount*itemWidth)/(itemCount+1);
        for (int i=0; i<itemCount; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(i*itemWidth+(i+1)*itemMargin, 0, itemWidth, _menuView.frame.size.height)];
            [button setTitleColor:self.unselectedColor forState:UIControlStateNormal];
            [button setTitleColor:self.selectedColor forState:UIControlStateSelected];
            [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [button setTitle:self.titles[i] forState:UIControlStateNormal];
            button.tag = i+1;
            [button addTarget:self action:@selector(navigationBarButtonItemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_menuView addSubview:button];
            
            if (i==0) {
                [button setTitleColor:self.selectedColor forState:UIControlStateNormal];
            }
        }
        
        UIButton *selectBtn = (UIButton *)[_menuView viewWithTag:self.selectedIndex];
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, selectBtn.frame.size.height-1, selectBtn.frame.size.width, 1)];
        _lineView.backgroundColor = self.selectedColor;
        [_menuView addSubview:_lineView];
    }
    return _menuView;
}

- (void)navigationBarButtonItemClicked:(UIButton *)button{
    self.selectedIndex = button.tag;
}

#pragma mark - set

- (void)setSelectedIndex:(NSUInteger)index{
    
    if (index != self.selectedIndex) {
        UIButton *origin = (UIButton *)[_menuView viewWithTag:self.selectedIndex];
        if ([origin isKindOfClass:[UIButton class]]) {
            [origin setTitleColor:self.unselectedColor forState:UIControlStateNormal];
        }
        
        UIButton *button = (UIButton *)[_menuView viewWithTag:index];
        [button setTitleColor:self.selectedColor forState:UIControlStateNormal];
        _selectedIndex = index;
        [UIView animateWithDuration:.1 animations:^{
            _lineView.left = button.frame.origin.x;
        }];
        if ([self.delegate respondsToSelector:@selector(menuView:didSelectedIndex:)]) {
            [self.delegate menuView:self didSelectedIndex:index-1];
        }
    }
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    
    _selectedColor = selectedColor;
    
    UIButton *selectBtn = (UIButton *)[_menuView viewWithTag:self.selectedIndex];
    [selectBtn setTitleColor:selectedColor forState:UIControlStateNormal];
}

- (void)setUnselectedColor:(UIColor *)unselectedColor {
    
    _unselectedColor = unselectedColor;
    
    for (UIView *view in _menuView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [(UIButton *)view setTitleColor:self.unselectedColor forState:UIControlStateNormal];
        }
    }
    
    UIButton *selectBtn = (UIButton *)[_menuView viewWithTag:self.selectedIndex];
    [selectBtn setTitleColor:self.selectedColor forState:UIControlStateNormal];
    
    _lineView.backgroundColor = self.selectedColor;
}

@end

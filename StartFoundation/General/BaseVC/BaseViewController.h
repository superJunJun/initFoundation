//
//  BaseViewController.h
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

//@property (assign, nonatomic) UIRectEdge customEdgesForExtendedLayout;
//@property (copy, nonatomic) NSString *   _Nullable titleText;
@property (assign, nonatomic) CGSize contentViewSize;
//@property (assign, nonatomic) BOOL isNoticeStyleBlack;
//@property (copy, nonatomic) NSString * _Nullable noticeText;


#pragma mark - barbuttonItem
- (void)ISG_NavigationBarDefaultBackButtonAndNavigationTitle:(NSString *_Nullable)title;
- (void)ISG_NavigationBarWithBackButtonTitle:(NSString *_Nullable)title leftImageNamed:(NSString *_Nullable)leftImageName andAction:(SEL _Nullable )action;
- (void)ISG_NavigationBarRightBarWithTitle:(NSString *_Nullable)title andAction:(nullable SEL)action;
- (void)ISG_NavigationBarRightBarWithTitle:(NSString *_Nullable)title leftImageNamed:(NSString *_Nullable)leftImageName andAction:(nullable SEL)action;

#pragma mark - Refresh
- (void)ISG_update_dataRefreshByScrollview:(nullable UIScrollView *)scroll target:(nullable id)target action:(nullable SEL)action isAutomaticallyRefreshing:(BOOL)isBegining;
- (void)ISG_more_dataRefreshByScrollview:(nullable UIScrollView *)scroll target:(nullable id)target action:(nullable SEL)action;
- (void)ISG_no_dataRefreshByScrollView:(nullable UIScrollView *)scroll;
- (void)ISG_resetRefreshByScrollView:(nullable UIScrollView *)scroll;

- (void)netWorkStateChange:(NSNotification *_Nullable)noti;

@end

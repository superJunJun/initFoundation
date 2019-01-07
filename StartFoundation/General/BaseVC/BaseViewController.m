//
//  BaseViewController.m
//

#import "BaseViewController.h"
#import "BOHUDManager.h"
#import "LoginViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) UIView *noDataView;

@end

@implementation BaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
        backBtn.title = @"";
        self.navigationItem.backBarButtonItem = backBtn;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:0xf8f8f8];

    [self localInfosInitialize];
    
    //解决iOS11：UITableView列表出现错位；页面切换过程中出现抖动问题
    // MARK: -  修改了这个地方-------------------
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkStateChange:) name:sNetworkState object:nil];
}

- (void)localInfosInitialize
{
    self.customEdgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.titleView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationItem.titleView.hidden = YES;
}

- (CGSize )contentViewSize {
    BOOL isIphoneXSseries = [[BOAssistor getDeviceSystemName]containsString:@"IPhone_X"];
    BOOL hasNavBar = !self.navigationController.navigationBarHidden;
    BOOL hasTabBar = !self.tabBarController.tabBar.isHidden;
    
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat navBarHeight = hasNavBar?44:0;
    CGFloat tabBarHeight = isIphoneXSseries?(hasTabBar?83:34):(hasTabBar?49:0);
    
    return CGSizeMake(KSCREEWIDTH, KSCREENHEIGHT - statusBarHeight - navBarHeight -tabBarHeight);
}

#pragma mark - NSNotification  网络恢复后刷新

- (void)netWorkStateChange:(NSNotification *)noti {
    UIViewController *vc = self;
    int networkState = [[noti object] intValue];

    if (networkState != 0) {
        if ([vc respondsToSelector:@selector(loadNewData)]) {
            [vc performSelector:@selector(loadNewData)];
        }
    }
    NSLog(@"开始重新加载网络");
}

#pragma mark - OverridePropertyMethod

- (void)setCustomEdgesForExtendedLayout:(UIRectEdge)customEdgesForExtendedLayout
{
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = customEdgesForExtendedLayout;
//        _customEdgesForExtendedLayout = customEdgesForExtendedLayout;
    }
}

#pragma mark - 工具方法
- (void)ISG_NavigationBarDefaultBackButtonAndNavigationTitle:(NSString *)title {
    self.navigationItem.title = title;
    
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"p_backArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(p_backAction)];
    backBarButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backBarButton;
}

- (void)ISG_NavigationBarWithBackButtonTitle:(NSString *)title leftImageNamed:(NSString *)leftImageName andAction:(SEL)action {
    //这个title是用来设置导航左返回按钮标题的，这里暂时没用。
    if (leftImageName == nil) {
        leftImageName = @"p_backArrow";
    }
    
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:leftImageName] style:UIBarButtonItemStylePlain target:self action:action];
    backBarButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backBarButton;
}

- (void)ISG_NavigationBarRightBarWithTitle:(NSString *)title andAction:(nullable SEL)action {
    UIFont *titleFont = [BOAssistor defaultTextStringFontWithSize:16];
    CGSize strSize = [title boundingRectWithSize:CGSizeMake(200, 100) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:titleFont} context:nil].size;
    CGFloat width = strSize.width+55;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 0, width, 30.0f);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = titleFont;
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)ISG_NavigationBarRightBarWithTitle:(NSString *)title leftImageNamed:(NSString *)leftImageName andAction:(nullable SEL)action {
    UIFont *titleFont = [BOAssistor defaultTextStringFontWithSize:16];
    CGSize strSize = [title boundingRectWithSize:CGSizeMake(200, 100) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:titleFont} context:nil].size;
    CGFloat width = strSize.width+55+50;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 0, width, 30.0f);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:@"set_bankIcon"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"set_bankIcon"] forState:UIControlStateHighlighted];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0,-3,0,3);
    btn.titleLabel.font = titleFont;
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)p_backAction {
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count > 1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == self) {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        //present方式
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)ISG_update_dataRefreshByScrollview:(UIScrollView *)scroll target:(nullable id)target action:(SEL)action isAutomaticallyRefreshing:(BOOL)isBegining {
    //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:action];
    //设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放立即刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    
    //马上进入刷新状态
    if(isBegining)
        [header beginRefreshing];
    
    // 设置header
    scroll.mj_header = header;
    scroll.mj_header.automaticallyChangeAlpha = YES;
}

- (void)ISG_more_dataRefreshByScrollview:(nullable UIScrollView *)scroll target:(nullable id)target action:(nullable SEL)action {
    //添加默认的上拉刷新
    //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter  footerWithRefreshingTarget:self refreshingAction:action];
    //MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:action];
//设置文字
//    [footer setTitle:@"" forState:MJRefreshStateIdle];
//    [footer setTitle:@"" forState:MJRefreshStateRefreshing];
//    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    footer.refreshingTitleHidden = YES;
    //设置footer
    scroll.mj_footer = footer;
}

- (void)ISG_no_dataRefreshByScrollView:(nullable UIScrollView *)scroll {
    MJRefreshAutoNormalFooter * footer = (MJRefreshAutoNormalFooter*)(scroll.mj_footer);
//    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateIdle];
//    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    [footer endRefreshingWithNoMoreData];
}

- (void)ISG_resetRefreshByScrollView:(nullable UIScrollView *)scroll {
    MJRefreshAutoNormalFooter * footer = (MJRefreshAutoNormalFooter*)(scroll.mj_footer);
    [footer resetNoMoreData];
}

@end

//
//  ViewController.m
//  PageViewController
//
//  Created by Wang on 2019/10/22.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "ViewController.h"
#import "ChildViewController.h"
#import "PageSegmentView.h"
@interface ViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate,PageSegmentViewDelegate>
{
    BOOL _done;
    NSInteger _currentIndex;
}

@property (nonatomic,strong) UIPageViewController *pageViewController;

@property (nonatomic,strong) NSMutableArray *vcArray;

@property (nonatomic,strong) PageSegmentView *segmentView;
@end

@implementation ViewController

- (PageSegmentView *)segmentView{
    
    if (!_segmentView) {
        self.segmentView = [[PageSegmentView alloc] initWithNameArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"]];
        _segmentView.defaultColor = [UIColor blueColor];
        _segmentView.selectColor = [UIColor cyanColor];
        _segmentView.lineColor = [UIColor grayColor];
        _segmentView.segmentViewColor = [UIColor orangeColor];
        _segmentView.defaultFont = [UIFont systemFontOfSize:16];
        _segmentView.selectFont = [UIFont systemFontOfSize:20];
        [_segmentView setUIContents];
        _segmentView.frame = CGRectMake(0, 44, SCREEN_WIDTH, 64);
        _segmentView.delegate = self;
    }
    return _segmentView;
}

-(NSMutableArray *)vcArray{
    if (!_vcArray) {
        self.vcArray = [NSMutableArray array];
    }
    return _vcArray;
}

-(UIPageViewController *)pageViewController{
    
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
        _pageViewController.view.frame = CGRectMake(0, 44+64, SCREEN_WIDTH,SCREEN_HEIGHT-64*2);
        for (UIView *subview in _pageViewController.view.subviews) {
            [(UIScrollView *)subview setDelegate:self];
            //设置是否支持手势滑动
            //            [(UIScrollView *)subview setScrollEnabled:NO];
        }
        [_pageViewController setViewControllers:@[self.vcArray[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    return _pageViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.segmentView];
    for (int i = 0; i<8; i++) {
        ChildViewController *childVC = [ChildViewController new];
        childVC.titleText = [NSString stringWithFormat:@"%d",i];
        [self.vcArray addObject:childVC];
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addChildViewController:self.pageViewController];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.view addSubview:self.pageViewController.view];
        
    });
    // Do any additional setup after loading the view.
}

-(void)segmenntView:(PageSegmentView *)seView didClickWithIndex:(NSInteger)index{
    if (index == _currentIndex) {
        return;
    }
    __weak typeof(ViewController *)weakSelf = self;
    [self.pageViewController setViewControllers:@[self.vcArray[index]] direction:index<_currentIndex animated:YES completion:^(BOOL finished) {
        self->_currentIndex = index;
        [weakSelf.segmentView setIndex:0 withClickIndex:index];
    }];
}

// 滑动的下一个VC
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSUInteger index = [self indexOfViewController:viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    
    if (index == [self.vcArray count]) {
        return nil;
    }
    
    return self.vcArray[index];
    
}

// 滑动的上一个VC
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(nonnull UIViewController *)viewController{
    
    NSUInteger index = [self indexOfViewController:viewController];
    
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    
    return self.vcArray[index];
}

// 开始翻页调用
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers NS_AVAILABLE_IOS(6_0) {
}
// 翻页完成调用
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    _done = YES;
    NSInteger index = [self.vcArray indexOfObject:pageViewController.viewControllers[0]];
    _currentIndex = index;
    [self.segmentView setIndex:0 withClickIndex:index];
}
- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED {
    return UIInterfaceOrientationPortrait;
}

// 根据数组元素，得到下标值
- (NSUInteger)indexOfViewController:(UIViewController *)viewControlller {
    return [self.vcArray indexOfObject:viewControlller];
}

#pragma mark - SCrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x-SCREEN_WIDTH;
    if (!_done) {
        [self.segmentView setIndex:offsetX withClickIndex:_currentIndex];
    }else{
        _done = NO;
    }
}

@end

# UIPageViewController
![效果动画](https://github.com/dianXiaoWang/PageSegment/blob/master/SegmentView.gif)
### 使用
```
创建UIPageViewController

// 懒加载PageVC
-(UIPageViewController *)pageViewController{
  if (!_pageViewController) {
      // 初始化
     _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
     _pageViewController.dataSource = self;
     _pageViewController.delegate = self;
     // 设置PageVC上View的frame
     _pageViewController.view.frame = CGRectMake(0, 44+64, SCREEN_WIDTH,SCREEN_HEIGHT-64*2);
     for (UIView *subview in _pageViewController.view.subviews) {
         [(UIScrollView *)subview setDelegate:self];
         // [(UIScrollView *)subview setScrollEnabled:NO];
        }
      // 设置PageVC的子VC
       [_pageViewController setViewControllers:@[self.vcArray[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
      return _pageViewController;
}

// 创建头部标题View
- (PageSegmentView *)segmentView{

 if (!_segmentView) {
    self.segmentView = [[PageSegmentView alloc] initWithNameArray:@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7"]];
    // 默认标题颜色
    _segmentView.defaultColor = [UIColor blueColor];
    // 选中标题颜色
    _segmentView.selectColor = [UIColor cyanColor];
    // 下划线颜色
    _segmentView.lineColor = [UIColor grayColor];
    // 背景颜色
    _segmentView.segmentViewColor = [UIColor orangeColor];
    // 默认标题字体大小
    _segmentView.defaultFont = [UIFont systemFontOfSize:16];
    // 选中标题字体大小
    _segmentView.selectFont = [UIFont systemFontOfSize:20];
    // 加载头部View中的控件
    [_segmentView setUIContents];
    // 设置头部View的大小
    _segmentView.frame = CGRectMake(0, 44, SCREEN_WIDTH, 64);
    _segmentView.delegate = self;
  }
    return _segmentView;
}

```

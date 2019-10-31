//
//  PageSegmentView.m
//  PageViewController
//
//  Created by Wang on 2019/10/22.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "PageSegmentView.h"

@interface PageSegmentView()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIView *nameView;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation PageSegmentView

-(PageSegmentView *)initWithNameArray:(NSArray *)array{
    self = [super init];
    self.nameArray = array;
    return self;
}

-(void)setUIContents{
    if (!_defaultColor) {
        self.defaultColor = [UIColor lightGrayColor];
    }
    if (!_selectColor) {
        self.selectColor = [UIColor blackColor];
    }
    if (!_defaultFont) {
        self.defaultFont = [UIFont  systemFontOfSize:16];
    }
    if (!_selectFont) {
        self.selectFont = [UIFont  systemFontOfSize:20];
    }
    if (!_lineColor) {
        self.lineColor = [UIColor blackColor];
    }
    if (!_segmentViewColor) {
        self.segmentViewColor = [UIColor lightGrayColor];
    }
    
    self.backgroundColor = self.segmentViewColor;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,SEGMENTHEIGHT)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.userInteractionEnabled = UIAccessibilityTraitHeader;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    // 标题View
    self.nameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SEGMENTHEIGHT)];
    for (int i = 0; i<self.nameArray.count; i++) {
        // 标题文字
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ITEMWIDTH * i, 0, ITEMWIDTH, SEGMENTHEIGHT)];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.text = self.nameArray[i];
        nameLabel.tag  = i;
        if (i == 0) {
            nameLabel.textColor = self.selectColor;
            nameLabel.font = self.selectFont;

        }else{
            nameLabel.textColor = self.defaultColor;
            nameLabel.font = self.defaultFont;
        }
        nameLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *clickNameText = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(clickNameLabel:)];
        clickNameText.delegate = self;
        [nameLabel addGestureRecognizer:clickNameText];
        [self.nameView addSubview:nameLabel];
    }
    [self.scrollView addSubview:self.nameView];
    
    // 下划线
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(SEGMENTHEIGHT/4, SEGMENTHEIGHT - 5, SEGMENTHEIGHT/2, LineHeight)];
    self.lineView.backgroundColor = self.lineColor;
    self.lineView.tag = 1001;
    [self.nameView addSubview:self.lineView];
    
}


-(void)clickNameLabel:(UITapGestureRecognizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(segmenntView:didClickWithIndex:)]) {
        [self.delegate segmenntView:self didClickWithIndex:tap.view.tag];
    }
}

-(void)setIndex:(CGFloat)offext withClickIndex:(NSInteger)index{
    
    [self changeViewWithIndex:CGRectMake(index * SEGMENTHEIGHT, 0, ITEMWIDTH, SEGMENTHEIGHT) withIndex:index];
    for (UIView *view in self.nameView.subviews) {
        UILabel *findLabel= (UILabel *)view;
        if (view.tag == index) {
            findLabel.font = self.selectFont;
            findLabel.textColor = self.selectColor;
        }else if (view.tag != 1001){
            findLabel.font = self.defaultFont;
            findLabel.textColor = self.defaultColor;
        }
    }
}

-(void)changeViewWithIndex:(CGRect)frame withIndex:(NSInteger)index{
    self.lineView.frame = CGRectMake(frame.origin.x+SEGMENTHEIGHT/4, SEGMENTHEIGHT - 5, SEGMENTHEIGHT/2, LineHeight);
    CGPoint pointOffset = self.scrollView.contentOffset;
    if (index <= 2) {
        pointOffset.x = 0;
        self.scrollView.contentOffset = pointOffset;
    }
    if ((SCREEN_WIDTH/ITEMWIDTH) - index <=2) {
        pointOffset.x = ITEMWIDTH*(self.nameArray.count) - SCREEN_WIDTH;
        self.nameView.frame = CGRectMake(0, 0, SCREEN_WIDTH+pointOffset.x, SEGMENTHEIGHT);
        self.scrollView.contentOffset = pointOffset;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    NSLog(@"%@",NSStringFromClass([touch.view class]));
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    
    return  YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

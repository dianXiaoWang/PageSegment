//
//  PageSegmentView.h
//  PageViewController
//
//  Created by Wang on 2019/10/22.
//  Copyright © 2019 Wang. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define ITEMWIDTH 64
#define SEGMENTHEIGHT 64
#define LineHeight 2
#define RGB(value) [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 green:((float)((value & 0xFF00) >> 8))/255.0 blue:((float)(value & 0xFF))/255.0 alpha:1.0]

#import <UIKit/UIKit.h>

@class PageSegmentView;

NS_ASSUME_NONNULL_BEGIN

/*
 代理方法,点击头部按钮
*/
@protocol PageSegmentViewDelegate <NSObject>

-(void)segmenntView:(PageSegmentView *)seView didClickWithIndex:(NSInteger )index;

@end

@interface PageSegmentView : UIView

@property (nonatomic,weak) id<PageSegmentViewDelegate> delegate;
@property (nonatomic,strong) NSArray *nameArray;
@property (nonatomic,strong) UIScrollView *scrollView;
/*
 默认字体颜色
*/
@property (nonatomic,strong) UIColor *defaultColor;
/*
 选中字体颜色
*/
@property (nonatomic,strong) UIColor *selectColor;
/*
 下划线颜色
*/
@property (nonatomic,strong) UIColor *lineColor;
/*
 默认字体大小
*/
@property (nonatomic,strong) UIFont  *defaultFont;
/*
 选中字体大小
*/
@property (nonatomic,strong) UIFont  *selectFont;
/*
 背景颜色
*/
@property (nonatomic,strong) UIColor *segmentViewColor;



-(PageSegmentView *)initWithNameArray:(NSArray *)array;
-(void)setIndex:(CGFloat )offext withClickIndex:(NSInteger )index;
-(void)setUIContents;
@end

NS_ASSUME_NONNULL_END

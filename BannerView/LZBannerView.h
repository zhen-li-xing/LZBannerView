//
//  LZBannerView.h
//  LZBannerView
//
//  Created by 李震 on 16/8/8.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LZCycleStyle) {
    //横向轮播
    LZCycleStyleHorizontal = 0,
    //纵向轮播
    LZCycleStyleVertical = 1,
};

typedef NS_ENUM(NSInteger,LZBannerSource) {
    //图片源自本帝
    LZBannerStyleOnlyLocalSource = 0,
    //图片源自于网络
    LZBannerStyleOnlyWebSource,
    //纯文本
    LZBannerStyleOnlyTextSource,
};


@protocol LZBannerViewDelegate <NSObject>

- (void)didSelectItemAtIndex:(NSInteger)index;

@end

@interface LZBannerView : UIView

/** 本地图片 */
@property(nonatomic,strong) UIImage     *localizationImage;
/** 要显示的文字数组 */
@property(nonatomic,strong) NSArray     *titleArray;

@property(nonatomic,strong) NSArray     *imageArray;

/** 自动滚动间隔时间,默认2s */
@property(nonatomic,assign) CGFloat     autoScrollTimeInterval;
/** 是否无限循环,默认Yes */
@property(nonatomic,assign) BOOL        infiniteLoop;
/** 是否自动滚动,默认Yes */
@property(nonatomic,assign) BOOL        autoScroll;

/** 轮播文字label字体颜色 */
@property (nonatomic, strong) UIColor *titleLabelTextColor;
/** 轮播文字label字体大小 */
@property (nonatomic, strong) UIFont  *titleLabelTextFont;
/** 轮播文字label背景颜色 */
@property (nonatomic,strong) UIColor *titleLabelBackgroundColor;
/** 轮播文字label高度 */
@property (nonatomic,assign) CGFloat titleLabelHeight;
/** 轮播方向 */
@property (nonatomic,assign) LZCycleStyle cycleStyle;
/** 轮播内容 */
@property (nonatomic,assign) LZBannerSource bannerSource;
/** 代理 */
@property (nonatomic,weak) id<LZBannerViewDelegate>deleGate;

/** 轮播初始化方式 */
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame WithCycleStyle:(LZCycleStyle)cycleStyle WithBannerSource:(LZBannerSource)bannerSource;


@end

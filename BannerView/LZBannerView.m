//
//  LZBannerView.m
//  LZBannerView
//
//  Created by 李震 on 16/8/8.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import "LZBannerView.h"
#import "LZBannerCell.h"
#import "UIImageView+WebCache.h"

NSString *const collectionID = @"collectionID";
@interface LZBannerView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,weak) UICollectionView              * collocation;
@property(nonatomic,weak) UICollectionViewFlowLayout    * flowLayout;
@property(nonatomic,weak) NSTimer                       * timer;
@property(nonatomic,assign) NSInteger                       totalItemsCount;

@end

@implementation LZBannerView

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame WithCycleStyle:(LZCycleStyle)cycleStyle WithBannerSource:(LZBannerSource)bannerSource{
    LZBannerView *scrollView = [[self alloc] initWithFrame:frame WithCycleStyle:cycleStyle WithBannerSource:bannerSource];
    
    return scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame WithCycleStyle:(LZCycleStyle)cycleStyle WithBannerSource:(LZBannerSource)bannerSource
{
    self = [super initWithFrame:frame];
    if (self) {
        _cycleStyle = cycleStyle;
        _bannerSource = bannerSource;
        [self initialization];
//        if (bannerSource == LZBannerStyleOnlyTextSource) {
            [self setUpMainView];
//        }
        
    }
    return self;
}

- (void)initialization{
    
    _autoScrollTimeInterval     = 2;
    _infiniteLoop               = YES;
    _autoScroll                 = YES;
    
    _titleLabelTextColor        = [UIColor blackColor];
    _titleLabelTextFont         = [UIFont systemFontOfSize:14];
    _titleLabelBackgroundColor  = [UIColor whiteColor];
    _titleLabelHeight           = 35;
    
}

- (void)setUpMainView{
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumLineSpacing = 0;
    if (_cycleStyle == LZCycleStyleVertical) {
       flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    }else{
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    _flowLayout = flow;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
    collectionView.pagingEnabled = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    if (_bannerSource == LZBannerStyleOnlyTextSource) {
        [collectionView registerClass:[LZBannerCell class] forCellWithReuseIdentifier:LZTextStyle];
    }else{
        [collectionView registerClass:[LZBannerCell class] forCellWithReuseIdentifier:LSImageStyle];
    }
    
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    _collocation = collectionView;
}

#pragma mark - setter

- (void)setInfiniteLoop:(BOOL)infiniteLoop{
    
    _infiniteLoop = infiniteLoop;
    
}

- (void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    [_timer invalidate];
    _timer = nil;
    
    if (_autoScroll) {
        [self setUpTimer];
    }
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval{
    
    _autoScrollTimeInterval = autoScrollTimeInterval;
    
    [self setAutoScroll:self.autoScroll];
}

- (void)setTitleArray:(NSArray *)titleArray{
    
    if (titleArray.count < _titleArray.count) {
        [_collocation setContentOffset:CGPointZero];
    }
    
    _titleArray = titleArray;
    
    _totalItemsCount = self.infiniteLoop ? titleArray.count * 10 : titleArray.count;
    
    if (titleArray.count != 1) {
        self.collocation.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    }else{
        self.collocation.scrollEnabled = NO;
    }
    [self.collocation reloadData];
}

- (void)setImageArray:(NSArray *)imageArray{
    if (imageArray.count < _imageArray.count) {
        [_collocation setContentOffset:CGPointZero];
    }
    
    _imageArray = imageArray;
    
    _totalItemsCount = self.infiniteLoop ? imageArray.count * 10 : imageArray.count;
    
    if (imageArray.count != 1) {
        self.collocation.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    }else{
        self.collocation.scrollEnabled = NO;
    }
    [self.collocation reloadData];
}

#pragma mark - actions

- (void)setUpTimer{
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)automaticScroll{
    
    if (0 == _totalItemsCount) return;
    int currentIndex = 0;
    if (_cycleStyle == LZCycleStyleVertical ) {
        currentIndex = _collocation.contentOffset.y / _flowLayout.itemSize.height;
    }else{
        currentIndex = _collocation.contentOffset.x / _flowLayout.itemSize.width;
    }
    
    int targetIndex = currentIndex + 1;
    if (targetIndex == _totalItemsCount) {
        if (self.infiniteLoop) {
            targetIndex = _totalItemsCount * 0.5;
        }else{
            return;
        }
        [_collocation scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        return;
    }
    [_collocation scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma mark - layout
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    _flowLayout.itemSize = self.frame.size;
    if (_collocation.contentOffset.y == 0 && _totalItemsCount) {
        
        int targetIndex = 0;
        if (self.infiniteLoop) {
            targetIndex = _totalItemsCount * 0.5;
        }else{
            targetIndex = 0;
        }
        [_collocation scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

#pragma mark - public actions

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_bannerSource == LZBannerStyleOnlyTextSource) {
        LZBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LZTextStyle forIndexPath:indexPath];
        long itemIndex = indexPath.item % self.titleArray.count;
        
        NSString *titleStr = self.titleArray[itemIndex];
        
        cell.title = titleStr;
        cell.titleLabelHeight = self.titleLabelHeight;
        cell.titleLabelTextFont = self.titleLabelTextFont;
        cell.titleLabelTextColor = self.titleLabelTextColor;
        cell.titleLabelBackgroundColor = self.titleLabelBackgroundColor;
        cell.imageView.image = _localizationImage;
        return cell;
    }else{
        LZBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LSImageStyle forIndexPath:indexPath];
        long itemIndex = indexPath.item % self.imageArray.count;
        
        NSString *titleStr = self.titleArray[itemIndex];
        
        NSString * imgStr = self.imageArray[itemIndex];
        
        
        cell.title = titleStr;
        cell.titleLabelHeight = self.titleLabelHeight;
        cell.titleLabelTextFont = self.titleLabelTextFont;
        cell.titleLabelTextColor = self.titleLabelTextColor;
        cell.titleLabelBackgroundColor = self.titleLabelBackgroundColor;
        
        if (_bannerSource == LZBannerStyleOnlyLocalSource) {
            cell.imageView.image = [UIImage imageNamed:imgStr];
        }else{
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imgStr]];
        }
        
        
        return cell;
    }
    return nil;
   
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.deleGate respondsToSelector:@selector(didSelectItemAtIndex:)]) {
        if (_bannerSource == LZBannerStyleOnlyTextSource) {
            [self.deleGate didSelectItemAtIndex:indexPath.item%self.titleArray.count];
        }else{
            [self.deleGate didSelectItemAtIndex:indexPath.item%self.imageArray.count];
        }
       
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.autoScroll) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.autoScroll) {
        [self setUpTimer];
    }
}

#pragma mark - timer == nil
//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [_timer invalidate];
        _timer = nil;
    }
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    _collocation.delegate = nil;
    _collocation.dataSource = nil;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

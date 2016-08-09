//
//  LZBannerCell.h
//  LZBannerView
//
//  Created by 李震 on 16/8/9.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *LZTextStyle = @"LZTextStyle";
static NSString *LSImageStyle = @"LSImageStyle";


@interface LZBannerCell : UICollectionViewCell

@property(nonatomic,weak) UIImageView       *imageView;
@property(nonatomic,copy) NSString          *title;

@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIFont *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;

@end

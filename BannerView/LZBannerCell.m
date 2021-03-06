//
//  LZBannerCell.m
//  LZBannerView
//
//  Created by 李震 on 16/8/9.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import "LZBannerCell.h"

@implementation LZBannerCell
{
    __weak UILabel   *_titleLable;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpImageView];
        [self setUpTitleLable];
        
        
    }
    return self;
}

#pragma mark - init
- (void)setUpImageView{
    
    UIImageView *imageV = [[UIImageView alloc] init];
    _imageView = imageV;
    [self.contentView addSubview:self.imageView];
}

- (void)setUpTitleLable{
    
    UILabel *lable = [[UILabel alloc] init];
    _titleLable = lable;
    lable.textAlignment = NSTextAlignmentLeft;
    lable.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLable];
}

#pragma mark - setter
- (void)setTitle:(NSString *)title{
    _title = title;
    _titleLable.text = title;
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor{
    _titleLabelTextColor = titleLabelTextColor;
    _titleLable.textColor = titleLabelTextColor;
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont{
    _titleLabelTextFont = titleLabelTextFont;
    _titleLable.font = titleLabelTextFont;
}

- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor{
    _titleLabelBackgroundColor = titleLabelBackgroundColor;
    _titleLable.backgroundColor = titleLabelBackgroundColor;
}

#pragma mark - layout
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    if ([self.reuseIdentifier isEqualToString:LZTextStyle]) {
        CGFloat imageVToLeft = 5;
        CGFloat imageVWidth  = 12;
        CGFloat imageVY      = (self.frame.size.height - imageVWidth)/2;
        _imageView.frame = CGRectMake(5, imageVY, imageVWidth, imageVWidth);
        
        CGFloat titleLableW = self.frame.size.width - imageVToLeft*3 - imageVWidth;
        CGFloat titleLableH = _titleLabelHeight;
        CGFloat titleLableX = imageVToLeft * 3+imageVWidth;
        CGFloat titleLableY = (self.frame.size.height-titleLableH)/2;
        _titleLable.frame = CGRectMake(titleLableX, titleLableY, titleLableW, titleLableH);
    }else{
        _imageView.frame = self.bounds;
        
        _titleLable.frame = CGRectMake(0, self.frame.size.height - 21, self.frame.size.width, 21);
//        _titleLable.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
    }
    
    
    
}


@end

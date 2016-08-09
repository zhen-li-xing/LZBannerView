//
//  ViewController.m
//  LZBannerView
//
//  Created by 李震 on 16/8/8.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import "ViewController.h"
#import "LZBannerView.h"

@interface ViewController ()<LZBannerViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self scrollView];
}

- (void)scrollView{
    //纯文本
    NSArray *titles = @[@"这是一个文字上下轮播图",
                        @"感谢您的支持",
                        @"如果代码在使用过程中出现问题",
                        @"嗯,请加Q2769614822"
                        ];
    //本地图片
    NSArray *array = @[@"home_1",@"home_2",@"home_3",@"home_4",@"home_5",@"home_6",@"home_7"];
    //网络图片
    NSArray *myWebArray = @[
                            
                            @"http://upload-images.jianshu.io/upload_images/132114-efbfcc01674c6b25.jpg?imageView2/2/w/1240/q/100",
                            @"http://upload-images.jianshu.io/upload_images/132114-f42cac262b9b6a6a.jpg?imageView2/2/w/1240/q/100",
                            @"http://upload-images.jianshu.io/upload_images/132114-43eac6a00b6397d2.jpg?imageView2/2/w/1240/q/100",
                            @"http://upload-images.jianshu.io/upload_images/132114-35b4acc945d615a1.jpg?imageView2/2/w/1240/q/100",
                            @"http://upload-images.jianshu.io/upload_images/132114-c2a07e52504e7b81.jpg?imageView2/2/w/1240/q/100",
                            @"http://upload-images.jianshu.io/upload_images/132114-68a63c1192691868.jpg?imageView2/2/w/1240/q/100"
                            ];
    
    LZBannerView *scrollView = [LZBannerView cycleScrollViewWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width * 3 / 4) WithCycleStyle:LZCycleStyleHorizontal WithBannerSource:LZBannerStyleOnlyLocalSource];
    scrollView.backgroundColor = [UIColor blueColor];
    
    scrollView.localizationImage = [UIImage imageNamed:@"xx_ico"];
    scrollView.deleGate = self;
//    scrollView.titleArray = titles;
    scrollView.imageArray = array;
    [self.view addSubview:scrollView];
    
    
    
}

- (void)didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"这是第%ld个",(long)index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

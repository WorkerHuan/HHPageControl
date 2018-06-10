//
//  ViewController.m
//  HHPageControl
//
//  Created by mac on 2018/4/7.
//  Copyright © 2018年 JS. All rights reserved.
//

#import "ViewController.h"
#import "HHPageScrollView.h"
#import "TestViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    HHPageScrollView *pageView = [[HHPageScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:pageView];
    pageView.titleArr = @[@"语文",@"数学",@"英语",@"生物",@"化学"];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i ++) {
        if (i == 0) {
            TestViewController *testVc = [[TestViewController alloc] init];
            [self addChildViewController:testVc];
            [arr addObject:testVc];
        }else
        {
            UIViewController *vc = [[UIViewController alloc] init];
            
            int R = (arc4random() % 256) ;
            int G = (arc4random() % 256) ;
            int B = (arc4random() % 256) ;
            vc.view.backgroundColor =[UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
            [self addChildViewController:vc];
            [arr addObject:vc];
        }
        
    }
    pageView.pageControlls = arr;
    
    [pageView refresh];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

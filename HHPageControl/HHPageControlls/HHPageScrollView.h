//
//  HHPageScrollView.h
//  HHPageControl
//
//  Created by mac on 2018/4/7.
//  Copyright © 2018年 JS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHPageScrollView : UIView
@property (nonatomic , copy) NSArray *titleArr;
@property (nonatomic , copy) NSArray <UIViewController *>*pageControlls;

- (void)refresh;

@end

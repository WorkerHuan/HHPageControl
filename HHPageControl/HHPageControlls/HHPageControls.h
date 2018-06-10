//
//  HHPageControls.h
//  HHPageControl
//
//  Created by mac on 2018/4/7.
//  Copyright © 2018年 JS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HHPageScrollviewDelegate<NSObject>

@required
- (void)page_didScrollAtPage:(NSInteger)page;
@end

@interface HHPageControls : UIView
@property (nonatomic , copy) NSArray <UIViewController *>*pageControlls;
@property (nonatomic, assign) id<HHPageScrollviewDelegate> delegate;
@property (nonatomic , strong) UICollectionView *pageCollectionView;/**< */
- (void)scrollToDesPageWithIndexPath:(NSIndexPath *)indexPath;

@end

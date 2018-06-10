//
//  HHItemView.h
//  HHPageControl
//
//  Created by mac on 2018/4/7.
//  Copyright © 2018年 JS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HHItem_ScrollviewDelegate<NSObject>

@required
- (void)item_disSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HHItemView : UIView

@property (nonatomic , copy) NSArray *titleArr;
@property (nonatomic, assign) id<HHItem_ScrollviewDelegate> delegate;

@property (nonatomic , strong) UICollectionView *itemCollectionView;/**< */
- (void)scrollCollectionItemToDesWithDesIndex:(NSInteger)index;
@end

//
//  HHPageScrollView.m
//  HHPageControl
//
//  Created by mac on 2018/4/7.
//  Copyright © 2018年 JS. All rights reserved.
//

#import "HHPageScrollView.h"
#import "HHItemView.h"
#import "HHPageControls.h"

@interface HHPageScrollView()<HHItem_ScrollviewDelegate,HHPageScrollviewDelegate>
@property (nonatomic , strong) HHItemView *itemView;/**< */
@property (nonatomic , strong) HHPageControls *pageView;/**< */
@end

@implementation HHPageScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setHHScrollHeaderPage];
    }
    return self;
}

- (void)setHHScrollHeaderPage
{
    self.itemView = [[HHItemView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    self.itemView.delegate = self;
    [self addSubview:self.itemView];
    
    self.pageView = [[HHPageControls alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height - 40)];
    self.pageView.delegate = self;
    [self addSubview:self.pageView];
    
}

- (void)refresh
{
    self.itemView.titleArr = self.titleArr;
    self.pageView.pageControlls = self.pageControlls;
    [self.itemView.itemCollectionView reloadData];
    [self.pageView.pageCollectionView reloadData];
}

- (void)item_disSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < (self.titleArr.count-1)) {
        [self.pageView scrollToDesPageWithIndexPath:indexPath];
    }
    
}

- (void)page_didScrollAtPage:(NSInteger)page
{
    [self.itemView scrollCollectionItemToDesWithDesIndex:page];
}
@end

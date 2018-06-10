//
//  HHPageControls.m
//  HHPageControl
//
//  Created by mac on 2018/4/7.
//  Copyright © 2018年 JS. All rights reserved.
//

#import "HHPageControls.h"
#import "HHPageControlsCell.h"
@interface HHPageControls()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic , assign) NSInteger currentPage;
@end



@implementation HHPageControls

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCollectionView];
    }
    return self;
}

- (void)setCollectionView
{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    //2.初始化collectionView
    _pageCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    [self addSubview:_pageCollectionView];
    _pageCollectionView.backgroundColor = [UIColor clearColor];
    _pageCollectionView.showsHorizontalScrollIndicator = NO;
    //    //3.注册collectionViewCell
    [_pageCollectionView registerNib:[UINib nibWithNibName:@"HHPageControlsCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HHPageControlsCell"];
    _pageCollectionView.pagingEnabled = YES;
    //4.设置代理
    _pageCollectionView.delegate = self;
    _pageCollectionView.dataSource = self;
}

- (void)scrollToDesPageWithIndexPath:(NSIndexPath *)indexPath
{
    self.currentPage = indexPath.row;
    [self.pageCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}


//结束拖拽时,计算当前位于第几页
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger currentPage = (int)(scrollView.contentOffset.x) / (int)(self.frame.size.width);
    self.currentPage = currentPage;
    if (self.delegate && [self.delegate respondsToSelector:@selector(page_didScrollAtPage:)]) {
        [self.delegate page_didScrollAtPage:currentPage];
    }
    
}

#pragma mark collectionView代理方法
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pageControlls.count;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"HHPageControlsCell";
    HHPageControlsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    UIView *oldView = [cell.contentView viewWithTag:1001];
    if (oldView) {
        [oldView removeFromSuperview];
    }
    UIViewController *vc = self.pageControlls[indexPath.row];
    vc.view.frame = CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame));
    vc.view.tag = 1001;
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

@end

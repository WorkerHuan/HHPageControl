//
//  HHItemView.m
//  HHPageControl
//
//  Created by mac on 2018/4/7.
//  Copyright © 2018年 JS. All rights reserved.
//

#import "HHItemView.h"
#import "HHItemCell.h"
typedef void(^sendblock)(int index);
@interface HHItemView()<UICollectionViewDelegate,UICollectionViewDataSource>


/**记录当前选择的 indexpath**/
@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end


@implementation HHItemView

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
    
    NSIndexPath *desIndexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.currentIndexPath = desIndexpath;
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    //2.初始化collectionView
    _itemCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    [self addSubview:_itemCollectionView];
    _itemCollectionView.backgroundColor = [UIColor clearColor];
    _itemCollectionView.showsHorizontalScrollIndicator = NO;
    //    //3.注册collectionViewCell
    [_itemCollectionView registerNib:[UINib nibWithNibName:@"HHItemCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HHItemCell"];
    
    //4.设置代理
    _itemCollectionView.delegate = self;
    _itemCollectionView.dataSource = self;
}


#pragma mark -- 处理滑屏事件
- (void)scrollCollectionItemToDesWithDesIndex:(NSInteger)index{
    
    NSIndexPath *desIndexpath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.itemCollectionView  scrollToItemAtIndexPath:desIndexpath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    self.currentIndexPath = desIndexpath;
    [self.itemCollectionView reloadData];
    
}
#pragma mark collectionView代理方法

//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(self.frame.size.width/4.0, self.frame.size.height);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"HHItemCell";
    HHItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell.tiltleBtn setTitle:self.titleArr[indexPath.row] forState:UIControlStateNormal];
    if (indexPath == self.currentIndexPath) {
        [cell.tiltleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }else
    {
        [cell.tiltleBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }
    
    
    return cell;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentIndexPath = indexPath;
    [collectionView reloadData];
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(item_disSelectRowAtIndexPath:)]) {
        [self.delegate item_disSelectRowAtIndexPath:indexPath];
    }
}

@end

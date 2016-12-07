//
//  CollectionViewLayout.m
//
//  Created by mac on 16/9/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DraggingCollectionViewLayout.h"
static const CGFloat itemHeight = 40;
@implementation DraggingCollectionViewLayout

-(instancetype)initWithItemsWidthBlock:(WidthBlock)block{
    self = [super init];
    if (self) {
        self.widthBlock = block;
        _colMargin = 8;
        _colWidth = 10;
    }
    return self;
}

//布局前的的初始工作
- (void)prepareLayout{

    [super prepareLayout];
    _rightSpace = 0;
    _bottomSpace = 0;
}


//内容尺寸
-(CGSize)collectionViewContentSize{
   
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, self.bottomSpace + itemHeight );
}


//为每一个item设置属性

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    //获取cell的高度
    CGFloat width = 0;
    if (self.widthBlock) {
         width = self.widthBlock(indexPath);
    }
    self.rightSpace += self.colWidth;
    if (self.rightSpace + width > [UIScreen mainScreen].bounds.size.width) {
        self.rightSpace = self.colWidth;
        self.bottomSpace += itemHeight + self.colMargin;
    }
    attributes.frame = CGRectMake(self.rightSpace, self.bottomSpace , width, itemHeight);
    self.rightSpace += width;
 
    return attributes;
    
}

//获取item的属性
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *mutArr = [NSMutableArray array];
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    for (int i=0; i<items; i++) {
        UICollectionViewLayoutAttributes *att = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [mutArr addObject:att];
    }
    return mutArr;
}

//这个方法是会在cell时重新布局并调用repareLayout方法
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end

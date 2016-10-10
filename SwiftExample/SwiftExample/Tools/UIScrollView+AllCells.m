//
//  UIScrollView+AllCells.m
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/9.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

#import "UIScrollView+AllCells.h"

@implementation UIScrollView (AllCells)

// 获取所有cell
- (NSArray *)allCells
{
    if ([self isKindOfClass:[UITableView class]]) {
        
        
        UITableView *aTableView = (UITableView *)self;
        NSInteger sections = aTableView.numberOfSections;
        NSMutableArray *cells = [[NSMutableArray alloc] init];
        for (int section = 0; section < sections; section++) {
            NSInteger rows =  [aTableView numberOfRowsInSection:section];
            for (int row = 0; row < rows; row++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
                if ([aTableView cellForRowAtIndexPath:indexPath]!=nil) {
                    [cells addObject:[aTableView cellForRowAtIndexPath:indexPath]];
                }
            }
        }
        return cells;
        
        
    }else if ([self isKindOfClass:[UICollectionView class]]){
        
        
        UICollectionView *aCollectionView = (UICollectionView *)self;
        NSInteger sections = aCollectionView.numberOfSections;
        NSMutableArray *collectionCells = [[NSMutableArray alloc] init];
        for (int section = 0; section < sections; section++) {
            NSInteger rows =  [aCollectionView numberOfItemsInSection:section];
            for (int row = 0; row < rows; row++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
                if ([aCollectionView cellForItemAtIndexPath:indexPath]!=nil) {
                    [collectionCells addObject:[aCollectionView cellForItemAtIndexPath:indexPath]];
                }
            }
        }
        return collectionCells;
    }
    
    
    return nil;
}



-(NSArray *)cellsForCollectionView:(UICollectionView *)collectionView
{
    NSInteger sections = collectionView.numberOfSections;
    NSMutableArray *cells = [[NSMutableArray alloc]  init];
    for (int section = 0; section < sections; section++) {
        NSInteger rows =  [collectionView numberOfItemsInSection:section];
        for (int row = 0; row < rows; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            if ([collectionView cellForItemAtIndexPath:indexPath]!=nil) {
                [cells addObject:[collectionView cellForItemAtIndexPath:indexPath]];
            }
        }
    }
    return cells;
}

-(NSArray *)cellsFortableView:(UITableView *)tableView
{
    NSInteger sections = tableView.numberOfSections;
    NSMutableArray *cells = [[NSMutableArray alloc]  init];
    for (int section = 0; section < sections; section++) {
        NSInteger rows =  [tableView numberOfRowsInSection:section];
        for (int row = 0; row < rows; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            if ([tableView cellForRowAtIndexPath:indexPath]!=nil) {
                [cells addObject:[tableView cellForRowAtIndexPath:indexPath]];
            }
        }
    }
    return cells;
}

@end

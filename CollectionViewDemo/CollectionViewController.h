//
//  CollectionViewController.h
//  CollectionViewDemo
//
//  Created by CashLee on 14-4-13.
//  Copyright (c) 2014年 cashlee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectionViewDelegate <NSObject>

@optional

-(void)collectionViewDidEndDecelerating:(UIScrollView *)scrollView;
-(void)collectionViewDidScroll:(UIScrollView *)scrollView;
-(void)collectionViewWillBeginDecelerating:(UIScrollView *)scrollView;
-(void)collectionViewWillBeginDragging:(UIScrollView *)scrollView;
-(void)collectionViewDidEndDragging:(UIScrollView *)scrollView;

@end

@interface CollectionViewController : UICollectionViewController
{
    id<CollectionViewDelegate> delegate;
}

@property (nonatomic, retain) id <CollectionViewDelegate> delegate;

@end

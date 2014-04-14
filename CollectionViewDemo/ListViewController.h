//
//  ListViewController.h
//  CollectionViewDemo
//
//  Created by CashLee on 14-4-13.
//  Copyright (c) 2014年 cashlee. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ListViewDelegate <NSObject>

@optional

-(void)listViewDidEndDecelerating:(UIScrollView *)scrollView;
-(void)listViewDidScroll:(UIScrollView *)scrollView;
-(void)listViewWillBeginDecelerating:(UIScrollView *)scrollView;
-(void)listViewWillBeginDragging:(UIScrollView *)scrollView;
-(void)listViewDidEndDragging:(UIScrollView *)scrollView;

@end

@interface ListViewController : UITableViewController
{
    id<ListViewDelegate> delegate;
}

@property (nonatomic, retain) id <ListViewDelegate> delegate;

@end

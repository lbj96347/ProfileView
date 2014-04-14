//
//  MainViewController.h
//  CollectionViewDemo
//
//  Created by CashLee on 14-4-10.
//  Copyright (c) 2014年 cashlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUNSlideSwitchView.h"
#import "ListViewController.h"
#import "CollectionViewController.h"

@interface MainViewController : UIViewController
<SUNSlideSwitchViewDelegate , ListViewDelegate, CollectionViewDelegate , UIScrollViewDelegate>

@end

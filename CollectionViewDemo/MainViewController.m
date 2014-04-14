//
//  MainViewController.m
//  CollectionViewDemo
//
//  Created by CashLee on 14-4-10.
//  Copyright (c) 2014年 cashlee. All rights reserved.
//

#import "MainViewController.h"
#import "Masonry.h"
#import "ListViewController.h"
#import "CollectionViewController.h"

@interface MainViewController ()

@property (nonatomic, retain) UIScrollView * scrollView;
@property (nonatomic, retain) SUNSlideSwitchView * slideSwitchView;
@property (nonatomic, retain) NSMutableArray * viewControllerArray;
@property int lastPosition;
@property float dynamicHeight;
@property BOOL directionUp;

@property (nonatomic, retain) UIPanGestureRecognizer * panGesture;

@property (nonatomic, strong) ListViewController *vc1;
@property (nonatomic, strong) UIViewController *vc2;
@property (nonatomic, strong) UIViewController *vc3;
@property (nonatomic, strong) UIViewController *vc4;
@property (nonatomic, strong) UIViewController *vc5;
@property (nonatomic, strong) UIViewController *vc6;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setSlideViewStyle];
}

#pragma mark - set ddScrollView style
-(void)setSlideViewStyle
{

    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.bounces = YES;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 250);
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    //[self.scrollView setContentInset:UIEdgeInsetsMake(-125, 0, 0, 0)];
    
    UILabel * testLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 80 , 40 , 40)];
    [testLabel setText:@"hello world"];
    [testLabel setBackgroundColor:[UIColor blackColor]];
    [self.scrollView addSubview:testLabel];
    
    self.scrollView.backgroundColor = [UIColor grayColor];
   
    self.slideSwitchView = [[SUNSlideSwitchView alloc]initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, self.view.frame.size.height)];
    self.dynamicHeight = self.view.frame.size.height;//set dynamic height a max value
    
    [self.slideSwitchView setSlideSwitchViewDelegate:self];
    
    /*
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
	[self.panGesture setMaximumNumberOfTouches:1];
	[self.slideSwitchView addGestureRecognizer:self.panGesture];
    */
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.slideSwitchView];
    
    self.slideSwitchView.tabItemNormalColor = [UIColor colorWithRed:77.0f/255.0f green:76.0f/255.0f blue:79.0f/255.0f alpha:1];
    self.slideSwitchView.tabItemSelectedColor = [UIColor colorWithRed:125.0f/255.0f green:103.0f/255.0f blue:206.0f/255.0f alpha:1];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"timeline_underline.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
    ListViewController * listView1 = [[ListViewController alloc]init];
    [listView1 setDelegate:self];
    listView1.view.backgroundColor = [UIColor redColor];
    listView1.title = @"广场";
    listView1.delegate = self;
    
    CollectionViewController * listView2 = [[CollectionViewController alloc]init];
    listView2.title = @"关注";
    [listView2 setDelegate:self];
    UIViewController * listView3 = [[UIViewController alloc]init];
    listView3.view.backgroundColor = [UIColor blackColor];
    listView3.title = @"最新";
    UIViewController * listView4 = [[UIViewController alloc]init];
    listView4.view.backgroundColor = [UIColor yellowColor];
    listView4.title = @"最热";
    
    self.viewControllerArray = [[NSMutableArray alloc]initWithObjects:listView1,listView2,listView3,listView4,nil];

    self.vc1 = listView1;
    self.vc2 = listView2;
    self.vc3 = listView3;
    self.vc4 = listView4;
    
    self.vc1.view.userInteractionEnabled = NO;
    
    [self addChildViewController:self.vc1];
    [self addChildViewController:self.vc2];
    [self addChildViewController:self.vc3];
    [self addChildViewController:self.vc4];
   
    [self.slideSwitchView buildUI];
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 滑动tab视图代理方法

- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return 4;
}

- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    if (number == 0) {
        return self.vc1;
    } else if (number == 1) {
        return self.vc2;
    } else if (number == 2) {
        return self.vc3;
    } else if (number == 3) {
        return self.vc4;
    } else {
        return nil;
    }
}

- (void)slideSwitchView:(SUNSlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer *)panParam
{
    //SUNViewController *drawerController = (SUNViewController *)self.navigationController.mm_drawerController;
    //[drawerController panGestureCallback:panParam];
}

- (void)slideSwitchView:(SUNSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    UIViewController *vc = nil;
    if (number == 0) {
        vc = self.vc1;
    } else if (number == 1) {
        vc = self.vc2;
    } else if (number == 2) {
        vc = self.vc3;
    } else if (number == 3) {
        vc = self.vc4;
    }
}


#pragma mark - MainViewScrollView Delegate Methods
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"content offset y is %f " , scrollView.contentOffset.y );
    if ( scrollView.contentOffset.y <= 125 && scrollView.contentOffset.y > 0 ) {
        self.slideSwitchView.frame = CGRectMake(0, 250 - scrollView.contentOffset.y , 320 , self.dynamicHeight );
        self.scrollView.contentSize = CGSizeMake(0 , self.view.frame.size.height + 250 - scrollView.contentOffset.y );
    }else if ( scrollView.contentOffset.y >= 125 ) {
        //self.scrollView.bounces = NO;
        self.scrollView.scrollEnabled = NO;
        self.vc1.view.userInteractionEnabled = YES;
        if (scrollView.contentOffset.y != 125 ) {
            self.scrollView.contentSize = CGSizeMake(0 , self.view.frame.size.height + 250 - 125 );
            CGPoint offset = CGPointMake( 0 , 125 );
            [self.scrollView setContentOffset:offset animated:YES];
        }
    }
    //NSLog(@"content size height is %f " , scrollView.contentSize.height );
}


#pragma mark - handle pan methods 
- (void)handlePan:(UIPanGestureRecognizer*)gesture
{
	CGPoint translation = [gesture translationInView:[self.slideSwitchView superview]];
    
    NSLog(@" translation y is %f " , translation.y );
    
    if ( translation.y > -125 && translation.y < 0 ) {
        self.slideSwitchView.frame = CGRectMake(0, 250 + translation.y , 320 , self.dynamicHeight - translation.y );
        self.scrollView.contentOffset = CGPointMake( 0 , - translation.y );
    }else if ( translation.y <= -125) {
        self.vc1.view.userInteractionEnabled = YES;
        [self.slideSwitchView removeGestureRecognizer:self.panGesture];
        if (self.slideSwitchView.frame.origin.y > 125 ) {
            NSLog(@"scroll not enough");
            [self checkForPartialScroll:self.scrollView];
        }
    }
    
    /*
	float delta = self.lastContentOffset - translation.y;
	self.lastContentOffset = translation.y;
	[self scrollWithDelta:delta];
    */
}


#pragma mark - slideScrollView 

-(void)slideScrollViewWillBeginDragging:(UIScrollView *)scrollView
{
}

-(void)slideScrollViewDidScroll:(UIScrollView *)scrollView
{
}

-(void)slideScrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}

#pragma mark - ListViewController Delegate Methods

-(void)listViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    /*
    if (scrollView.contentOffset.y > 250)
        [self setSlideSwitchViewPointYAndHeight];
    */
}

-(void)listViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollView did scroll content offset y value %f" , scrollView.contentOffset.y );
    //[self handleSwitchViewPosition:scrollView];
    
    if (scrollView.contentOffset.y <= 0 ) {
        self.vc1.view.userInteractionEnabled = NO;
        self.scrollView.scrollEnabled = YES;
    }
}

-(void)listViewDidEndDecelerating:(UIScrollView *)scrollView
{
    /*
    NSLog(@"print scroll view top is %f and scrollview offset y is %f " , self.slideSwitchView.frame.origin.y , scrollView.contentOffset.y );
    [self checkForPartialScroll:scrollView];
    */
}

-(void)listViewDidEndDragging:(UIScrollView *)scrollView
{
}

-(void)listViewWillBeginDragging:(UIScrollView *)scrollView
{
}


-(void)setSlideSwitchViewPointYAndHeight
{
    self.slideSwitchView.frame = CGRectMake(0, 0 , 320 , self.view.frame.size.height );
}

#pragma mark - collectionView delegate methods 

-(void)collectionViewDidScroll:(UIScrollView *)scrollView
{
    //判断内嵌的scrollView的情况
    
    //[self handleSwitchViewPosition:scrollView];
    if (scrollView.contentOffset.y < 0 ) {
        self.vc1.view.userInteractionEnabled = NO;
        self.scrollView.scrollEnabled = YES;
    }
}

-(void)collectionViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 250 )
        [self setSlideSwitchViewPointYAndHeight];
}

-(void)collectionViewDidEndDecelerating:(UIScrollView *)scrollView
{
}

-(void)collectionViewDidEndDragging:(UIScrollView *)scrollView
{

}

-(void)collectionViewWillBeginDecelerating:(UIScrollView *)scrollView
{
}

#pragma mark - handle slideView postion methods
-(void)handleSwitchViewPosition:(UIScrollView *)scrollView
{
    int currentPostion = scrollView.contentOffset.y;
    
    if (currentPostion < 0 ) {
        self.vc1.view.userInteractionEnabled = NO;
        self.scrollView.scrollEnabled = YES;
    }
    
    if (currentPostion - _lastPosition >= 0) {
    
        NSLog(@"print delta %d" , currentPostion - _lastPosition );
    
        _lastPosition = currentPostion;
        //返回到一定程度的时候，将tableView设置手势禁用
        self.directionUp = YES;
        NSLog(@"向下滚动中");
        if ( scrollView.contentOffset.y == -0.5 && !scrollView.isDragging ) {
            self.vc1.view.userInteractionEnabled = NO;
            self.scrollView.scrollEnabled = YES;
            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }else {
            NSLog(@"内部scrollView 向下 的 content offset y is %f " , scrollView.contentOffset.y );
            //self.slideSwitchView.frame = CGRectMake(0, scrollView.contentOffset.y - 250 , 320 , self.dynamicHeight );
            //self.scrollView.contentSize = CGSizeMake(0 , self.view.frame.size.height + 250 - 125 );
        }
    }else if (_lastPosition - currentPostion >= 0){
        //NSLog(@"向上滚动中");
        _lastPosition = currentPostion;
        
        if ( scrollView.contentOffset.y < 250 && scrollView.contentOffset.y >= -0.5 ) {
            self.slideSwitchView.frame = CGRectMake(0, 250 - scrollView.contentOffset.y , 320 , self.dynamicHeight );
            self.scrollView.contentSize = CGSizeMake(0 , self.view.frame.size.height + 250 - scrollView.contentOffset.y );
        }else if( scrollView.contentOffset.y >= 250  ){
            self.scrollView.scrollEnabled = NO;
            self.vc1.view.userInteractionEnabled = YES;
            
            NSLog(@"内部scrollView 向上 的 content offset y is %f " , scrollView.contentOffset.y );
            
            //self.slideSwitchView.frame = CGRectMake(0, 250 - scrollView.contentOffset.y , 320 , self.dynamicHeight );
            //self.scrollView.contentSize = CGSizeMake(0 , self.view.frame.size.height + 250 + scrollView.contentOffset.y );
            
        }
        //要计算翻同样的动画，要看动画如何处理...
        self.directionUp = NO;
    }
}

-(void)checkForPartialScroll:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.2 animations:^{
        NSLog(@"animate ... ???");
        self.slideSwitchView.frame = CGRectMake(0, 125 , 320, self.view.frame.size.height );
        [self.scrollView setContentOffset:CGPointMake(0, 125) animated:YES];
    } completion:^(BOOL finished) {
        NSLog(@"slide switch view top is %f " , self.slideSwitchView.frame.origin.y );
    }];
    /*
    if ( self.slideSwitchView.frame.origin.y < 250  ) {
        if (self.directionUp == YES ) {
            if (scrollView.contentOffset.y == 0 ) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.slideSwitchView.frame = CGRectMake(0, 250 , 320, self.view.frame.size.height );
                }];
            }else{
                [UIView animateWithDuration:0.2 animations:^{
                    self.slideSwitchView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height );
                }];
            }
        }else{
            if( scrollView.contentOffset.y < 250 ){
                [UIView animateWithDuration:0.2 animations:^{
                    self.slideSwitchView.frame = CGRectMake(0, 250 , 320, self.view.frame.size.height - 250 );
                }];
            }
        }
    }
    */
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

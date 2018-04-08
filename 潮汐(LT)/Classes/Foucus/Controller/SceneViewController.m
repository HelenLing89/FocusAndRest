//
//  SceneViewController.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/9.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "SceneViewController.h"
#import "SceneHeadView.h"
#import "SceneItem.h"
#import "SceneCell.h"

@interface SceneViewController ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>

@property(nonatomic,strong) NSMutableArray *itemArr;
@property(strong,nonatomic) UITouch *touch;

@end

@implementation SceneViewController

- (NSMutableArray *)itemArr{
    if (_itemArr == nil) {
        _itemArr = [NSMutableArray array];
    }
    
    return _itemArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专注场景";
   //self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"general_close_black_32_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(closeBtn)];
    
    
    [self setUpTableView];
    [self setUpItems];
}

- (void)setUpTableView{
    
//    UIView *blankView = [[UIView alloc] init];
//    blankView.frame = CGRectMake(0, -screenH, screenW, screenH);
//    blankView.backgroundColor = [UIColor redColor];
//    [self.tableView addSubview:blankView];
    
    self.tableView.tableHeaderView = [SceneHeadView sceneHeadView];
    self.tableView.tableHeaderView.userInteractionEnabled = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 400;
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.alwaysBounceVertical = YES;
    self.tableView.contentInsetAdjustmentBehavior = YES;
//    UISwipeGestureRecognizer *swipe= [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(down:)];
//    swipe.direction = UISwipeGestureRecognizerDirectionDown;
//    swipe.delegate = self;
//    [self.tableView.tableHeaderView addGestureRecognizer:swipe];
//
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
//    pan.delegate = self;
//    [self.tableView.tableHeaderView addGestureRecognizer:pan];
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//    longPress.delegate = self;
//    [self.tableView.tableHeaderView addGestureRecognizer:longPress];
   // NSLog(@"%@",self.tableView.tableHeaderView.gestureRecognizers);
}


- (void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint currentP = [pan locationInView:self.navigationController.view];
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
   // self.tableView.layer.transform = CATransform3DMakeTranslation(0, currentP.y, 0);
   // NSLog(@"%f",panP.y);
    self.tableView.transform = CGAffineTransformMakeTranslation(0, currentP.y);
    self.navigationController.navigationBar.alpha = 1- currentP.y/667.0;
    if (pan.state == UIGestureRecognizerStateEnded) {
        self.tableView.transform = CGAffineTransformIdentity;
    }
    
    
    
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    
    CGPoint longPressP = [longPress locationInView:self.navigationController.view];
    
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    CGRect frame = self.tableView.frame;
    frame.origin.y = longPressP.y-64;
    self.tableView.transform = CGAffineTransformMakeTranslation(0, longPressP.y);
    NSLog(@"%f",longPressP.y);
    
    self.tableView.backgroundColor = [UIColor clearColor];
    if (longPress.state == UIGestureRecognizerStateEnded) {
        frame.origin.y = 0;
        
    }
    self.tableView.frame = frame;
    
}
- (void)down:(UISwipeGestureRecognizer *)down{
    if (down.state == UIGestureRecognizerStateEnded) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    NSLog(@"%@",touch.view);
    if ([touch.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    
    return YES;
    
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
   

    return YES;


}




- (void)setUpItems{
    SceneItem *item0 = [SceneItem itemWithSceneTitle:@"海洋" SceneSubTitle:@"下午四点的海边" SceneImage:[UIImage imageNamed:@"guide_intro_focus_banner_1"] lockImage:YES price:nil];
    [self.itemArr addObject:item0];
    SceneItem *item1 = [SceneItem itemWithSceneTitle:@"雨天" SceneSubTitle:@"落在树叶上的雨" SceneImage:[UIImage imageNamed:@"preset_wakeup_rain"] lockImage:NO price:@"免费"];
    [self.itemArr addObject:item1];
    SceneItem *item2 = [SceneItem itemWithSceneTitle:@"冥想" SceneSubTitle:@"天上落下的光" SceneImage:[UIImage imageNamed:@"preset_wakeup_ocean"] lockImage:NO price:@"￥6.00"];
    [self.itemArr addObject:item2];

}



- (void)closeBtn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   CGPoint panP = [scrollView.panGestureRecognizer translationInView:self.navigationController.view];
   CGPoint currentP = [scrollView.panGestureRecognizer locationInView:self.tableView];
    
   
    //CGPoint currenP = [self.touch locationInView:self.navigationController.view];
    
    NSLog(@"%@",NSStringFromCGPoint(currentP));
    CGFloat offSetY = self.tableView.contentOffset.y;
    
   
    
      //  self.tableView.transform = CGAffineTransformIdentity;
    //}else if (offSetY < 0){
    NSLog(@"%f",offSetY);
    CGRect frame = self.tableView.frame;
    if (panP.y > 0 &&currentP.y <= 667 && scrollView.panGestureRecognizer.state == UIGestureRecognizerStateChanged ) {
     self.navigationController.view.backgroundColor = [UIColor clearColor];
     self.tableView.backgroundColor = [UIColor clearColor];
     frame.origin.y = panP.y;
     self.tableView.frame = frame;
    }
    
    if(panP.y > 0 &&currentP.y <= 667 &&scrollView.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        frame.origin.y = 0;
        self.tableView.frame = frame;
    }

    
//        CGRect frame = self.tableView.frame;
//        frame.origin.y = 0;
//        self.tableView.frame = frame;
    
    
    //NSLog(@"%@",NSStringFromUIEdgeInsets(self.tableView.contentInset));
    //self.tableView.frame = CATransform3DMakeTranslation(0, -offSetY, 0);
   // CGRect frame = self.tableView.tableHeaderView.frame;
    //frame.origin.y = - offSetY;
    //self.tableView.tableHeaderView.frame = frame;
      // UIEdgeInsets indicatorInset = self.tableView.scrollIndicatorInsets;
    //NSLog(@"%@",NSStringFromUIEdgeInsets(indicatorInset));
     // indicatorInset.top = self.tableView.frame.origin.y;
     // indicatorInset.bottom = 20;
      // self.tableView.scrollIndicatorInsets = indicatorInset;
    //NSLog(@"%@",self.tableView);
    
    //}
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (scrollView.frame.origin.y != 0) {
        CGRect frame = scrollView.frame;
        frame.origin.y = 0;
        scrollView.frame = frame;
    }
    
    
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.itemArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SceneCell *cell = [SceneCell cellWithTableView:tableView];
    
    cell.item = self.itemArr[indexPath.row];
    
    return cell;
}

- (BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches
                 withEvent:(UIEvent *)event
             inContentView:(UIView *)view{
    
    UITouch *touch = [touches anyObject];
    self.touch = touch;
    
    return YES;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

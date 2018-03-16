//
//  EqualierViewController.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/7.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "EqualierViewController.h"
#import "FocusSettingViewController.h"
#import "EqualierViewCell.h"
#import "CountTimeCell.h"
#import "LTBaseNavigationController.h"


@interface EqualierViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(strong,nonatomic) NSArray *timeArr;
@property(strong,nonatomic) UIView *centerView;
@end

@implementation EqualierViewController


- (NSArray *)timeArr{
    if (_timeArr == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"focusTimePlist.plist" ofType:nil];
        _timeArr = [NSArray arrayWithContentsOfFile:filePath];
    }
    
    return _timeArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpCollectionView];
    [self setUpCenterView];
    [self setUpMoreOptionBtn];
    
    // Do any additional setup after loading the view from its nib.
}


- (void)setUpCenterView{
    
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(20, 64, screenW-40, 132)];
    centerView.backgroundColor = [UIColor whiteColor];
    self.centerView = centerView;
    [self.view addSubview:centerView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,centerView.bounds.size.width, 88)];
    tableView.delegate = self;
    tableView.dataSource = self;
  //  tableView.rowHeight = 50;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorColor = [UIColor redColor];
    self.tableView = tableView;
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([EqualierViewCell class]) bundle:nil] forCellReuseIdentifier:@"equalier"];
    [self.tableView insertSubview:self.collectionView atIndex:0];
    [centerView addSubview:tableView];
  //  [centerView insertSubview:self.collectionView belowSubview:self.tableView];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EqualierViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"equalier"];
   
    if (indexPath.row == 0) {
        cell.voiceStr = @"自然声音";
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.timeStr = nil;
        
    }else {
        cell.voiceStr = @"计时时长";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.timeStr = @"20";
    }
    
    
    return  cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EqualierViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else {
        CATransition *animation = [CATransition animation];
        
        animation.duration = 0.5;
        
        animation.type = kCATransitionFade;//这里可以选择下面列举出来的几个动画，
        
        animation.subtype = kCATransitionFromRight;
        
        [cell.layer addAnimation:animation forKey:nil];
        cell.hidden = YES;
        self.collectionView.hidden = NO;
        cell.backgroundColor = [UIColor clearColor];
        
        
    }
  
   
    
    
    
}

- (void)setUpCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(30,30);
    layout.minimumLineSpacing = 40;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,44, screenW-40, 44) collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.alwaysBounceHorizontal=YES;
    collectionView.scrollsToTop = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.scrollEnabled = YES;
    collectionView.backgroundColor = [UIColor grayColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.hidden = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CountTimeCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
   
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.timeArr.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"%ld",[self.timeArr[section] count]);
    return [self.timeArr[section] count] ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CountTimeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.timeStr = [NSString stringWithFormat:@"%@m",self.timeArr[indexPath.section][indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *tableViewIndex = [NSIndexPath indexPathForRow:1 inSection:0];
    EqualierViewCell *cell = [self.tableView cellForRowAtIndexPath:tableViewIndex];
    cell.timeStr = self.timeArr[indexPath.section][indexPath.row];
    
    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.25;
    
    animation.type = kCATransitionPush ;//这里可以选择下面列举出来的几个动画，
    
    animation.subtype = kCATransitionFromRight;
    
    [cell.layer addAnimation:animation forKey:nil];
    cell.hidden = NO;
    self.collectionView.hidden = YES;

}

- (void)setUpMoreOptionBtn{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0,88,screenW-40, 44);
    [btn setTitle:@"更多选项" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    //btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.centerView insertSubview:btn aboveSubview:self.tableView];
    
}


- (void)btnClick{
    
    
    
    FocusSettingViewController *focusSettingVc = [[FocusSettingViewController alloc] init];
    focusSettingVc.view.backgroundColor = [UIColor redColor];
    LTBaseNavigationController *baseNav = [[LTBaseNavigationController alloc] initWithRootViewController:focusSettingVc];
    
    [self presentViewController:baseNav animated:YES completion:nil];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

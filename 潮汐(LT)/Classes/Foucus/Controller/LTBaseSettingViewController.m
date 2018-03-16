//
//  LTBaseSettingViewController.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/8.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "LTBaseSettingViewController.h"
#import "FocusSettingGroup.h"
#import "FocusSettingItem.h"
#import "FocusSettingCell.h"
#import "LTVoiceViewController.h"
#import "LTHighEffectViewController.h"
#import "LTCountTimeViewController.h"
#import "LTBaseNavigationController.h"
#import "TimeSettingItem.h"
#import <POP.h>

@interface LTBaseSettingViewController ()<LTCountTimeViewControllerDelegate>
@property (nonatomic,strong) NSIndexPath *selectedIndex;


@end

@implementation LTBaseSettingViewController

//- (instancetype)init {
//    
//    return [self initWithStyle:UITableViewStyleGrouped];
//}

- (NSMutableArray *)groups{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专注选项";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"general_close_black_32_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(closeBtn)];
    self.tableView.userInteractionEnabled = YES;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)closeBtn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FocusSettingGroup *group = self.groups[section];
    return group.items.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    FocusSettingGroup *group = self.groups[section];
    
    return group.headTitle;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FocusSettingGroup *group = self.groups[indexPath.section];
    FocusSettingItem *item = group.items[indexPath.row];
    
    UITableViewCellStyle style = UITableViewCellStyleValue1;
    if ([item.style  isEqual: @"subTitle"]) {
        style = UITableViewCellStyleSubtitle;
    }
    FocusSettingCell *cell = [FocusSettingCell cellWithTableView:tableView style:style];
    
    cell.item = item;
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FocusSettingGroup *group = self.groups[indexPath.section];
    FocusSettingItem *item = group.items[indexPath.row];
    self.selectedIndex = indexPath;
  //  __weak typeof (self)weakSelf = self;
  if (item.deVc == [LTCountTimeViewController class]) {
//        self.timeBlock = ^(NSString *time){
//            item.subTitle = time;
//        };
    
        LTCountTimeViewController *vc = [[LTCountTimeViewController alloc] init];
      vc.view.backgroundColor = [UIColor whiteColor];
       vc.delegate = self;
        LTBaseNavigationController *naVc = [[LTBaseNavigationController alloc] initWithRootViewController:vc];
       vc.time = item.subTitle;
       naVc.modalPresentationStyle = UIModalPresentationCustom;
      [self presentViewController:naVc animated:YES completion:^{
          
      }];
        
    }else if (item.deVc == [LTHighEffectViewController class]){
        LTHighEffectViewController *vc = [[LTHighEffectViewController alloc]init];
        //LTBaseNavigationController *naVc = [[LTBaseNavigationController alloc] initWithRootViewController:vc];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (item.deVc == [LTVoiceViewController class]){
        LTVoiceViewController *vc = [[LTVoiceViewController alloc] init];
        vc.view.frame = CGRectMake(5,screenH - 150, screenW-10, 150);
        vc.view.backgroundColor = [UIColor greenColor];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (item.deVc == [UIAlertController class]){
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:nil message:@"重置后所有的选项都会恢复到默认状态" preferredStyle:UIAlertControllerStyleActionSheet];
        
        [vc addAction:[UIAlertAction actionWithTitle:@"恢复默认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            
            
            
        }] ];
        
        [vc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //[self dismissViewControllerAnimated:YES completion:nil];
            
            
        }] ];
        
        
        [self presentViewController:vc animated:YES completion:nil];
        
        
    }
    
    
}


- (void)countTimeVc:(LTCountTimeViewController *)countTimeVc didSelectTime:(NSString *)time{
    
    FocusSettingGroup *group = self.groups[self.selectedIndex.section];
    TimeSettingItem *item = (TimeSettingItem *) group.items[self.selectedIndex.row];
    if (item.timeBlock) {
        item.timeBlock(time);
        [self.tableView reloadData];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 64;
}

//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//}



@end

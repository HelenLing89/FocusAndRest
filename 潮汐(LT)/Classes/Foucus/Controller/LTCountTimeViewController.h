//
//  LTCountTimeViewController.h
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/8.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FocusSettingViewController;
@class LTCountTimeViewController;
@protocol LTCountTimeViewControllerDelegate <NSObject>
@optional

- (void)countTimeVc:(LTCountTimeViewController *)countTimeVc didSelectTime:(NSString*)time;

@end

@interface LTCountTimeViewController : UIViewController

@property (nonatomic,weak) id<LTCountTimeViewControllerDelegate> delegate;

@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) FocusSettingViewController *vc;
@end

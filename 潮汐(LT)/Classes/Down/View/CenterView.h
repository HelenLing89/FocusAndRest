//
//  CenterView.h
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/5.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CenterView : UIView
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeBtn;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *calendarBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *relinkBtn;

//@property (strong,nonatomic) (void)(^calendarBtnBlock)(UIView *view);
+ (instancetype)centerView;


@end

//
//  FocusSettingGroup.h
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/7.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FocusSettingGroup : NSObject
@property(nonatomic,strong) NSArray *items;
@property(nonatomic,strong) NSString *headTitle;
//@property(nonatomic,strong) NSString *footTitle;

+(instancetype)initWithItems:(NSArray *)items;



@end

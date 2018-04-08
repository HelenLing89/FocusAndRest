//
//  GuideItem.h
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/23.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuideItem : NSObject
@property (strong,nonatomic) NSString *icon;
@property (strong,nonatomic) NSString *largeWords;
@property (strong,nonatomic) NSString *smallWords;
@property (strong,nonatomic) NSString *buttonWords;

+ (instancetype)guideItemWithDict:(NSDictionary *)dict;

@end

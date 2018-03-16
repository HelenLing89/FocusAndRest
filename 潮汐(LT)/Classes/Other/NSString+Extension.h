//
//  NSString+Extension.h
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/16.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (NSInteger)convertToTotalMinutefromString;
+ (instancetype)convertToStringFromTotalMinute:(NSInteger)total;
- (NSInteger)calculateDelateTimeFromString;
@end

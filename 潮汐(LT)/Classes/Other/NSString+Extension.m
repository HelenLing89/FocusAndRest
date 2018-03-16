//
//  NSString+Extension.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/16.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (NSInteger)convertToTotalMinutefromString{
    NSArray *strArr = [self componentsSeparatedByString:@":"];
    if (strArr.count == 0) {
        return 0;
    }
    NSInteger total = 0;
     if (strArr.count == 2){
        total = [strArr[0] integerValue]*60 + [strArr[1] integerValue];
        
    }else {
        total = [strArr[0] integerValue];
    }
    
    return total;
    
}

+ (instancetype)convertToStringFromTotalMinute:(NSInteger)total{
    
    NSInteger minute = total % 60;
    NSInteger hour = total/60;
    if (minute<0) {
        hour = 23;
        minute = 60+minute;
    }
    
   return [NSString stringWithFormat:@"%02ld:%02ld",(long)hour,(long)minute];
 
    
}

- (NSInteger)calculateDelateTimeFromString{
    NSInteger total = [self convertToTotalMinutefromString];
    NSString *currentDate = [self getCurrentTime];
    NSInteger currentTotal = [currentDate convertToTotalMinutefromString];
   
    if (currentTotal>total) {
        if ((total+12*60 - currentTotal)<0) {
            return (total+24*60-currentTotal);
        }else{
           return (total+12*60 - currentTotal);
        }
    }else{
       return (total - currentTotal);
    }
}


- (NSString *)getCurrentTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:MM";
    NSString *stringDate = [formatter stringFromDate:date];
    return  stringDate;
    
}

@end

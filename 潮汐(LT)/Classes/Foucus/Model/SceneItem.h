//
//  SceneItem.h
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/9.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SceneItem : NSObject
@property (strong,nonatomic) NSString *sceneTitle;
@property (strong,nonatomic) NSString *subTitle;
@property (strong,nonatomic) UIImage *sceneImage;
@property (nonatomic,assign) BOOL isLocked;
@property (nonatomic,strong) NSString *price;


+ (instancetype)itemWithSceneTitle:(NSString *)title SceneSubTitle:(NSString *)subTitle SceneImage:(UIImage *)image lockImage:(BOOL)isLocked price:(NSString *)price;

@end

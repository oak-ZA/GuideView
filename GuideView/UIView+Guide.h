//
//  UIView+Guide.h
//  GuideView
//
//  Created by 张奥 on 2019/5/23.
//  Copyright © 2019年 张奥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Guide)
@property (nonatomic,assign) CGRect focuseRect;
-(void)showGuideView:(CGRect)focuseRect;
@end

//
//  UIView+Guide.m
//  GuideView
//
//  Created by 张奥 on 2019/5/23.
//  Copyright © 2019年 张奥. All rights reserved.
//

#import "UIView+Guide.h"
#import <objc/runtime.h>
@implementation UIView (Guide)
static const void *VALID_FRAME_KEY = &VALID_FRAME_KEY;
-(void)showGuideView:(CGRect)focuseRect{
//    self.focuseRect = focuseRect;
    [self layOutGuideSubviews];
}

-(void)layOutGuideSubviews{
    
    UIView *containerView = [[UIView alloc] initWithFrame:self.window.bounds];
    containerView.backgroundColor = [UIColor grayColor];
    [self setContainerView:containerView];
    [self.window addSubview:containerView];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.window.bounds.size.width, self.window.bounds.size.height)cornerRadius:0];
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    shaperLayer.path = path.CGPath;
    shaperLayer.fillRule = kCAFillRuleEvenOdd;
    shaperLayer.fillColor = [UIColor blackColor].CGColor;
    shaperLayer.opacity = 0.8;
    [containerView.layer addSublayer:shaperLayer];
    
    [self layOutItem];
}

-(void)layOutItem{
    
    UIView *containerView = [self getContainerView];
    
    UIView *focusView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 80, 80)];
    //镂空区域
    CGRect hollowFrame = [ focusView convertRect:focusView.bounds toView:containerView];
    CAShapeLayer *shapeLayer = (CAShapeLayer *)[containerView.layer.sublayers firstObject];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath:shapeLayer.path];
    [bezierPath appendPath:[UIBezierPath bezierPathWithRoundedRect:hollowFrame cornerRadius:8.f]];
    shapeLayer.path = bezierPath.CGPath;
}

-(void)setContainerView:(UIView*)containerView{
    objc_setAssociatedObject(self, @selector(getContainerView), containerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView*)getContainerView{
    return objc_getAssociatedObject(self,_cmd);
}

-(void)setFocuseRect:(CGRect)focuseRect{
    NSValue *rectValue = [NSValue valueWithCGRect:focuseRect];
    objc_setAssociatedObject(self, VALID_FRAME_KEY, rectValue, OBJC_ASSOCIATION_ASSIGN);
}
-(CGRect)focuseRect{
    NSValue *rectValue = objc_getAssociatedObject(self, VALID_FRAME_KEY);
    return [rectValue CGRectValue];
}

@end

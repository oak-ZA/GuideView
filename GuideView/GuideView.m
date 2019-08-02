//
//  GuideView.m
//  GuideView
//
//  Created by 张奥 on 2019/5/23.
//  Copyright © 2019年 张奥. All rights reserved.
//

#import "GuideView.h"
@interface GuideView()
@property (nonatomic,assign) CGRect focuseViewFrame;
@end
@implementation GuideView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame focuseViewFrame:(CGRect)focuseViewFrame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.focuseViewFrame = focuseViewFrame;
        [self layOutSubViews];
    }
    return self;
}

-(void)layOutSubViews{
    
    //镂空
    UIView *maskView = [[UIView alloc] initWithFrame:self.bounds];
    maskView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    [self addSubview:maskView];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:0];
//    如果想保留矩形以外的部分 , 矩形需要反方向绘制path bezierPathByReversingPath
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:self.focuseViewFrame cornerRadius:10.f] bezierPathByReversingPath]];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    maskView.layer.mask = shapeLayer;
    
    //图片
    UIImage *indicatorImg = [UIImage imageNamed:@"icon_ea_indicator"];
    CGSize imageSize = CGSizeMake(indicatorImg.size.width, indicatorImg.size.height);
    UIImageView *indicatorImgView = [[UIImageView alloc] initWithImage:indicatorImg];
    indicatorImgView.clipsToBounds = YES;
    indicatorImgView.contentMode = UIViewContentModeScaleAspectFit;
    CGFloat xFrame = self.focuseViewFrame.origin.x+(self.focuseViewFrame.size.width - imageSize.width)/2;
    CGFloat yFrame = self.focuseViewFrame.origin.y + self.focuseViewFrame.size.height;
    indicatorImgView.frame = CGRectMake(xFrame, yFrame, imageSize.width, imageSize.height);
    [maskView addSubview:indicatorImgView];
    
    //title
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    title.center = CGPointMake(indicatorImgView.center.x, CGRectGetMinY(indicatorImgView.frame) + imageSize.height+20);
    title.text = @"双击就可放大哦!";
    title.textColor = [UIColor redColor];
    title.font = [UIFont systemFontOfSize:17.f];
    title.textAlignment = NSTextAlignmentCenter;
    [maskView addSubview:title];
    
    //button
    UIButton *disMissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    disMissBtn.frame = CGRectMake(0, 0, 100, 60);
    disMissBtn.center = CGPointMake(title.center.x, CGRectGetMaxY(title.frame)+20);
    [disMissBtn setTitle:@"知道啦" forState:UIControlStateNormal];
    disMissBtn.backgroundColor = [UIColor grayColor];
    [maskView addSubview:disMissBtn];
    [disMissBtn addTarget:self action:@selector(clickDisMissBtn:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clickDisMissBtn:(UIButton*)button{
    [self removeFromSuperview];
}
@end

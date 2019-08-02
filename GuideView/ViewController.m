//
//  ViewController.m
//  GuideView
//
//  Created by 张奥 on 2019/5/23.
//  Copyright © 2019年 张奥. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Guide.h"
#import "GuideView.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor yellowColor];
    GuideView *guideView = [[GuideView alloc] initWithFrame:self.view.bounds focuseViewFrame:CGRectMake(25, 150, 160, 250)];
    guideView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:guideView];
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(80, 100, 80, 80);
//    [button setTitle:@"" forState:UIControlStateNormal];
//    button.backgroundColor = [UIColor yellowColor];
//    button.titleLabel.font = [UIFont systemFontOfSize:13.f];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    button.layer.cornerRadius = 8.f;
//    button.layer.masksToBounds = YES;
//    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
}

-(void)clickButton:(UIButton*)button{
    
//    const char *className = [@"SecondeViewController" UTF8String];
//    Class cls = objc_getClass(className);
//    id instance = [[cls alloc] init];
//    [self.navigationController pushViewController:instance animated:YES];
    
   NSDictionary *infoDic = @{@"class":@"RLGongZhongHaoViewController",
                @"property":@{
                        @"gongzhonghao":@"iOS每日推"
                        }
                };
}

-(void)pushToControllerWithData:(NSDictionary*)vcDic{
    const char *className = [vcDic[@"class"] UTF8String];
    Class cls = objc_getClass(className);
    if (!cls) {
        
        Class superClass = [UIViewController class];
        cls = objc_allocateClassPair(superClass, className, 0);
        
        class_addIvar(cls, "new", sizeof(NSString*), log2(sizeof(NSString*)), @encode(NSString*));
        class_addIvar(cls, "des", sizeof(NSString*), log2(sizeof(NSString*)), @encode(NSString*));
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

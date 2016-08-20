//
//  ViewController.m
//  TDButton
//
//  Created by imtudou on 16/8/20.
//  Copyright © 2016年 imtudou. All rights reserved.
//

#import "ViewController.h"

#import "TDButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.

    TDCustomButton *btn = [[TDCustomButton alloc]initWitAligenmentStyleOutsideCancel:TDAligenmentStyleCenter andBlock:^{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"点击了按钮" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setImage:[UIImage imageNamed:@"tabBar_home_click_icon"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"Market-The-rise-and-green"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"中心对齐" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    btn.buttonCornerRadius = 25.0f;
    btn.canHeightlight = NO;
    btn.frame = CGRectMake(20, 40, 300, 50);
    [self.view addSubview:btn];
    
    
    //2.
    
    TDCustomButton *btn1 = [TDCustomButton TD_ShareButton];
    [btn1 setBackgroundColor:[UIColor yellowColor]];
    [btn1 setImage:[UIImage imageNamed:@"tabBar_home_click_icon"] forState:UIControlStateNormal];
    [btn1 setTitle:@"我是标题" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn1.buttonStyle = TDAligenmentStyleBottom;
    btn1.buttonCornerRadius = 5.0;
    btn1.titleLabel.font = [UIFont systemFontOfSize:14];
    btn1.frame = CGRectMake(20,100,80,80);
    //btn1.canHeightlight = NO;
    [self.view addSubview:btn1];
    
    //3.
    
    TDCustomButton *btn2 = [[TDCustomButton alloc]initWitAligenmentStyle:TDAligenmentStyleRight borderW:1 borderColor:[UIColor orangeColor]];
    [btn2 setBackgroundColor:[UIColor orangeColor]];
    [btn2 setImage:[UIImage imageNamed:@"tabBar_home_click_icon"] forState:UIControlStateNormal];
    [btn2 setTitle:@"我是标题222222" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.buttonCornerRadius = 10.0;
    btn2.titleLabel.font = [UIFont systemFontOfSize:14];
    btn2.frame = CGRectMake(20,200,200,40);
    btn2.canHeightlight = YES;
    [self.view addSubview:btn2];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

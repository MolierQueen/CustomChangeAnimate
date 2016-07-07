//
//  OnePushViewController.m
//  CustomAnimate
//
//  Created by meitu on 16/7/6.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import "OnePushViewController.h"
#import "TwoPushViewController.h"
#import "CustomAnimate.h"


@interface OnePushViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) CustomAnimate * presentAnimation;

@end

@implementation OnePushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     _presentAnimation = [[CustomAnimate alloc] init];
    
    [self.navigationItem setTitle:@"第一页"];
}
- (IBAction)pushAction:(id)sender {
    
    TwoPushViewController * twoVC = [[TwoPushViewController alloc] init];
    twoVC.transitioningDelegate = self;
    [self.navigationController pushViewController:twoVC animated:YES];
    
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return _presentAnimation;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

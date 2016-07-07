//
//  OnePresentViewController.m
//  CustomAnimate
//
//  Created by meitu on 16/7/6.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import "OnePresentViewController.h"
#import "TwoPresentViewController.h"
#import "CustomAnimate.h"
#import "SwipeInteractiveTransition.h"



@interface OnePresentViewController ()<UIViewControllerTransitioningDelegate, TwoPresentViewControllerDelegate>

@property (nonatomic, strong) SwipeInteractiveTransition * swipeInterActive;

@property (nonatomic, strong) SwipeInteractiveTransition * swipeInterActiveDismiss;


@end

@implementation OnePresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.swipeInterActive = [SwipeInteractiveTransition createswipeGestureWithSwipeInteractiveTransitionType:SwipeInteractiveTransitionTypePresent andSwipeInteractiveTransitionGestureDirection:SwipeInteractiveTransitionGestureDirectionUp];
    
    typeof(self)weakSelf = self;

    self.swipeInterActive.presentConfig = ^{
        
        [weakSelf present];
        
    };
    
    [self.swipeInterActive addPanGestureForViewController:self];

}
- (IBAction)presentAction {
    
    [self present];
}


- (void)present {
    TwoPresentViewController * twoVC = [[TwoPresentViewController alloc] init];
    
    twoVC.delegate = self;
    
    twoVC.transitioningDelegate = self;
    
    self.swipeInterActiveDismiss = [twoVC returnSwipeInteractiveTransition];
    
    [self presentViewController:twoVC animated:YES completion:^{
    }];
    
}

//点击相关代理
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return [CustomAnimate createCustomAnimateWithType:CustomAnimateTypePresent];
    
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return [CustomAnimate createCustomAnimateWithType:CustomAnimateTypeDismiss];

}

//手势相关代理
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    
    return self.swipeInterActive.interacting ? self.swipeInterActive : nil;
    
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    
    return self.swipeInterActiveDismiss.interacting ? self.swipeInterActiveDismiss : nil;
    
}

//dismiss代理
-(void)dismissController {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
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

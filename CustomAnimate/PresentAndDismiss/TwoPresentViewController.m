//
//  TwoPresentViewController.m
//  CustomAnimate
//
//  Created by meitu on 16/7/6.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import "TwoPresentViewController.h"
#import "SwipeInteractiveTransition.h"




@interface TwoPresentViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) SwipeInteractiveTransition * swipeInterActive;

@end

@implementation TwoPresentViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.swipeInterActive = [SwipeInteractiveTransition createswipeGestureWithSwipeInteractiveTransitionType:SwipeInteractiveTransitionTypeDismiss andSwipeInteractiveTransitionGestureDirection:SwipeInteractiveTransitionGestureDirectionDown];
        
        [self.swipeInterActive addPanGestureForViewController:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
}
- (IBAction)dismissAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dismissController)]) {
        
        [self.delegate dismissController];
        
    }
    
}

- (nullable id <UIViewControllerInteractiveTransitioning>) returnSwipeInteractiveTransition {
    return self.swipeInterActive;
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

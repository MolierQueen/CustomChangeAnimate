//
//  TwoPresentViewController.h
//  CustomAnimate
//
//  Created by meitu on 16/7/6.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TwoPresentViewControllerDelegate <NSObject>

- (void) dismissController;

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent;


@end

@interface TwoPresentViewController : UIViewController

@property (nonatomic, assign) id<TwoPresentViewControllerDelegate> delegate;

- (nullable id <UIViewControllerInteractiveTransitioning>) returnSwipeInteractiveTransition;

@end

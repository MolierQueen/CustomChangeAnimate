//
//  SwipeInteractiveTransition.h
//  CustomAnimate
//
//  Created by meitu on 16/7/6.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GestureConifg)(); //手势触发push或者present操作时候把他封装的block中

typedef NS_ENUM(NSUInteger, SwipeInteractiveTransitionGestureDirection) {//手势的方向
    
    SwipeInteractiveTransitionGestureDirectionLeft = 0,
    
    SwipeInteractiveTransitionGestureDirectionRight,
    
    SwipeInteractiveTransitionGestureDirectionUp,
    
    SwipeInteractiveTransitionGestureDirectionDown
    
};

typedef NS_ENUM(NSUInteger,SwipeInteractiveTransitionType) {//页面切换的种类
    
   SwipeInteractiveTransitionTypePresent = 0,
    
   SwipeInteractiveTransitionTypeDismiss,
    
   SwipeInteractiveTransitionTypePush,
    
   SwipeInteractiveTransitionTypePop,
    
};


@interface SwipeInteractiveTransition : UIPercentDrivenInteractiveTransition



/**
 *  记录手势状态判断是通过点击进行转场还是通过手势
 */
@property (nonatomic, assign) BOOL interacting;

/**
 *  present时候做一些配置
 */
@property (nonatomic, copy)GestureConifg presentConfig;

/**
 *  push时候做一些配置
 */
@property (nonatomic, copy)GestureConifg PushConfig;


/**
 *  自定义初始化方法
 *
 *  @param TransitionType   转场的方式
 *  @param GestureDirection 手势的方向
 *
 *  @return 初始化返回值
 */
+ (instancetype) createswipeGestureWithSwipeInteractiveTransitionType:(SwipeInteractiveTransitionType)TransitionType
                        andSwipeInteractiveTransitionGestureDirection:(SwipeInteractiveTransitionGestureDirection)GestureDirection;


- (instancetype) initWithSwipeInteractiveTransitionType:(SwipeInteractiveTransitionType)TransitionType
          andSwipeInteractiveTransitionGestureDirection:(SwipeInteractiveTransitionGestureDirection)GestureDirection;

/** 给传入的控制器添加手势*/
- (void)addPanGestureForViewController:(UIViewController *)viewController;
@end

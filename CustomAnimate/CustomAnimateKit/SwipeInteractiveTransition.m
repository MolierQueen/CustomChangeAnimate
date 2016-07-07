//
//  SwipeInteractiveTransition.m
//  CustomAnimate
//
//  Created by meitu on 16/7/6.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import "SwipeInteractiveTransition.h"

@interface SwipeInteractiveTransition ()
{
    SwipeInteractiveTransitionType _transtype;
    
    SwipeInteractiveTransitionGestureDirection _GestureDirection;
    
}

@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, strong) UIViewController * vc;


@end


@implementation SwipeInteractiveTransition

- (void)addPanGestureForViewController:(UIViewController *)viewController{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    //将传入的控制器保存，因为要利用它触发转场操作
    self.vc = viewController;
    [viewController.view addGestureRecognizer:pan];
}

//关键的手势过渡的过程
- (void)handleGesture:(UIPanGestureRecognizer *)panGesture{
    //手势百分比
    CGFloat persent = 0;
    switch (_GestureDirection) {
        case SwipeInteractiveTransitionGestureDirectionLeft:{
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case SwipeInteractiveTransitionGestureDirectionRight:{
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case SwipeInteractiveTransitionGestureDirectionUp:{
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.height;
        }
            break;
        case SwipeInteractiveTransitionGestureDirectionDown:{
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.height;
        }
            break;
    }

    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            //手势开始的时候标记手势状态，并开始相应的事件，它的作用在使用这个类的时候说明
            self.interacting = YES;
            //手势开始是触发对应的转场操作，方法代码在后面
            [self startGesture];
            break;
        case UIGestureRecognizerStateChanged:{
            //手势过程中，通过updateInteractiveTransition设置转场过程进行的百分比，然后系统会根据百分比自动布局控件，不用我们控制了
            [self updateInteractiveTransition:persent];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作，转场失败
            self.interacting = NO;
            
            if (persent > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

//触发对应转场操作的代码如下，根据type(type是我自定义的枚举值)我们去判断是触发哪种操作，对于push和present由于要传入需要push和present的控制器，为了解耦，我用block把这个操作交个控制器去做了，让这个手势过渡管理者可以充分被复用
- (void)startGesture{
    switch (_transtype) {
        case SwipeInteractiveTransitionTypePresent:{
            if (_presentConfig) {
                _presentConfig();
            }
        }
            break;
            
        case SwipeInteractiveTransitionTypeDismiss:
            [_vc dismissViewControllerAnimated:YES completion:nil];
            break;
        case SwipeInteractiveTransitionTypePush:{
            if (_PushConfig) {
                _PushConfig();
            }
        }
            break;
        case SwipeInteractiveTransitionTypePop:
            [_vc.navigationController popViewControllerAnimated:YES];
            break;
    }
}

-(instancetype)initWithSwipeInteractiveTransitionType:(SwipeInteractiveTransitionType)TransitionType
        andSwipeInteractiveTransitionGestureDirection:(SwipeInteractiveTransitionGestureDirection)GestureDirection {
    if ([super init]) {
        
        _transtype = TransitionType;
        
        _GestureDirection = GestureDirection;
    }
    return self;
}

+ (instancetype)createswipeGestureWithSwipeInteractiveTransitionType:(SwipeInteractiveTransitionType)TransitionType
                       andSwipeInteractiveTransitionGestureDirection:(SwipeInteractiveTransitionGestureDirection)GestureDirection {
    
    return [[self alloc] initWithSwipeInteractiveTransitionType:TransitionType andSwipeInteractiveTransitionGestureDirection:GestureDirection];
    
}

@end

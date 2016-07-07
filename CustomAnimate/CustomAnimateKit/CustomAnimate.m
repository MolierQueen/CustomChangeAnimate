//
//  CustomAnimate.m
//  CustomAnimate
//
//  Created by meitu on 16/7/6.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import "CustomAnimate.h"

@interface CustomAnimate()
{
    enum CustomAnimateType _type;
}

@end

@implementation CustomAnimate

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 1.0f;
    
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
        switch (_type) {
        case CustomAnimateTypePresent:
            [self presentActionAnimateWith:transitionContext];
            break;
        case CustomAnimateTypeDismiss:
            [self dismissActionAnimateWith:transitionContext];
            break;
        default:
            break;
    }
}
- (void) presentActionAnimateWith:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    //不管怎么样我先获取到两个视图控制器 来和去
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //对原视图做一个截图，因为可能会与一会的滑动手势冲突，所以就不对原视图操作了， 直接直接对该截图操作，外表是一样的。
    UIView * shotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    shotView.frame = fromVC.view.frame;
    
    //因为有了截图所以原视图就不用了，可以隐藏掉
    [fromVC.view setHidden:YES];
    
    //congtainerView算是一个视图容器(他本是是个View)，所有参与过场动画的视图都会被放到这个容器中。所以我们要建立一个containerView
    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:shotView];
    [containerView addSubview:toVC.view];
    
    //设置toVC的frame
    toVC.view.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, containerView.frame.size.height);
    
    //开始动画(往上弹簧)
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:0.55
          initialSpringVelocity:1.0/0.55
                        options:0
                     animations:^{
                         
                         toVC.view.transform = CGAffineTransformMakeTranslation(0, -550);
                         
                         shotView.transform = CGAffineTransformMakeScale(0.85, 0.85);
                         
                          } completion:^(BOOL finished) {
                              
                              //告知系统转场完成
                              [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                              if ([transitionContext transitionWasCancelled]) {
                                  //失败后，我们要把vc1显示出来
                                  fromVC.view.hidden = NO;
                                  //然后移除截图视图，因为下次触发present会重新截图
                                  [shotView removeFromSuperview];
                              }
                              
                          }];
    

    
}

- (void) dismissActionAnimateWith:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    //不管怎么样我先获取到两个视图控制器 来和去
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //因为containerView是基于上下文获得的，并且transitionContext与present的上下文是同一个 所以这里获得的containerView就是present的并且里面的两个子视图也在里面
    UIView * containerView = [transitionContext containerView];
    
    //这里直接取出截图
    UIView * shotView = containerView.subviews[0];
    
    //动画效果还原
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:0.55
          initialSpringVelocity:1.0/0.55
                        options:0
                     animations:^{
                         
                         //还原效果：CGAffineTransformIdentity
                         fromVC.view.transform = CGAffineTransformIdentity;
                         
                         shotView.transform = CGAffineTransformIdentity;
                         
                         
                         
    } completion:^(BOOL finished) {
        
        if ([transitionContext transitionWasCancelled]) {
            //失败了标记失败
            [transitionContext completeTransition:NO];
        }else{
            //如果成功了，我们需要标记成功，同时让vc1显示出来，然后移除截图视图，
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
            [shotView removeFromSuperview];
        }
        
    }];
}

+ (instancetype)createCustomAnimateWithType:(CustomAnimateType)type {
    return [[[self class] alloc] initWithCustomAnimateTyp:type];
}

- (instancetype)initWithCustomAnimateTyp:(CustomAnimateType)type
{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

@end

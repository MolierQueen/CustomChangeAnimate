//
//  CustomAnimate.m
//  CustomAnimate
//
//  Created by meitu on 16/7/6.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import "CustomAnimate.h"

#import "CollectionViewController.h"
#import "CollectionInfoConttroller.h"

#import "CustomCollectionCell.h"



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
        case CustomAnimateTypePush:
            [self pushActionAnimateWith:transitionContext];
            break;
        case CustomAnimateTypePop:
            [self popActionAnimateWith:transitionContext];
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

- (void) pushActionAnimateWith:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    CollectionViewController *fromVC = (CollectionViewController *)[transitionContext     viewControllerForKey:UITransitionContextFromViewControllerKey];
    CollectionInfoConttroller *toVC = (CollectionInfoConttroller *)[transitionContext     viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //拿到当前点击的cell的imageView
    CustomCollectionCell * cell = (CustomCollectionCell *)[fromVC.mainCollection cellForItemAtIndexPath:fromVC.currentIndexPath];
    UIView *containerView = [transitionContext containerView];
    
    //snapshotViewAfterScreenUpdates 对cell的imageView截图保存成另一个视图用于过渡，并将视图转换到当前控制器的坐标
    UIView *tempView = [cell.imageView snapshotViewAfterScreenUpdates:NO];
    //将第一个视图的rect转换到目标视图中
    tempView.frame = [cell.imageView convertRect:cell.imageView.bounds toView: containerView];
    
    
    //设置动画前的各个控件的状态
    cell.imageView.hidden = YES;
    toVC.view.alpha = 0;
    toVC.imageViewC.hidden = YES;
    //tempView 添加到containerView中，要保证在最前方，所以后添加
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    //开始做动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55     initialSpringVelocity:1 / 0.55 options:0 animations:^{
        tempView.frame = [toVC.imageViewC convertRect:toVC.imageViewC.bounds toView:containerView];

        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        //tempView先隐藏不销毁，pop的时候还会用
        tempView.hidden = YES;
        toVC.imageViewC.hidden = NO;
        //如果动画过渡取消了就标记不完成，否则才完成，这里可以直接写YES，如果有手势过渡才需要判断，必须标记，否则系统不会中动画完成的部署，会出现无法交互之类的bug
        [transitionContext completeTransition:YES];
    }];
    
}

- (void) popActionAnimateWith:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    CollectionInfoConttroller *fromVC = (CollectionInfoConttroller *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CollectionViewController *toVC = (CollectionViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CustomCollectionCell *cell = (CustomCollectionCell *)[toVC.mainCollection cellForItemAtIndexPath:toVC.currentIndexPath];
    UIView *containerView = [transitionContext containerView];
    //这里的lastView就是push时候初始化的那个tempView
    UIView *tempView = containerView.subviews.lastObject;
    //设置初始状态
    cell.imageView.hidden = YES;
    fromVC.imageView.hidden = YES;
    tempView.hidden = NO;
    [containerView insertSubview:toVC.view atIndex:0];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:0 animations:^{
        tempView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        //由于加入了手势必须判断
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {//手势取消了，原来隐藏的imageView要显示出来
            //失败了隐藏tempView，显示fromVC.imageView
            tempView.hidden = YES;
            fromVC.imageView.hidden = NO;
        }else{//手势成功，cell的imageView也要显示出来
            //成功了移除tempView，下一次pop的时候又要创建，然后显示cell的imageView
            cell.imageView.hidden = NO;
            [tempView removeFromSuperview];
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

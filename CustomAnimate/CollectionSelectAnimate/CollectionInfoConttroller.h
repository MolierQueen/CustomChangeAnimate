//
//  CollectionInfoConttroller.h
//  CustomAnimate
//
//  Created by meitu on 16/7/7.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionInfoConttroller : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) UIImageView * imageViewC;

- (nullable id <UIViewControllerInteractiveTransitioning>) returnSwipeInteractiveTransition;


@end

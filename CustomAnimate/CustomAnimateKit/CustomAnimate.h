//
//  CustomAnimate.h
//  CustomAnimate
//
//  Created by meitu on 16/7/6.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CustomAnimateType) {
    
    CustomAnimateTypePresent = 1,
    
    CustomAnimateTypeDismiss,
    
    CustomAnimateTypePush,
    
    CustomAnimateTypePop,
    
};


@interface CustomAnimate : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)createCustomAnimateWithType:(CustomAnimateType)type;

- (instancetype)initWithCustomAnimateTyp:(CustomAnimateType)type;

@end

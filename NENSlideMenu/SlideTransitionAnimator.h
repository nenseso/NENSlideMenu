//
//  SlideTransitionAnimator.h
//  SlideController
//
//  Created by weuse_hao on 2018/9/3.
//  Copyright © 2018 weuse_hao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SlideTransitionType) {
    SlideTransitionTypeModal,
    SlideTransitionTypePush,
};

NS_ASSUME_NONNULL_BEGIN

@interface SlideTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge transitionType:(SlideTransitionType)transitionType;

@property (nonatomic, readwrite) UIRectEdge targetEdge;

@property (nonatomic, assign) SlideTransitionType transitionType;

@end

NS_ASSUME_NONNULL_END

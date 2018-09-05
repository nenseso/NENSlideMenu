//
//  SlideTransitionAnimator.h
//  SlideController
//
//  Created by weuse_hao on 2018/9/3.
//  Copyright © 2018 weuse_hao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SlideTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge;

@property (nonatomic, readwrite) UIRectEdge targetEdge;

@end

NS_ASSUME_NONNULL_END

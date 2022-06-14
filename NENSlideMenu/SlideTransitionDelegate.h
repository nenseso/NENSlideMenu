//
//  SlideTransitionDelegate.h
//  SlideController
//
//  Created by weuse_hao on 2018/9/3.
//  Copyright © 2018 weuse_hao. All rights reserved.
//

#import "SlideTransitionAnimator.h"

NS_ASSUME_NONNULL_BEGIN

@interface SlideTransitionDelegate : NSObject<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController transitonType:(SlideTransitionType)transitionType;

@property (nonatomic, strong, nullable) UIGestureRecognizer *gestureRecognizer;

@property (nonatomic, readwrite) UIRectEdge presentTargetEdge;
@property (nonatomic, readwrite) UIRectEdge dismissTargetEdge;

@property (nonatomic, assign) SlideTransitionType transitionType;

@property (nonatomic, assign) CGFloat menuRadius;
@property (nonatomic, assign) BOOL needBlur;
@end

NS_ASSUME_NONNULL_END

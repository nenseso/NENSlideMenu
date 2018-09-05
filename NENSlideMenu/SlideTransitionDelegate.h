//
//  SlideTransitionDelegate.h
//  SlideController
//
//  Created by weuse_hao on 2018/9/3.
//  Copyright © 2018 weuse_hao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SlideTransitionDelegate : NSObject<UIViewControllerTransitioningDelegate>

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController;

@property (nonatomic, strong, nullable) UIGestureRecognizer *gestureRecognizer;

@property (nonatomic, readwrite) UIRectEdge presentTargetEdge;
@property (nonatomic, readwrite) UIRectEdge dismissTargetEdge;

@end

NS_ASSUME_NONNULL_END

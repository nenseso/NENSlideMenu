//
//  SlideTransitionDelegate.m
//  SlideController
//
//  Created by weuse_hao on 2018/9/3.
//  Copyright © 2018 weuse_hao. All rights reserved.
//

#import "SlideTransitionDelegate.h"
#import "SlideTransitionAnimator.h"
#import "SlideTransitionInteractionController.h"
#import "SlideCustomPresentationController.h"

@interface SlideTransitionDelegate ()

@property (nonatomic, strong) UIViewController *presentedViewController;
@property (nonatomic, strong) UIViewController *presentingViewController;

@end

@implementation SlideTransitionDelegate

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super init];
    if (self) {
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
        self.presentedViewController = presentedViewController;
        self.presentingViewController = presentingViewController;
    }
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[SlideTransitionAnimator alloc] initWithTargetEdge:self.presentTargetEdge];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[SlideTransitionAnimator alloc] initWithTargetEdge:self.dismissTargetEdge];
}

// 当这个方法有返回的时候会默认执行这个方法，如果本来的点击按钮跳转也走这个方法，会导致动画执行不能走completion，所以如果是按钮执行，要先让这个方法返回nil
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    if (self.gestureRecognizer.state == UIGestureRecognizerStateBegan)
        return [[SlideTransitionInteractionController alloc] initWithGestureRecognizer:self.gestureRecognizer edgeForDragging:self.presentTargetEdge];
    else
        return nil;
}


- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    if (self.gestureRecognizer.state == UIGestureRecognizerStateBegan)
        return [[SlideTransitionInteractionController alloc] initWithGestureRecognizer:self.gestureRecognizer edgeForDragging:self.dismissTargetEdge];
    else
        return nil;
}

- (UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    NSAssert(self.presentedViewController == presented, @"You didn't initialize %@ with the correct presentedViewController.  Expected %@, got %@.",
             self, presented, self.presentedViewController);
    SlideCustomPresentationController *presentationController = [[SlideCustomPresentationController alloc] initWithPresentedViewController:self.presentedViewController presentingViewController:self.presentingViewController];
    presentationController.targetEdge = self.presentTargetEdge;
    return presentationController;
}

@end

//
//  SlideTransitionDelegate.m
//  SlideController
//
//  Created by weuse_hao on 2018/9/3.
//  Copyright © 2018 weuse_hao. All rights reserved.
//

#import "SlideTransitionDelegate.h"

#import "SlideTransitionInteractionController.h"
#import "SlideCustomPresentationController.h"

@interface SlideTransitionDelegate ()

@property (nonatomic, strong) UIViewController *presentedViewController;
@property (nonatomic, strong) UIViewController *presentingViewController;
@property (nonatomic, assign) UINavigationControllerOperation operation;

@end

@implementation SlideTransitionDelegate

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController transitonType:(SlideTransitionType)transitionType
{
    self = [super init];
    if (self) {
        _transitionType = transitionType;
        if (self.transitionType == SlideTransitionTypeModal) {
            presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
        }
        self.presentedViewController = presentedViewController;
        self.presentingViewController = presentingViewController;
    }
    return self;
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    self.operation = operation;
    if ( ([fromVC isKindOfClass:self.presentingViewController.class] && [toVC isKindOfClass:self.presentedViewController.class]) || ([toVC isKindOfClass:self.presentingViewController.class] && [fromVC isKindOfClass:self.presentedViewController.class]) ) {
        if (operation == UINavigationControllerOperationPush) {
            return [[SlideTransitionAnimator alloc] initWithTargetEdge:self.presentTargetEdge transitionType:self.transitionType];
        } else if (operation == UINavigationControllerOperationPop) {
            return [[SlideTransitionAnimator alloc] initWithTargetEdge:self.dismissTargetEdge transitionType:self.transitionType];
        }
    }
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    UIRectEdge edge = self.operation == UINavigationControllerOperationPush ? self.presentTargetEdge : self.dismissTargetEdge;
    if (self.gestureRecognizer.state == UIGestureRecognizerStateBegan)
        return [[SlideTransitionInteractionController alloc] initWithGestureRecognizer:self.gestureRecognizer edgeForDragging:edge];
    else
        return nil;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[SlideTransitionAnimator alloc] initWithTargetEdge:self.presentTargetEdge transitionType:self.transitionType];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[SlideTransitionAnimator alloc] initWithTargetEdge:self.dismissTargetEdge transitionType:self.transitionType];
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

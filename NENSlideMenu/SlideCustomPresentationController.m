//
//  SlideCustomPresentationController.m
//  SlideController
//
//  Created by weuse_hao on 2018/9/3.
//  Copyright © 2018 weuse_hao. All rights reserved.
//

#import "SlideCustomPresentationController.h"

@interface SlideCustomPresentationController ()

@property (nonatomic, strong) UIView *dimmingView;
@property (nonatomic, strong) UIView *presentationWrappingView;
@end

@implementation SlideCustomPresentationController

- (UIView *)presentedView
{
    return self.menuRadius ? self.presentationWrappingView : [super presentedView];
}

- (void)presentationTransitionWillBegin
{
    if (self.targetEdge == UIRectEdgeBottom && self.menuRadius > 0) {
        // The default implementation of -presentedView returns
        // self.presentedViewController.view.
        UIView *presentedViewControllerView = [super presentedView];
        
        // Wrap the presented view controller's view in an intermediate hierarchy
        // that applies a shadow and rounded corners to the top-left and top-right
        // edges.  The final effect is built using three intermediate views.
        //
        // presentationWrapperView              <- shadow
        //   |- presentationRoundedCornerView   <- rounded corners (masksToBounds)
        //        |- presentedViewControllerWrapperView
        //             |- presentedViewControllerView (presentedViewController.view)
        //
        // SEE ALSO: The note in AAPLCustomPresentationSecondViewController.m.
        {
            UIView *presentationWrapperView = [[UIView alloc] initWithFrame:self.frameOfPresentedViewInContainerView];
            presentationWrapperView.layer.shadowOpacity = 0.44f;
            presentationWrapperView.layer.shadowRadius = 13.f;
            presentationWrapperView.layer.shadowOffset = CGSizeMake(0, -6.f);
            self.presentationWrappingView = presentationWrapperView;
            
            // presentationRoundedCornerView is CORNER_RADIUS points taller than the
            // height of the presented view controller's view.  This is because
            // the cornerRadius is applied to all corners of the view.  Since the
            // effect calls for only the top two corners to be rounded we size
            // the view such that the bottom CORNER_RADIUS points lie below
            // the bottom edge of the screen.
            UIView *presentationRoundedCornerView = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(presentationWrapperView.bounds, UIEdgeInsetsMake(0, 0, -self.menuRadius, 0))];
            presentationRoundedCornerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            presentationRoundedCornerView.layer.cornerRadius = self.menuRadius;
            presentationRoundedCornerView.layer.masksToBounds = YES;
            
            // To undo the extra height added to presentationRoundedCornerView,
            // presentedViewControllerWrapperView is inset by CORNER_RADIUS points.
            // This also matches the size of presentedViewControllerWrapperView's
            // bounds to the size of -frameOfPresentedViewInContainerView.
            UIView *presentedViewControllerWrapperView = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(presentationRoundedCornerView.bounds, UIEdgeInsetsMake(0, 0, self.menuRadius, 0))];
            presentedViewControllerWrapperView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            
            // Add presentedViewControllerView -> presentedViewControllerWrapperView.
            presentedViewControllerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            presentedViewControllerView.frame = presentedViewControllerWrapperView.bounds;
            [presentedViewControllerWrapperView addSubview:presentedViewControllerView];
            
            // Add presentedViewControllerWrapperView -> presentationRoundedCornerView.
            [presentationRoundedCornerView addSubview:presentedViewControllerWrapperView];
            
            // Add presentationRoundedCornerView -> presentationWrapperView.
            [presentationWrapperView addSubview:presentationRoundedCornerView];
        }
        
        // Add a dimming view behind presentationWrapperView.  self.presentedView
        // is added later (by the animator) so any views added here will be
        // appear behind the -presentedView.
        {
            UIView *dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
            dimmingView.backgroundColor = [UIColor blackColor];
            dimmingView.opaque = NO;
            dimmingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)]];
            self.dimmingView = dimmingView;
            [self.containerView addSubview:dimmingView];
            
            // Get the transition coordinator for the presentation so we can
            // fade in the dimmingView alongside the presentation animation.
            id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
            
            self.dimmingView.alpha = 0.f;
            [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
                self.dimmingView.alpha = 0.5f;
            } completion:NULL];
        }
    } else {
        UIView *dimmingView;
        if (_needBlur) {
            UIBlurEffect *blurEffrct =[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            dimmingView = [[UIVisualEffectView alloc]initWithEffect:blurEffrct];
        } else {
            dimmingView = [[UIView alloc] init];
            dimmingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        }
        self.dimmingView = dimmingView;
        dimmingView.frame = self.containerView.bounds;
        dimmingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)]];
        [self.containerView addSubview:dimmingView];
        
        id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
        
        self.dimmingView.alpha = 0.f;
        [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            self.dimmingView.alpha = 1.f;
        } completion:NULL];
    }

}

//| ----------------------------------------------------------------------------
- (void)presentationTransitionDidEnd:(BOOL)completed
{
    if (completed == NO)
    {
        self.dimmingView = nil;
    }
}

//| ----------------------------------------------------------------------------
- (void)dismissalTransitionWillBegin
{
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.f;
    } completion:NULL];
}


//| ----------------------------------------------------------------------------
- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (completed == YES)
    {
        self.presentationWrappingView = nil;
        self.dimmingView = nil;
    }
}

#pragma mark -
#pragma mark Layout

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container
{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    
    if (container == self.presentedViewController)
        [self.containerView setNeedsLayout];
}

- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize
{
    if (container == self.presentedViewController)
        return ((UIViewController*)container).preferredContentSize;
    else
        return [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
}

//| ----------------------------------------------------------------------------
- (CGRect)frameOfPresentedViewInContainerView
{
    CGRect containerViewBounds = self.containerView.bounds;
    CGSize presentedViewContentSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    
    CGRect presentedViewControllerFrame = containerViewBounds;
    if (self.targetEdge == UIRectEdgeTop)
    {
        presentedViewControllerFrame.size.height = presentedViewContentSize.height;
        presentedViewControllerFrame.origin.y = 0;
    }
    else if (self.targetEdge == UIRectEdgeBottom)
    {
        presentedViewControllerFrame.size.height = presentedViewContentSize.height;
        presentedViewControllerFrame.origin.y = containerViewBounds.size.height - presentedViewContentSize.height;
    }
    else if (self.targetEdge == UIRectEdgeLeft)
    {
        presentedViewControllerFrame.size.width = presentedViewContentSize.width;
        presentedViewControllerFrame.origin.x = 0;
    }
    else if (self.targetEdge == UIRectEdgeRight)
    {
        presentedViewControllerFrame.size.width = presentedViewContentSize.width;
        presentedViewControllerFrame.origin.x = containerViewBounds.size.width - presentedViewContentSize.width;
    }
    else
        NSAssert(NO, @"targetEdge must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.");
    

    return presentedViewControllerFrame;
}

- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    
    self.dimmingView.frame = self.containerView.bounds;
    self.presentationWrappingView.frame = self.frameOfPresentedViewInContainerView;
}


#pragma mark -
#pragma mark Tap Gesture Recognizer

- (IBAction)dimmingViewTapped:(UITapGestureRecognizer*)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end

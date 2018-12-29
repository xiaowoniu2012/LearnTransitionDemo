//
//  SOLSlideTransitionAnimator.m
//  PresentingFun
//
//  Created by Jesse Wolff on 10/31/13.
//  Copyright (c) 2013 Soleares, Inc. All rights reserved.
//

#import "SOLSlideTransitionAnimator.h"

/*
 @see https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/CustomizingtheTransitionAnimations.html
 */
@implementation SOLSlideTransitionAnimator

#pragma mark - UIViewControllerAnimatedTransitioning

-(CGAffineTransform)transformFromRect:(CGRect)fromRect toRect:(CGRect)toRect{
    CGAffineTransform moveTrans = CGAffineTransformMakeTranslation(CGRectGetMidX(toRect) - CGRectGetMidX(fromRect), CGRectGetMidY(toRect) - CGRectGetMidY(fromRect));
    CGAffineTransform scaleTrans = CGAffineTransformMakeScale(toRect.size.width / fromRect.size.width, toRect.size.height / fromRect.size.height);
    
    return CGAffineTransformConcat(scaleTrans, moveTrans);
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{

    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext
                                viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC   = [transitionContext
                                viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];

    CGRect initRect = CGRectZero;
    initRect.origin = toView.frame.origin;
    if (self.edge == SOLEdgeCustom) {
        initRect = CGRectMake(100, 100, 100, 100);
    }else{
        initRect = [self rectOffsetFromRect:toView.frame atEdge:self.edge];
    }
    

    if (self.appearing) {
        [containerView addSubview:toView];
        toView.transform = [self transformFromRect:toView.frame toRect:initRect];
    }
    else {
        [containerView insertSubview:toView belowSubview:fromView];
    }
    // Animate using the animator's own duration value.
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         if (self.appearing) {
                             fromView.alpha = 0.5;
                             toView.transform = CGAffineTransformIdentity;
                         }
                         else {
                             toView.alpha = 1.0;
                             fromView.transform = [self transformFromRect:fromView.frame toRect:initRect];
                         }
                         
                     }
                     completion:^(BOOL finished){
                         BOOL success = ![transitionContext transitionWasCancelled];
                        
                         // After a failed presentation or successful dismissal, remove the view.
                         if ((self.appearing && !success) ) {
                             [toView removeFromSuperview];
                         }
                         if ( !self.appearing && success) {
                             [fromView removeFromSuperview];
                         }
                         // Notify UIKit that the transition has finished
                         [transitionContext completeTransition:success];
                     }];
}

#pragma mark - Helper methods
- (void)addtionDissmissalWithToVC :(UIViewController *)fromVC {
    NSLog(@" begin ...");
    id<UIViewControllerTransitionCoordinator> coordinator;
    coordinator = [fromVC transitionCoordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        fromVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        NSLog(@" done ...");
    }];
}

+ (NSDictionary *)edgeDisplayNames
{
    return @{@(SOLEdgeTop) : @"Top",
             @(SOLEdgeLeft) : @"Left",
             @(SOLEdgeBottom) : @"Bottom",
             @(SOLEdgeRight) : @"Right",
             @(SOLEdgeTopRight) : @"Top-Right",
             @(SOLEdgeTopLeft) : @"Top-Left",
             @(SOLEdgeBottomRight) : @"Bottom-Right",
             @(SOLEdgeBottomLeft) : @"Bottom-Left"};
}

- (CGRect)rectOffsetFromRect:(CGRect)rect atEdge:(SOLEdge)edge
{
    CGRect offsetRect = rect;
    
    switch (edge) {
        case SOLEdgeTop: {
            offsetRect.origin.y -= CGRectGetHeight(rect);
            break;
        }
        case SOLEdgeLeft: {
            offsetRect.origin.x -= CGRectGetWidth(rect);
            break;
        }
        case SOLEdgeBottom: {
            offsetRect.origin.y += CGRectGetHeight(rect);
            break;
        }
        case SOLEdgeRight: {
            offsetRect.origin.x += CGRectGetWidth(rect);
            break;
        }
        case SOLEdgeTopRight: {
            offsetRect.origin.y -= CGRectGetHeight(rect);
            offsetRect.origin.x += CGRectGetWidth(rect);
            break;
        }
        case SOLEdgeTopLeft: {
            offsetRect.origin.y -= CGRectGetHeight(rect);
            offsetRect.origin.x -= CGRectGetWidth(rect);
            break;
        }
        case SOLEdgeBottomRight: {
            offsetRect.origin.y += CGRectGetHeight(rect);
            offsetRect.origin.x += CGRectGetWidth(rect);
            break;
        }
        case SOLEdgeBottomLeft: {
            offsetRect.origin.y += CGRectGetHeight(rect);
            offsetRect.origin.x -= CGRectGetWidth(rect);
            break;
        }
        default:
            break;
    }
    
    return offsetRect;
}


@end

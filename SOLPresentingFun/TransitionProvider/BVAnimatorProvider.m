//
//  BVAnimatorProvider.m
//  SOLPresentingFun
//
//  Created by smart on 2018/12/11.
//  Copyright © 2018 Soleares. All rights reserved.
//

#import "BVAnimatorProvider.h"
@interface BVAnimatorProvider()

@end

@implementation BVAnimatorProvider
{
    id<UIViewControllerAnimatedTransitioning> _presentAnimator;
    id<UIViewControllerAnimatedTransitioning> _dismissalAnimator;
    id<UIViewControllerAnimatedTransitioning> _pushAnimator;
    id<UIViewControllerAnimatedTransitioning> _popAnimator;
    
    
    id<UIViewControllerInteractiveTransitioning> _presentInteractor;
    id<UIViewControllerInteractiveTransitioning> _dismissalInteractor;
    id<UIViewControllerInteractiveTransitioning> _pushInteractor;
    id<UIViewControllerInteractiveTransitioning> _popInteractor;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return  _presentAnimator;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return  _dismissalAnimator;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return _presentInteractor;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return _popInteractor;
}

- (void)attachAnimator:(id<UIViewControllerAnimatedTransitioning>)animator
               options:(BVAnimatorOption)options {
    
    NSAssert(animator, @"animator is nil,must provide an vaild animator");
    if (options & BVAnimatorOptionPresent) {
        _presentAnimator = animator;
    }
    if (options & BVAnimatorOptionDismisal) {
        _dismissalAnimator = animator;
    }
    if (options & BVAnimatorOptionPush) {
        _pushAnimator = animator;
    }
    if (options & BVAnimatorOptionPop) {
        _popAnimator = animator;
    }
}



- (void)attachInteractiveAnimator:(id<UIViewControllerInteractiveTransitioning>)animator
                          options:(BVInteractorOption)options {
    NSAssert(animator, @"animator is nil,must provide an vaild animator");
    if (options & BVInteractorOptionPresent) {
        _presentInteractor = animator;
    }
    if (options & BVInteractorOptionDismisal) {
        _dismissalInteractor = animator;
    }
    if (options & BVInteractorOptionPush) {
        _pushInteractor = animator;
    }
    if (options & BVInteractorOptionPop) {
        _popInteractor = animator;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return _pushAnimator;
    }else if (operation == UINavigationControllerOperationPop) {
        return _popAnimator;
    }
    return nil;
}


- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController  {
    return _popInteractor;
}



@end

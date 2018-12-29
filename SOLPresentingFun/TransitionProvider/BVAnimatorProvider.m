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
    NSMutableDictionary *_animatorMap;
}

- (instancetype)init {
    if (self = [super init]) {
        _enable = YES;
        _animatorMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return  [self animatorForAnimatorOption:BVAnimatorOptionPresent];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return  [self animatorForAnimatorOption:BVAnimatorOptionDismisal];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioningExtend>)animator {
    return animator.interactor.isInteracting ? animator.interactor : nil;
    
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioningExtend>)animator {
    return animator.interactor.isInteracting ? animator.interactor : nil;
}

- (nullable __kindof id <UIViewControllerAnimatedTransitioning>)animatorForAnimatorOption:(BVAnimatorOption)option {
    if (!_enable) {
        return nil;
    }
    id <UIViewControllerAnimatedTransitioningExtend> animator = _animatorMap[@(option)];
    [animator setAppearing:((option & BVAnimatorOptionPush) || (option & BVAnimatorOptionPresent))];
    return animator;
}

- (void)attachAnimator:(id<UIViewControllerAnimatedTransitioningExtend>)animator
               options:(BVAnimatorOption)options {
    NSAssert(animator, @"animator is nil,must provide a vaild animator");
    if (!animator) {
        return;
    }
    if (options & BVAnimatorOptionPresent) {
        _animatorMap[@(BVAnimatorOptionPresent)] = animator;
    }
    if (options & BVAnimatorOptionDismisal) {
        _animatorMap[@(BVAnimatorOptionDismisal)] = animator;
    }
    if (options & BVAnimatorOptionPush) {
        _animatorMap[@(BVAnimatorOptionPush)] = animator;
    }
    if (options & BVAnimatorOptionPop) {
        _animatorMap[@(BVAnimatorOptionPop)] = animator;
    }
}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return [self animatorForAnimatorOption:BVAnimatorOptionPush];
    }else if (operation == UINavigationControllerOperationPop) {
        return [self animatorForAnimatorOption:BVAnimatorOptionPop];
    }
    return nil;
}


- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioningExtend>) animationController  {
    return animationController.interactor.isInteracting ? animationController.interactor : nil;
}



@end

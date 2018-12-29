//
//  UIViewController+BVAnimator.m
//  SOLPresentingFun
//
//  Created by smart on 2018/12/11.
//  Copyright © 2018 Soleares. All rights reserved.
//

#import "UIViewController+BVAnimator.h"
#import <objc/runtime.h>
static const char animatorKey;
@implementation UIViewController (BVAnimator)
- (BVAnimatorProvider *)bv_animatorProvider {
    return  (BVAnimatorProvider *)objc_getAssociatedObject(self, &animatorKey);
}

- (void)setBv_animatorProvider:(BVAnimatorProvider *)bv_animatorProvider {
    
    if (bv_animatorProvider != self.bv_animatorProvider) {
        //for kvo
        [self willChangeValueForKey:@"bv_animatorProvider"];
        objc_setAssociatedObject (self, &animatorKey, bv_animatorProvider, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = bv_animatorProvider;
        [self didChangeValueForKey:@"bv_animatorProvider"];
    }

}

@end

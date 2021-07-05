//
//  KeyboardHandling.m
//  RS7_task
//
//  Created by Yan Khanetski on 4.07.21.
//

#import "RSKeyboard.h"

@implementation RSViewController (RSKeyboard)
- (void)subscribeOnKeyboardEvents {
    [NSNotificationCenter.defaultCenter
        addObserver:self
        selector:@selector(keyboardWillHide:)
        name:UIKeyboardWillHideNotification
        object:nil];
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    self.tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:self.tap];
}

@end

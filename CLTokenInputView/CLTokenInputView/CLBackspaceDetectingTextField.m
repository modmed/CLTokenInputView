//
//  CLBackspaceDetectingTextField.m
//  CLTokenInputView
//
//  Created by Rizwan Sattar on 2/24/14.
//  Copyright (c) 2014 Cluster Labs, Inc. All rights reserved.
//

#import "CLBackspaceDetectingTextField.h"

@implementation CLBackspaceDetectingTextField

@dynamic delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Listen for the deleteBackward method from UIKeyInput protocol
- (void)deleteBackward
{
    NSObject <CLBackspaceDetectingTextFieldDelegate> *strongDelegate = self.delegate;
    if ([strongDelegate respondsToSelector:@selector(textFieldDidDeleteBackwards:)]) {
        [strongDelegate textFieldDidDeleteBackwards:self];
    }
    // Call super afterwards, so the -text property will return text
    // prior to the delete
    [super deleteBackward];
}

// On iOS 8.0, deleteBackward is not called anymore, so according to:
// http://stackoverflow.com/a/25862878/9849
// This method override should work
- (BOOL)keyboardInputShouldDelete:(UITextField *)textField {
    BOOL shouldDelete = YES;

    if ([UITextField instancesRespondToSelector:_cmd]) {
        BOOL (*keyboardInputShouldDelete)(id, SEL, UITextField *) = (BOOL (*)(id, SEL, UITextField *))[UITextField instanceMethodForSelector:_cmd];

        if (keyboardInputShouldDelete) {
            shouldDelete = keyboardInputShouldDelete(self, _cmd, textField);
        }
    }

    if (![textField.text length] && [[[UIDevice currentDevice] systemVersion] intValue] >= 8) {
        [self deleteBackward];
    }

    return shouldDelete;
}

// Override the delegate to ensure our own delegate subclass gets set
- (void)setDelegate:(NSObject<CLBackspaceDetectingTextFieldDelegate> *)delegate
{
    [super setDelegate:delegate];
}

- (NSArray *)keyCommands {
    static NSArray *commands;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        UIKeyCommand *const forward = [UIKeyCommand keyCommandWithInput:@"\t" modifierFlags:0 action:@selector(ignore)];
        UIKeyCommand *const backward = [UIKeyCommand keyCommandWithInput:@"\t" modifierFlags:UIKeyModifierShift action:@selector(ignore)];
        
        commands = @[forward, backward];
    });
    
    return self.disallowTabbingBetweenFields ? commands : nil;
}

- (void)ignore {
    // intentionally do nothing
}

@end

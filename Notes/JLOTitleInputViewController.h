//
//  JLOTitleInputViewController.h
//  Notes
//
//  Created by Javier Llaca on 4/23/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLOContentInputViewController.h"

@class JLOTitleInputViewController;

@protocol JLOTitleInputViewControllerDelegate <NSObject>

- (void)inputController:(JLOTitleInputViewController *)controller
      didFinishWithText:(NSString *)text;

@end

@interface JLOTitleInputViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) id<JLOTitleInputViewControllerDelegate> delegate;
@property (strong, nonatomic) UITextField *noteTitle;

// Formats title input text field
- (void)formatTextField:(UITextField *)textField;

// Next button to move on to note content input view
- (void)nextButtonPressed:(UIBarButtonItem *)sender;


@end

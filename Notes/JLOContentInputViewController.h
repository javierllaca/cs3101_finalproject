//
//  JLOContentInputViewController.h
//  Notes
//
//  Created by Javier Llaca on 4/23/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLOImageSelectionViewController.h"

@class JLOContentInputViewController;

@protocol JLOContentInputViewControllerDelegate <NSObject>

- (void)inputController:(JLOContentInputViewController *)controller
      didFinishWithText:(NSString *)text;

@end

@interface JLOContentInputViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) id<JLOContentInputViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString *noteTitle;
@property (strong, nonatomic) UITextView *noteBody;

- (id)initWithTitle:(NSString *)title;

// Next button to move on to note image selection view
- (void)nextButtonPressed:(UIBarButtonItem *)sender;

@end

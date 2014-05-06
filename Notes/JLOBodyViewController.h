//
//  JLOBodyViewController.h
//  Notes
//
//  Created by Javier Llaca on 4/23/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JLOBodyViewController;

@protocol JLOBodyViewControllerDelegate <NSObject>

- (void)inputController:(JLOBodyViewController *)controller
      didFinishWithText:(NSString *)text;

@end

@interface JLOBodyViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) id<JLOBodyViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString *noteTitle;
@property (strong, nonatomic) UITextView *noteBody;

- (id)initWithTitle:(NSString *)title;

@end

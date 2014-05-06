//
//  JLOTitleViewController.h
//  Notes
//
//  Created by Javier Llaca on 4/23/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JLOTitleViewController;

@protocol JLOTitleViewControllerDelegate <NSObject>

- (void)inputController:(JLOTitleViewController *)controller
      didFinishWithText:(NSString *)text;

@end

@interface JLOTitleViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) id<JLOTitleViewControllerDelegate> delegate;
@property (strong, nonatomic) UITextField *noteTitle;

@end

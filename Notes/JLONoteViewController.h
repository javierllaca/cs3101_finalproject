//
//  JLONoteViewController.h
//  Notes
//
//  Created by Javier Llaca on 4/23/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "JLONote.h"

@interface JLONoteViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) JLONote *note;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UITextView *body;
@property (strong, nonatomic) UIImageView *image;

// Custom constructor
- (id)initWithNote:(JLONote *)note;

// Adds a square image container to view
- (void)setImageContainer;

// Modally presents a view controller to send note via email
- (IBAction)email:(id)sender;

@end

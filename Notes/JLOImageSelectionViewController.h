//
//  JLOImageSelectionViewController.h
//  Notes
//
//  Created by Javier Llaca on 4/23/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLOHomeViewController.h"
#import "JLONote.h"

#define IMAGE_CONTAINER_TAG 10
#define IMAGE_TAG           20

@interface JLOImageSelectionViewController : UIViewController <UIImagePickerControllerDelegate,
    UINavigationControllerDelegate>

// buttons
@property UIButton *takePhoto;
@property UIButton *choosePhoto;

// pickers
@property UIImagePickerController *pickFromCamera;
@property UIImagePickerController *pickFromLibrary;

// image and container
@property UIView *imageContainer;
@property UIImageView *imageView;
@property UIImage *image;

// properties from past view controllers
@property NSString *noteTitle;
@property NSString *noteBody;

// custom constructor
- (id)initWithTitle:(NSString *)title Body:(NSString *)body;

// Take photo with phone camera
- (IBAction)takePhoto:(UIButton *)sender;

// Choose photo from photo library
- (IBAction)choosePhoto:(UIButton *)sender;

// Calls storeNote and then pops to rootViewController (home view)
- (void)done:(UIBarButtonItem *)sender;

// Stores note to home view array (connected to table view)
// Storage to disk is done in a separate thread in home view
- (void)storeNote;

@end

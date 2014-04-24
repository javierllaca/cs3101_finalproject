//
//  JLOImageViewController.h
//  Notes
//
//  Created by Javier Llaca on 4/23/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLOImageViewController : UIViewController <UIImagePickerControllerDelegate,
UINavigationControllerDelegate>
{
    UIImagePickerController *takePhoto;
    UIImagePickerController *choosePhoto;
    UIImage *image;
    IBOutlet UIImageView *imageView;
}

@property UIButton *take;
@property UIButton *choose;

@end

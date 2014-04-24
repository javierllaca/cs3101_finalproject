//
//  JLOImageViewController.m
//  Notes
//
//  Created by Javier Llaca on 4/23/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import "JLOImageViewController.h"

@interface JLOImageViewController ()


@end

@implementation JLOImageViewController

- (instancetype)init
{
    self = [super init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Picture";
    imageView = [[UIImageView alloc] init];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Done!"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(nextButtonPressed:)];
    self.navigationItem.rightBarButtonItem = nextButton;
}

- (void)nextButtonPressed:(UIBarButtonItem *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)takePhoto:(id)sender
{
    takePhoto = [[UIImagePickerController alloc] init];
    takePhoto.delegate = self;
    [takePhoto setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:takePhoto animated:YES completion:nil];
}

- (IBAction)choosePhoto:(id)sender
{
    choosePhoto = [[UIImagePickerController alloc] init];
    choosePhoto.delegate = self;
    [choosePhoto setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:choosePhoto animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self setImageView];
    [imageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)setImageView
{
    for (UIView *v in self.view.subviews)
        if (v == imageView)
            [v removeFromSuperview];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    int topBound = self.navigationController.navigationBar.frame.size.height + 130;
    double ratio;
    if (image.size.width > image.size.height)
        ratio = image.size.width / bounds.size.width;
    else
        ratio = image.size.height / (bounds.size.height - topBound - 30);
    
    imageView = [[UIImageView alloc] initWithFrame:
                 CGRectMake((2 * self.view.center.x - image.size.width / ratio) / 2,
                            topBound,
                            image.size.width / ratio,
                            image.size.height / ratio)];
    [self.view addSubview:imageView];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end

//
//  JLOImageViewController.m
//  Notes
//
//  Created by Javier Llaca on 4/23/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import "JLOImageViewController.h"

#define IMAGE_TAG 10

@implementation JLOImageViewController

- (id)initWithTitle:(NSString *)title Body:(NSString *)body
{
    self = [super init];
    if (self) {
        _noteTitle = title;
        _noteBody = body;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set background to white to hide transition between views
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"Picture";
    
    // next button
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done!"
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(nextButtonPressed:)];
    self.navigationItem.rightBarButtonItem = nextButton;
    
    // take photo button
    _takePhoto = [UIButton buttonWithType:UIButtonTypeSystem];
    [_takePhoto addTarget:self
                 action:@selector(takePhoto:)
       forControlEvents:UIControlEventTouchUpInside];
    _takePhoto.titleLabel.font = [UIFont systemFontOfSize:18];
    [_takePhoto setFrame:CGRectMake(10, 80, 300, 30)];
    [_takePhoto setTitle:@"Take Photo" forState:UIControlStateNormal];
    [self.view addSubview:_takePhoto];
    
    // choose photo button
    _choosePhoto = [UIButton buttonWithType:UIButtonTypeSystem];
    [_choosePhoto addTarget:self
                   action:@selector(choosePhoto:)
         forControlEvents:UIControlEventTouchUpInside];
    _choosePhoto.titleLabel.font = [UIFont systemFontOfSize:18];
    [_choosePhoto setFrame:CGRectMake(10, 120, 300, 30)];
    [_choosePhoto setTitle:@"Choose Photo" forState:UIControlStateNormal];
    [self.view addSubview:_choosePhoto];
}

- (void)nextButtonPressed:(UIBarButtonItem *)sender
{
    JLONote *note = [[JLONote alloc] initWithTitle:_noteTitle Body:_noteBody Image:_image];
    JLOHomeViewController *rootViewController = [self.navigationController.viewControllers
                                            firstObject];
    [[rootViewController notes] addObject:note];
    
    // reload table view in home before popping to home view controller
    // gives the impression that table reloaded quickly
    [[rootViewController tableView] reloadData];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)takePhoto:(UIButton *)sender
{
    _pickFromCamera = [[UIImagePickerController alloc] init];
    _pickFromCamera.delegate = self;
    [_pickFromCamera setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:_pickFromCamera animated:YES completion:nil];
}

- (IBAction)choosePhoto:(UIButton *)sender
{
    _pickFromLibrary = [[UIImagePickerController alloc] init];
    _pickFromLibrary.delegate = self;
    [_pickFromLibrary setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:_pickFromLibrary animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self setImageView];
    [_imageView setImage:_image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)setImageView
{
    if([self.view viewWithTag:IMAGE_TAG] != nil)
        [[self.view viewWithTag:IMAGE_TAG] removeFromSuperview];
    
    int topBound = _choosePhoto.frame.origin.y + _choosePhoto.frame.size.height + 20;
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    double ratio = (_image.size.width > _image.size.height) ?
        _image.size.width / (screenSize.width - 30) :
        _image.size.height / (screenSize.height - topBound - 30);
    
    _imageView = [[UIImageView alloc] initWithFrame:
                  CGRectMake((2 * self.view.center.x - _image.size.width / ratio) / 2,
                             topBound,_image.size.width / ratio, _image.size.height / ratio)];
    _imageView.tag = IMAGE_TAG;
    [self.view addSubview:_imageView];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end

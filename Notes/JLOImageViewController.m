//
//  JLOImageViewController.m
//  Notes
//
//  Created by Javier Llaca on 4/23/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import "JLOImageViewController.h"

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


- (void)loadView
{
    [super loadView];
    // Set background to white to hide transition between views
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"Picture";
    
    // next button
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done!"
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = nextButton;
    
    CGSize viewSize = self.view.frame.size;
    
    // take photo button
    _takePhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_takePhoto addTarget:self
                   action:@selector(takePhoto:)
         forControlEvents:UIControlEventTouchUpInside];
    _takePhoto.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_takePhoto setFrame:CGRectMake(0, 90, viewSize.width, 40)];
    [_takePhoto setTitle:@"Take Photo" forState:UIControlStateNormal];
    [self.view addSubview:_takePhoto];
    
    // choose photo button
    _choosePhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_choosePhoto addTarget:self
                     action:@selector(choosePhoto:)
           forControlEvents:UIControlEventTouchUpInside];
    _choosePhoto.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_choosePhoto setFrame:CGRectMake(0, 150, viewSize.width, 40)];
    [_choosePhoto setTitle:@"Choose Photo" forState:UIControlStateNormal];
    [self.view addSubview:_choosePhoto];
    
    // square image container
    double margin = 40.0;
    double topBound = _choosePhoto.frame.origin.y + _choosePhoto.frame.size.height + margin;
    double sideLength = viewSize.width - 2 * margin;
    
    _imageContainer = [[UIView alloc]
                              initWithFrame:CGRectMake(margin, topBound, sideLength, sideLength)];
    _imageContainer.tag = IMAGE_CONTAINER_TAG;
    [self.view addSubview:_imageContainer];
}

- (void)done:(UIBarButtonItem *)sender
{
    JLONote *note = [[JLONote alloc] initWithTitle:_noteTitle Body:_noteBody Image:_image];
    JLOHomeViewController *rootViewController = [self.navigationController.viewControllers
                                            firstObject];
    [[rootViewController notes] addObject:note];
    
    // reload table view in home before popping to home view controller
    // gives the impression that table reloaded quickly
    [[rootViewController tableView] reloadData];
    
    // Store in core data
    JLOAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *newContact;
    newContact = [NSEntityDescription insertNewObjectForEntityForName:@"Notes" inManagedObjectContext:context];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:note];
    [newContact setValue:data forKey:@"note"];
    [newContact setValue:note.date forKey:@"date"];
    
    NSError *error;
    [context save:&error];
    
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


- (void)imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info
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
    
    CGSize imageSize = _image.size;
    CGSize containerSize = _imageContainer.frame.size;
    
    double width, height;
    double originX = 0;
    double ratio = imageSize.width / imageSize.height;
    
    if (imageSize.width > imageSize.height) {
        width = containerSize.width;
        height = width / ratio;
        
    } else {
        height = containerSize.width;
        width = height * ratio;
        
        // make image appear centered if its height > width
        originX = (containerSize.width - width) / 2;
    }
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(originX, 0, width, height)];
    
    _imageView.image = _image;
    _imageView.tag = IMAGE_TAG;
    [[self.view viewWithTag:IMAGE_CONTAINER_TAG] addSubview:_imageView];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end

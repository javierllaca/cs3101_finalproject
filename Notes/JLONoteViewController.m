//
//  JLONoteViewController.m
//  Notes
//
//  Created by Javier Llaca on 4/23/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import "JLONoteViewController.h"

@implementation JLONoteViewController

- (id)initWithNote:(JLONote *)note
{
    self = [super init];
    if (self) {
        _note = note;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:_note.title];
    
    // email note button
    UIBarButtonItem *email = [[UIBarButtonItem alloc] initWithTitle:@"Email"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(email:)];
    self.navigationItem.rightBarButtonItem = email;
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGSize navBarSize = self.navigationController.navigationBar.frame.size;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 10,
        screenSize.width - 20, screenSize.height - navBarSize.height)];
    
    _body = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, 0)];
    _body.textAlignment = NSTextAlignmentJustified;
    _body.text = _note.body;
    _body.textColor = [UIColor blackColor];
    [_body setFont:[UIFont systemFontOfSize:16.0]];
    [_body sizeToFit];
    _body.scrollEnabled = NO;
    
    if (_note.image) {
        // We want the width of the image to fit the width of the scroll view
        double ratio = _note.image.size.width / _scrollView.frame.size.width;
        
        _image = [[UIImageView alloc] initWithFrame: CGRectMake(0.0, _body.frame.size.height + 20.0,
                                                                _note.image.size.width / ratio, _note.image.size.height / ratio)];
        _image.image = _note.image;
        [_scrollView addSubview:_image];
    }
    
    [_scrollView addSubview:_body];
    
    // Set content size of scroll view to fit the body and image of note
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width,
                    _body.frame.size.height + 20 + _image.frame.size.height)];
    [self.view addSubview:_scrollView];
}

- (IBAction)email:(id)sender
{
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    if ([MFMailComposeViewController canSendMail]) {
        mc.mailComposeDelegate = self;
        [mc setSubject:_note.title];
        [mc setMessageBody:_note.body isHTML:NO];
        
        // Encode scaled image as jpeg file
        NSData *picture = UIImageJPEGRepresentation(_note.image, 1.0);
        
        // Set atttachment attributes
        NSString *mime = @"image/jpeg";
        NSString *filename = @"attached_picture.jpg";
        
        // Send image as attachment
        [mc addAttachmentData:picture
                     mimeType:mime
                     fileName:filename];
        
        [self presentViewController:mc animated:YES completion:NULL];
     }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller
           didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end

//
//  JLOBodyViewController.m
//  Notes
//
//  Created by Javier Llaca on 4/23/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import "JLOBodyViewController.h"
#import "JLOImageViewController.h"

@implementation JLOBodyViewController

- (id)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        _noteTitle = title;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set background to white to hide transition between views
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"Content";
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Picture"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(nextButtonPressed:)];
    self.navigationItem.rightBarButtonItem = nextButton;
    
    // Add text view to view
    _noteBody = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, 400)];
    _noteBody.text = @"Enter body content...";
    _noteBody.textColor = [UIColor lightGrayColor];
    [_noteBody setFont:[UIFont systemFontOfSize:16.0]];
    _noteBody.textAlignment = NSTextAlignmentJustified;
    _noteBody.delegate = self;
    [self.view addSubview:_noteBody];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Enter body content..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

- (void)nextButtonPressed:(UIBarButtonItem *)sender
{
    JLOImageViewController *imageVC = [[JLOImageViewController alloc] initWithTitle:_noteTitle
                                                                               Body:_noteBody.text];
    [self.navigationController pushViewController:imageVC animated:YES];
}

@end

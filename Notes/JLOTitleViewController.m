//
//  JLOTitleViewController.m
//  Notes
//
//  Created by Javier Llaca on 4/23/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import "JLOTitleViewController.h"
#import "JLOBodyViewController.h"

@implementation JLOTitleViewController

- (id)init
{
    self = [super init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set background to white to hide transition between views
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"Title";
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Content"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(nextButtonPressed:)];
    self.navigationItem.rightBarButtonItem = nextButton;
    
    // Initialize text field
    _noteTitle = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, 300, 50)];
    
    [self formatTextField:_noteTitle];
    
    // Add text field to view
    [self.view addSubview:_noteTitle];
}

- (void)formatTextField:(UITextField *)textField
{
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:18];
    textField.placeholder = @"Enter note title...";
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

- (void)nextButtonPressed:(UIBarButtonItem *)sender
{
    JLOBodyViewController *bodyVC = [[JLOBodyViewController alloc] initWithTitle:_noteTitle.text];
    //[bodyVC setTitle:self.textField.text];
    [self.navigationController pushViewController:bodyVC animated:YES];
}

@end

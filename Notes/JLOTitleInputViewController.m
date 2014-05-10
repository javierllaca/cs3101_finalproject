//
//  JLOTitleInputViewController.m
//  Notes
//
//  Created by Javier Llaca on 4/23/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import "JLOTitleInputViewController.h"

@implementation JLOTitleInputViewController

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
                                   initWithTitle:@"Next"
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
    JLOContentInputViewController *bodyVC = [[JLOContentInputViewController alloc] initWithTitle:_noteTitle.text];
    [self.navigationController pushViewController:bodyVC animated:YES];
}

@end

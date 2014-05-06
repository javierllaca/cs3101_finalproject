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
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Add Content"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(nextButtonPressed:)];
    self.navigationItem.rightBarButtonItem = nextButton;
    
    // Initialize text field
    _noteTitle = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, 300, 50)];
    
    // Format text field
    _noteTitle.borderStyle = UITextBorderStyleRoundedRect;
    _noteTitle.font = [UIFont systemFontOfSize:18];
    _noteTitle.placeholder = @"Enter note title...";
    _noteTitle.autocorrectionType = UITextAutocorrectionTypeNo;
    _noteTitle.keyboardType = UIKeyboardTypeDefault;
    _noteTitle.returnKeyType = UIReturnKeyDone;
    _noteTitle.clearButtonMode = UITextFieldViewModeWhileEditing;
    _noteTitle.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    // Add text field to view
    [self.view addSubview:_noteTitle];
}

- (void)nextButtonPressed:(UIBarButtonItem *)sender
{
    JLOBodyViewController *bodyVC = [[JLOBodyViewController alloc] initWithTitle:_noteTitle.text];
    //[bodyVC setTitle:self.textField.text];
    [self.navigationController pushViewController:bodyVC animated:YES];
}

@end

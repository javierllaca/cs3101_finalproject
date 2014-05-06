//
//  JLOHomeViewController.m
//  Notes
//
//  Created by Javier Llaca on 4/20/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import "JLOHomeViewController.h"

@implementation JLOHomeViewController

- (id)init
{
    self = [super init];
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"home vc"];
}

- (void)loadView
{
    [super loadView];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _notes = [[NSMutableArray alloc] init];
    self.navigationController.delegate = self;
    self.title = @"Notes";
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(addButtonPressed:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)addButtonPressed:(UIBarButtonItem *)sender
{
    JLOTitleViewController *titleVC = [[JLOTitleViewController alloc] init];
    [self.navigationController pushViewController:titleVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReuseIdentifer"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellReuseIdentifer"];
    }
    
    // set cell text to note title
    cell.textLabel.text = [_notes[indexPath.row] title];
    return cell;
}

-(void)inputController:(JLOTitleViewController *)controller didFinishWithText:(NSString *)text
{
    
}

@end

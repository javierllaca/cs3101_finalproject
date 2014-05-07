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

- (void)loadView
{
    [super loadView];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                              style:UITableViewStylePlain];
    [_tableView setRowHeight:CELL_HEIGHT];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _notes = [[NSMutableArray alloc] init];
    [self loadStoredNotes];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Notes";
    self.navigationController.delegate = self;
    [self setNavigationBarButtons];
}

- (void)setNavigationBarButtons
{
    // add note button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self
                                  action:@selector(addNote:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    // edit note list button
    UIBarButtonItem *edit = [[UIBarButtonItem alloc]
                             initWithTitle:@"Edit"
                             style:UIBarButtonItemStylePlain
                             target:self
                             action:@selector(toggleEditingMode:)];
    self.navigationItem.leftBarButtonItem = edit;
}

// Load from core data
- (void)loadStoredNotes
{
    JLOAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Notes" inManagedObjectContext:context]];
    [request setPredicate:nil];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    NSManagedObject *matches = nil;
    if ([objects count] != 0) {
        for (int i = 0; i < [objects count];i++) {
            matches = objects[i];
            NSData *data = [matches valueForKey:@"note"];
            JLONote *note = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [self.notes addObject:note];
        }
    }
}

// deletes note from core data
- (void)deleteNote:(JLONote *)note
{
    JLOAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(date == %@)", note.date];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Notes" inManagedObjectContext:context]];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    [context deleteObject:[results firstObject]];
    [context save:&error];
}

#pragma Navigation Bar Button Methods

- (void)addNote:(UIBarButtonItem *)sender
{
    JLOTitleViewController *titleVC = [[JLOTitleViewController alloc] init];
    [self.navigationController pushViewController:titleVC animated:YES];
}

- (IBAction)toggleEditingMode:(id)sender
{
    if (_tableView.isEditing) {
        [sender setTitle:@"Edit"];
        [_tableView setEditing:NO animated:YES];
    } else {
        [sender setTitle:@"Done"];
        [_tableView setEditing:YES animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [_notes copy];
        JLONote *note = items[indexPath.row];
        [_notes removeObject:note];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        [self deleteNote:note];
    }
}

#pragma Table View Methods

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
    return _notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellIdentifier";
    JLONote *note = _notes[indexPath.row];
    
    // Format the NSDate in an NSString (e.g. "May 5, 2014")
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *dateString = [dateFormatter stringFromDate:note.date];
    
    UIImageView *photo;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    
    // If note has an image, setup a subview for it in the cell
    if (note.image) {
        CGSize photosize = note.image.size;
        double margin = 5.0;
        double ratio = photosize.width / photosize.height;
        double height = CELL_HEIGHT - 2 * margin;
        double width = height * ratio;
        photo = [[UIImageView alloc]
                 initWithFrame:CGRectMake(self.view.frame.size.width - width - margin,
                                          margin, width, height)];
        photo.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        photo.image = note.image;
        [cell.contentView addSubview:photo];
    }
    
    // Assign the cell title and subtitle
    cell.textLabel.text = note.title;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.detailTextLabel.text = dateString;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JLONoteViewController *detailVC = [[JLONoteViewController alloc] initWithNote:_notes[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
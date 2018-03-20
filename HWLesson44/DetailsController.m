//
//  DetailsController.m
//  HWLesson44
//
//  Created by Alex Delin on 18.03.2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

#import "DetailsController.h"
#import "User+CoreDataClass.h"
#import "Course+CoreDataClass.h"
#import "ChangeDetailsController.h"

@interface DetailsController ()

@end

@implementation DetailsController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"USER = %@ %@", self.user.lastName, self.user.firstName);
    self.title = @"Инфо";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark CoreData
- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Course" inManagedObjectContext:self.viewContext];
    [fetchRequest setEntity:entity];
    
    //     Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Сортировка
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[nameDescriptor]];
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"students contains %@", self.user];
//    [fetchRequest setPredicate:predicate];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                managedObjectContext:self.viewContext
                                                                                                  sectionNameKeyPath:nil
                                                                                                           cacheName:nil];
    
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *) indexPath {

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Фамилия";
            cell.detailTextLabel.text = self.user.lastName;
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"Имя";
            cell.detailTextLabel.text = self.user.firstName;
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"email";
            cell.detailTextLabel.text = self.user.email;
        }
    } else if (indexPath.section == 1) {
        NSIndexPath *iPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section-1];
        Course *course = [self.fetchedResultsController objectAtIndexPath:iPath];
        cell.textLabel.text = course.name;
    }
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", [course.students count]];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}


#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell* higlightedCell = [self.tableView cellForRowAtIndexPath:indexPath];
        self.currentTextValue = higlightedCell.detailTextLabel.text;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"ChangeDetailsSegue" sender:nil];
    
}


#pragma mark  UITableViewDataSource

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *sectionName = nil;
    if (section == 0) {
        sectionName = @"Личные данные";
    } else if (section == 1) {
        sectionName = @"Курсы";
    }

    return sectionName;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sectionsCount = [[self.fetchedResultsController sections] count] + 1;
    return sectionsCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger rowsCount = 0;
    
    if (section == 0) {
        rowsCount = 3;
    } else if (section == 1) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section-1];
        rowsCount = [sectionInfo numberOfObjects];
    }
    return rowsCount;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ChangeDetailsSegue"]) {
        ChangeDetailsController *changeDetailsController = [segue destinationViewController];
        changeDetailsController.changeFieldText = self.currentTextValue;
    }
}


@end

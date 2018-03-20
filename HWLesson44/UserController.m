//
//  UserController.m
//  HWLesson44
//
//  Created by Alex Delin on 17.03.2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

#import "UserController.h"
#import "User+CoreDataClass.h"
#import "UserCell.h"
#import "DetailsController.h"

@interface UserController ()
@property (strong,nonatomic) User *currentUser;
@end

@implementation UserController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Пользователи";
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
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.viewContext];
    [fetchRequest setEntity:entity];
    
//     Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Сортировка
    NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[lastNameDescriptor, firstNameDescriptor]];
    
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
    UserCell* userCell = [[UserCell alloc] init];
    userCell = (UserCell*) cell;
    
    User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    userCell.lastNameLabel.text = user.lastName;
    userCell.firstNameLabel.text = user.firstName;
    userCell.emailLabel.text = user.email;
    
//    расчет начальной точки для firstName
    float widthLastName =  [userCell.lastNameLabel.text boundingRectWithSize:userCell.lastNameLabel.frame.size
                                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                                  attributes:@{ NSFontAttributeName:userCell.lastNameLabel.font }
                                                                     context:nil]
   
    .size.width;
    
    CGRect frame = userCell.lastNameLabel.frame;
    frame.origin.x = widthLastName + 20;
    
    userCell.firstNameLabel.frame = frame;
    
}



#pragma mark  UITableViewDataSource
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return sectionInfo.name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    static NSString *identifier = @"CellUser";
    
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    self.currentUser = user;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"DetailsSegue"]) {
        
        DetailsController *detailsController = [segue destinationViewController];
        detailsController.user = self.currentUser;
    }
}

@end

//
//  CoreDataTableViewController.h
//  CoreDataTest
//
//  Created by Alex Delin on 23.02.2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CoreDataTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *viewContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

//
//  DetailsController.h
//  HWLesson44
//
//  Created by Alex Delin on 18.03.2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@class User;

@interface DetailsController : CoreDataTableViewController
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSString* currentTextValue;

@end

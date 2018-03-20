//
//  AddUserController.m
//  HWLesson44
//
//  Created by Alex Delin on 17.03.2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

#import "AddUserController.h"
#import "UserController.h"
#import "DataManager.h"

@interface AddUserController ()

@end

@implementation AddUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)actionSave:(id)sender {
    DataManager *dataManager = [DataManager sharedManager];
    [dataManager addUserWithName:self.nameField.text lastName:self.lastNameField.text email:self.emailField.text];
    
    [self.navigationController popViewControllerAnimated:YES];
    
//    [dataManager printAllObjects:@"User"];
}



@end

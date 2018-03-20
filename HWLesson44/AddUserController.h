//
//  AddUserController.h
//  HWLesson44
//
//  Created by Alex Delin on 17.03.2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddUserController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

//- (IBAction)actionTextChanged:(UITextField *)sender;
- (IBAction)actionSave:(id)sender;

@end

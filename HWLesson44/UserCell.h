//
//  UserCell.h
//  HWLesson44
//
//  Created by Alex Delin on 18.03.2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end

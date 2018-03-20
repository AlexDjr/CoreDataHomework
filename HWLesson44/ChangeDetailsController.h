//
//  ChangeDetailsController.h
//  HWLesson44
//
//  Created by Alex Delin on 19.03.2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeDetailsController : UIViewController
@property (strong,nonatomic) NSString* changeFieldText;
@property (weak, nonatomic) IBOutlet UITextField *changeField;

@end

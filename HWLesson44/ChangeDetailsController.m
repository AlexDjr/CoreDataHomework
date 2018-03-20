//
//  ChangeDetailsController.m
//  HWLesson44
//
//  Created by Alex Delin on 19.03.2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

#import "ChangeDetailsController.h"

@interface ChangeDetailsController ()

@end

@implementation ChangeDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.changeField.text = self.changeFieldText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

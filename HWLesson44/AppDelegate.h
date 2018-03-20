//
//  AppDelegate.h
//  HWLesson44
//
//  Created by Alex Delin on 17.03.2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end


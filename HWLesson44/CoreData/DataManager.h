//
//  DataManager.h
//  CoreDataTest
//
//  Created by Alex Delin on 23.02.2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Student;
@class User;
@class Course;

@interface DataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

+ (DataManager*) sharedManager;

//- (void) createRandomStudents:(NSInteger) count;
- (Student*) addStudent;
- (User*) addUserWithName:(NSString*) name lastName:(NSString*) lastName  email:(NSString*) email;
- (void) deleteAllObjects;
- (void) printAllObjects:(NSString*) object;
- (Course*) addCourseWithName:(NSString*) name;

- (void)saveContext;

@end


//
//  DataManager.m
//  CoreDataTest
//
//  Created by Alex Delin on 23.02.2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

#import "DataManager.h"
#import "User+CoreDataClass.h"
#import "Teacher+CoreDataClass.h"
#import "Student+CoreDataClass.h"
#import "Course+CoreDataClass.h"

@interface DataManager ()
//@property (strong, nonatomic) NSManagedObjectContext *viewContext;
@end


@implementation DataManager

+ (DataManager*) sharedManager {
    static DataManager *manager = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc] init];
    });
    return manager;
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"DataModel"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


#pragma mark - Methods
- (Student*) addStudent {
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student"
                                                     inManagedObjectContext:self.persistentContainer.viewContext];
    student.score = (float)arc4random_uniform(201)/200.f + 2.f; //генерация числа от 2 до 4
    
    return student;
}

- (User*) addUserWithName:(NSString*) name lastName:(NSString*) lastName  email:(NSString*) email  {
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                     inManagedObjectContext:self.persistentContainer.viewContext];
    user.firstName = name;
    user.lastName = lastName;
    user.email = email;
    
//    сохраняем в БД
    NSError* error = nil;
    if (![self.persistentContainer.viewContext save:&error]) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    return user;
}

- (Course*) addCourseWithName:(NSString*) name {
    
    Course* course =
    [NSEntityDescription insertNewObjectForEntityForName:@"Course"
                                  inManagedObjectContext:self.persistentContainer.viewContext];
    
    course.name = name;
    
    //    сохраняем в БД
    NSError* error = nil;
    if (![self.persistentContainer.viewContext save:&error]) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    return course;
}

- (NSArray*) allObjects:(NSString*) entity {
    //    ПОЛУЧЕНИЕ ДАННЫХ ИЗ БД
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //    [request setFetchBatchSize:20];
    //    [request setFetchLimit:35];
    //    [request setFetchOffset:10];
//    [request setRelationshipKeyPathsForPrefetching:@[@"car",@"courses"]]; //Для Student
//        [request setRelationshipKeyPathsForPrefetching:@[@"students"]]; //Для Course
    
    NSEntityDescription *description = [NSEntityDescription entityForName:entity inManagedObjectContext:self.persistentContainer.viewContext];
    [request setEntity:description];
    
    
    //    Инициализация request, созданного через конструктор
    //    NSFetchRequest* request = [[self.managedObjectModel fetchRequestTemplateForName:@"FetchStudents"] copy];
    
    //   СОРТИРОВКА
    //для Student
    //     NSSortDescriptor* firstNameDescriptor =
    //     [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    //
    //     NSSortDescriptor* lastNameDescriptor =
    //     [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    //
    //     [request setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
    
    
    //    ФИЛЬТРАЦИЯ
    // для Student
    //     NSArray* validNames = @[@"Janna", @"Cleveland", @"Daryl"];
    //
    //     NSPredicate* predicate = [NSPredicate predicateWithFormat: @"score > %f AND "
    //                                                                 "score <= %f AND "
    //                                                                 "courses.@count >= %d AND "
    //                                                                 "firstName IN %@",
    //                                                                 3.0, 3.5, 3, validNames];
    
    // для Course
    //    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"@max.students.score > %f", 3.9];
    //    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SUBQUERY(students, $student, $student.car.model == %@).@count >= %d", @"BMW", 6];
    
    //   устанавливаем predicate для request
    //    [request setPredicate:predicate];
    
    
    
    NSError *requestError = nil;
    NSArray *resultArray = [self.persistentContainer.viewContext executeFetchRequest:request error:&requestError];
    
    
    if (requestError) {
        NSLog(@"%@",[requestError localizedDescription]);
    }
    return resultArray;
}

- (void) printAllObjects:(NSString*) object  {
    
    NSArray *array = [self allObjects:object];
    
    for (id object in array) {
        if ([object isKindOfClass:[Student class]]) {
            Student *student = (Student*) object ;
            NSLog(@"STUDENT: %@ %@, score: %1.2f", student.firstName, student.lastName, student.score);
        } else if ([object isKindOfClass:[User class]]) {
            User *user = (User*) object ;
            NSLog(@"USER: %@ %@, email: %@", user.firstName, user.lastName, user.email);
        } else if ([object isKindOfClass:[Course class]]) {
            
            Course* course = (Course*) object;
            NSLog(@"COURSE: %@ Students: %ld", course.name, [course.students count]);
            
            //            NSLog(@"BEST STUDENTS:");
            //            for (Student *student in course.bestStudents) {
            //                NSLog(@"    student: %@ %@, score: %1.2f", student.firstName, student.lastName, student.score);
            //            }
            
        }
    };
}

- (void) deleteAllObjects {
    NSArray *array = [self allObjects:@"Entity"];
    
    for (id object in array) {
        [self.persistentContainer.viewContext deleteObject:object];
    };
    [self.persistentContainer.viewContext save:nil];
}

//- (void) createRandomStudents:(NSInteger) count {
//    
//    [self deleteAllObjects];
//    
//    NSError* error = nil;
//    
//    NSArray* courses =    @[[self addCourseWithName:@"iOS"],
//                            [self addCourseWithName:@"Android"],
//                            [self addCourseWithName:@"PHP"],
//                            [self addCourseWithName:@"Javascript"],
//                            [self addCourseWithName:@"HTML"]];
//    
//    University* university = [self addUniversity];
//    
//    [university addCourses:[NSSet setWithArray:courses]];
//    
//    for (int i = 0; i < count; i++) {
//        
//        Student* student = [self addRandomStudent];
//        
//        if (arc4random_uniform(1000) < 500) {
//            Car* car = [self addRandomCar];
//            student.car = car;
//        }
//        
//        student.university = university;
//        
//        NSInteger number = arc4random_uniform(5) + 1;
//        
//        while ([student.courses count] < number) {
//            Course* course = [courses objectAtIndex:arc4random_uniform(5)];
//            if (![student.courses containsObject:course]) {
//                [student addCoursesObject:course];
//            }
//        }
//    }
//    
//    if (![self.persistentContainer.viewContext save:&error]) {
//        NSLog(@"%@", [error localizedDescription]);
//    }
//     
//}

@end

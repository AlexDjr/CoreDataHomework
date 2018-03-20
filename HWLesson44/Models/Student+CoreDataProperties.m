//
//  Student+CoreDataProperties.m
//  HWLesson44
//
//  Created by Alex Delin on 18.03.2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic score;
@dynamic courses;

@end

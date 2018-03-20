//
//  Course+CoreDataProperties.m
//  HWLesson44
//
//  Created by Alex Delin on 18.03.2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//
//

#import "Course+CoreDataProperties.h"

@implementation Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Course"];
}

@dynamic name;
@dynamic students;
@dynamic teacher;

@end

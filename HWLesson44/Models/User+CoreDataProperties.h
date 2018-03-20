//
//  User+CoreDataProperties.h
//  HWLesson44
//
//  Created by Alex Delin on 18.03.2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;

@end

NS_ASSUME_NONNULL_END

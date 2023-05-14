//
//  Task.h
//  ToDo List
//
//  Created by MAC on 26/04/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task  : NSObject <NSCoding, NSSecureCoding>

@property NSString *title;
@property NSInteger *taskId;
@property NSString *descriptionTask;
@property NSString *priority;
@property NSDate *date;


-(void) encodeWithCoder:(NSCoder *)encoder;
@end

NS_ASSUME_NONNULL_END

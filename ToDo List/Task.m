//
//  Task.m
//  ToDo List
//
//  Created by MAC on 26/04/2023.
//

#import "Task.h"

@implementation Task

- (void)encodeWithCoder:(nonnull NSCoder *)encoder {
    [encoder encodeObject:_title forKey:@"title"];
    [encoder encodeObject:_date forKey:@"date"];
    [encoder encodeObject:_priority forKey:@"priority"];
    [encoder encodeObject:_descriptionTask forKey:@"descriptionTask"];
    [encoder encodeInt:_taskId forKey:@"taskId"];
}
static int instanceCount = 0;
- (instancetype)init
{
    
    self = [super init];
    if (self) {
        instanceCount++;
        self.taskId = instanceCount;
    }
    return self;
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)decoder {
    if(self=[super init]){
        _title=[decoder decodeObjectOfClass:[NSString class] forKey:@"title"];
        _date=[decoder decodeObjectOfClass:[NSDate class] forKey:@"date"];
        _descriptionTask=[decoder decodeObjectOfClass:[NSString class] forKey:@"descriptionTask"];
        _priority=[decoder decodeObjectOfClass:[NSString class] forKey:@"priority"];
        _taskId=[decoder decodeIntForKey:@"taskId"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding{
    return YES;
}

@end

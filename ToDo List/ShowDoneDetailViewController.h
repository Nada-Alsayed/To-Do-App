//
//  ShowDoneDetailViewController.h
//  ToDo List
//
//  Created by MAC on 27/04/2023.
//

#import "ViewController.h"
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShowDoneDetailViewController : ViewController

@property Task *receivedObject;
@property long index;
@end

NS_ASSUME_NONNULL_END

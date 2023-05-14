//
//  EditToDoViewController.h
//  ToDo List
//
//  Created by MAC on 26/04/2023.
//

#import "ViewController.h"
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditToDoViewController : ViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *state;
@property (weak, nonatomic) IBOutlet UIDatePicker *date;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;
@property (weak, nonatomic) IBOutlet UITextField *txtDesc;
@property (weak, nonatomic) IBOutlet UITextField *txtTitle;

@property Task *receivedObject;
@property long index;

@end

NS_ASSUME_NONNULL_END

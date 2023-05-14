//
//  TableViewCell.h
//  ToDo List
//
//  Created by MAC on 26/04/2023.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

NS_ASSUME_NONNULL_END

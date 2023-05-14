//
//  ViewController.m
//  ToDo List
//
//  Created by MAC on 26/04/2023.
//

#import "ViewController.h"
#import "Task.h"
#import "TableViewCell.h"
#import "AddTaskViewController.h"
#import "EditToDoViewController.h"

@interface ViewController (){
    Boolean _isSearching;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar2;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property NSMutableArray<Task *> *todoArr;
@property (nonatomic, strong) NSMutableArray<Task *> *filteredData;
@end

@implementation ViewController

-(IBAction)btnAdd:(id)sender {
    AddTaskViewController *addScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"addScreen"];
    [ self.navigationController pushViewController:addScreen animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:@"TASK"];
//    self.todoArr=[NSKeyedUnarchiver unarchiveObjectWithData:data];
//
    //if(self.todoArr==nil){
        self.todoArr=[NSMutableArray new];
  //  }
    _isSearching=false;
   _searchBar2.delegate=self;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if(searchText.length>0)
    {
        _isSearching=true;
        _filteredData=[NSMutableArray new];
        for(Task *task in self.todoArr)
        {
            NSRange range=[task.title rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(range.location != NSNotFound)
            {
                [_filteredData addObject:task];
            }
        }
    }
    else
    {
        _filteredData=nil;
        _isSearching=false;
    }
    [self.table reloadData];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
    
    NSError *error;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];

    NSData *saveData=[defaults objectForKey:@"Try"];

    NSMutableArray<Task *> *task1=(NSMutableArray *) [NSKeyedUnarchiver unarchiveObjectWithData:saveData];
    if(task1==nil){
        task1=[NSMutableArray new];
        self.todoArr=task1;
    }else{
        
        if(error !=nil){
            NSLog(@"error log");
        }else{
            NSLog( @"%@ task1 date", task1.firstObject.date);
        }
        self.todoArr=task1;
        NSLog(@"%lu count2:", (unsigned long)task1.count);

        NSLog(@"%lu count:", (unsigned long)self.todoArr.count);
        [_table reloadData];
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
            [self.todoArr removeObjectAtIndex:indexPath.row];
            NSData *newArchiveData = [NSKeyedArchiver archivedDataWithRootObject:self.todoArr];
            NSUserDefaults *defaultData = [NSUserDefaults standardUserDefaults];
            [defaultData setObject:newArchiveData forKey:@"Try"];
            [defaultData synchronize];
        // Delete the row from the table view
        [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
     TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.imgView.layer.cornerRadius = cell.imgView.frame.size.width / 2;
    cell.imgView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imgView.clipsToBounds = YES;
    
    
    if(_isSearching){
        cell.labelTitle.text=_filteredData[indexPath.row].title;

        if([_filteredData[indexPath.row].priority isEqual:@"High"])
           {
            cell.imgView.image=[UIImage imageNamed:@"red"] ;
        }
        else if ([_filteredData[indexPath.row].priority isEqual:@"Medium"])
           {
            cell.imgView.image=[UIImage imageNamed:@"orange"] ;
        }
        else
           {
            cell.imgView.image=[UIImage imageNamed:@"green"] ;
        }
    }else{
        cell.labelTitle.text=_todoArr[indexPath.row].title;
        
        if([_todoArr[indexPath.row].priority isEqual:@"High"])
        {
            cell.imgView.image=[UIImage imageNamed:@"red"] ;
        }
        else if ([_todoArr[indexPath.row].priority isEqual:@"Medium"])
        {
            cell.imgView.image=[UIImage imageNamed:@"orange"] ;
        }
        else
        {
            cell.imgView.image=[UIImage imageNamed:@"green"] ;
        }
    }
    cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _isSearching?_filteredData.count: _todoArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
  
    Task *
        dataObject = [_todoArr objectAtIndex:indexPath.row] ;

    EditToDoViewController *addScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"editToDo"];
    [ self.navigationController pushViewController:addScreen animated:YES];
    
    addScreen.index=indexPath.row;
    addScreen.receivedObject=dataObject;
    NSLog(@"add id8888 :%d",dataObject.taskId);
    NSLog(@"title id8888 :%@",dataObject.title);
    
}

@end

//
//  ViewController.h
//  ProgrammingAssessmentiOS
//
//  Created by Diego Eduardo on 11/13/15.
//  Copyright © 2015 Diego Eduardo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (strong, atomic) IBOutlet UITableView *tableViewResults;
@property (strong, nonatomic) IBOutlet UITextField *texFieldInput;
@property(strong,nonatomic) NSArray* resultsDictionary;
- (IBAction)nyButtonAction:(UIButton *)sender;


@end


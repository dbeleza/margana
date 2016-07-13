//
//  ViewController.m
//  Margana
//
//  Created by David Beleza on 13/07/16.
//  Copyright © 2016 David Beleza. All rights reserved.
//

#import "ViewController.h"
#import "TableViewDataSource.h"
#import "ViewModel.h"

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldAddWord;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *textFieldWordToSearch;

@property (nonatomic,strong) TableViewDataSource *dataSource;

@property (nonatomic, strong) ViewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _dataSource = [[TableViewDataSource alloc]init];
    
    _tableView.dataSource = _dataSource;
    
    _textFieldAddWord.delegate = self;
    
    _textFieldWordToSearch.delegate = self;
    
    _viewModel = [[ViewModel alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addWord:(id)sender {
    
    if (_textFieldAddWord.text.length>0) {
        
        [_dataSource.mutableArray addObject:_textFieldAddWord.text];
        
        [_tableView reloadData];
        
        _textFieldAddWord.text=@"";
        
    }
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ( [string isEqualToString:@" "] ){
        return NO;
    }
    else {
        return YES;
    }
}


- (IBAction)searchAnagramFromArray:(id)sender {
    
    if (_textFieldWordToSearch.text.length>0) {
     
        [_viewModel getAnagramList:_dataSource.mutableArray withString:_textFieldWordToSearch.text afterCompletion:^(NSMutableArray *arrayAnagram) {
            
            NSLog(@"%@", arrayAnagram);
            
        }];
        
    }
    
}


- (IBAction)clear:(id)sender {
    
    [_dataSource.mutableArray removeAllObjects];
    [_tableView reloadData];
    
    _textFieldWordToSearch.text=@"";
    
    if ([_textFieldWordToSearch isFirstResponder]) {
        [_textFieldWordToSearch resignFirstResponder];
    }
    else if ([_textFieldAddWord isFirstResponder]) {
        [_textFieldAddWord resignFirstResponder];
    }
    
}

@end

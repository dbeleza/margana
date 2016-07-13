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

@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;

@property (weak, nonatomic) IBOutlet UIButton *buttonSearch;

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
    
    [_buttonAdd setEnabled:false];
    
    [_buttonSearch setEnabled:false];
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
        
        [_buttonAdd setEnabled:false];
        
    }
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ( [string isEqualToString:@" "] ){
        return NO;
    }
    else {
        
        NSUInteger length = 0;
        
        if (textField.tag == _textFieldAddWord.tag) {
            length = _textFieldAddWord.text.length - range.length + string.length;
            
            if (length > 0) {
                _buttonAdd.enabled = YES;
            } else {
                _buttonAdd.enabled = NO;
            }
        }
        else if (textField.tag == _textFieldWordToSearch.tag) {
            length = _textFieldWordToSearch.text.length - range.length + string.length;
            
            if (length > 0) {
                _buttonSearch.enabled = YES;
            } else {
                _buttonSearch.enabled = NO;
            }
        }

        
        return YES;
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.tag == _textFieldWordToSearch.tag && _dataSource.mutableArray.count==0) {
        
        return false;
        
    }
    
    return true;
    
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
    
    [_buttonAdd setEnabled:false];
    [_buttonSearch setEnabled:false];
    
}

@end

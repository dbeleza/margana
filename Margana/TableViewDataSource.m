//
//  TableViewDataSource.m
//  Margana
//
//  Created by David Beleza on 13/07/16.
//  Copyright © 2016 David Beleza. All rights reserved.
//

#import "TableViewDataSource.h"


@implementation TableViewDataSource

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        _mutableArray = [[NSMutableArray alloc]init];
        
    }
    
    return self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _mutableArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    UILabel *label = (UILabel*)[cell.contentView viewWithTag:100];

    NSString *stringFromArray = [_mutableArray objectAtIndex:indexPath.row];
    
    [label setText:stringFromArray];
    
    return cell;
    
}

@end

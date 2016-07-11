//
//  TableVC.m
//  jyt
//
//  Created by 贺少虎 on 16/4/15.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "TableVC.h"

@implementation TableVC

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (void)dealloc {
    self.dataSource = nil;
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    self.tableView = nil;
}

#pragma mark - Propertys

- (UITableView *)tableView{

    if (!_tableView) {
        CGRect tableViewFrame = self.view.bounds;
        
        _tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:self.tableViewStyle];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (![self validateSeparatorInset]) {
            if (self.tableViewStyle == UITableViewStyleGrouped) {
                UIView *backgroundView = [[UIView alloc] initWithFrame:_tableView.bounds];
                backgroundView.backgroundColor = _tableView.backgroundColor;
                _tableView.backgroundView = backgroundView;
            }
        }
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _dataSource;
}

#pragma mark - TableView Helper Method

- (BOOL)validateSeparatorInset {
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        return YES;
    }
    return NO;
}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // in subClass
    return nil;
}


@end

//
//  ViewController.m
//  MJRefreshTestDemo
//
//  Created by wxj on 2019/2/21.
//  Copyright © 2019年 zkml－wxj. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSArray *sourceArr;//源数据
    BOOL pullDownRefresh;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"demo";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor grayColor];
    pullDownRefresh = YES;
    _dataArray = [NSMutableArray new];
    sourceArr = @[@{
                      @"address":@"，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子"
                      }
                  ];
    [self createNavBtnView];
    [self createView];
    [self loadMoreData];
}

- (void)createNavBtnView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 80, 30);
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitle:@"清空数组" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    UIBarButtonItem *navigationSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    navigationSpacer.width = -7;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:navigationSpacer,item, nil];
}

- (void)createView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSelfWidth, kSelfHeight-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor orangeColor];
    _tableView.tableFooterView = [UIView new];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 50;//预估高度远小于cell的实际高度
    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pullDownRefresh = YES;
        [self loadMoreData];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        pullDownRefresh = NO;
        [self loadMoreData];
    }];
    [self.view addSubview:_tableView];
}

- (void)clearBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        sourceArr = [NSMutableArray new];
    }else{
        sourceArr = @[@{
                          @"address":@"，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子"
                          }
                      ];
    }
}
- (void)loadMoreData{
    @try {
        if (sourceArr.count == 0) {
            if (pullDownRefresh) { //刷新替换数据
                _dataArray = [NSMutableArray arrayWithArray:sourceArr];
            } else {               //加载更多 则显示提示信息
                NSLog(@"没有更多数据了...");
            }
        } else {
            if (pullDownRefresh) {//刷新替换数据
                _dataArray = [NSMutableArray arrayWithArray:sourceArr];
            }else{                //加载更多数据
                [_dataArray addObjectsFromArray:sourceArr];
            }
        }
       [self doneLoadingTableViewData];
    }
    @catch (NSException *exception) {
        NSLog(@"数据处理异常...");
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ide = @"CustomTableViewCell";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ide];
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ide];
    }
    
    NSDictionary *dic = _dataArray[indexPath.row];
    NSString *addressStr = [dic objectForKey:@"address"];
    CustomTableViewModel *model = [[CustomTableViewModel alloc]init];
    model.address = addressStr;
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)doneLoadingTableViewData{
    [_tableView reloadData];
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

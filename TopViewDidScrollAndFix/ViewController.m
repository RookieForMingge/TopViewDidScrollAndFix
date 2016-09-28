//
//  ViewController.m
//  TopViewDidScrollAndFix
//
//  Created by 1 on 16/9/28.
//  Copyright © 2016年 1. All rights reserved.
//

#import "ViewController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray           *dataArray;
    UIView                   *headView;
    UILabel                  *lbl_scroll;
}

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    //创建TableView
    [self createTableView];
}

//创建数据源
- (void)loadData{
    dataArray=[[NSMutableArray alloc]init];
    for (int i = 0; i < 30; i++) {
        NSString * string=[NSString stringWithFormat:@"第%d行",i];
        [dataArray addObject:string];
    }
}

- (UIView *)headIView
{
    if (!headView) {
        headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 240)];
        headView.backgroundColor = [UIColor greenColor];
        //图片
        UIImageView *img_view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
        img_view.image = [UIImage imageNamed:@"1.jpg"];
        img_view.backgroundColor = [UIColor redColor];
        [headView addSubview:img_view];
        //分类
        [lbl_scroll removeFromSuperview];
        lbl_scroll = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, WIDTH, 40)];
        lbl_scroll.text = @"我就在这了！";
        lbl_scroll.backgroundColor = [UIColor cyanColor];
        [headView addSubview:lbl_scroll];
        return headView;
    }
    else
    {
        return nil;
    }
}

- (void)createTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.dataSource=self;
        _tableView.delegate=self;
        [self.view addSubview:_tableView];
    }
    [_tableView setTableHeaderView:[self headIView]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //int contentOffsety = scrollView.contentOffset.y;
    if (scrollView.contentOffset.y > 200)
    {
        [lbl_scroll removeFromSuperview];
        lbl_scroll = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 40)];
        lbl_scroll.text = @"我就在这了！";
        lbl_scroll.backgroundColor = [UIColor cyanColor];
        [self.view addSubview:lbl_scroll];
    }
    else
    {
        [lbl_scroll removeFromSuperview];
        lbl_scroll = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, WIDTH, 40)];
        lbl_scroll.text = @"我就在这了！";
        lbl_scroll.backgroundColor = [UIColor cyanColor];
        [headView addSubview:lbl_scroll];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"第%ld区",section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建一个静态标识符  来给每一个cell 加上标记  方便我们从复用队列里面取到 名字为该标记的cell
    static NSString *reusID=@"ID";
    //我创建一个cell 先从复用队列dequeue 里面 用上面创建的静态标识符来取
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reusID];
    //做一个if判断  如果没有cell  我们就创建一个新的 并且 还要给这个cell 加上复用标识符
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reusID];
    }
    cell.textLabel.textColor = [UIColor magentaColor];
    cell.detailTextLabel.textColor = [UIColor purpleColor];
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [dataArray objectAtIndex:indexPath.row];
    return cell;
}

@end

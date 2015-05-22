//
//  UserNoteViewController.m
//  Guideo
//
//  Created by wei on 15/5/22.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DataTransfer.h"
@interface UserNoteViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic) NSArray *listData;
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)UITableViewCell *tableViewCell;

@end

@implementation UserNoteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //初始化表格
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    // 设置协议，意思就是UITableView类的方法交给了tabView这个对象，让完去完成表格的一些设置操作
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    //把tabView添加到视图之上
    [self.view addSubview:self.tableView];
    
//        调用server得到json数据
//        NSDictionary *keyPair = @{@"username" : [self.textName text]};
//        NSDictionary *jsonData = [DataTransfer requestObjectWithURL:@"http://52.6.223.152:80/usernotes" httpMethod:@"POST" params:keyPair];
    
    //    存放显示在单元格上的数据
    NSArray *array = [NSArray arrayWithObjects:@"张三",@"张四",@"张五",@"李三",@"李四",@"李五",@"李六",@"王三",@"王四",@"王五",@"王六",@"王七",@"王八",@"王九",@"王十", nil];
    self.listData = array;
    
}

//返回多少个section
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


//返回行数，也就是返回数组中所存储数据，也就是section的元素
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    声明静态字符串型对象，用来标记重用单元格
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    //    用TableSampleIdentifier表示需要重用的单元
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    //    如果如果没有多余单元，则需要创建新的单元
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableSampleIdentifier];
    }
    
    else {
        while ([cell.contentView.subviews lastObject ]!=nil) {
            [(UIView*)[cell.contentView.subviews lastObject]removeFromSuperview];
        }
    }
    //    获取当前行信息值
    NSUInteger row = [indexPath row];
    //    填充行的详细内容
    cell.detailTextLabel.text = @"详细内容";
    //    把数组中的值赋给单元格显示出来
    cell.textLabel.text=[self.listData objectAtIndex:row];
    
    
    //    cell.textLabel.backgroundColor= [UIColor greenColor];
    
    //    表视图单元提供的UILabel属性，设置字体大小
    cell.textLabel.font = [UIFont boldSystemFontOfSize:40.0f];
    //    tableView.editing=YES;
    /*
     cell.textLabel.backgroundColor = [UIColor clearColor];
     UIView *backgroundView = [[UIView alloc] initWithFrame:cell.frame];
     backgroundView.backgroundColor = [UIColor greenColor];
     cell.backgroundView=backgroundView;
     */
    //    设置单元格UILabel属性背景颜色
    cell.textLabel.backgroundColor=[UIColor clearColor];
    //    正常情况下现实的图片
    UIImage *image = [UIImage imageNamed:@"2.png"];
    cell.imageView.image=image;
    
    //    被选中后高亮显示的照片
    UIImage *highLightImage = [UIImage imageNamed:@"1.png"];
    cell.imageView.highlightedImage = highLightImage;
    return cell;
}

//选中单元格所产生事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    首先是用indexPath获取当前行的内容
    NSInteger row = [indexPath row];
    //    从数组中取出当前行内容
    NSString *rowValue = [self.listData objectAtIndex:row];
    NSString *message = [[NSString alloc]initWithFormat:@"You selected%@",rowValue];
    //    弹出警告信息
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:message
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles: nil];
    [alert show];
}


@end
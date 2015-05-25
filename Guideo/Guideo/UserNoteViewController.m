//
//  UserNoteViewController.m
//  Guideo
//
//  Created by wei on 15/5/22.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//


#import "UserNoteViewController.h"
#import "NoteDetailViewController.h"
#import "DataTransfer.h"
#import "ImageScaler.h"
#import "userData.h"
#import "tableData.h"

@interface UserNoteViewController()

@end

@implementation UserNoteViewController
{
    __weak IBOutlet UITableView *_tableView;
}
@synthesize notes;
@synthesize imageCache, imageDownloadingQueue;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
    self.imageDownloadingQueue.maxConcurrentOperationCount = 4; // many servers limit how many concurrent requests they'll accept from a device, so make sure to set this accordingly
    
    self.imageCache = [[NSCache alloc] init];

    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"Your Notes";
    
    userData *user = [userData sharedSingletonClass];
    NSString* username = user.userName;
    notes = [[NSMutableArray alloc] init];
    
    NSDictionary *keyPair = @{@"username": username};
    NSArray *jsonData = [DataTransfer requestArrayWithURL:@"http://52.6.223.152:80/note/user" httpMethod:@"POST" params:keyPair];
    
    //NSString *word = [jsonData objectAtIndex:0][@"topic"];
    //NSLog(@"jsonData: %@\n\n",word);
    
    NSUInteger noteNum = 0;
    if(jsonData != NULL)
    {
        noteNum = [jsonData count];
        
        NSLog(@"Note Number: %lu", (unsigned long)noteNum);
    }
    
    for(int i = 0; i < noteNum; i++)
    {
        tableData *note = [tableData new];
        note.tableContent = [jsonData objectAtIndex:i][@"topic"];
        note.tableImage = [jsonData objectAtIndex:i][@"image"];
        
        [notes addObject:note];
    }

}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [notes count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier = @"Identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableSampleIdentifier];
    }
    
    else {
        while ([cell.contentView.subviews lastObject ]!=nil) {
            [(UIView*)[cell.contentView.subviews lastObject]removeFromSuperview];
        }
    }
    
    tableData *note;
    note = [notes objectAtIndex:indexPath.row];
    
    CGSize newSize = CGSizeMake(64, 64);
    NSString *imageUrlString = [note tableImage];
    
    UIImage *cachedImage = [self.imageCache objectForKey:imageUrlString];
    if (cachedImage) {
        cell.imageView.image = cachedImage;
    } else {
        // you'll want to initialize the image with some blank image as a placeholder
        
        cell.imageView.image = [ImageScaler imageResize:[UIImage imageNamed:@"image1.jpg"] andResizeTo:newSize];
        
        // now download in the image in the background
        
        [self.imageDownloadingQueue addOperationWithBlock:^{
            
            NSURL *imageUrl   = [NSURL URLWithString:imageUrlString];
            NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
            UIImage *image    = nil;
            if (imageData)
                image = [ImageScaler imageResize:[UIImage imageWithData:imageData] andResizeTo:newSize];
            else
                image = [ImageScaler imageResize:[UIImage imageNamed:@"default.jpg"] andResizeTo:newSize];
            
            if (image) {
                
                [self.imageCache setObject:image forKey:imageUrlString];
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                    UITableViewCell *updateCell = [tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        updateCell.imageView.image = image;
                }];
            }
        }];
    }
    
    cell.detailTextLabel.numberOfLines = 2000;
    if([[note tableContent] length] >= 100)
        cell.detailTextLabel.text = [[note tableContent] substringToIndex:100];
    else
        cell.detailTextLabel.text = [note tableContent];
    cell.tag = indexPath.row;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    NoteDetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteDetailViewController"];
    
    detailView.hidesBottomBarWhenPushed = YES;
    
    detailView.text = [[notes objectAtIndex:indexPath.row] tableContent];
    detailView.image = [[notes objectAtIndex:indexPath.row] tableImage];
    
    [[self navigationController] pushViewController:detailView animated:YES];
    
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 99.0f;
}


@end
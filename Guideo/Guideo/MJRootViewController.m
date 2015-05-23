//
//  MJRootViewController.m
//  Guideo
//
//  Created by wei on 15/4/11.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "MJRootViewController.h"
#import "MJCollectionViewCell.h"
#import "DataTransfer.h"
@interface MJRootViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *notesCollectionView;


@property (nonatomic, strong) NSMutableArray* images;

@end

@implementation MJRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
   // [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:176/255.0 green:215/255.0 blue:255/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], UITextAttributeTextColor,[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 1)],UITextAttributeTextShadowOffset,[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], UITextAttributeFont, nil]];
    self.title = @"Notes";
    
    
    UIImage *backButtonImage = [[UIImage imageNamed:@"back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];

//    NSDictionary *keyPair = @{@"note": @"1"};
//    NSArray *jsonData = [DataTransfer requestArrayWithURL:@"http://52.6.223.152:80/notes" httpMethod:@"POST" params:keyPair];
//    
//    NSUInteger noteNum = 0;
//    if(jsonData != NULL)
//    {
//        noteNum = [jsonData count];
//        
//        NSLog(@"Event Number: %lu", (unsigned long)noteNum);
//    }

    // Fill image array with images
    NSUInteger index;
    
//    for (index = 0; index < noteNum; ++index) {
//        // Setup image name
//        NSString *name = [jsonData objectAtIndex:index][@"note_name"];
//        
//
//        //
//        if(!self.images)
//            self.images = [jsonData objectAtIndex:index][@"image"];
//        [self.images addObject:name];
//        
//    }
    


    for (index = 0; index < 14; ++index) {
        // Setup image name
        NSString *name = [NSString stringWithFormat:@"image%03ld.jpg", (unsigned long)index];
//
        if(!self.images)
            self.images = [NSMutableArray arrayWithCapacity:0];
        [self.images addObject:name];
        
    }
    
    [self.notesCollectionView reloadData];

}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDatasource Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MJCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"noteCell" forIndexPath:indexPath];
    
    //get image name and assign
    NSString* imageName = [self.images objectAtIndex:indexPath.item];
    cell.image = [UIImage imageNamed:imageName];
    
//    NSLog(@"%@", imageName);
    
    //set offset accordingly
    CGFloat yOffset = ((self.notesCollectionView.contentOffset.y - cell.frame.origin.y) / IMAGE_HEIGHT) * IMAGE_OFFSET_SPEED;
    cell.imageOffset = CGPointMake(0.0f, yOffset);
    
    return cell;
}

#pragma mark - UIScrollViewdelegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for(MJCollectionViewCell *view in self.notesCollectionView.visibleCells) {
//        NSLog(@"here");
        CGFloat yOffset = ((self.notesCollectionView.contentOffset.y - view.frame.origin.y) / IMAGE_HEIGHT) * IMAGE_OFFSET_SPEED;
        view.imageOffset = CGPointMake(0.0f, yOffset);
        
    }
}

@end
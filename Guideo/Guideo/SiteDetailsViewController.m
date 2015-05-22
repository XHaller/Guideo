//
//  SiteDetailsViewController.m
//  Guideo
//
//  Created by 亮亮 李 on 15/4/15.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "SiteDetailsViewController.h"
#import "ContentViewController.h"
#import "PicturesViewController.h"
#import "siteData.h"


@interface SiteDetailsViewController () <ViewPagerDataSource, ViewPagerDelegate>

@property (nonatomic) NSUInteger numberOfTabs;

@end

@implementation SiteDetailsViewController
@synthesize topicName;
@synthesize siteInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
        
    self.title = topicName;
    
    self.dataSource = self;
    self.delegate = self;

    siteInfo = [[siteData alloc] init];
    siteInfo.siteName = topicName;
    
    siteInfo.siteItemsName = [[NSMutableArray alloc] init];
    [siteInfo.siteItemsName addObject:@"Info"];
    [siteInfo.siteItemsName addObject:@"Basic"];
    [siteInfo.siteItemsName addObject:@"History"];
    [siteInfo.siteItemsName addObject:@"Culture"];
    [siteInfo.siteItemsName addObject:@"Artifact"];
    [siteInfo.siteItemsName addObject:@"Map"];
    
    siteInfo.siteItemsContent = [[NSMutableArray alloc] init];
    [siteInfo.siteItemsContent addObject:@""];
    [siteInfo.siteItemsContent addObject:@"The Statue of Liberty (Liberty Enlightening the World; French: La Liberté éclairant le monde) is a colossal neoclassical sculpture on Liberty Island in New York Harbor in New York City, in the United States. The copper statue, designed by Frédéric Auguste Bartholdi, a French sculptor and dedicated on October 28, 1886, was a gift to the United States from the people of France. The statue is of a robed female figure representing Libertas, the Roman goddess, who bears a torch and a tabula ansata (a tablet evoking the law) upon which is inscribed the date of the American Declaration of Independence, July 4, 1776. A broken chain lies at her feet. The statue is an icon of freedom and of the United States: a welcoming signal to immigrants arriving from abroad.\nBartholdi was inspired by French law professor and politician Édouard René de Laboulaye, who is said to have commented in 1865 that any monument raised to American independence would properly be a joint project of the French and American peoples. He may have been minded to honor the Union victory in the American Civil War and the end of slavery. Due to the troubled political situation in France, work on the statue did not commence until the early 1870s. In 1875, Laboulaye proposed that the French finance the statue and the Americans provide the site and build the pedestal. Bartholdi completed the head and the torch-bearing arm before the statue was fully designed, and these pieces were exhibited for publicity at international expositions."];
    [siteInfo.siteItemsContent addObject:@"The origin of the Statue of Liberty project is sometimes traced to a comment made by French law professor and politician Édouard René de Laboulaye in mid-1865. In after-dinner conversation at his home near Versailles, Laboulaye, an ardent supporter of the Union in the American Civil War, is supposed to have said: \"If a monument should rise in the United States, as a memorial to their independence, I should think it only natural if it were built by united effort—a common work of both our nations.\"[7] The National Park Service, in a 2000 report, however, deemed this a legend traced to an 1885 fundraising pamphlet, and that the statue was most likely conceived in 1870.[8] In another essay on their website, the Park Service suggested that Laboulaye was minded to honor the Union victory and its consequences, \"With the abolition of slavery and the Union's victory in the Civil War in 1865, Laboulaye's wishes of freedom and democracy were turning into a reality in the United States. In order to honor these achievements, Laboulaye proposed that a gift be built for the United States on behalf of France. Laboulaye hoped that by calling attention to the recent achievements of the United States, the French people would be inspired to call for their own democracy in the face of a repressive monarchy.\"[9]\nAccording to sculptor Frédéric Auguste Bartholdi, who later recounted the story, Laboulaye's comment was not intended as a proposal, but it inspired Bartholdi.[7] Given the repressive nature of the regime of Napoleon III, Bartholdi took no immediate action on the idea except to discuss it with Laboulaye. Bartholdi was in any event busy with other possible projects; in the late 1860s, he approached Isma'il Pasha, Khedive of Egypt, with a plan to build a huge lighthouse in the form of an ancient Egyptian female fellah or peasant, robed and holding a torch aloft, at the northern entrance to the Suez Canal in Port Said. Sketches and models were made of the proposed work, though it was never erected. There was a classical precedent for the Suez proposal, the Colossus of Rhodes: an ancient bronze statue of the Greek god of the sun, Helios. This statue is believed to have been over 100 feet (30 m) high, and it similarly stood at a harbor entrance and carried a light to guide ships.[10]\nAny large project was further delayed by the Franco-Prussian War, in which Bartholdi served as a major of militia. In the war, Napoleon III was captured and deposed. Bartholdi's home province of Alsace was lost to the Prussians, and a more liberal republic was installed in France.[7] As Bartholdi had been planning a trip to the United States, he and Laboulaye decided the time was right to discuss the idea with influential Americans.[11] In June 1871, Bartholdi crossed the Atlantic, with letters of introduction signed by Laboulaye.[12]\nArriving at New York Harbor, Bartholdi focused on Bedloe's Island as a site for the statue, struck by the fact that vessels arriving in New York had to sail past it. He was delighted to learn that the island was owned by the United States government—it had been ceded by the New York State Legislature in 1800 for harbor defense. It was thus, as he put it in a letter to Laboulaye: \"land common to all the states.\"[13] As well as meeting many influential New Yorkers, Bartholdi visited President Ulysses S. Grant, who assured him that it would not be difficult to obtain the site for the statue.[14] Bartholdi crossed the United States twice by rail, and met many Americans he felt would be sympathetic to the project.[12] But he remained concerned that popular opinion on both sides of the Atlantic was insufficiently supportive of the proposal, and he and Laboulaye decided to wait before mounting a public campaign.[15]\nBartholdi had made a first model of his concept in 1870.[16] The son of a friend of Bartholdi's, American artist John LaFarge, later maintained that Bartholdi made the first sketches for the statue during his U.S. visit at La Farge's Rhode Island studio. Bartholdi continued to develop the concept following his return to France.[16] He also worked on a number of sculptures designed to bolster French patriotism after the defeat by the Prussians. One of these was the Lion of Belfort, a monumental sculpture carved in sandstone below the fortress of Belfort, which during the war had resisted a Prussian siege for over three months. The defiant lion, 73 feet (22 m) long and half that in height, displays an emotional quality characteristic of Romanticism, which Bartholdi would later bring to the Statue of Liberty.[17]"];
    [siteInfo.siteItemsContent addObject:@"Bartholdi and Laboulaye considered how best to express the idea of American liberty.[18] In early American history, two female figures were frequently used as cultural symbols of the nation.[19] One of these symbols, the personified Columbia, was seen as an embodiment of the United States in the manner that Britannia was identified with the United Kingdom and Marianne came to represent France. Columbia had supplanted the earlier figure of an Indian princess, which had come to be regarded as uncivilized and derogatory toward Americans.[19] The other significant female icon in American culture was a representation of Liberty, derived from Libertas, the goddess of freedom widely worshipped in ancient Rome, especially among emancipated slaves. A Liberty figure adorned most American coins of the time,[18] and representations of Liberty appeared in popular and civic art, including Thomas Crawford's Statue of Freedom (1863) atop the dome of the United States Capitol Building.[18]"];
    [siteInfo.siteItemsContent addObject:@"When the torch was illuminated on the evening of the statue's dedication, it produced only a faint gleam, barely visible from Manhattan. The World characterized it as \"more like a glowworm than a beacon.\"[97] Bartholdi suggested gilding the statue to increase its ability to reflect light, but this proved too expensive. The United States Lighthouse Board took over the Statue of Liberty in 1887 and pledged to install equipment to enhance the torch's effect; in spite of its efforts, the statue remained virtually invisible at night. When Bartholdi returned to the United States in 1893, he made additional suggestions, all of which proved ineffective. He did successfully lobby for improved lighting within the statue, allowing visitors to better appreciate Eiffel's design.[97] In 1901, President Theodore Roosevelt, once a member of the New York committee, ordered the statue's transfer to the War Department, as it had proved useless as a lighthouse.[106] A unit of the Army Signal Corps was stationed on Bedloe's Island until 1923, after which military police remained there while the island was under military jurisdiction.[107]"];
    [siteInfo.siteItemsContent addObject:@"Map"];
    
    // Keeps tab bar below navigation bar on iOS 7.0+
//     if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//         self.edgesForExtendedLayout = UIRectEdgeNone;
//     }
    
    self.numberOfTabs = [siteInfo.siteItemsName count];
    
    UIImage *picturesButtonImage = [[UIImage imageNamed:@"pictures.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    UIBarButtonItem *pictureItem = [[UIBarButtonItem new] initWithImage:picturesButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(pictureView)];
   
    NSArray *itemsArr = @[pictureItem];
    self.navigationItem.rightBarButtonItems = itemsArr;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
     [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setters
- (void)setNumberOfTabs:(NSUInteger)numberOfTabs {
    
    // Set numberOfTabs
    _numberOfTabs = numberOfTabs;
    
    // Reload data
    [self reloadData];
    
}

#pragma mark - Interface Orientation Changes
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    // Update changes after screen rotates
    [self performSelector:@selector(setNeedsReloadOptions) withObject:nil];
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return self.numberOfTabs;
}
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Cochin-BoldItalic" size:20.0];
    label.text = [siteInfo.siteItemsName objectAtIndex:index];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    ContentViewController *cvc = [self.storyboard instantiateViewControllerWithIdentifier:@"contentViewController"];
    
    if([[siteInfo.siteItemsName objectAtIndex:index] isEqualToString:@"Info"])
        cvc.isBase = YES;
    else
        cvc.isBase = NO;
    cvc.siteInfo = siteInfo;
    [cvc setContentString:[siteInfo.siteItemsContent objectAtIndex:index]];
    
    return cvc;
}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
        case ViewPagerOptionCenterCurrentTab:
            return 1.0;
        case ViewPagerOptionTabLocation:
            return 0.0;
        case ViewPagerOptionTabHeight:
            return 49.0;
        case ViewPagerOptionTabOffset:
            return 36.0;
        case ViewPagerOptionTabWidth:
            return UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? 128.0 : 96.0;
        case ViewPagerOptionFixFormerTabsPositions:
            return 1.0;
        case ViewPagerOptionFixLatterTabsPositions:
            return 1.0;
        default:
            return value;
    }
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
        case ViewPagerTabsView:
            return [[UIColor lightGrayColor] colorWithAlphaComponent:0.32];
        case ViewPagerContent:
            return [[UIColor darkGrayColor] colorWithAlphaComponent:0.32];
        default:
            return color;
    }
}

-(void)pictureView
{
    PicturesViewController *pictureController=[self.storyboard instantiateViewControllerWithIdentifier:@"PicturesViewController"];
    pictureController.topicName = self.topicName;
    pictureController.hidesBottomBarWhenPushed = YES;
    [[self navigationController] pushViewController:pictureController animated:YES];
}

@end

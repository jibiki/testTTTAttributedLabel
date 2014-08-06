//
//  MasterViewController.m
//  testArrributedString
//
//  Created by 地引秀和 on 2014/08/05.
//  Copyright (c) 2014年 Jibiki Wroks. All rights reserved.
//

#import "TTTAttributedLabel.h"
#import "TTTAttributedLabelCell.h"
#import "TextViewCell.h"
#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}

@property (strong, nonatomic) NSMutableArray *attrStrings;

@property (strong, nonatomic) TTTAttributedLabelCell *dummyTTTAttributedLabelCell;
@property (strong, nonatomic) TextViewCell *dummyTextViewCell;

@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    self.dummyTTTAttributedLabelCell = [self.tableView dequeueReusableCellWithIdentifier:@"TTTAttributedLabelCell"];
    self.dummyTextViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"TextViewCell"];
    

    [self updateDataSource];
}

- (void)updateDataSource
{
    _objects = [[NSMutableArray alloc] init];
    [_objects addObject:@"<h1>Hola</h1><br>Please access <a href=\"http://google.com\">google</a> now.<BR>Search your \n questions.<br>Quick<br>brown<br>fox<br>dumps<br>over<br>the<br>lazy<br><br><br><br><br><br>dog."];
    [_objects addObject:@"じゅげむじゅげむ<br>ごこうのすりきれ<br>海砂利水魚の<br>水魚末<br>運来末<br>風来末<br>食う寝る所に住む所<br>ぱいぽぱいぽ<br>ぱいぽのちゅーりんだい<br>ちゅほりんだいのぐーりんくだい<br>ぽんぽこぴーの<br>ぽんぽこなーの<br>長久命の<br>長介<br>祇園精舎の鐘の声<br>諸行無常の響きあり<br>沙羅双樹の花の色<br>勝者必衰の理を現す<br>奢れる物は久しからず<br>ただ春の夜の夢のごとし<br>たけき者も遂には滅びぬ<br>偏に風の前の塵に同じ"];
}

- (NSAttributedString*)attributedStringWithString:(NSString*)string
{
    // 行間
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineHeightMultiple = 1.2f;
    
    NSData *data =[string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *options = @{
                              NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                              NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding),
                              };
    NSError *error = nil;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithData:data options:
                                      options documentAttributes:NULL error:&error];
 
    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attrString.length)];
    
    return attrString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"TextViewCell";
    }
    
    return @"TTTAttributedLabel";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return _objects.count;
    }
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        
        TextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextViewCell" forIndexPath:indexPath];
        [self setupTextViewCell:cell indexPath:indexPath];
        return cell;
    }
    
    TTTAttributedLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TTTAttributedLabelCell" forIndexPath:indexPath];
    [self setupTTTAttributedLabelCell:cell indexPath:indexPath];
    return cell;
}

- (void)setupTextViewCell:(TextViewCell*)cell indexPath:(NSIndexPath*)indexPath
{
    if (_objects.count < indexPath.row) {
        abort();
    }
    NSAttributedString *attrString = [self attributedStringWithString:_objects[indexPath.row]];
    
    cell.textView.attributedText = attrString;
}

- (void)setupTTTAttributedLabelCell:(TTTAttributedLabelCell*)cell indexPath:(NSIndexPath*)indexPath
{
    if (_objects.count < indexPath.row) {
        abort();
    }
    NSString *text = _objects[indexPath.row];

    [cell.attributedLabel setText:text];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        [self setupTextViewCell:self.dummyTextViewCell indexPath:indexPath];
        [self.dummyTextViewCell layoutSubviews];
        CGSize size = [self.dummyTextViewCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return size.height + 1;
    }
    
    [self setupTTTAttributedLabelCell:self.dummyTTTAttributedLabelCell indexPath:indexPath];
    [self.dummyTTTAttributedLabelCell layoutSubviews];
    CGSize size = [self.dummyTTTAttributedLabelCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Cell



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end

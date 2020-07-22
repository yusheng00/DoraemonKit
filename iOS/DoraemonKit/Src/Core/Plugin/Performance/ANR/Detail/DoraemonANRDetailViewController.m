//
//  DoraemonANRDetailViewController.m
//  DoraemonKit-DoraemonKit
//
//  Created by yixiang on 2018/6/16.
//

#import "DoraemonANRDetailViewController.h"
#import "DoraemonDefine.h"
#import "DoraemonUtil.h"

@interface DoraemonANRDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *anrTimeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) NSDictionary *anrInfo;
@property (nonatomic, copy) NSArray *anrArray;

@end

@implementation DoraemonANRDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = DoraemonLocalizedString(@"卡顿详情");
    [self setRightNavTitle:DoraemonLocalizedString(@"导出")];
    
    if (self.info) {
        self.anrInfo = self.info;
    } else {
        self.anrInfo = [NSDictionary dictionaryWithContentsOfFile:self.filePath];
    }
    NSString *tem = self.anrInfo[@"content"];
    self.anrArray = [tem componentsSeparatedByString:@"&&"];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.textColor = [UIColor doraemon_black_2];
    _contentLabel.font = [UIFont systemFontOfSize:kDoraemonSizeFrom750_Landscape(20)];
    _contentLabel.numberOfLines = 0;
    _contentLabel.text = _anrInfo[@"content"];
    
    CGSize fontSize = [_contentLabel sizeThatFits:CGSizeMake(self.view.doraemon_width-40, MAXFLOAT)];
    _contentLabel.frame = CGRectMake(20, IPHONE_NAVIGATIONBAR_HEIGHT, fontSize.width, fontSize.height);
    [self.view addSubview:_contentLabel];
    
    _anrTimeLabel = [[UILabel alloc] init];
    _anrTimeLabel.textColor = [UIColor doraemon_black_1];
    _anrTimeLabel.font = [UIFont systemFontOfSize:kDoraemonSizeFrom750_Landscape(20)];
    _anrTimeLabel.text = [NSString stringWithFormat:@"anr time : %@ms",_anrInfo[@"duration"]];
    [_anrTimeLabel sizeToFit];
    _anrTimeLabel.frame = CGRectMake(20, _contentLabel.doraemon_bottom+20, _anrTimeLabel.doraemon_width, _anrTimeLabel.doraemon_height);
    [self.view addSubview:_anrTimeLabel];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, IPHONE_NAVIGATIONBAR_HEIGHT, self.view.doraemon_width, self.view.doraemon_height-IPHONE_NAVIGATIONBAR_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}


#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.anrArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"anrcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        
    }
    if (indexPath.row < self.anrArray.count) {
        NSString *text = [self.anrArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = text;
    }
    
    return cell;
}

- (void)rightNavTitleClick:(id)clickView{
    [DoraemonUtil shareURL:[NSURL fileURLWithPath:self.filePath] formVC:self];
}




@end

//
//  ChooseImageViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/16.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "ChooseImageViewController.h"
#import "ChooseImageCollectionViewCell.h"
#import "CommonTool.h"
#import "UIImage+Small.h"
#import "SellCarNetWork.h"

@interface ChooseImageViewController ()<UIActionSheetDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (nonatomic,strong) NSMutableArray *datasource;

@end

@implementation ChooseImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datasource = [NSMutableArray array];
    self.title = @"我要卖车";
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#0FA945"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onclickDoneButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.collectionview registerNib:[UINib nibWithNibName:@"ChooseImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ChooseImageCollectionViewCell"];
    
    UICollectionViewFlowLayout *categoryFlowLayout = (UICollectionViewFlowLayout *)self.collectionview.collectionViewLayout;
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 32 - 16*3)/4.0;
    categoryFlowLayout.itemSize = CGSizeMake(width, width/170*126.0);
    categoryFlowLayout.minimumInteritemSpacing = 16;
    categoryFlowLayout.minimumLineSpacing = 16;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onclickDoneButton
{
    self.callBackImage(self.datasource);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datasource.count + 1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChooseImageCollectionViewCell" forIndexPath:indexPath];
    if (self.datasource.count != indexPath.row) {
        [cell.iconImageView yy_setImageWithURL:[NSURL URLWithString:self.datasource[indexPath.row]] placeholder:nil];
        cell.deleteButton.hidden = NO;
        __weak typeof(self) weakself = self;
        cell.block = ^{
            [weakself.datasource removeObjectAtIndex:indexPath.row];
            [weakself.collectionview reloadData];
        };
    }else{
        cell.iconImageView.image = [UIImage imageNamed:@"chooseImage_addIcon"];
        cell.deleteButton.hidden = YES;
    }
    return cell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.datasource.count) {
        UIActionSheet *actionSheet =[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
        actionSheet.tag = indexPath.row;
        [actionSheet showInView:self.view];
    }else{
        
    }
}

#pragma mark  UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]){
            return;
        }
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        picker.view.tag = actionSheet.tag;
        [self presentViewController:picker animated:YES completion:NULL];
        if (![CommonTool isAllowTakePhoto]) {
            UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:@"请在iPhone的'设置-隐私-相机'选项中,允许半挂二手车访问你的相机" message:nil delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    }
    if (buttonIndex == 1) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.allowsEditing = YES;
        picker.delegate = self;
        picker.view.tag = actionSheet.tag;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark  UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image.size.width < 700 || image.size.height < 1500) {
    }else{
        image = [image imageByScalingAndCroppingForSize:CGSizeMake(image.size.width * .2, image.size.height * .2)];
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        [self uploadImage:image];
    }];
}

- (void)uploadImage:(UIImage *)image
{
    [SellCarNetWork uploadImage:image success:^(YMBaseRequest *request) {
        NSString *url = [NSString stringWithFormat:@"%@%@",request.responseObject[@"data"][@"host"],request.responseObject[@"data"][@"path"]];
        [self.datasource addObject:url];
        [self.collectionview reloadData];
    } failure:^(YMBaseRequest *request, NSError *error) {
        
    }];
}



@end

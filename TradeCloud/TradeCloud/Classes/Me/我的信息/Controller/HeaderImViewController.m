//
//  HeaderImViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/25.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "HeaderImViewController.h"

@interface HeaderImViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerControllerSourceType sourceType;
}

@property (strong, nonatomic) UIImage *theNewImg;

@end

@implementation HeaderImViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.headerIm.image = self.img;
    
    [self setNavBarWithTitle:@"头像"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style:UIBarButtonItemStylePlain target:self action:@selector(selectIm)];
}


- (void)selectIm{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        
        picker.delegate = self;
        
        picker.sourceType=sourceType;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"选择图片" preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            sourceType = UIImagePickerControllerSourceTypeCamera;
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            
            picker.delegate = self;
            
            picker.sourceType=sourceType;
            
            [self presentViewController:picker animated:YES completion:nil];
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            
            picker.delegate = self;
            
            picker.sourceType=sourceType;
            
            [self presentViewController:picker animated:YES completion:nil];
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self showMBPError:@"保存"];
        }]];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
    
}

#pragma mark - 相册选择完成
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.headerIm.image = image;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

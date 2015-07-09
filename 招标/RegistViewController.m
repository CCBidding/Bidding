//
//  RegistViewController.m
//  招标
//
//  Created by mac chen on 15/7/2.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIImageView *backgroundImage;//背景图片
    CustomField *namefield;
    CustomField *pwfield;
    CustomField *qualifications; //资质
    CustomField *category;       //类别
    UITextView  *achievement;    //业绩
    UIButton    *addpickview;
    UIImageView *accIcon;
    UIImageView *pwIcon;
    UIButton    *surebtn;
    UIButton    *cancelbtn;
    UIPickerView *pickview;
    UIButton    *addcgpickview;
    NSArray     *categorylist;
    BOOL        ispick;


}

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ispick=YES;
    categorylist=@[@"施工",@"监理",@"设计",@"勘察",@"设备",@"轨道交通",@"总承包",@"货物",@"服务"];
    [self creatUI];
 
    // Do any additional setup after loading the view from its nib.
}

-(void)creatUI{
    
    backgroundImage=[UIImageView newAutoLayoutView];
    UIImage *img=[[UIImage alloc]init];
    backgroundImage.image= [img getBlurImage:[UIImage imageNamed:@"backImage2"]];
    backgroundImage.userInteractionEnabled=YES;
    [backgroundImage bk_whenTapped:^{
        [self.view endEditing:YES];
        [pickview removeFromSuperview];
        achievement.hidden=NO;
        ispick=YES;
    }];
    [self.view addSubview:backgroundImage];
    [backgroundImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [backgroundImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [backgroundImage autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [backgroundImage  autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
    namefield=[CustomField newAutoLayoutView];
    namefield.placeholder=@"username";
    namefield.autocapitalizationType=UITextAutocapitalizationTypeSentences;
    namefield.textColor=[UIColor whiteColor];
    namefield.textAlignment=NSTextAlignmentCenter;
    accIcon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"account"]];
    namefield.leftView=accIcon;  //textfield左侧添加图片
    namefield.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:namefield];
    [namefield autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:TTScreenWith-200];
    [namefield autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [namefield autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    
    
    pwfield=[CustomField newAutoLayoutView];
    pwfield.placeholder=@"password";
    pwfield.textColor=[UIColor whiteColor];
    pwfield.secureTextEntry=YES;
    pwfield.textAlignment=NSTextAlignmentCenter;
    pwIcon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password"]];
    pwfield.leftView=pwIcon;
    pwfield.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:pwfield];
    [pwfield addSubview:pwIcon];
    [pwfield autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:TTScreenWith-150];
    [pwfield autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [pwfield autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    
    qualifications=[CustomField newAutoLayoutView];
    qualifications.placeholder=@"qualifications";
    qualifications.textColor=[UIColor whiteColor];
    qualifications.userInteractionEnabled=NO;
    qualifications.textAlignment=NSTextAlignmentCenter;
    pwIcon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password"]];
    qualifications.leftView=pwIcon;
    qualifications.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:qualifications];
    [qualifications addSubview:pwIcon];
    [qualifications autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:TTScreenWith-100];
    [qualifications autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [qualifications autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    
    addpickview=[UIButton buttonWithType:UIButtonTypeCustom];
    addpickview.tag=1001;
    addpickview.frame=CGRectMake(60, TTScreenWith-100, TTScreenWith-60, 30);
    [addpickview addTarget:self action:@selector(addpickview:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addpickview];
    
    
    category=[CustomField newAutoLayoutView];
    category.placeholder=@"category";
    category.textColor=[UIColor whiteColor];
    category.userInteractionEnabled=NO;
    category.textAlignment=NSTextAlignmentCenter;
    pwIcon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password"]];
    category.leftView=pwIcon;
    category.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:category];
    [category addSubview:pwIcon];
    [category autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:TTScreenWith-50];
    [category autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [category autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    
    addcgpickview=[UIButton buttonWithType:UIButtonTypeCustom];
    addcgpickview.tag=1002;
    addcgpickview.frame=CGRectMake(60, TTScreenWith-50, TTScreenWith-60, 30);
    [addcgpickview addTarget:self action:@selector(addpickview:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addcgpickview];

    
    achievement=[UITextView newAutoLayoutView];
    achievement.text=@"achievement";
    achievement.textColor=[UIColor grayColor];;
    achievement.font=[UIFont fontWithName:nil size:20];
    [self.view addSubview:achievement];
    [achievement autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:TTScreenWith];
    [achievement autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [achievement autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    [achievement autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:150];
    
    surebtn=[UIButton newAutoLayoutView];
    [surebtn setTitle:@"确认" forState:UIControlStateNormal];
    surebtn.backgroundColor=[UIColor colorWithRed:0 green:245/255.0 blue:255/255.0 alpha:1];
    surebtn.layer.cornerRadius=5;
    [surebtn addTarget:self action:@selector(registuser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:surebtn];
    [surebtn autoSetDimension:ALDimensionHeight toSize:30];
    [surebtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [surebtn autoSetDimension:ALDimensionWidth toSize:60];
    [surebtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:100];
    
    cancelbtn=[UIButton newAutoLayoutView];
    [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelbtn.backgroundColor=[UIColor redColor];
    cancelbtn.layer.cornerRadius=5;
    [cancelbtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelbtn];
    [cancelbtn autoSetDimension:ALDimensionHeight toSize:30];
    [cancelbtn autoSetDimension:ALDimensionWidth toSize:60];
    [cancelbtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    [cancelbtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:100];
    
    
    

}

-(void)registuser{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    AFHTTPRequestOperation *op = [manager POST:TTRegistUrl parameters:@{@"username":namefield.text,@"password":pwfield.text} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (![responseObject[@"datas"][0][@"sessionid"]isEqualToString:@"aperror"]) {
            [TTUserDefaultTool setObject:responseObject[@"datas"][0][@"sessionid"] forKey:TTsessinid];
            [self dismiss];
        }
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
    }];
    [op start];



}
-(void)dismiss{

    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)addpickview:(UIButton *)button{
    if (ispick==YES) {
        pickview=[[UIPickerView alloc]initWithFrame:CGRectMake(10, TTScreenHeight-300, TTScreenWith-20, 100)];
        if (button.tag==1001) {
            pickview.tag=1001;
        }
        else{
            pickview.tag=1002;
        }
        pickview.backgroundColor=[UIColor whiteColor];
        pickview.delegate=self;
        pickview.dataSource=self;
      
        [self.view addSubview:pickview];
        achievement.hidden=YES;
        ispick=NO;
    }
    else{
    }
   


}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag==1002) {
         return 9;
    }
    else  return 5;
   

}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag==1001)
    {
        qualifications.text=[NSString stringWithFormat:@"级别%ld",row];
        return qualifications.text;
    }
    else
    {
        category.text=categorylist[row];
        return category.text;
    
    }
    
    
}





@end

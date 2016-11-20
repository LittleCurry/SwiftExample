
#import "PCGestureMenuViewController.h"
#import "GestureViewController.h"
#import "GestureVerifyViewController.h"
#import "PCCircleViewConst.h"

@interface PCGestureMenuViewController ()<UIAlertViewDelegate>

- (void)BtnClick:(UIButton *)sender;

@end

@implementation PCGestureMenuViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getView];
}

- (void)getView
{
    self.title = @"手势解锁";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(0, 80, self.view.frame.size.width, 80);
    [button1 setTitle:@"设置手势密码" forState:0];
    [button1 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag = 687;
    [self.view addSubview:button1];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.frame = CGRectMake(0, 160, self.view.frame.size.width, 80);
    [button2 setTitle:@"登录手势密码" forState:0];
    [button2 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag = 688;
    [self.view addSubview:button2];
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    button3.frame = CGRectMake(0, 240, self.view.frame.size.width, 80);
    [button3 setTitle:@"验证手势密码" forState:0];
    [button3 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    button3.tag = 689;
    [self.view addSubview:button3];
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeSystem];
    button4.frame = CGRectMake(0, 320, self.view.frame.size.width, 80);
    [button4 setTitle:@"修改手势密码" forState:0];
    [button4 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    button4.tag = 690;
    [self.view addSubview:button4];
    
    
}

- (void)BtnClick:(UIButton *)sender {
    
    switch (sender.tag-686) {
        case 1:
        {
            GestureViewController *gestureVc = [[GestureViewController alloc] init];
            gestureVc.type = GestureViewControllerTypeSetting;
            [self.navigationController pushViewController:gestureVc animated:YES];
        }
            break;
        case 2:
        {
            if ([[PCCircleViewConst getGestureWithKey:gestureFinalSaveKey] length]) {
                GestureViewController *gestureVc = [[GestureViewController alloc] init];
                [gestureVc setType:GestureViewControllerTypeLogin];
                [self.navigationController pushViewController:gestureVc animated:YES];
            } else {
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂未设置手势密码，是否前往设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
                [alerView show];
            }
        }
            break;
        case 3:
        {
            GestureVerifyViewController *gestureVerifyVc = [[GestureVerifyViewController alloc] init];
            [self.navigationController pushViewController:gestureVerifyVc animated:YES];
        }
            break;
            
        case 4:
        {
            GestureVerifyViewController *gestureVerifyVc = [[GestureVerifyViewController alloc] init];
            gestureVerifyVc.isToSetNewGesture = YES;
            [self.navigationController pushViewController:gestureVerifyVc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        GestureViewController *gestureVc = [[GestureViewController alloc] init];
        gestureVc.type = GestureViewControllerTypeSetting;
        [self.navigationController pushViewController:gestureVc animated:YES];
    }
}

@end

# CWActionSheet
一款简单的仿微信底部弹出
## 使用方法
将文件拖入工程项目中，在需要用到的地方添加以下代码
   
    NSArray *title = @[@"_codeBo", @"拍摄" , @"从相册选择"];
    CWActionSheet *sheet = [[CWActionSheet alloc] initWithTitles:title clickAction:^(CWActionSheet *sheet, NSIndexPath *indexPath) {
        NSLog(@"点击了%@", title[indexPath.row]);
        self.label.text = title[indexPath.row];
    }];
    [sheet show];
    
### 实现比较简单，方便扩展。欢迎交流讨论 [简书](http://www.jianshu.com/u/330af95c59d8)

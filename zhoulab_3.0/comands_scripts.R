library(devtools)
library(roxygen2)
# 利用git创建git需要的文件
use_git()

setwd('C:\\Users\\admin\\Desktop\\zhoulab')

# 引用包
usethis::use_package(package = "base",type = 'Depends')
usethis::use_package(package = "ggplot2",type = 'Depends')
usethis::use_package(package = "ggprism",type = 'Depends')
usethis::use_package(package = "ggrepel",type = 'Depends')
usethis::use_package(package = "utils",type = 'Depends')

# 测试下
load_all()

# 1.加上选定参数测试
volcaplot(res = data,log2FoldChange = 1,pvalue = 0.05,size = 4)

# 2.使用默认参数测试
volcaplot(res = data,pvalue = 0.05,size = 4)

# 3.提供颜色测试
volcaplot(res = data,log2FoldChange = 1,pvalue = 0.05,size = 4,col = c('red','blue','gray'))

# 4.选定x轴和y轴范围画图测试
volcaplot(res = data,log2FoldChange = 1,pvalue = 0.05,size = 4,xcut = 5, ycut=100)

# 5.更改主题字体大小
volcaplot(res = data,log2FoldChange = 1,pvalue = 0.05,size = 4,base_size = 18)

# 6.更改颜色主题
load_all()
volcaplot(res = data,log2FoldChange = 1,pvalue = 0.05,size = 5,xcut = 5, ycut=100,col = unlist(chose[5]))

# 7.测试是否显示画图边框
volcaplot(res = data,log2FoldChange = 1,pvalue = 0.05,size = 5,col = flat6,border = TRUE)

# 8.测试是否显示基因名
load_all()
volcaplot(res = data,log2FoldChange = 1,pvalue = 0.05,size = 5,col = flat6, gene = c('BMP3','SUSD3'))

# 9.可以设置基因名字体大小和标的圈圈大小
volcaplot(res = data,log2FoldChange = 1,pvalue = 0.05,size = 5,col = flat6, gene = c('BMP3','SUSD3'),
          gen_stoke_col = 'green',gen_size = 10)

# 9.可以设置横坐标间隔
volcaplot(res = data,log2FoldChange = 1,pvalue = 0.05,size = 4,xdis = 8,ydis = 40)
################################################################################
# 10.表达值与pvalue的关系
load_all()
meanplot(res = data,log2FoldChange = 1,pvalue = 0.05,size = 2,xcut = 10,xdis = 5,border = T)

# 11.测试看能不能添加基因名
meanplot(res = data,log2FoldChange = 1,pvalue = 0.05,size = 2,xcut = 10,
         xdis = 5,border = T,gene = c('NMUR2','ISY1-RAB43'))
# 12.测试输出差异表达结果

otresults(res = data,log2FoldChange = 1,pvalue = 0.05,name = 'firsttest')

# 13.测试gsea绘图
load_all()
gseaplot1(res = res)

gseaplot2(res = res)
gseaplot2(res = res,col = rev(rainbow(2)))
gseaplot2(res = res,col = rev(c('red','black','blue')))

# 把所有信息写入到description文件里
# 有warning就把NAMESPACE删掉重新来
document()

# 下面检验你的R包有什么问题，先添加下协议
use_mit_license("junjun")

# 全面检查有没有错误
check()

# 打包
build()
# 安装到我们library里
install()

library(ZhoulabVoCalno)

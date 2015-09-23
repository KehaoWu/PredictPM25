# Predict pm2.5 using Bayes method 
# 基于贝叶斯方法的pm2.5预测

理论公式推导见：[Conda's Blog](http://blog.how-to-code.info/r/Bayes-to-predict-PM25-based-on-China-data.html)

Crawler.R用来抓取pm2.5数据，抓取后结果见pm.RData

Predict.R包括一些预测pm2.5的函数，最新添加了最大似然估计期望值，并引入了LaPlace变换。

使用方法（基于长沙pm2.5数据）：

```R
    > predictPM25(pm25 = 72,city = "长沙市")
    Expected value: 61-90 
                     Pr
    1-30     0.09730849
    31-60    0.10724638
    61-90    0.11138716
    91-120   0.10186335
    121-150  0.09772257
    151-180  0.09689441
    181-210  0.09689441
    211-240  0.09689441
    241-270  0.09689441
    271-more 0.09689441
```

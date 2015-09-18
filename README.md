# Predict pm2.5 using Bayes method 
# 基于贝叶斯方法的pm2.5预测

理论公式推导见：[Conda's Blog](http://blog.how-to-code.info/r/Bayes-to-predict-PM25-based-on-China-data.html)

Crawler.R用来抓取pm2.5数据，抓取后结果见om.RData

Predict.R包括一些预测pm2.5的函数

使用方法（基于北京市pm2.5数据）：

```R
    > load("pm.RData")
    > empiricalData = rev(pm$pm[pm$city=="北京市"])
    > source("Predict.R")
    > P = GeneratePMatrix(empiricalData)
    > predictionPM25(120,P) # 120为今天pm2.5数据，预测明天的pm2.5数据
    Expected value: 119.1892 
                     Pr
    1-30     0.00000000
    31-60    0.10810811
    61-90    0.43243243
    91-120   0.16216216
    121-150  0.10810811
    151-180  0.10810811
    181-210  0.05405405
    211-240  0.00000000
    241-270  0.02702703
    271-more 0.00000000
    240-271  0.02702703
    270-more 0.00000000
```

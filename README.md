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
    > predictionPM25(120,P) # 150为今天pm2.5数据，预测明天的pm2.5数据
    Expected value: 109.2793 
                     Pr
    0-31            NaN
    30-61    0.10810811
    60-91    0.43243243
    90-121   0.16216216
    120-151  0.10810811
    150-181  0.10810811
    180-211  0.05405405
    210-241  0.00000000
    240-271  0.02702703
    270-more 0.00000000
```

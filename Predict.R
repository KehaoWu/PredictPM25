category = function(PM25){
  PM25 = ceiling(PM25 / 30)
  unlist(lapply(PM25,FUN = function(X)min(X,10)))
}

GeneratePMatrix = function(empiricalData){
  P = matrix(0,nrow = 10,ncol = 10)
  empiricalData = category(empiricalData)
  for(i in 2:length(empiricalData)){
    P[empiricalData[i],empiricalData[i-1]] = P[empiricalData[i],empiricalData[i-1]] + 1
  }
  #P1 current day is condition
  P100 = apply(P,2,sum)
  P10 = matrix(rep(P100,10),byrow = T,ncol = 10)
  P1 = rbind(P / P10,P100/sum(P))
  
  #P2 next day is condition
  P200 = apply(P,1,sum)
  P20 = matrix(rep(P200,10),ncol = 10,byrow = F)
  P2 = cbind(P / P20,P200/sum(P))
  P1[is.na(P1)] = 0
  P2[is.na(P2)] = 0
  return(list(P1,P2))
}

..predictPM25 = function(i,j,P){
  
  (P[[1]][i,j] * P[[1]][11,j]  + 1)/ (P[[2]][i,11] + 10)
}

.predictionPM25 = function(pm,P){
  pm = category(pm)
  labels = paste(seq(1,271,30),c(seq(30,270,30),"more"),sep="-")

  res = matrix(numeric(),nrow = 10,ncol = 1,dimnames = list(labels,c("Pr")))
  for(i in 1:10){
    res[i,1] = ..predictPM25(pm,i,P)
  }
  res[is.na(res)] = 0
  row.names(res) = labels

  expect = labels[order(res[,1],decreasing = T)[1]]

  cat("Expected value:",expect,"\n")
  print(res)
  return(invisible(list(res,expect)))
}

predictPM25 = function(pm25,city){
  load("pm.RData")
  empiricalData = rev(pm$pm[pm$city==city])
  P = GeneratePMatrix(empiricalData)
  .predictionPM25(pm25,P)
}


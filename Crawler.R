library(XML)
StartDate = "2014-09-01"
EndDate = as.character(format(Sys.time(),"%Y-%m-%d"))


Start = Sys.time()
cat("Obtaining data ...\n")
website = paste("http://datacenter.mep.gov.cn/report/air_daily/air_dairy.jsp?city=&startdate=",StartDate,"&enddate=",EndDate,"&page=",1,sep = "")
pmweb = readLines(website,encoding="UTF-8")
pmweb = paste(pmweb,collapse = "")
pmhtml = htmlParse(pmweb,encoding="UTF-8")
totalPages = as.numeric(xmlValue(getNodeSet(pmhtml,"//font[@color='#004e98']")[[2]]))
cat("\tThere are",totalPages-1,"pages need to be downloaded ...\n")
pmtotal = getNodeSet(pmhtml,"//table/tr/td")
pmvalue = sapply(X=pmtotal,FUN=xmlValue)
pmvalue = pmvalue[-1:(-match(x = "首要污染物",table = pmvalue))]
pmvalue = pmvalue[1:((1:length(pmvalue))[grepl(pattern = "记录总数",x = pmvalue)]-1)]
pm = matrix(pmvalue,byrow = T,ncol = 6)
pm = data.frame(city=pm[,2],date=pm[,3],pm=as.numeric(pm[,4]),type=pm[,6],degree=pm[,5])
if(totalPages>=2)
{
  for(page in 2:totalPages )
  {
    cat("Obtaining data for page",page,"...\n")
    website = paste("http://datacenter.mep.gov.cn/report/air_daily/air_dairy.jsp?city=&startdate=",StartDate,"&enddate=",EndDate,"&page=",page,sep = "")
    pmweb = readLines(website,encoding="UTF-8")
    pmweb = paste(pmweb,collapse = "")
    pmhtml = htmlParse(pmweb,encoding="UTF-8")
    pmtotal = getNodeSet(pmhtml,"//table/tr/td")
    pmvalue = sapply(X=pmtotal,FUN=xmlValue)
    pmvalue = pmvalue[-1:(-match(x = "首要污染物",table = pmvalue))]
    pmvalue = pmvalue[1:((1:length(pmvalue))[grepl(pattern = "记录总数",x = pmvalue)]-1)]
    pm.new = matrix(pmvalue,byrow = T,ncol = 6)
    pm.new = data.frame(city=pm.new[,2],date=pm.new[,3],pm=as.numeric(pm.new[,4]),type=pm.new[,6],degree=pm.new[,5])
    pm = rbind(pm,pm.new)
    save(list=c("pm"),file = "pm.RData")
  }
}
save(list=c("pm"),file = "pm.RData")

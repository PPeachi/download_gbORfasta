URL1 <- "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nuccore&id=34577062,24475906&rettype=fasta&retmode=text"
URL2 <- "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nuccore&id=NW_019173287&rettype=fasta&retmode=text"
URL3 <- "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nuccore&id=NW_019173287&rettype=gb&retmode=text"
base <- "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi"

#1
download.file(url = URL1,destfile = "file1.fas")
download.file(url = URL2,destfile = "file2.fas")
download.file(url = URL3,destfile = "file3.gb")

###test1
library('RCurl')
html<-getURL(base)
#ERROR!

###test2
html=getURL("https://www.ncbi.nlm.nih.gov/nuccore/AB115403/")
temp=strsplit(html,"<li><a href=\"")[[1]]
files=strsplit(temp,"\"")
files=lapply(files,function(x){x[1]})
files
class(files)
files=unlist(files)
files=files[-(1:2)]
setwd('C:\\Users\\18307\\Documents\\大四\\课件\\科研训练\\R_y叔\\4-download_genbank\\RCurl抓取的文件')
dir()
i=1
base="https://www.ncbi.nlm.nih.gov/nuccore/AB115403/"
for(i in 1:length(files)){
  url=paste(base,files[i],sep='')    #拼接url
  temp=getBinaryURL(url)    #获取网页内容
  note=file(paste("AB115403",files[i],sep='.'),open="wb")   #文件属性
  writeBin(temp,note)     #文件写入内容
  close(note)         #关闭文件
}
#ERROR!

#2
dir.create("gb")
dir.create("fasta")
getwd()
wd<-"C:/Users/18307/Documents/大四/课件/科研训练/R_y叔/4-download_genbankORfasta"
setwd(wd)
setwd("gb")
setwd("fasta")
accn<-paste("AJ5345", 26:49, sep="")
accn
list.files()
#acc<-accn
#database<-"nucleotide"
#returntype<-"gb"
#returnmode<-"text"
#base<- "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi"
download_GBorFASTA<-function(acc,database,returntype,returnmode){
  base<- "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi"
  for(i in 1:length(acc)){
    url=paste(base,"?db=",database,"&rettype=",returntype,"&retmode=",returnmode,"&id=",acc[i],sep = "")
    if(returntype=="gb"){files<-paste(acc[i],".gb",sep = "")}
    if(returntype=="fasta"){files<-paste(acc[i],".fas",sep = "")}
    download.file(url,destfile = files)
  }
}
download_GBorFASTA(accn,"nucleotide","gb","text")
download_GBorFASTA(accn,"nucleotide","fasta","text")
list.files()

###attention
for(acc in accn){print(acc)}
download_genbank <- function(accession) {
  for (acc in accession) {
    URL <- paste("https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=", 
                 paste(acc, collapse = ","), "&rettype=gb&retmode=text", 
                 sep = "")
    utils::download.file(url = URL, destfile = paste0(acc, ".gb"), quiet = TRUE)
  }
}
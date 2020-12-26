setwd("~/Desktop/Università/MODERN STATISTICS AND BIG DATA ANALYTICS ")
library(EMMIXskew)
library(clusterSim)
library(poLCA)
library(fpc)
library(cluster)
library(nomclust)
library(mclust)
library(cluster)
library(smacof)
data<- read.table("stars5000.dat.txt",header=TRUE)
str(data)
data.s1=data.Normalization(data,type="n2",normalization="column")

set.seed(123456)
skew.t <- list()
bicvals <- ariarea <- ariregion <- numeric(0)

for (i in 1:12){
  print(i)
  tryattempts <- 3
  trycounter <- 1
  tst <- try(skew.t[[i]] <- EmSkew(data.s1,g=i,distr="mst",ncov=3))
  while((is.null(tst) | class(tst)=="try-error") & trycounter<tryattempts+1){
    print("Error, try again")
    tst <- try(skew.t[[i]] <- EmSkew(data.s1,g=1,distr="mst",ncov=3))
    trycounter <- trycounter+1
  }
  trycounter <- 1
  while((is.null(tst) | class(tst)=="try-error") & trycounter<tryattempts+1){
    print("Error, try again")
    tst <- try(skew.t[[i]] <- EmSkew(data.s1,g=i,distr="mst",ncov=4))
    trycounter <- trycounter+1
  }
  trycounter <- 1
  while((is.null(tst) | class(tst)=="try-error") & trycounter<tryattempts+1){
    print("Error, try again")
    tst <- try(skew.t[[i]] <- EmSkew(data.s1,g=i,distr="mst",ncov=2))
    trycounter <- trycounter+1
  }
  bicvals[i] <- skew.t[[i]]$bic
}


set.seed(123456)
norm <- list()
bicvals <- ariarea <- ariregion <- numeric(0)

for (i in 1:12){
  print(i)
  tryattempts <- 3
  trycounter <- 1
  tst <- try(norm[[i]] <- EmSkew(data.s1,g=i,distr="mvn",ncov=3))
  while((is.null(tst) | class(tst)=="try-error") & trycounter<tryattempts+1){
    print("Error, try again")
    tst <- try(norm[[i]] <- EmSkew(data.s1,g=1,distr="mvn",ncov=3))
    trycounter <- trycounter+1
  }
  trycounter <- 1
  while((is.null(tst) | class(tst)=="try-error") & trycounter<tryattempts+1){
    print("Error, try again")
    tst <- try(norm[[i]] <- EmSkew(data.s1,g=i,distr="mvn",ncov=4))
    trycounter <- trycounter+1
  }
  trycounter <- 1
  while((is.null(tst) | class(tst)=="try-error") & trycounter<tryattempts+1){
    print("Error, try again")
    tst <- try(norm[[i]] <- EmSkew(data.s1,g=i,distr="mvn",ncov=2))
    trycounter <- trycounter+1
  }
  bicvals[i] <- norm[[i]]$bic
}


set.seed(123456)
skew.m <- list()
bicvals <- ariarea <- ariregion <- numeric(0)

for (i in 1:12){
  print(i)
  tryattempts <- 3
  trycounter <- 1
  tst <- try(skew.m[[i]] <- EmSkew(data.s1,g=i,distr="msn",ncov=3))
  while((is.null(tst) | class(tst)=="try-error") & trycounter<tryattempts+1){
    print("Error, try again")
    tst <- try(skew.m[[i]] <- EmSkew(data.s1,g=1,distr="msn",ncov=3))
    trycounter <- trycounter+1
  }
  trycounter <- 1
  while((is.null(tst) | class(tst)=="try-error") & trycounter<tryattempts+1){
    print("Error, try again")
    tst <- try(skew.m[[i]] <- EmSkew(data.s1,g=i,distr="msn",ncov=4))
    trycounter <- trycounter+1
  }
  trycounter <- 1
  while((is.null(tst) | class(tst)=="try-error") & trycounter<tryattempts+1){
    print("Error, try again")
    tst <- try(skew.m[[i]] <- EmSkew(data.s1,g=i,distr="msn",ncov=2))
    trycounter <- trycounter+1
  }
  bicvals[i] <- skew.m[[i]]$bic
}

set.seed(123456)
tdist <- list()

for (i in 1:12){
  print(i)
  tryattempts <- 3
  trycounter <- 1
  tst <- try(tdist[[i]] <- EmSkew(data.s1,g=i,distr="mvt",ncov=3))
  while((is.null(tst) | class(tst)=="try-error") & trycounter<tryattempts+1){
    print("Error, try again")
    tst <- try(tdist[[i]] <- EmSkew(data.s1,g=1,distr="mvt",ncov=3))
    trycounter <- trycounter+1
  }
  trycounter <- 1
  while((is.null(tst) | class(tst)=="try-error") & trycounter<tryattempts+1){
    print("Error, try again")
    tst <- try(tdist[[i]] <- EmSkew(data.s1,g=i,distr="mvt",ncov=4))
    trycounter <- trycounter+1
  }
  trycounter <- 1
  while((is.null(tst) | class(tst)=="try-error") & trycounter<tryattempts+1){
    print("Error, try again")
    tst <- try(tdist[[i]] <- EmSkew(data.s1,g=i,distr="mvt",ncov=2))
    trycounter <- trycounter+1
  }
  
}

bicvals.sm<-bicvals.st<-bicvals.td<-bicvals.nd<-numeric(0)

for (i in 1:12){
  bicvals.sm[i] <- skew.m[[i]]$bic
}


for (i in 1:12){
  bicvals.st[i] <- skew.t[[i]]$bic
}

for (i in 1:12){
  bicvals.td[i] <- tdist[[i]]$bic
}

for (i in 1:12){
  bicvals.nd[i] <- norm[[i]]$bic
}

plot(1:12,bicvals.sm,typ="l",xlab="Number of clusters",ylab="BIC",lty=2,col=6)
lines(1:12,bicvals.st,typ="l",xlab="Number of clusters",ylab="BIC",col=2)
lines(1:12,bicvals.td,typ="l",xlab="Number of clusters",ylab="BIC",col=3,lty=2)
lines(1:12,bicvals.nd,typ="l",xlab="Number of clusters",ylab="BIC",col=4,lty=2)
legend(x=3,y=90000,c("skew-normal","skew-t","t","normal"),col=c("purple","red","green","blue"),lty = c(2,1,2,2),cex=0.5)

min(bicvals.sm)
min(bicvals.st)
min(bicvals.td)
min(bicvals.nd)



#########################EXERCISE 4######################
data("election")
election12 <- election[,1:12]
electioncomplete <- election12[complete.cases(election12),]

electionwithna <- election12
for (i in 1:12){
  levels(electionwithna[,i]) <- c(levels(election12[,i]),"NA")
  electionwithna[is.na(election12[,i]),i] <- "NA"
}

s=sm(electioncomplete)
s2=sm(electionwithna)
mds1 <- mds(s)
mds2=mds(s2)
#a)
set.seed(123)
f <- cbind(MORALG,CARESG,KNOWG,LEADG,DISHONG,INTELG,
           MORALB,CARESB,KNOWB,LEADB,DISHONB,INTELB)~1
nes1 <- poLCA(f,election,nclass=3)

#b)
set.seed(123)
nes2 <- poLCA(f,electionwithna,nclass=3)

nes2c=nes2$predclass[complete.cases(election12)]
adjustedRandIndex(nes1$predclass,nes2c)

par(mfrow=c(1,2))
plot(mds1$conf[,1],mds1$conf[,2],col=nes1$predclass,cex=0.75,pch=18,xlab="",ylab="",main="poLCA electioncomplete")
plot(mds2$conf[,1],mds2$conf[,2],col=nes2$predclass,cex=0.75,pch=18,xlab="",ylab="",main="poLCA electionwithna")

#c)
set.seed(123)
flex1=flexmixedruns(electioncomplete,continuous=0,discrete=12,n.cluster=3)
set.seed(123)
flex2=flexmixedruns(electionwithna,continuous=0,discrete=12,n.cluster=3)
flex2$flexout[[flex2$optimalk]]@cluster

adjustedRandIndex(flex2$flexout[[flex2$optimalk]]@cluster[complete.cases(election12)]
,flex1$flexout[[flex1$optimalk]]@cluster
)

par(mfrow=c(1,2))
plot(mds1$conf[,1],mds1$conf[,2],col=flex1$flexout[[flex1$optimalk]]@cluster,cex=0.75,pch=18,xlab="",ylab="",main="flexmixedruns electioncomplete")
plot(mds2$conf[,1],mds2$conf[,2],col=flex2$flexout[[flex2$optimalk]]@cluster,cex=0.75,pch=18,xlab="",ylab="",main="flexmixedruns electionwithna")

#e)
a=as.matrix(electioncomplete)
dist.complete=dist(a,method = "binary")
hclust(dist.complete,method="single")

levels(electioncomplete$MORALG) <- c(levels(electioncomplete$MORALG), 1,2,3,4)
levels(electioncomplete$CARESG) <- c(levels(electioncomplete$CARESG), 1,2,3,4)
levels(electioncomplete$KNOWG) <- c(levels(electioncomplete$KNOWG), 1,2,3,4)
levels(electioncomplete$LEADG) <- c(levels(electioncomplete$LEADG), 1,2,3,4)
levels(electioncomplete$DISHONG) <- c(levels(electioncomplete$DISHONG), 1,2,3,4)
levels(electioncomplete$INTELG) <- c(levels(electioncomplete$INTELG), 1,2,3,4)
levels(electioncomplete$MORALB) <- c(levels(electioncomplete$MORALB), 1,2,3,4)
levels(electioncomplete$CARESB) <- c(levels(electioncomplete$CARESB), 1,2,3,4)
levels(electioncomplete$KNOWB) <- c(levels(electioncomplete$KNOWB), 1,2,3,4)
levels(electioncomplete$LEADB) <- c(levels(electioncomplete$LEADB), 1,2,3,4)
levels(electioncomplete$DISHONB) <- c(levels(electioncomplete$DISHONB), 1,2,3,4)
levels(electioncomplete$INTELB) <- c(levels(electioncomplete$INTELB), 1,2,3,4)

electioncomplete[electioncomplete=="3 Not too well"]<-3
electioncomplete[electioncomplete=="1 Extremely well"]<-1
electioncomplete[electioncomplete=="2 Quite well"]<-2
electioncomplete[electioncomplete=="4 Not well at all"]<-4


##e)
s=sm(electioncomplete)
pam=pam(s,3)

#f)

s2=sm(electionwithna)
pam2=pam(s2,3)


adjustedRandIndex(pam$clustering,pam2$clustering[complete.cases(election12)])

par(mfrow=c(1,2))
plot(mds1$conf[,1],mds1$conf[,2],col=pam$clustering,cex=0.75,pch=18,xlab="",ylab="",main="pam-Clustering electioncomplete")
plot(mds2$conf[,1],mds2$conf[,2],col=pam2$clustering,cex=0.75,pch=18,xlab="",ylab="",main="pam-C electionwithna")



h=flexmixedruns(electioncomplete,continuous=0,discrete=12,n.cluster=1:10)
par=1
plot(1:10,h$bicvals,typ="l",
     xlab="Number of clusters",ylab="BIC")

plot(mds1$conf[,1],mds1$conf[,2],col=h$flexout[[h$optimalk]]@cluster,cex=0.75,pch=18,xlab="",ylab="",main="flexmixedruns 7 clusters ")

#####
rand.unif1 <- runif(1000000, min = 1, max = 4)
rand.unif2 <- runif(1000000, min = 2, max = 5)
dens=0.7*rand.unif1+0.3*rand.unif2
plot(density(dens))

rand.unif1 <- runif(1000000, min = 11, max = 14)
rand.unif2 <- runif(1000000, min = 12, max = 15)
dens=0.3*rand.unif1+0.7*rand.unif2
plot(density(dens))

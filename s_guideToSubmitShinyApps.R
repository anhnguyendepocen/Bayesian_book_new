library(shinyapps)
shinyapps::setAccountInfo(name='ben18785',
                          token='5698C07FA0452DF286D563737A3B882D',
                          secret='Ch5paWJPUOqPudGF5NeRcwSvdQSJZHoHiOMt7Zic')
shinyapps::deployApp('App-1')

plot(DR_data(rdirichlet(1000,c(1,1,1,1))),a3d=list(rgl=FALSE))
#Add references to the various pages
lSamples<-rdirichlet(1000,c(1,1))
hist(lSamples[,1])

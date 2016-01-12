library(shiny)
library(LaplacesDemon)
library(ggplot2)
library(logitnorm)
library(actuar)
library(VGAM)
library(reshape)
library(mvtnorm)
library(ggExtra)
library(grid)
library(gridExtra)
library(DirichletReg)
library(scatterplot3d)

dCustomInverseChiSquared <- function(x,df){
  return(ifelse(x>0,dinvchisq(x,df),0))
}

dCustomHalfCauchy <- function(x,location,scale){
  return(dcauchy(x,location,scale))
}

rCustomUnif <- function(n,min,max){
  if (min < max){return(runif(n,min,max))}
  else {return(runif(n,max,min))}
} 

fFirstInputPositiveOnly <- function(aDist){
           aOutput <- switch(aDist,
                      Normal=0,
                      Uniform=0,
                      LogNormal=0,
                      Exponential=1,
                      Gamma=1,
                      t=0,
                      Beta=1,
                      Cauchy=0,
                      HalfCauchy=0,
                      InverseGamma=1,
                      InverseChiSquared=1,
                      LogitNormal=0,
                        0)
           return(aOutput)}
fSecondInputPositiveOnly <- function(aDist){
  aOutput <- switch(aDist,
                       Normal=1,
                       Uniform=0,
                       LogNormal=1,
                       Exponential=-1,
                       Gamma=1,
                       t=1,
                       Beta=1,
                       Cauchy=1,
                       HalfCauchy=1,
                       InverseGamma=1,
                       InverseChiSquared=1,
                       LogitNormal=1,
                    1)
  return(aOutput)
}

# Define server logic for random distribution application
shinyServer(function(input, output) {
  
  fSelectUpperDist1 <- reactive({
    aDist <- switch(input$upperDist1,
                    Normal=rnorm,
                    Uniform=runif,
                    LogNormal=rlnorm,
                    Exponential=rexp,
                    Gamma=rgamma,
                    t = rst,
                    Beta=rbeta,
                    Cauchy=rcauchy,
                    HalfCauchy=rCustomHalfCauchy,
                    InverseGamma=rinvgamma,
                    InverseChiSquared=rCustomInverseChiSquared,
                    LogitNormal=rlogitnorm,
                    rnorm)
  })
  
  fSelectUpperDist2 <- reactive({
    aDist <- switch(input$upperDist2,
                    Normal=rnorm,
                    Uniform=runif,
                    LogNormal=rlnorm,
                    Exponential=rexp,
                    Gamma=rgamma,
                    t = rst,
                    Beta=rbeta,
                    Cauchy=rcauchy,
                    HalfCauchy=rCustomHalfCauchy,
                    InverseGamma=rinvgamma,
                    InverseChiSquared=rCustomInverseChiSquared,
                    LogitNormal=rlogitnorm,
                    rnorm)
  })
  
  
  fSelectLowerDist <- reactive({
    aDist <- switch(input$lowerDist,
                    Normal=rnorm,
                    Uniform=rCustomUnif,
                    LogNormal=rlnorm,
                    Exponential=rexp,
                    Gamma=rgamma,
                    t = rst,
                    Beta=rbeta,
                    Cauchy=rcauchy,
                    HalfCauchy=rCustomHalfCauchy,
                    InverseGamma=rinvgamma,
                    InverseChiSquared=rCustomInverseChiSquared,
                    LogitNormal=rlogitnorm,
                    rnorm)
  })
  
  fExtraFunctionInputs1 <- reactive({
    lExtra <-switch(input$upperDist1,
                    Normal=list(mean=input$muN1,sd=input$sigmaN1),
                    Uniform = list(min=input$aU1,max=input$aU1),
                    LogNormal = list(meanlog=input$meanlog1,sdlog=input$sdlog1),
                    Exponential = list(rate=input$rateE1),
                    Gamma=list(shape=input$shapeGam1,rate=input$rateGam1),
                    t = list(mu=input$muT1,sigma=input$sigmaT1,nu=input$nuT1),
                    Beta=list(shape1=input$aBeta1,shape1=input$bBeta1),
                    Cauchy=list(location=input$locationC1,scale=input$scaleC1),
                    HalfCauchy=list(location=input$locationHC1,scaleinput$scaleHC1),
                    InverseGamma=list(shape=input$shapeIG1,scale=input$scaleIG1),
                    InverseChiSquared=list(df=input$dfIC1),
                    LogitNormal=list(mu=input$muLogitN1,sigma=input$sigmaLogitN1),
                    list(mean=input$muN1,sd=input$sigmaN1))
              })
              
  fExtraFunctionInputs2 <- reactive({    
              lExtra <-switch(input$upperDist2,
                            Normal=list(mean=input$muN2,sd=input$sigmaN2),
                            Uniform = list(min=input$aU2,max=input$aU2),
                            LogNormal = list(meanlog=input$meanlog2,sdlog=input$sdlog2),
                            Exponential = list(rate=input$rateE2),
                            Gamma=list(shape=input$shapeGam2,rate=input$rateGam2),
                            t = list(mu=input$muT2,sigma=input$sigmaT2,nu=input$nuT2),
                            Beta=list(shape1=input$aBeta2,shape2=input$bBeta2),
                            Cauchy=list(location=input$locationC2,scale=input$scaleC2),
                            HalfCauchy=list(location=input$locationHC2,scaleinput$scaleHC2),
                            InverseGamma=list(shape=input$shapeIG2,scale=input$scaleIG2),
                            InverseChiSquared=list(df=input$dfIC2),
                            LogitNormal=list(mu=input$muLogitN2,sigma=input$sigmaLogitN2),
                            list(mean=input$muN2,sd=input$sigmaN2))
    return(lExtra)
  })
  
  
  fGenerateSamples <- function(aIndicator,aLowerDist,aUpperDist,numSamples,lExtra){
    aPositiveOnly <- ifelse(aIndicator==1,fFirstInputPositiveOnly(aLowerDist),
                            fSecondInputPositiveOnly(aLowerDist))
    # print(lExtra)
    lSamples <- if(aPositiveOnly==1){
      fSelectOnlyPositive(aUpperDist,numSamples,lExtra)
    } else {
      aFnInputsList <- append(lExtra,list(n=numSamples))
      do.call(aUpperDist,aFnInputsList)
    }
    return(lSamples)
  }
  
 fSelectOnlyPositive <- function(aDist,aNumberSamples,lExtra){
   lSamples <- vector(length=aNumberSamples)
   count <- 0
   aFnInputsList <- append(lExtra,list(n=1))
   while (count < aNumberSamples){
     aSample <- do.call(aDist,aFnInputsList)
     if (aSample >= 0){
       count <- count + 1
       lSamples[count] <- aSample
     }
   }
   return(lSamples)
 }
  
  output$plot <- renderPlot({
      aLowerDist <- fSelectLowerDist()
      aUpperDist1 <- fSelectUpperDist1()
      lExtra1 <- fExtraFunctionInputs1()
      aUpperDist2 <- fSelectUpperDist2()
      lExtra2 <- fExtraFunctionInputs2()
      # print(lExtra1)
      lSamples1 <- fGenerateSamples(1,input$lowerDist,aUpperDist1,input$sampleSize,lExtra1)
      lSamples2 <- fGenerateSamples(2,input$lowerDist,aUpperDist2,input$sampleSize,lExtra2)
     print('hello')
       lData <- aLowerDist(input$sampleSize,lSamples1,lSamples2)
      lData <- data.frame(data=lData)
      ggplot(lData, aes(data)) +
        geom_histogram(binwidth=(max(lData)-min(lData))/input$numBins,fill=I("blue"))
  })
  
})
# This is the function to generate observations
addictionSimulation<-function(input){
  
  # initialize the variables and constant values
  addict<-c()
  vulne<-c()
  crav<-0
  selfcon<-input$Smax
  extcon<-1
  lambda<-0.5
  
  b<-0.5
  h<-0.2
  k<-0.25
  
  # a function passing lambda to one of the two alternative distribution functions
  distr<-function(distr,lambda){
    if (distr=='poisson'){
      return(rpois(1,lambda))
    }else{
      return(rnorm(1,lambda,1))
    }
  }
  
  # a advanced min function, when a number is too big and becomes NA, it returns the other number
  minNA<-function(x,y){
    if (is.na(x)) {
      return(y)
    }else{
      return(min(x,y))
    }
  }
  
  # for loop iterate the variables of every time point on those of the previous time point
  for(i in 1:input$n)
  {
    vulne[i]<-min(1,max(0,crav[i]-selfcon[i]-extcon[i]))
    addict[i]<-input$q*vulne[i]+minNA(distr(input$distr,lambda[i])*input$q/7,input$q*(1-vulne[i]))
    crav[i+1]<-crav[i]+b*min(1,1-crav[i])*addict[i]-input$d*crav[i]
    selfcon[i+1]<-selfcon[i]+input$p*max(0,input$Smax-selfcon[i])-h*crav[i]-k*addict[i]
    extcon[i+1]<-extcon[i]-input$d*extcon[i]
    lambda[i+1]<-lambda[i]+input$d*lambda[i]
  }
  # the change of addiciton behavior, craving and self control over time are stored and returned in a list
  return(list(addict=addict,crav=crav[1:input$n],selfcon=selfcon[1:input$n]))
}

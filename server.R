# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
source('addictionSimulation.R')
shinyServer(function(input, output) {
  
  # plot for change of craving over time
  output$craving <- renderPlot({
    # generate the obsevations
    plotlist<-addictionSimulation(input)
    # draw the plots
    plot(plotlist$crav,xlab = "Week", type = "l",main = "change of craving over time")
  })
  
  # plot for change of addiction over time
  output$addiction <- renderPlot({
    # generate the obsevations
    plotlist<-addictionSimulation(input)
    # draw the plots
    plot(plotlist$addict,xlab = "Week", type = "l",main = "change of addiction behavior over time")
  })
  
  # plot for change of self control over time
  output$self.control <- renderPlot({
    # generate the obsevations
    plotlist<-addictionSimulation(input)
    # draw the plots
    plot(plotlist$selfcon,xlab = "Week", type = "l",main = "change of self-control over time")
  })
  
  # plot for change of craving over self control
  output$C_S_plane <- renderPlot({
    # generate the obsevations
    plotlist<-addictionSimulation(input)
    # draw the plots
    par(pty="s")
    plot(plotlist$selfcon,plotlist$crav,type = "l",main = "C-S Plane")
  })
  
  # plot for change of addiction behavior over craving
  output$A_C_plane <- renderPlot({
    # generate the obsevations
    plotlist<-addictionSimulation(input)
    # draw the plots
    par(pty="s")
    plot(plotlist$crav,plotlist$addict,type = "l",xlab = "craving", ylab = "addiction behavior",main = "A-C Plane")
  })
  
  # plot for change of addiction behavior over self control
  output$A_S_plane <- renderPlot({
    # generate the obsevations
    plotlist<-addictionSimulation(input)
    # draw the plots
    par(pty="s")
    plot(plotlist$selfcon,plotlist$addict,type = "l",xlab = "self-control", ylab = "addiction behavior",main = "A-S Plane")
  })
})

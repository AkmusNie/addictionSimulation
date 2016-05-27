
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(fluidPage(
  
  # Application title
  headerPanel("Simulation of Getting addicted"),
  # Panels for users to change parameters
  fluidRow(
    column(4,
           # duration of time
           numericInput("n","time points:",100,min = 1,max = 1000),
           # upper edge of alcohol consumption
           numericInput("q","maximum of pure alcohol consumption over one week [kg]",0.8,min = 0,max = 10)
    ),
    column(4,
           # distribution of random events
           selectInput("distr", "Choose a distribution for random events generation",
                       choices = c("poisson", "normal")),
           # psychological resilience
           sliderInput("p",
                       "psychological resilience",
                       min = 0,
                       max = 1,
                       value = 0.4)
    ),
    column(4,
           # die-off coefficient
           sliderInput("d",
                       "die-off coefficient",
                       min = 0,
                       max = 1,
                       value = 0.2),
           # capacity of self control
           sliderInput("Smax",
                       "capacity of self-control",
                       min = 0,
                       max = 1,
                       value = 0.5)
    )
  ),
  
  hr(),
  
  # Show the generated plots
  fluidRow(
    # the plots of the planes are at the left of the plot panel
    column(7,plotOutput("C_S_plane"),plotOutput("A_C_plane"),plotOutput("A_S_plane")),
    # the plots of the change of variables over time are at the right of the plot panel
    column(4,offset=1,plotOutput("addiction"),plotOutput("craving"),plotOutput("self.control"))
  )
    )
)
  

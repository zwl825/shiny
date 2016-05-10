library(shiny)

# Define UI for miles per gallon application
shinyUI(fluidPage(
     
     # Application title
     titlePanel("Study of Linear Regression Models, Miles Per Gallon Data"),
     
     # Sidebar with controls to select the variable to plot against
     # mpg and to specify whether outliers should be included
     sidebarLayout(
          sidebarPanel(
               selectInput("variable", "Variable:",
                           c("Cylinders" = "cyl",
                             "Transmission" = "am",
                             "Gears" = "gear")),
               
          checkboxInput("smooth", "Show Linear Regression", FALSE)
          ),

          mainPanel(

               tabsetPanel(type = "tabs", 
                           tabPanel("Plot", h3(textOutput("caption")), br(), plotOutput("mpgPlot")), 
                           tabPanel("Model1", verbatimTextOutput("summary1")),
                           tabPanel("Model2", verbatimTextOutput("summary2")),
                           tabPanel("Model3", verbatimTextOutput("summary3")),
                           tabPanel("Anova", verbatimTextOutput("anova")),
                           tabPanel("Conclusion",
                                    br(),
                                    br(),
                                    p("Model1", code("lm(mpg ~ .)"), "summary showed wt is the significant varible, with adjusted R-sq of 0.8066"),
                                    p("Model2", code("lm(mpg ~ cyl + gear + wt + am)"), "summary showed wt & cyl are the significant varibles, with adjusted R-sq of 0.8125"),
                                    p("Model3", code("lm(mpg ~ cyl + wt)"), "with only 2 varibles, adjusted R-sq is ",strong("0.8185")),
                                    br(),
                                    p("Finally, the Anova table showed lm (mpg ~ cyl + wt) is the best model."), 
                                    br()
               ))
          
     )
)))
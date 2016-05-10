library(shiny)
library(datasets)
library(ggplot2)


shinyServer(function(input, output) {
     

     captionText <- reactive({
          if (input$variable == "cyl") {
          paste("mpg ~ wt color = Cylinders")
          }  
          else if (input$variable == "am") {

               paste("mpg ~ wt color = Transmission")
          }
          else if (input$variable == "gear") {
               
               paste("mpg ~ wt color = Gears")
          }
     })
     
     fit <-lm(mpg ~ ., data = mtcars)
     fit1<-lm(mpg ~ cyl + gear + wt + am, data = mtcars)
     fit2<-lm(mpg ~ cyl + wt, data = mtcars)
     
     fit4<-lm(mpg ~ wt, data =mtcars)
     fit5 <- update(fit, mpg ~ cyl + wt)
     fit6 <- update(fit, mpg ~ cyl + gear + wt + am)
     output$caption <- renderText({
          captionText()
     })
     

     output$mpgPlot <- reactivePlot(function() {
          # check for the input variable
          if (input$variable == "am") {
               # am
               mpgData <- data.frame(mpg = mtcars$mpg, wt = mtcars$wt, var = factor(mtcars[[input$variable]], labels = c("Automatic", "Manual")))
          }
          else {
               # cyl and gear
               mpgData <- data.frame(mpg = mtcars$mpg, wt = mtcars$wt, var = factor(mtcars[[input$variable]]))
          }
          g <- ggplot(mpgData, aes(wt,mpg)) + geom_point(aes(color = var), size = 4, alpha = 1/2)+ guides(color=guide_legend(title=input$variable))
          if (input$smooth) {
               g<- g+geom_smooth(size = 3, linetype = 3, method = "lm", se = FALSE)
          }
          print(g)
     })

     output$summary1 <- renderPrint({
          summary(fit)

     })
     output$summary2 <- renderPrint({
          summary(fit1)
          
     })
     output$summary3 <- renderPrint({
          summary(fit2)
          
     })
     output$anova <- renderPrint({
          anova(fit4,fit5,fit6)
     })
})
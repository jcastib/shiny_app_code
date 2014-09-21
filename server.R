library(shiny)

# App relies on these packages
library(HardyWeinberg)
library(ggplot2)

# Some default values for example and ease of calculations
genotypes<-c(30,60,30)
HWAlltests(genotypes,verbose=F)

shinyServer(
  function(input, output) {
    output$inputaa <- renderPrint({input$gaa})
    output$inputab <- renderPrint({input$gab})
    output$inputbb <- renderPrint({input$gbb})
    #Output for the results of the test perfomed on the input frequencies
    output$hwp <- renderPrint({
      genotypes<-c(input$gaa, input$gab, input$gbb)
      hwe<-HWAlltests(genotypes, verbose=F)
      hwe[1,]  
    })
    sliderValues<-reactive({
    # Genetype frequency calculations (observed and expected)
      aa<-input$gaa
      ab<-input$gab
      bb<-input$gbb
      freqgeno<-as.data.frame(c(aa, ab, bb)/(aa+ab+bb))
    # Calculation of allele frequencies for expected genotypes frquency calculations  
      alleles<-c(aa+ab+bb)*2
      p<-(aa*2+(ab/2))/alleles 
      data.frame(Genotype= c("AA","AB","BB"), Observed=c(input$gaa, input$gab, input$gbb), Freq.Observed=as.vector(c(aa, ab, bb)/(aa+ab+bb)), Freq.Expected= as.vector(c(p^2,2*p*(1-p),(1-p)^2)))
      })
    # print for the decision regarding HWE
    output$decision<- renderPrint({
      genotypes<-c(input$gaa, input$gab, input$gbb)
      hwe<-HWAlltests(genotypes, verbose=F)
      ifelse(hwe[1,2]>=0.05,"Hardy-Weinberg Equilibrium","Hardy-Weinberg Disequilibrium") 
    })
    # Summary table for the input and frequencies
    output$values<-renderTable({
      sliderValues()
    })
    # Barplot for Observed input frequencies from sliders
    output$GenoFreqplot <- renderPlot({
      aa<-input$gaa
      ab<-input$gab
      bb<-input$gbb
      freqgeno<-as.data.frame(c(aa, ab, bb)/(aa+ab+bb))
      barplot(freqgeno[,1], names.arg=c("AA","AB","BB"),col=c("green", "red", "darkblue"), xlab="Genotypes", ylab="Relative Genotype Frequencies", ylim=c(0,1))
      })
  }
)
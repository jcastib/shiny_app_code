library(shiny)

shinyUI(
  # Using fluid boostrap layout    
  fluidPage(
  # Page Header and Tittle  
    h2("Hardy-Weinberg Equilibrium Calculator",aling="center"),
    br(),
  # Descripton of  App  
    h5('The Hardy-Weinberg principle is commonly used in population genetic studies and states that a gene in a population should remain constant from generation to generation when there is not an effect of evolution going on.'),
    h5('A gene in a population is at Hardy-Weinberg Equilibrium when:'),
    h5('when the population is mating randomly, size of the population is large and there is no migration, mutation or selection.'),
    br(),
  # Sidebar defined to receive input using slider per each genotype - Defeaul is set for HWE  
    sidebarPanel(
      h3('How to use this App!!!'),     
      p('Use the sliders below to input the observed frequencies for a gene (i.e. genotypes - AA, AB, BB) in order to calculate the hardy-Weinberg proportions and to get a decision if they are or not in equilibrium.'),
        
      sliderInput('gaa', 'Genotype AA',25, min = 1, max = 100, step = 1),
      sliderInput('gab', 'Genotype AB',50, min = 1, max = 100, step = 1),
      sliderInput('gbb', 'Genotype BB',25, min = 1, max = 100, step = 1),
      
      submitButton('Calculate'),
     br(),
     p('Default values (AA=25,AB=50,BB=25) - give an example of equilibrium.')
      ),
  # Summary of input, results, graph and decision  
    mainPanel(
      h4('Table of Genotypes Observed and Expected', align="center"),
      tableOutput('values'),
      p('Observed frequencies are calculated as relative frequencies and expected frequancies are calculated by calculation of the allele frequencies for the gene.'),
      h4('Results and Decision for the Hardy-Weinberg Observed Proportions'),
      verbatimTextOutput("hwp"),
      verbatimTextOutput("decision"),
      p('After comparing the observed and expected frequencies for the gene, a comparison using a chi-square would allows us to decide if there is equilibrium (p-value <0.05) or not (p-value >0.05). If not, the gene is under the effec ot possible selection most probably due to evolution forces.'),
      h4("Barplot Showing the Observed Frequencies of the Gene"),
      plotOutput('GenoFreqplot')
            
    )
  )
)
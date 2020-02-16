library(shiny)
ui<-(fluidPage(
  titlePanel("Multiple Linear Regression"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose File',
                accept=c('text/csv',
                         'text/comma-separated-values,text/plain',
                         '.csv')),
      
      tags$hr(),
      checkboxInput('header', 'Header', TRUE),
      
      radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   'Comma'),
      
      radioButtons('quote', 'Quote',
                   c(None='',
                     'Double Quote'='"',
                     'Single Quote'="'"),
                   'Double Quote'),
      
      actionButton("structure", "View data structure"),
      actionButton("summary", "View data summary"),
      
      uiOutput("dependent"),
      uiOutput("independents"),
      tags$hr(),
      actionButton("regression", "Linear regression"),
      actionButton("correlation", "Correlation")
      
    ),
    mainPanel(
      verbatimTextOutput('alloutput')
    )
  )
))
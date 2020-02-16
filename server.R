library(shiny)
server<-(function(input, output) {
  
  filedata <- reactive({
    infile <- input$file1
    if (is.null(infile)){
      return(NULL)
    }
    
    read.csv(infile$datapath, sep=input$sep, quote=input$quote)
    
  })
  
  output$dependent <- renderUI({
    df <- filedata()
    if (is.null(df)) return(NULL)
    items=names(df)
    names(items)=items
    selectInput("dependent","Select dependent variable from:",items)
  })
  
  
  output$independents <- renderUI({
    df <- filedata()
    if (is.null(df)) return(NULL)
    items=names(df)
    names(items)=items
    selectInput("independents","Select variable(s) from:",items,multiple=TRUE)
  })
  
  viewStructure <- function(){
    df <- filedata()
    str(df)
  }
  
  viewSummary <- function(){
    df <- filedata()
    summary(df)
  }
  
  doRegression <- function(){
    df <- filedata()
    if (is.null(df)) return(NULL)
    fmla <- as.formula(paste(input$dependent," ~  ",paste(input$independents,collapse="+")))
    summary(lm(fmla,data=df))
  }
  
  doCorrelation <- function(){
    df <- filedata()
    if (is.null(df)) return(NULL)
    vars <- c(input$dependent, input$independents)
    cor(df[,vars])
  }
  
  task <- reactiveValues(name="")
  observeEvent(input$structure, task$name <- 'structure')
  observeEvent(input$summary, task$name <- 'summary')
  observeEvent(input$regression, task$name <- 'regression')
  observeEvent(input$correlation, task$name <- 'correlation')
  
  output$alloutput <- renderPrint({
    task$name
    isolate(
      switch(task$name, 'structure'=viewStructure(), 'summary'=viewSummary(), 'regression'=doRegression(), 'correlation'=doCorrelation())
    )
  })
  
})
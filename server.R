library(shiny)
library(dplyr)

shinyServer(function(input, output) {
  
  output$difftable <- renderDataTable({
    f1 <- input$file1
    f2 <- input$file2
    
    if (is.null(f1) || is.null(f2))
      return(NULL)
    
    df1 <- read.csv(f1$datapath, header=input$header, sep=input$sep, 
                    quote=input$quote)
    df2 <- read.csv(f2$datapath, header=input$header, sep=input$sep, 
                    quote=input$quote)
    
    if (nrow(df1) < nrow(df2)) {
      tmp <- df1
      df1 <- df2
      df2 <- tmp
    }

    if (input$join.type == 'anti')
      anti_join(df1,df2)
    else if (input$join.type == 'semi')
      semi_join(df1,df2)
    else
      return(NULL)
  })
  
  output$comparison.text <- renderText({
    f1 <- input$file1
    f2 <- input$file2
    
    if (is.null(f1) || is.null(f2))
      return(NULL)

    df1 <- read.csv(f1$datapath, header=input$header, sep=input$sep, 
                    quote=input$quote)
    df2 <- read.csv(f2$datapath, header=input$header, sep=input$sep, 
                    quote=input$quote)
    
    
    if (input$join.type == 'anti') {
      if (nrow(df1) == nrow(df2))
        if (df1 == df2)
          return("The two datasets are identical.")
        else
          return(paste("Here are the rows unique to either file."))
      else if (nrow(df1) > nrow(df2)) 
        return(paste("Here are the rows in ", toString(f1$name), "and not in ", toString(f2$name)))
      else
        return(paste("Here are the rows in ", toString(f2$name), "and not in ", toString(f1$name)))
    }
    else if (input$join.type == 'semi')
      if (nrow(df1) == nrow(df2) && df1 == df2)
        return("The two datasets are identical.")
      else
        return(paste("Here are the rows in both ", toString(f1$name), "and ", toString(f2$name)))
    else
      return(NULL)
  })
  
})
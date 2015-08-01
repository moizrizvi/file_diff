library(shiny)

shinyUI(fluidPage(
  titlePanel("file diff"),
  sidebarLayout(
    sidebarPanel(
      helpText("Upload two datasets and see how they're different."),
      fileInput('file1', 'Choose CSV File',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv')),
      fileInput('file2', 'Choose CSV File',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv')),
      tags$hr(),
      textOutput('comparison.text'),
      checkboxInput('header', 'Header', TRUE),
      radioButtons('join.type', 'Comparison type',
                   c('In both files'='semi',
                     'In one file'='anti'),
                   'anti'),
      radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ','),
      radioButtons('quote', 'Quote',
                   c(None='',
                     'Double Quote'='"',
                     'Single Quote'="'"),
                   '"')
    ),
    mainPanel(
      fluidRow(
        dataTableOutput('difftable')
      )
    )
  )
))
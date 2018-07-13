# This app reads multiple .txt files 
# connects to google TTS using our JSON key [DO NOT SHARE]
# spits out the audio file with the same name. 



library(shiny)


shinyUI(fluidPage(
  
  # Application title
  titlePanel("Text File to MP3 using Google Text to Speech"),
  
  # Sidebar   
  sidebarLayout(
    sidebarPanel(
      ## Select a file --- 
      h6("Select multiple .txt files with unique names and this app returns an mp3 file for each. The files will be located in the directory
         of this app though- i.e. K://CDC/TextToSpeech_App  - Always move files immediately and count them twice!"),
      h6("It might say 'null' when the files are done. That's fine."),
      fileInput("the.files","Choose Multiple .txt Files",
                multiple = TRUE,
                accept = ".txt",
                buttonLabel = "Browse"),
      
      actionButton(inputId = "submit",label = "Run Program")
      
      ),
    
    # Main Panel
    mainPanel(
      textOutput("main.content")
    )
      )
))

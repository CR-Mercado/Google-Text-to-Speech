#these top two lines were just for local building - the deployment will include the remote github file. 
#library(remotes)
#remotes::install_github("ropensci/googleLanguageR")
library(googleLanguageR)

# Define server logic required to draw a histogram
shinyServer(function(input,output,session) {
  
  # Accept the files - and only begin the app after the event "Run Program" (our submit button) has been clicked
  observeEvent(
    eventExpr = input[["submit"]],
    handlerExpr = {
      print("Running")
    }
  )
  #this starts once the "submit" button as been hit
  output$main.content <- eventReactive(input$submit,{ 
    gl_auth("GoogleTTSAccountInfo.json") # THIS IS A CUSTOM GOOGLE CLOUD AUTHORIZATION FILE. PLEASE DO NOT DISTRIBUTE / ALTER / SHARE / DELETE
    
    #inputs the uploaded files   # this creates a dataframe of the files with columns:  name | size | type | datapath      note: datapath is a temporary file  
    inFile <- input$the.files 
    file.names <- inFile$name
    file.locations <- inFile$datapath
    
    # this loops through all of the narration files and calls the google text to speech api to convert them into mp3 format. 
    
    for(i in 1:length(file.names)){  # normally I would index the list itself, but we're going to be referencing 2 columns - the object name, and the objects path
      
      file.content <- readLines(file.locations[i])          #read the text by reading the file location 
      new.file.name <- sub(".txt",".mp3",file.names[i])     # replace .txt with .mp3 in the object's name
      gl_talk(input = file.content, 
            output = new.file.name, 
             name = "en-US-Wavenet-F",   # voice:  American - US - Woman - Version F 
             pitch = -3,                 # 3 tiers lower in pitch than usual  -20:20 range. 
             audioEncoding = "MP3") 
      
    }
    
  })
# this is so the app closes when you close the browser. It makes testing a pain, but its important for deployment.
     session$onSessionEnded(function() {
     stopApp()
    q("no")
    })
})
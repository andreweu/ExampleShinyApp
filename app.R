library(shiny)
# Equivalent to R shiny's print statement: cat(file=stderr(), "Value of turn val is ", turn_val, "\n")


# Define UI ----
# fluidPage: display automatically adjusts to dimensions of user's browser window
# fluidPage is a function that is taking takes the title + sidebar as args
# if i wanted multi-page ui w/ a navigation bar could use navbarpage
# further description: https://shiny.rstudio.com/articles/layout-guide.html
# most likely will end up using tabsets or navbarpage (if more than a handful, use navlists)
# formatting text in ui in lesson 2 
ui <- fluidPage( 
  # title panel
  titlePanel("Example Shiny App"),
  
  # sidebar function takes these 2 args
  sidebarLayout(position = "right",
                sidebarPanel("sidebar panel"),
                mainPanel(
                  h1("First Level title", align="center"),
                  h2("Second Level title", align="center"),
                  h3("Third Level title", align="center"),
                  h4("Fourth Level title", align="center"),
                  h5("Fifth Level title", align="center"),
                  h6("Sixth Level title", align="center"),
                  # example of inserting image (need to put images within folder of app called www)
                  # to find dimmensions of png file, open and check settings -> file info
                 # img(src="drawing.png", height=200, width=200),
                  # newline
                  br(),
                  # go to this link (need to keep link in http:// format)
                  p("Click on this ",
                    a("word", 
                      href= "http://google.com"),
                    "to go to google.", align="center"),
                  
                  # WIDGETS: http://shiny.rstudio.com/gallery/widget-gallery.html
                  # adding widgets (name to access widget's value + label to appear w/ in app)
                  actionButton("turn_button", label="Press me!"),
                  
                  # USE ACTION BUTTONS TO LISTEN + USE VARIABLE (even= normal size image, odd=BIG IMAGE) 
                  # do things like change height=something$dimension, width=something$dimension too maybe?
                  # go through lesson 4 first
                  
                  imageOutput("drawing", width=200, height=200)
                )
                
  )
)

# Define server logic ----
server <- function(input, output) {
  
  # initializations
  turn_val <<- 0
  output$drawing <- renderImage({
    list(src = "www/drawing_0.png")
  }, deleteFile=FALSE)
  
  # Load different images depending on action button press!
  observeEvent(input$turn_button, {
    # 0, 1, 2, 3
    turn_val <<- turn_val + 1
    
    if(turn_val == 4){
      turn_val <<- 0
    }
   
    output$drawing <- renderImage({
      if(turn_val == 0){
        filename = "www/drawing_0.png"
      } else if (turn_val == 1) {
        filename = "www/drawing_90.png"
      } else if (turn_val == 2) {
        filename = "www/drawing_180.png"
      } else {
        filename = "www/drawing_270.png"
      }
      list(src = filename)
      
    }, deleteFile=FALSE)
    
  })
  
  
}

# Run the app ----
shinyApp(ui = ui, server = server)
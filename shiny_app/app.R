#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

available_months <- sprintf("2024%02d", 1:12)

month_labels <- sprintf("2024-%02d", 1:12)

# Combine: value = 202401, label = "2024-01"
month_choices <- setNames(available_months, month_labels)

ui <- fluidPage(
  h2("Citi Bike Usage Maps (2024)", 
     style = "font-weight: 600; margin-top: 20px; margin-bottom: 10px;"),
  
  p("Explore monthly Citi Bike station usage across NYC.",
    style = "color: #666; margin-bottom: 30px;"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "month",
        "Select a month:",
        choices = month_choices,
        selected = "202401"
      ),
      width = 3
    ),
    mainPanel(
      uiOutput("map_ui"),
      width = 9
    )
  )
)

server <- function(input, output, session) {
  
  addResourcePath("maps", "maps_by_month")
  
  output$map_ui <- renderUI({
    file_name <- paste0("citibike_map_", input$month, ".html")
    
    tags$iframe(
      src = file.path("maps", file_name),
      style = "width: 100%; height: 80vh; border: 0;"
    )
  })
}

shinyApp(ui = ui, server = server)

# #
# # This is a Shiny web application. You can run the application by clicking
# # the 'Run App' button above.
# #
# # Find out more about building applications with Shiny here:
# #
# #    https://shiny.posit.co/
# #
# 
# library(shiny)
# 
# # Define UI for application that draws a histogram
# ui <- fluidPage(
# 
#     # Application title
#     titlePanel("Old Faithful Geyser Data"),
# 
#     # Sidebar with a slider input for number of bins 
#     sidebarLayout(
#         sidebarPanel(
#             sliderInput("bins",
#                         "Number of bins:",
#                         min = 1,
#                         max = 50,
#                         value = 30)
#         ),
# 
#         # Show a plot of the generated distribution
#         mainPanel(
#            plotOutput("distPlot")
#         )
#     )
# )
# 
# # Define server logic required to draw a histogram
# server <- function(input, output) {
# 
#     output$distPlot <- renderPlot({
#         # generate bins based on input$bins from ui.R
#         x    <- faithful[, 2]
#         bins <- seq(min(x), max(x), length.out = input$bins + 1)
# 
#         # draw the histogram with the specified number of bins
#         hist(x, breaks = bins, col = 'darkgray', border = 'white',
#              xlab = 'Waiting time to next eruption (in mins)',
#              main = 'Histogram of waiting times')
#     })
# }
# 
# # Run the application 
# shinyApp(ui = ui, server = server)



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

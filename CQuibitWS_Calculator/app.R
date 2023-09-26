#Creating a calculator to help me calculate the parts needed for making my working solutions during DNA quibiting (quantification) using shiny.

library(shiny)

# Defining the User Interface
ui <- fluidPage(
  titlePanel("Quibit Working Solution Calculator"),
  sidebarLayout(position = "right",
                sidebarPanel(
                  numericInput("Num_of_Samples", "Number of Samples:", value = 0),
                  br(),
                  HTML("<p>Number of Standards: 2</p>"),  # Display the fixed number of standards
                  br(),
                  actionButton("calculate", "Calculate"),
                  br(),
                  verbatimTextOutput("buffer_result"),  # Output for buffer
                  br(),
                  verbatimTextOutput("reagent_result"),  # Output for reagent
                ),
                mainPanel(
                  img(src = "Screenshot 2023-06-28 104707.png", height = 400, width = 500)
    )
  )
)

# Defining server logic
server <- function(input, output) {
  observeEvent(input$calculate, {
    req(input$Num_of_Samples)
    
    # Calculate the amount of working solution needed based on the Quibit protocol
    working_solution <- (199 * ((input$Num_of_Samples) + 2)) + (1 * (input$Num_of_Samples + 2))
    
    # Formatting the output to display results at only two decimal places
    working_solution_formatted <- sprintf("%.2f", working_solution)
    
    # Calculate the amounts of buffer and reagent based on the protocol
    buffer_amount <- 199 * ((input$Num_of_Samples) + 2)  # Assume 90% is buffer
    reagent_amount <- 1 * ((input$Num_of_Samples) + 2)   # Assume 10% is reagent
    
    # Format the output to display two decimal places
    buffer_formatted <- sprintf("%.2f", buffer_amount)
    reagent_formatted <- sprintf("%.2f", reagent_amount)
    
    # Output the results
    output$buffer_result <- renderPrint({
      paste("Add to your working solution", buffer_formatted, "μL of buffer")
    })
    output$reagent_result <- renderPrint({
      paste("Add to your working solution", reagent_formatted, "μL of reagent")
    })
  })
}

# Run the app
shinyApp(ui = ui, server = server)

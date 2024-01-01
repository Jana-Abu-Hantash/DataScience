# Import libraries
library(shiny)
library(data.table)
library(randomForest)

# Read the Obesity Dataset
obesity_data <- read.csv("Data/Obesity.csv")

# Load the trained model
model <- readRDS("model_subset.rds")  # Replace with the correct path

# Define the UI
ui <- fluidPage(
  titlePanel("Obesity Prediction"),
  sidebarLayout(
    sidebarPanel(
      width = 7,
      # Using tabsetPanel to create tabs for each group of inputs
      tabsetPanel(id = "tabs",
        # First tab with basic Basic information
        tabPanel("Basic Info",
                 numericInput("years", "Prediction after how many years:", value = NULL),
                 numericInput("age", "Age:", value = NULL),
                 numericInput("height", "Height (in m):", value = NULL),
                 numericInput("weight", "Weight (in kg):", value = NULL),
                 selectInput("gender", "Gender:", choices = c("Female", "Male")),
                 actionButton("next1", "Next") 
        ),
        # Second tab with family and personal health history
        tabPanel("Health History",
                 selectInput("family_history_with_overweight", "Family History with Overweight:", choices = c("Yes", "No")),
                 selectInput("SMOKE", "Do you smoke?", choices = c("Yes", "No")),
                 selectInput("SCC", "Do you monitor your calorie intake?", choices = c("Yes", "No")),
                 actionButton("next2", "Next")
        ),
        # Third tab with dietary habits
        tabPanel("Dietary Habits",
                 selectInput("FAVC", "Do you eat high caloric food frequently?", choices = c("Yes", "No")),
                 selectInput("FCVC", "Do you usually eat vegetables in your food?", choices = c("Never", "Sometimes", "Always")),
                 selectInput("NCP", "How many main meals do you have daily?", choices = c("Between 1 and 2", "Three", "More than three")),
                 selectInput("CH2O", "How often do you drink water?", choices = c("Less than a liter", "Between 1 & 2 L", "More than 2 L")),
                 selectInput("CALC", "How often do you drink alcohol?", choices = c("I don't drink", "Sometimes", "Frequently", "Always")),
                 actionButton("next3", "Next")
        ),
        # Fourth tab with lifestyle habits
        tabPanel("Lifestyle",
                 selectInput("FAF", "How often do you have physical activities?", choices = c("I don't", "1 or 2 days", "2 or 4 days", "4 or 5 days")),
                 selectInput("TUE", "How much time do you use on devices?", choices = c("0-2 hours", "3-5 hours", "More than 5 hours")),
                 selectInput("MTRANS", "Which transportation do you usually use?", choices = c("Automobile", "Motorbike", "Bike", "Public Transportation", "Walking")),
                 actionButton("predict", "Predict")
        )
      ),
      
    ),
    mainPanel(
      width = 5,
      tags$label(h3("Prediction Output")),
      textOutput("contents"),
      tableOutput("tabledata")
    )
  )
)



# Define the server function
server <- function(input, output, session) {
  observeEvent(input$next1, {
    updateTabsetPanel(session, "tabs", selected = "Health History")
  })
  observeEvent(input$next2, {
    updateTabsetPanel(session, "tabs", selected = "Dietary Habits")
  })
  observeEvent(input$next3, {
    updateTabsetPanel(session, "tabs", selected = "Lifestyle")
  })
  
  # Reactive function to perform prediction
  datasetInput <- reactive({
    # Create a data frame for prediction with all inputs
    test <- data.frame(
      Age = input$age + input$years,
      Height = input$height,
      Weight = input$weight,
      Gender = input$gender,
      family_history_with_overweight = input$family_history_with_overweight,
      FAVC = input$FAVC,
      FCVC = input$FCVC,
      NCP = input$NCP,
      SMOKE = input$SMOKE,
      FAF = input$FAF,
      SCC = input$SCC,
      CH2O = input$CH2O,
      TUE = input$TUE,
      CALC = input$CALC,
      MTRANS = input$MTRANS
    )
    
    # Perform prediction
    Prediction <- predict(model, test)
    
    # Calculate probabilities or other metrics as needed
    Probability <- predict(model, test, type = "response")
    
    # Create a data frame to display results
    Output <- data.frame(
      Prediction = Prediction,
      Probability = Probability,
      Age = input$age + input$years
    )
    return(Output)
  })
  
  # Display a message when the prediction button is clicked
  output$contents <- renderPrint({
    if (input$predict > 0) {
      "Calculation Completed"
    } else {
      "Our model is ready to predict"
    }
  })
  
  # Display the prediction results in a table
  output$tabledata <- renderTable({
    if (input$predict > 0) {
      datasetInput() 
    }
  })
}

# Create the shiny app
shinyApp(ui = ui, server = server)
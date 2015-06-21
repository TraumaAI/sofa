
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Sofa Score"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(position = "right",
    sidebarPanel(
      selectInput("respiratory", label = h4("PaO2 / FiO2 (mmHg)"), 
                  choices = list(">= 400" = 0, "300 - 399" = 1, "200 - 299" = 2, "100 - 199" = 3, "< 99" = 4), 
                  selected = 0),
      radioButtons("ventilator", label = h4("Mechanical Ventilation"),
                   choices = list("No" = 0, "Yes" = 1), 
                   selected = 0,
                   inline = TRUE),
      selectInput("neuro", label = h4("Glasgow Comma Scale"), 
                  choices = list("15" = 0, "13-14" = 1, "10-12" = 2, "6-9" = 3, "<6" = 4), 
                  selected = 0),
      selectInput("cv", label = h4("Mean Arterial Pressue", "Vasopressors (mcg/kg/min)"), 
                  choices = list("MAP > 70" = 0, "MAP <= 70" = 1, "Dopamine <= 5" = 2, "Dopamine > 5 OR Epinephrine/Norepinephrine <= 0.1" = 3, "Dopamine > 15 OR Epinephrine/Norepinephrine > 0.1" = 4), 
                  selected = 0),
      selectInput("liver", label = h4("Bilirubin"), 
                  choices = list("<= 1.1" = 0, "1.2 - 1.9" = 1, "2.0 - 5.9" = 2, "6.0 - 11.9" = 3, ">= 12" = 4), 
                  selected = 0),
      selectInput("coag", label = h4("Platelets"), 
                  choices = list(">= 150" = 0, "100 - 149" = 1, "50 - 99" = 2, "20-49" = 3, "<= 19" = 4), 
                  selected = 0),
      selectInput("renal", label = h4("Creatinine"), 
                  choices = list("<=1.1" = 0, "1.2-1.9" = 1, "2.0-3.4" = 2, "3.5-4.9" = 3, ">= 5.0" = 4), 
                  selected = 0),
      radioButtons("uop", label = h4("Urine Output (ml/day)"),
                   choices = list("> 500 " = 0, "200 - 500" = 1, "< 200" = 2), 
                   selected = 0,
                   inline = TRUE)
      
      # actionButton("goButton", "Go!")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      p("The Sequential Organ Failure Assessment (SOFA) is a morbidity severity score and mortality estimation tool.  The parameters found on the right are physiologic variables used to calcute the score.  Essentially, one uses the worst score of a parameter in a 24 hour period."),
      p("Normal physiologic parameters already pre-selected. The rank order is best to worst on the drop down lists and left to right on the radio button selections"),
      hr(),
      fluidRow(column(4, "PaO2/FiO2 ratio:" ), 
               column(4, "Ventilated:"),
               column(4, "Glasgow Comma:")
               ),
      fluidRow(column(4, verbatimTextOutput("resp_value")),
               column(4, verbatimTextOutput("vent_value")),
               column(4, verbatimTextOutput("neuro_value"))
               ),
      fluidRow(column(4, "MAP & Pressors:" ), 
               column(4, "Bilirubin:"),
               column(4, "Platelets:")
      ),
      fluidRow(column(4, verbatimTextOutput("cv_value")),
               column(4, verbatimTextOutput("liver_value")),
               column(4, verbatimTextOutput("coag_value"))
      ),
      fluidRow(column(4, "Creatinine:" ), 
               column(4, "Urine Output:")
      ),
      fluidRow(column(4, verbatimTextOutput("renal_value")),
               column(4, verbatimTextOutput("uop_value"))
      ),
      hr(),
      h4("SOFA Score: "),
      h4(uiOutput("sofa_value")),
      hr(),
      h4("General Interpretation of SOFA Score:"),
      p("Each organ is graded from 0 (normal) to 4 (the most abnormal), providing a daily score of 0 to 24 points. Sequential assessment of organ dysfunction during the first few days of ICU admission is a good indicator of prognosis. Both the mean and highest SOFA scores are particularly useful predictors of outcome. Independent of the initial score, an increase in SOFA score during the first 48 hours in the ICU predicts a mortality rate of at least 50%"),
      hr(),
      fluidRow(column(3, h5("Maximum", br("SOFA Score")) ), 
               column(3, h5("Hospital", br("Mortality")))),
      fluidRow(column(3, "0 - 6" ), 
               column(3, "< 10%")),
      fluidRow(column(3, "7 - 9" ), 
               column(3, "15% - 20%")),
      fluidRow(column(3, "10 - 12" ), 
               column(3, "40% - 60%")),
      fluidRow(column(3, "13 - 14" ), 
               column(3, "50% - 60%")),
      fluidRow(column(3, "15" ), 
               column(3, "> 80%")),
      fluidRow(column(3, "> 15" ), 
               column(3, "> 90%")),
      fluidRow(column(3, h5("Score Trend", br("Initial 48 hrs"))), 
               column(3, h5("Hospital", br("Mortality")))),
      fluidRow(column(3, "Increasing" ), 
               column(3, "> 50%")),
      fluidRow(column(3, "Unchanged" ), 
               column(3, "27% - 35%")),
      fluidRow(column(3, "Deacreasing" ), 
               column(3, "< 27%")),
      hr(),
      h5("References"),
      p("Vincent JL, de Mendonça A, Cantraine F, et al. Use of the SOFA score to assess the incidence of organ dysfunction/failure in intensive care units: results of a multicenter, prospective study. Working group on \"sepsis-related problems\" of the European Society of Intensive Care Medicine. Crit Care Med. 1998;26(11):1793-800."),
      p("Ferreira FL, Bota DP, Bross A, et al. Serial evaluation of the SOFA score to predict outcome in critically ill patients. JAMA. 2001;286(14):1754-8."),
      p("Clinical Calculators. http://clincalc.com/IcuMortality/SOFA.aspx")
    )
  )
))

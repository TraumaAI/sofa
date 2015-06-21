
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

resp_list <- c(">= 400", "300-399", "200-299", "100-199", "<= 99")
vent_list <- c("No", "Yes")
gcs_list <- c("15", "13-14", "10-12", "6-9", "< 6")
cv_list <- c("MAP > 70", "MAP <= 70", "Dopamine <= 5", "Dopamine > 5, Epinephrine/Norepinephrine <= 0.1", "Dopamine > 15, Epinephrine/Norepinephrine > 0.1")
liver_list <- c("<= 1.1", "1.2 - 1.9", "2.0 - 5.9", "6.0 - 11.9", ">= 12")
coag_list <- c(">= 150", "100 - 149", "50 - 99", "20-49", "<= 19")
renal_list <- c("<=1.1", "1.2-1.9", "2.0-3.4", "3.5-4.9", ">= 5.0")
uop_list <- c("> 500", "200 - 500", "< 200")

shinyServer(function(input, output) {

  output$resp_value <- renderPrint({ 
          if (input$respiratory == 0) return(resp_list[1])
          if (input$respiratory == 1) return(resp_list[2])
          if (input$respiratory == 2) return(resp_list[3])
          if (input$respiratory == 3) return(resp_list[4])
          if (input$respiratory == 4) return(resp_list[5])
          })
  output$vent_value <-renderPrint({
          if (input$ventilator == 0) return(vent_list[1])
          if (input$ventilator == 1) return(vent_list[2])
          })
  output$neuro_value <- renderPrint({
          if (input$neuro == 0) return(gcs_list[1])
          if (input$neuro == 1) return(gcs_list[2])
          if (input$neuro == 2) return(gcs_list[3])
          if (input$neuro == 3) return(gcs_list[4])
          if (input$neuro == 4) return(gcs_list[5])
          })
  output$cv_value <- renderPrint({
          if (input$cv == 0) return(cv_list[1])
          if (input$cv == 1) return(cv_list[2])
          if (input$cv == 2) return(cv_list[3])
          if (input$cv == 3) return(cv_list[4])
          if (input$cv == 4) return(cv_list[5])
          })
  output$liver_value <- renderPrint({
          if (input$liver == 0) return(liver_list[1])
          if (input$liver == 1) return(liver_list[2])
          if (input$liver == 2) return(liver_list[3])
          if (input$liver == 3) return(liver_list[4])
          if (input$liver == 4) return(liver_list[5])
          })
  output$coag_value <- renderPrint({
          if (input$coag == 0) return(coag_list[1])
          if (input$coag == 1) return(coag_list[2])
          if (input$coag == 2) return(coag_list[3])
          if (input$coag == 3) return(coag_list[4])
          if (input$coag == 4) return(coag_list[5])
          })
  output$renal_value <- renderPrint({
          if (input$renal == 0) return(renal_list[1])
          if (input$renal == 1) return(renal_list[2])
          if (input$renal == 2) return(renal_list[3])
          if (input$renal == 3) return(renal_list[4])
          if (input$renal == 4) return(renal_list[5])
          })
  output$uop_value <-renderPrint({
          input$uop
          if (input$uop == 0) return(uop_list[1])
          if (input$uop == 1) return(uop_list[2])
          if (input$uop == 2) return(uop_list[3])
          })
  s <- function(r, v, n, cv, l, cg, cr, up) {
          sofa = 0
          if (as.integer(r) <= 2){
                  sofa = sofa + as.integer(r)
          } else { 
                  if (as.integer(v) == 1){
                          sofa = sofa + as.integer(r)
                  }else{
                        sofa = sofa + 2
                  }
          }
          
          sofa = sofa + as.integer(n) + as.integer(cv) + as.integer(l) + as.integer(cg)
          
          if (as.integer(up) >= 1){
                  if ((as.integer(up) + 2) >= as.integer(cr)){
                          sofa = sofa + as.integer(up) + 2
                  }else{sofa = sofa + as.integer(cr)}
          }else{sofa = sofa + as.integer(cr)}
  }
 
output$sofa_value <- renderText({s(input$respiratory, input$ventilator, input$neuro, input$cv, input$liver, input$coag, input$renal, input$uop)})

})

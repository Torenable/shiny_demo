#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui = navbarPage('Demo Charts',
	tabPanel(title = 'Scatter Plot',
		plotly::plotlyOutput('earning_gaps'),
		hr(),
		fluidRow(
			column(4,
				h4("Diamonds Explorer"),
      			sliderInput('bubble_scale', 'Scale of bubbles:', 
                	min = 0.1, max = 2, value = 1)
			)
		)
	),
	tabPanel("Pie Chart", plotly::plotlyOutput('expenditures')),
	tabPanel("Multi-level Pie Chart", plotly::plotlyOutput('ball_games')),
	tabPanel("Radar Chart", plotly::plotlyOutput('beer')),
	tabPanel("Sankey Diagram", plotly::plotlyOutput('energy')),
	tabPanel("Pixel Art", plotOutput('pixel_rose'))
)

# Define server side logic
source('R/server.R')

# Run the application 
shinyApp(ui = ui, server = server)

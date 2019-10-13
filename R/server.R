library(dplyr)
library(shiny)
library(plotly)

source('R/plotly.R')
source('R/plot_rose.R')

server = function(input, output) {
	output$earning_gaps = plotly::renderPlotly(plotly_earning_gaps)
	
	output$expenditures = plotly::renderPlotly(plotly_expnditures)
	
	output$ball_games   = plotly::renderPlotly(plotly_ball_games)
	
	output$beer         = plotly::renderPlotly(plotly_beer)
	
	output$energy       = plotly::renderPlotly(plotly_energy)

	output$pixel_rose   = shiny::renderPlot(rose_obj %>% plot.pixel_art(),
		width = 640, height = 720
	)
}
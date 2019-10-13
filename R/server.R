library(dplyr)
library(shiny)
library(plotly)

source('R/plotly.R')

server = function(input, output) {
	output$earning_gaps = plotly::renderPlotly(plotly_earning_gaps)
	
	output$expenditures = plotly::renderPlotly(plotly_expnditures)
	
	output$ball_games   = plotly::renderPlotly(plotly_ball_games)
	
	output$beer         = plotly::renderPlotly(plotly_beer)
	
	output$energy       = plotly::renderPlotly(plotly_energy)
}
library(dplyr)
library(plotly)
# library(readxl)
# library(jsonlite)

# Scatter plot / Bubble
dat_gaps = readxl::read_xlsx('data/data_sets.xlsx', sheet = 'EarningGaps')

plotly_earning_gaps = dat_gaps %>%
	plot_ly(x = ~Women, y = ~Men, type = 'scatter', mode = 'markers', size = ~Gap, color = ~State, colors = 'Paired',
		sizes = c(10, 50),
		marker = list(opacity = 0.5, sizemode = 'diameter'),
		hoverinfo = 'text',
		text = ~paste('School:', School, '<br>Gender Gap:', Gap)) %>%
	layout(
		title = 'Gender Gap in Earnings per University',
		xaxis = list(showgrid = FALSE),
		yaxis = list(showgrid = FALSE),
		showlegend = FALSE
	)


# Pie Chart
dat_expenditures = readxl::read_xlsx('data/data_sets.xlsx', sheet = 'Expenditures')

plotly_expnditures = dat_expenditures %>%
	plot_ly(labels = ~Categorie, values = ~X1960, type = 'pie',
		textposition = 'inside',
		textinfo = 'label+percent',
		insidetextfont = list(color = '#FFFFFF'),
		hoverinfo = 'text',
		text = ~paste('$', X1960, ' billions'),
		marker = list(colors = colors,
					  line = list(color = '#FFFFFF', width = 1)),
					  #The 'pull' attribute can also be used to create space between the sectors
		showlegend = FALSE) %>%
	layout(
		title = 'United States Personal Expenditures by Categories in 1960',
		xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
		yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
	)


# Sunburst Chart / Multi-level Pie Chart --------------------------------
dat_ballgames = readxl::read_xlsx('data/data_sets.xlsx', sheet = 'BallGames')

plotly_ball_games = dat_ballgames %>%
    plot_ly(ids = ~ids, labels = ~labels, parents = ~parents, type = 'sunburst') %>%
    layout(title = 'Ball Games in Continents')


# Radar Chart -----------------------------------------------------------
dat_beer = readxl::read_xlsx('data/data_sets.xlsx', sheet = 'Beer')

plotly_beer = plot_ly(
	type = 'scatterpolar',
	mode = 'lines',
	fill = 'toself'
) %>%
	add_trace(
		r = dat_beer$A
		, theta = dat_beer$Features
		, name = 'Brand A'
	) %>%
	add_trace(
		r = dat_beer$B
		, theta = dat_beer$Features
		, name = 'Brand B'
	) %>%
	layout(
		title = "Beer Comparison between Brand A & B",
		polar = list(
			radialaxis = list(
				visible = T
			)
		)
	)


# Sankey Diagram ---------------------------------------------------------
# dat_energy = 'https://raw.githubusercontent.com/plotly/plotly.js/master/test/image/mocks/sankey_energy.json' %>%
# 	jsonlite::read_json()

# nodes = list(
# 	label = dat_energy$data[[1]]$node$label
# 	, color  = dat_energy$data[[1]]$node$color
# 	, pad = 15
# 	, thickness = 15
# 	, line = list(
# 		color = 'black'
# 		, width = 0.5
# 	)
# )
# links = list(
# 	source = dat_energy$data[[1]]$link$source
# 	, target = dat_energy$data[[1]]$link$target
# 	, value = dat_energy$data[[1]]$link$value
# 	, label = dat_energy$data[[1]]$link$label
# )
# save(dat_energy, nodes, links, file = 'data/dat_energy.RData')

load(file = 'data/dat_energy.RData')
plotly_energy = plot_ly(
	type = "sankey",
	domain = list(
		x =  c(0, 1),
		y =  c(0, 1)
	),
	orientation = "h",
	valueformat = ".0f",
	valuesuffix = "TWh",
	node = nodes,
	link = links
) %>%
	layout(
		title = "Energy forecast for 2050",
		font = list(
			size = 10
		),
		xaxis = list(showgrid = F, zeroline = F),
		yaxis = list(showgrid = F, zeroline = F)
	)

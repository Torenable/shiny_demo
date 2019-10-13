library(dplyr)
# library(tidyxl)

# Functions ---------------------------------
read.pixel_art = function(file, sheet = 1) {
	dat_obj = tidyxl::xlsx_cells(file, sheets = 1)

	# Prepare the data
	art_shape = c(nrow = max(dat_obj$row), ncol = max(dat_obj$col))
	art_mx = matrix(NA, nrow = art_shape['nrow'], ncol = art_shape['ncol'])

	tibble(
	    r = dat_obj$row
	    , c = dat_obj$col
	    , v = dat_obj$local_format_id # 2: black; 3: red; 4: green
	) %>%
	    # apply(1, function(x) invisible(gf[x['r'], x['c']] <<- x['v']))
	    apply(1, function(x) invisible(art_mx[art_shape['nrow'] - x['r'], x['c']] <<- x['v'])) # flipped

	# Prepare the color
	fmt = tidyxl::xlsx_formats(file)
	rgb = fmt$local$fill$patternFill$fgColor$rgb[dat_obj$local_format_id %>% unique()] %>%
	    stringr::str_replace(pattern = '^FF', '#')

	# Return the art
	list(
		data = art_mx
		, color = rgb
	)
}

plot.pixel_art = function(obj) {
	obj$data %>% t() %>% image(col = obj$color)
}


# # Plotting process -------------------------
fl = 'data/rose.xlsx'
rose_obj = read.pixel_art(file = fl, sheet = 1) 
# rose_obj %>% plot.pixel_art()
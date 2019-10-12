library(dplyr)

fl = 'data/rose.xlsx'
obj = tidyxl::xlsx_cells(fl, sheets = 1)

# Data injection
gf = matrix(NA, nrow = 42, ncol = 26)

tibble(
    r = obj$row
    , c = obj$col
    , v = obj$local_format_id # 2: black; 3: red; 4: green
) %>%
    # head() %>%
    apply(1, function(x) invisible(gf[x['r'], x['c']] <<- x['v']))

saveRDS(gf, file = 'data/rose_mx.RDS')

# Color
obj$local_format_id %>% unique()
fmt = tidyxl::xlsx_formats(fl)
rgb = fmt$local$fill$patternFill$fgColor$rgb[obj$local_format_id %>% unique()] %>%
    stringr::str_replace(pattern = '^FF', '#')

# Plot
rotate <- function(x) t(apply(x, 2, rev))

par_mar_org = par("mar")
par(mar=c(5.1, 15, 4.1, 24.5))
on.exit(expr = par(mar=par_mar_org), add = TRUE)

gf %>% rotate() %>% image(col = rgb)

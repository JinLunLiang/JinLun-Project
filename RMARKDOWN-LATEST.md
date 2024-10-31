RMARKDOWN
================

## GitHub Documents

This is an R Markdown format used for publishing markdown documents to
GitHub. When you click the **Knit** button all R code chunks are run and
a markdown file (.md) suitable for publishing to GitHub is generated.

## Including Code

You can include R code in the document as follows:

``` r
summary(cars)
```

    ##      speed           dist       
    ##  Min.   : 4.0   Min.   :  2.00  
    ##  1st Qu.:12.0   1st Qu.: 26.00  
    ##  Median :15.0   Median : 36.00  
    ##  Mean   :15.4   Mean   : 42.98  
    ##  3rd Qu.:19.0   3rd Qu.: 56.00  
    ##  Max.   :25.0   Max.   :120.00

## Including Plots

You can also embed plots, for example:

![](RMARKDOWN-LATEST_files/figure-gfm/pressure-1.png)<!-- -->

Note that the `echo = FALSE` parameter was added to the code chunk to
prevent printing of the R code that generated the plot.

``` r
# Load necessary libraries
install.packages(c("ggplot2", "reshape2", "ggcorrplot"))
```

    ## Installing packages into 'C:/Users/jinlu/AppData/Local/R/win-library/4.4'
    ## (as 'lib' is unspecified)

    ## package 'ggplot2' successfully unpacked and MD5 sums checked
    ## package 'reshape2' successfully unpacked and MD5 sums checked

    ## Warning: cannot remove prior installation of package 'reshape2'

    ## Warning in file.copy(savedcopy, lib, recursive = TRUE): problem copying
    ## C:\Users\jinlu\AppData\Local\R\win-library\4.4\00LOCK\reshape2\libs\x64\reshape2.dll
    ## to
    ## C:\Users\jinlu\AppData\Local\R\win-library\4.4\reshape2\libs\x64\reshape2.dll:
    ## Permission denied

    ## Warning: restored 'reshape2'

    ## package 'ggcorrplot' successfully unpacked and MD5 sums checked
    ## 
    ## The downloaded binary packages are in
    ##  C:\Users\jinlu\AppData\Local\Temp\RtmpmwrCJ7\downloaded_packages

``` r
library(ggplot2)
library(reshape2)
library(ggcorrplot)

# Load the dataset
walmart_sales <- read.csv("Walmart_Sales.csv")

# Select only the numeric columns needed for correlation
data_numeric <- walmart_sales[, c("Weekly_Sales", "Temperature", "Fuel_Price", "CPI", "Unemployment")]

# Calculate the correlation matrix
cor_matrix <- cor(data_numeric, use = "complete.obs")  # Use "complete.obs" to handle missing values

# Plot the full correlation heatmap
ggcorrplot(cor_matrix, 
            method = "square", 
            type = "full",       # Change to "full" to display the entire matrix
            lab = TRUE, 
            lab_size = 3, 
            title = "Correlation Matrix Heatmap",
            colors = c("blue", "white", "red"),
            outline.color = "black",
            ggtheme = theme_minimal())
```

![](RMARKDOWN-LATEST_files/figure-gfm/project%201-1.png)<!-- -->

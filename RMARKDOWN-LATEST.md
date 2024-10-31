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

## Conclusion

1.**Weekly Sales**

-There is a weak negative correlation between Weekly_Sales and
Unemployment (-0.11), CPI (-0.07) and Temperature (-0.06). These
negative values suggest that as unemployment, CPI or temperature
increases, weekly sales may slightly decrease, though the correlation is
very weak.

-Weekly Sales show a very weak, almost negligible, positive correlation
with Fuel Price(0.01)

2.**Temperature**

-Temperature has a weak positive correlation with CPI (0.18) and
Fuel_Price (0.14), indicating that temperature might slightly rise with
the consumer price index and fuel price.

3.**Fuel Price**

-Fuel_Price has a weak negative correlation with CPI (-0.17), meaning
that as fuel prices increase, there may be a slight decrease in the CPI,
though this relationship is weak.

4.**CPI**

-Moderate negative correlation with Unemployment (-0.3), which shows a
slight tendency for unemployment to rise as CPI decreases, though this
is still a weak relationship.

5.**Unemployment**

-Moderate negative correlation with CPI (-0.3), indicating that when
unemployment is high, CPI tends to be lower, which could reflect general
economic trends.\*\*

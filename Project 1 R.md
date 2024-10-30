---
title: "Porject 1 R"
output: github_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## GitHub Documents

This is an R Markdown format used for publishing markdown documents to GitHub. When you click the **Knit** button all R code chunks are run and a markdown file (.md) suitable for publishing to GitHub is generated.

## Including Code

You can include R code in the document as follows:

```{r cars}
summary(cars)
```

## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

```{r}
install.packages(c("ggplot2", "reshape2", "ggcorrplot"))
library(ggplot2)
library(reshape2)
library(ggcorrplot)

# Load the dataset
walmart_sales <- read.csv("Walmart_Sales.csv")

# Select only the numeric columns needed for correlation
data_numeric <- walmart_sales[, c("Weekly_Sales", "Temperature", "Fuel_Price", "CPI", "Unemployment")]

# Calculate the correlation matrix
cor_matrix <- cor(data_numeric, use = "complete.obs")  # Use "complete.obs" to handle missing values

# Plot the correlation heatmap
plot1 <- ggcorrplot(cor_matrix, 
           method = "square", 
           type = "lower", 
           lab = TRUE, 
           lab_size = 3, 
           title = "Correlation Matrix Heatmap",
           colors = c("blue", "white", "red"),
           outline.color = "black",
           ggtheme = theme_minimal())

print(plot1)
```
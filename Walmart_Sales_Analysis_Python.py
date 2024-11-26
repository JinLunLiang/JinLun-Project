# Import necessary libraries
import numpy as np 
import pandas as pd 
import seaborn as sns 
import matplotlib.pyplot as plt 

# Load the dataset
df = pd.read_csv('Walmart_Sales.csv')
print(df.head())

# Select only the numeric columns needed for correlation
data_numeric = df[["Weekly_Sales", "Temperature", "Fuel_Price", "CPI", "Unemployment"]]

# Calculate the correlation matrix
cor_matrix = data_numeric.corr()

# Plot the full correlation heatmap
plt.figure(figsize=(8, 6))
sns.heatmap(cor_matrix, 
            annot=True,         # Display correlation values
            fmt=".2f",          # Format the correlation values
            cmap="RdBu_r",      # Colors for the heatmap (red to blue)
            linewidths=0.5,     # Add lines between cells
            cbar_kws={"shrink": 0.8})  # Adjust the size of the color bar

# Show the plot
plt.tight_layout()
plt.show()
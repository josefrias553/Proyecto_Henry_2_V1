import pandas as pd

def null_count(df):
    return df.isnull().sum()

def null_percentage(df):
    return (df.isnull().mean() * 100).round(2)

def duplicates_count(df, subset=None):
    return df.duplicated(subset=subset).sum()

def duplicated_rows(df, subset=None):
    return df[df.duplicated(subset=subset, keep=False)]

def iqr_outliers(df, column):
    q1 = df[column].quantile(0.25)
    q3 = df[column].quantile(0.75)
    iqr = q3 - q1
    lower = q1 - 1.5 * iqr
    upper = q3 + 1.5 * iqr
    return df[(df[column] < lower) | (df[column] > upper)]

def negative_values(df, column):
    return df[df[column] < 0]

def invalid_categories(df, column, valid_values):
    return df[~df[column].isin(valid_values)]
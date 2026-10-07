import os
from pathlib import Path
from dotenv import load_dotenv
from google import genai
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import pyodbc

# =========================================================
# Step 0: Security & AI Client Setup
# =========================================================
env_path = Path(__file__).resolve().parent / '.env'
load_dotenv(dotenv_path=env_path)

api_key = os.getenv("GEMINI_API_KEY")
if not api_key:
    print(f"Error: API key not found at path: {env_path}")
else:
    print("API key loaded successfully!")

client = genai.Client(api_key=api_key)

pd.set_option('display.max_columns', None)
pd.set_option('display.width', 1000)

# =========================================================
# Step 1: Data Loading from SQL Server (Single Source of Truth)
# =========================================================
connection_string = (
    'Driver={SQL Server};'
    'Server=TAL\\MSSQLSERVER3;'
    'Database=SuperstoreDB;'
    'Trusted_Connection=yes;'
)

query = """
SELECT 
    [Ship_Mode] AS [Ship Mode],
    [Segment] AS [Segment],
    [Country] AS [Country],
    [City] AS [City],
    [State] AS [State],
    [Postal_Code] AS [Postal Code],
    [Region] AS [Region],
    [Category] AS [Category],
    [Sub_Category] AS [Sub-Category],
    [Sales] AS [Sales],
    [Quantity] AS [Quantity],
    [Discount] AS [Discount],
    [Profit] AS [Profit]
FROM dbo.SampleSuperstoreProject
"""

conn = pyodbc.connect(connection_string)
df = pd.read_sql(query, conn)
conn.close()

df.info()
print("Dataset Shape:", df.shape)

# =========================================================
# Step 2: Data Cleaning & Quality Checks
# =========================================================
duplicates_count = len(df[df.duplicated()])
print(f"Number of duplicate rows: {duplicates_count}")
print("Missing values per column:\n", df.isnull().sum())

# =========================================================
# Step 3: Feature Engineering
# =========================================================
df['Cost'] = df['Sales'] - df['Profit']
df['Original_Price'] = df['Sales'] / (1 - df['Discount'])

# =========================================================
# Step 4: Analytical Anchors
# =========================================================
worst_profits = df.loc[df.groupby('Category')['Profit'].idxmin()]
print("\n--- Worst Profit Records per Category ---")
print(worst_profits[['Category', 'Sub-Category', 'Sales', 'Profit', 'Discount']])

regional_summary = df.groupby(['Region', 'Category']).agg(
    Total_cost=('Cost', 'sum'),
    Total_Discount=('Discount', 'mean'),
    Total_Original_Price=('Original_Price', 'sum'),
    Total_Sales=('Sales', 'sum')
).reset_index()

print("\n--- Regional and Category Summary ---")
print(regional_summary)

# =========================================================
# Step 5: Send Data to AI & Generate Executive Report
# =========================================================
table_text = regional_summary.to_string()

prompt = f"""
You are a senior data analyst. Below is a summary table of sales, costs, and discounts grouped by region and category:

{table_text}

Please analyze the data, identify one region or category where discounts are too high or profitability is suffering, 
and provide two practical business recommendations for management. Write in clear, professional, and concise English.
"""

print("\n--- AI Business Report ---")

try:
    response = client.models.generate_content(
        model='gemini-3.5-flash-lite',
        contents=prompt
    )
    
    if response and response.text:
        print(response.text)
    else:
        print("Received an empty response from the model.")

except Exception as e:
    print(f"Warning: Communication error with the server: {e}")


🤖 AI-Driven Data Analytics Pipeline

A modern, production-grade project showcasing the evolution of the Data Analyst in the AI Era. This project bridges traditional business intelligence with Generative AI through an end-to-end workflow: Advanced T-SQL ➔ Python Data Engineering & Feature Engineering ➔ Automated AI Executive Reporting ➔ Power BI.

By integrating Google's Gemini AI (via the official GenAI SDK) directly into the data pipeline, the system acts as an automated analytics co-pilot—evaluating regional performance, uncovering profit leaks, and generating real-time executive insights.

🌟 The AI-Driven Edge (GenAI Integration)

Unlike traditional static dashboards, this pipeline features an AI Intelligence Layer. Once Python aggregates and processes the transactional data from SQL Server, it dynamically constructs an analytical prompt and feeds the structured summary table straight into Gemini. The AI acts as a Senior Data Analyst, autonomously evaluating discount efficiency, regional margins, and providing executive recommendations.

🏗️ Architecture & Workflow

Data Layer (SQL Server / T-SQL):

Complex data manipulation, CTEs, Window Functions (RANK, PARTITION BY), and custom Stored Procedures (sp_GetPerformanceByCategory).

Analytics & Engineering Layer (Python & Pandas):

Secure connection (pyodbc), data cleaning, quality validation, and advanced Feature Engineering (Cost, Original_Price).

Intelligence Layer (Google GenAI SDK):

Automated transmission of live aggregated DataFrames to Gemini for programmatic executive reporting.

Visualization Layer (Power BI):

Interactive business dashboards for deep-dive exploratory analysis.

🛠️ Tech Stack & Libraries

Database: Microsoft SQL Server, T-SQL (SSMS)

Programming Language: Python 3.x

Core Libraries: pandas, pyodbc, python-dotenv

AI Engine: Google GenAI SDK (google-genai / Gemini)

BI Tool: Power BI Desktop

📁 Project Structure

📦 AI-Driven-Superstore-Pipeline
│
├── 📂 sql/
│   └── superstore_analysis.sql       # Advanced T-SQL queries, CTEs, Window Functions, and Stored Procedures
│
├── 📂 python/
│   └── main.py                       # Python ETL script, Feature Engineering, and automated Gemini AI reporting
│
├── 📂 power_bi/
│   └── superstore_dashboard.pbix     # Interactive Power BI Dashboard
│
└── 📄 README.md                      # Project documentation


🔍 Key Technical Highlights

1. Advanced T-SQL & Stored Procedures

CTEs & Window Functions: Ranking sub-categories by profitability and regional sales performance.

Business Segmentation: Utilizing CASE WHEN logic to evaluate discount tiers and impact on profit margins.

Stored Procedures: Modular, parameter-driven procedures (sp_GetPerformanceByCategory) for clean database architecture.

2. Python & Generative AI Integration

Secure ETL: Environment-based credential management (python-dotenv) and safe connection lifecycles.

Feature Engineering: Deriving true operational costs and pre-discount pricing models.

Automated AI Insights (Code Snippet):

# Dynamic prompt construction from live Pandas aggregations
table_text = regional_summary.to_string()
prompt = f"""
You are a senior data analyst. Below is a summary table grouped by region and category:
{table_text}
Analyze the data, identify profitability bottlenecks, and provide two practical business recommendations.
"""

response = client.models.generate_content(
    model='gemini-3.5-flash-lite',
    contents=prompt
)
print(response.text)


🚀 Getting Started

Prerequisites

Microsoft SQL Server & SSMS

Python 3.8+

Power BI Desktop

Installation & Execution

Clone the repository:

git clone https://github.com/your-username/ai-driven-superstore-pipeline.git
cd ai-driven-superstore-pipeline


Install requirements:

pip install pandas pyodbc python-dotenv google-genai


Configure Environment Variables:
Create a .env file in the root directory:

GEMINI_API_KEY=your_actual_api_key_here


Run the AI Pipeline:

python python/main.py




Tal Druker

LinkedIn Profile

GitHub Portfolio

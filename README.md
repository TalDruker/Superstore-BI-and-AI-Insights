# 🤖 AI-Driven Data Analytics Pipeline

A modern, production-grade project showcasing the evolution of the **Data Analyst in the AI Era**. This project bridges traditional business intelligence with Generative AI through an end-to-end workflow: **Advanced T-SQL ➔ Python Data Engineering & Feature Engineering ➔ Automated AI Executive Reporting ➔ Power BI**.

By integrating **Google's Gemini AI (via the official GenAI SDK)** directly into the data pipeline, the system acts as an automated analytics co-pilot—evaluating regional performance, uncovering profit leaks, and generating real-time executive insights.

---

## 🌟 The AI-Driven Edge (GenAI Integration)

Unlike traditional static dashboards, this pipeline features an **AI Intelligence Layer**. Once Python aggregates and processes the transactional data from SQL Server, it dynamically constructs an analytical prompt and feeds the structured summary table straight into Gemini. The AI acts as a **Senior Data Analyst**, autonomously evaluating discount efficiency, regional margins, and providing executive recommendations.

---

## 🏗️ Architecture & Workflow

1. **Data Layer (SQL Server / T-SQL):** 
   - Complex data manipulation, CTEs, Window Functions (`RANK`, `PARTITION BY`), and custom Stored Procedures (`sp_GetPerformanceByCategory`).
2. **Analytics & Engineering Layer (Python & Pandas):** 
   - Secure connection (`pyodbc`), data cleaning, quality validation, and advanced **Feature Engineering** (`Cost`, `Original_Price`).
3. **Intelligence Layer (Google GenAI SDK):** 
   - Automated transmission of live aggregated DataFrames to Gemini for programmatic executive reporting.
4. **Visualization Layer (Power BI):** 
   - Interactive business dashboards for deep-dive exploratory analysis.

---

## 🛠️ Tech Stack & Libraries

* **Database:** Microsoft SQL Server, T-SQL (SSMS)
* **Programming Language:** Python 3.x
* **Core Libraries:** `pandas`, `pyodbc`, `python-dotenv`
* **AI Engine:** Google GenAI SDK (`google-genai` / Gemini)
* **BI Tool:** Power BI Desktop

---

## 📁 Project Structure

```text
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

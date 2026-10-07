# 🤖 Superstore-BI-and-AI-Insights

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

## 🔍 Component Deep Dive

### 1. The Data Layer (Advanced T-SQL Queries)
The project starts in MS SQL Server, utilizing sophisticated T-SQL logic to transform raw retail transactions into structured, high-value metrics:

* **Query 1: High-Discount Transaction Filtering (`Central` Region)**
  * **Logic:** Filters transactions in the `Central` region where discounts exceeded 50%, grouping by city and sub-category.
  * **Business Value:** Pinpoints the exact geographical and product-level friction points driving profitability leakage.

* **Query 2: Category Performance & Threshold Filtering (`HAVING`)**
  * **Logic:** Aggregates total sales, total profit, and average discounts per product category, filtering strictly for major categories generating over \$200,000 in sales.
  * **Business Value:** Focuses executive attention on high-scale enterprise lines while filtering out low-impact noise.

* **Query 3: Bottom 5 Least Profitable Sub-Categories (CTEs)**
  * **Logic:** Leverages a **Common Table Expression (CTE)** to calculate total profit per sub-category and sorts them ascending using `TOP 5`.
  * **Business Value:** Instantly isolates the most critical loss-making product items.

* **Query 4: Category Profitability Ranking via Window Functions (`RANK & PARTITION BY`)**
  * **Logic:** Employs the `RANK()` window function partitioned by `Category` to rank sub-categories internally based on profitability.
  * **Business Value:** Enables relative performance evaluation of products *within* their specific category ecosystem.

* **Query 5: Regional Sales Ranking for Profitable Products**
  * **Logic:** Filters strictly for profitable items (`Profit > 0`), groups by `Region` and `Sub_Category`, and applies `RANK() OVER (PARTITION BY [Region] ...)` to order local sales performance.
  * **Business Value:** Highlights regional sales champions and territory-specific wins.

* **Query 6: Shipping Mode Margin Analysis & Error Protection**
  * **Logic:** Evaluates sales and profits across different `Ship_Mode` options, calculating precise profit margins with built-in **`NULLIF`** division-by-zero protection.
  * **Business Value:** Identifies the most cost-effective and profitable logistics fulfillment methods.

* **Query 7: Top 5 Most Profitable States**
  * **Logic:** Uses a CTE to aggregate total sales and profits by US State, returning the top 5 highest-performing regions.
  * **Business Value:** Guides geographic expansion and resource allocation.

* **Query 8: Advanced Discount Tier Segmentation & Margin Analysis**
  * **Logic:** Implements a complex `CASE WHEN` conditional statement inside a multi-CTE structure to segment discounts into four tiers (*No discount*, *Little discount*, *Good discount*, *High discount*), calculating total volume, revenue, profit, and margin percentages per tier.
  * **Business Value:** Empirically proves the direct correlation between excessive discounting (`> 0.5`) and bottom-line destruction.

* **Stored Procedure: `sp_GetPerformanceByCategory`**
  * **Logic:** Encapsulates a reusable parameterized procedure accepting a `@CategoryName` input to output sub-category performance metrics sorted by profitability.
  * **Business Value:** Provides a modular, high-performance database interface for downstream analytical pipelines.

---

### 2. The Intelligence & Engineering Layer (Python & Gemini API)
The Python script (`main.py`) acts as the core orchestration and automation engine. To run it properly, all dependencies must be installed from `requirements.txt` and a local `.env` file must be configured:

* **Step 0: Security & Environment Setup**
  - **Dependencies Installation:** Before running the script, ensure all required libraries (`pandas`, `pyodbc`, `google-genai`, `python-dotenv`) are installed via `requirements.txt`:
    ```bash
    pip install -r requirements.txt
    ```
  - **Environment Configuration (`.env`):** Because sensitive credentials and server names are excluded from GitHub via `.gitignore`, create a local `.env` file in the root directory to define your API key and local SQL Server instance:
    ```env
    GEMINI_API_KEY=your_actual_api_key_here
    DB_SERVER=localhost\SQLEXPRESS
    ```
  - The script uses `pathlib` to dynamically resolve paths, loads environment variables securely, and initializes the official Google AI client (`genai.Client`).

* **Step 1: Database Integration & ETL Layer**
  - Establishes a secure connection to the SQL Server instance using `pyodbc` and pulls the full retail transactions table directly into a high-performance `pandas` DataFrame.

* **Step 2 & 3: Data Quality & Advanced Feature Engineering**
  - Audits data hygiene by checking duplicate rows (`df.duplicated()`) and missing values (`df.isnull().sum()`).
  - Computes critical derived analytical features:
    - `Cost` ($\text{Sales} - \text{Profit}$).
    - `Original_Price` (mathematically reverse-engineered: $\frac{\text{Sales}}{1 - \text{Discount}}$).

* **Step 4 & 5: Analytics & AI Co-Pilot Integration**
  - Identifies top loss-making records per category and compiles an aggregated regional summary table grouped by `Region` and `Category`.
  - Automatically formats the summary table into text and embeds it into a dynamic prompt. Using the official `google-genai` SDK (`gemini-3.5-flash-lite`), it transmits the data to Google Gemini acting as a **Senior Data Analyst** to generate automated executive business recommendations.

* **How to Run and Test Locally:**
  Once dependencies are installed and the `.env` file is configured, execute the script in your terminal:
  ```bash
  python main.py
  ---
  ### 3. The Visualization Layer (Power BI Dashboard)
* **Executive Summary:** Focuses on high-level macro KPIs (`Total Sales`, `Total Profit`, `Average Discount`) and regional tracking for a fast, top-down snapshot of business health.
* **Deep Dive Page:** Features dynamic cross-filtering (`Segment` and `Region` slicers), a geographic map with conditional formatting (highlighting profit zones vs. loss zones), and granular city-level breakdown charts.

---

## 📸 Dashboard Preview

### Executive Summary View
![Executive Summary](https://raw.githubusercontent.com/TalDruker/Superstore-BI-and-AI-Insights/main/asstes/Executive%20Summary.png)
---
### Deep Dive & Profitability Analysis View
![Deep Dive](https://raw.githubusercontent.com/TalDruker/Superstore-BI-and-AI-Insights/main/asstes/Deep%20Dive.png)
---
## 🛠️ Tech Stack & Libraries

* **Database:** Microsoft SQL Server, T-SQL (SSMS)
* **Programming Language:** Python 3.x
* **Core Libraries:** `pandas`, `pyodbc`, `python-dotenv`, `google-genai`
* **AI Engine:** Google Gemini AI SDK
* **BI Tool:** Power BI Desktop
---
### SQL Script
The advanced T-SQL queries and stored procedures used for data transformation and analysis are available in the repository file:
* [SampleSuperstoreQuery.sql](https://github.com/TalDruker/Superstore-BI-and-AI-Insights/blob/main/SampleSuperstoreQuery.sql)

---

### Pipeline & ETL Code & Security
The core logic for database connectivity, data cleaning, feature engineering, and Google Gemini AI integration, along with configuration and security templates, is available in the repository files:
* [main.py](https://github.com/TalDruker/Superstore-BI-and-AI-Insights/blob/main/main.py)
* [requirements.txt](https://github.com/TalDruker/Superstore-BI-and-AI-Insights/blob/main/requirements.txt) *(required Python dependencies)*
* [.gitignore](https://github.com/TalDruker/Superstore-BI-and-AI-Insights/blob/main/.gitignore) *(repository security rules)*
* [.envExample](https://github.com/TalDruker/Superstore-BI-and-AI-Insights/blob/main/.envExample) *(environment variables template)*

---

### How to View the Project
1. Click [SampleSuperstoreProject.pbix](https://github.com/TalDruker/Superstore-BI-and-AI-Insights/blob/main/SampleSuperstoreProject.pbix) to download the Power BI dashboard directly to your computer.
2. Open the downloaded file using Power BI Desktop to explore the interactive executive reports.



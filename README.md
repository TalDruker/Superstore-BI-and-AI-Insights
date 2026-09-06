# 📊 Autonomous Data Analyst Agent CLI

>  **Status: In Active Development (WIP) 🚧**  
> This project is currently undergoing active development, implementing autonomous agentic architectures (Agentic AI) for enterprise data analytics.

---

### 📌 Overview
An autonomous Command Line Interface (CLI) agent powered by the Google Gemini API. The system automates end-to-end exploratory data analysis (EDA), translates natural language business queries into executable SQL, calculates descriptive statistics, and generates visualization reports directly from the terminal.

---

### 🛠️ Tech Stack
* **Primary Language:** Python
* **LLM Engine:** Google Gemini API (`gemini-3.6-flash`)
* **CLI & UI:** Typer, Rich
* **Data Processing & Analytics:** Pandas, NumPy
* **Database & Query Layer:** SQLite / SQLAlchemy

---

### 🗺️ Project Milestones & Progress
- [x] **Project Scaffolding:** Virtual environment setup, dependency management, and environment secrets configuration.
- [x] **API Connectivity:** Established initial handshake and verified baseline communication with Gemini API.
- [x] **Dataset Acquisition:** Integrated the benchmark *Sample - Superstore* dataset for development and testing.
- [ ] **Core Agent Architecture (In Progress):** Implementing the ReAct loop (Reasoning + Action) and tool-calling execution engine.
- [ ] **SQL Tooling & Schema Inspection:** Automated schema discovery and safe read-only SQL execution.
- [ ] **Human-in-the-Loop Safeguards:** Destructive operation guards requiring interactive user confirmation.
- [ ] **Automated Reporting:** Visual chart generation and executive summary report generation.

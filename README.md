# CloudMetrics B2B SaaS Churn Analysis

## 📌 Project Overview

CloudMetrics is a B2B SaaS analytics company experiencing a slowdown in revenue growth despite steady new customer signups.

This project analyzes customer, subscription, product usage, and support-ticket data to understand:

- Why customers are churning
- Which customer groups have higher churn
- Whether product usage is related to churn
- How customer engagement changes over time
- Whether support satisfaction is associated with churn
- Which customer segments may require attention
- The potential revenue impact of customer churn

The project follows a complete data analytics workflow from raw data loading and cleaning through statistical analysis, visualization, segmentation, SQL analysis, Power BI reporting, and executive recommendations.

---

## 🎯 Business Objective

The primary objective is to identify patterns associated with customer churn and provide actionable insights that can help CloudMetrics improve customer retention and protect recurring revenue.

### Key Business Questions

1. What is the overall customer churn rate?
2. How does churn change over time?
3. Do churned customers show lower product usage?
4. Which industries, plans, or acquisition channels have higher churn?
5. Is customer support satisfaction related to churn?
6. Which customer behaviors are associated with higher churn risk?
7. Which customer segments require additional attention?
8. What revenue is potentially at risk because of churn?

---

## 📊 Datasets

The project uses four datasets collected from different internal systems.

### 1. Customers

Contains customer profile and acquisition information.

Main columns:

- CustomerID
- CompanyName
- Industry
- Country
- City
- EmployeeCount
- SignupDate
- AcquisitionChannel

### 2. Subscriptions

Contains subscription and revenue information.

Main columns:

- SubscriptionID
- CustomerID
- PlanName
- BillingTerm
- Seats
- MRR
- StartDate
- EndDate
- Status

### 3. Usage

Contains product engagement information.

Main columns:

- CustomerID
- SubscriptionID
- Month
- Logins
- ActiveUsers
- FeatureUsed
- APICalls
- SessionMinutes

### 4. Support Tickets

Contains customer support information.

Main columns:

- TicketID
- CustomerID
- OpenedDate
- Category
- Priority
- ResolutionHours
- SatisfactionScore

---

## 🛠️ Tools & Technologies

- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Scikit-learn
- SQL Server
- Excel
- Power BI
- Jupyter Notebook
- Git
- GitHub

---

# 🔄 Project Workflow

## Module 1 — Data Loading & Validation

- Loaded all four CSV datasets.
- Created reusable CSV loading functionality.
- Added exception handling.
- Validated:
  - Dataset shape
  - Column names
  - Data types
  - Missing values
- Verified the structure before further processing.

---

## Module 2 — Data Cleaning

Performed a detailed data-quality audit across all datasets.

### Cleaning activities included:

- Missing-value analysis
- Duplicate detection
- Data-type validation
- Text standardization
- Referential integrity checks
- Business-key validation
- Cleaning documentation

An important issue identified during the audit was **18 exact duplicate rows in the Usage dataset**.

The duplicate records were investigated and removed.

After cleaning, the duplicate count was rechecked to confirm that the issue had been resolved.

A Data Cleaning Log was maintained to document:

- Issue
- Rows affected
- Action taken
- Reason for the action

---

## Module 3 — Statistics & Numerical Analysis

Performed customer-level numerical analysis using Pandas and NumPy.

### Analysis included:

- Mean
- Median
- Standard deviation
- Minimum
- Maximum
- Percentiles
- MRR normalization
- Customer-level aggregation
- Rule-based customer flags

Subscription and usage data were aggregated using `CustomerID` to avoid treating multiple records belonging to the same customer as separate customers.

---

## Module 4 — Pandas Wrangling & EDA

Created a customer-level analytical dataset by combining information from the four source tables.

### Analysis included:

- GroupBy analysis
- Multiple aggregations
- Pivot tables
- Customer-level metrics
- Tenure calculation
- Revenue per seat
- Tickets per month
- Usage trend
- IQR-based outlier detection
- Correlation analysis

Transactional tables were aggregated before merging to prevent row multiplication and incorrect revenue or usage calculations.

A left join from the customer master was used to retain the customer population.

---

## Module 5 — Statistical Analysis

Performed statistical analysis to investigate churn-related hypotheses.

### Analysis included:

- Descriptive statistics
- Population mean calculation
- Random sample selection
- Sample mean comparison
- Churned vs retained customer comparison
- Hypothesis testing
- P-value interpretation

One of the key hypotheses investigated was whether churned customers had significantly lower login activity than retained customers.

Statistical significance was interpreted carefully, with the distinction between statistical association and causation maintained.

---

## Module 6 — Cohort & Retention Analysis

Analyzed customer retention and churn behavior over time.

### Analysis included:

- Cohort analysis
- Retention rates
- Churn month
- Churn trend
- Retention curve
- Segment-level churn analysis

The analysis helped identify periods and customer groups where retention changed significantly.

---

## Module 7 — Data Visualization

Created visualizations to communicate the major findings.

At least seven charts were produced:

1. Churn trend over time
2. Retention curve
3. Churn by segment
4. Usage distribution
5. Usage vs churn relationship
6. Ticket satisfaction impact
7. Correlation heatmap

Each visualization includes:

- Clear title
- Axis labels
- Relevant metrics
- One-line business insight

---

## Module 8 — Customer Segmentation

Performed customer segmentation using K-Means clustering.

### Process:

1. Created customer-level behavioral features.
2. Handled missing values.
3. Scaled numerical features.
4. Used the Elbow Method to evaluate different values of K.
5. Applied K-Means clustering.
6. Interpreted clusters based on customer behavior.

Clusters were described using behavioral characteristics rather than arbitrary labels.

---

## Module 9 — Churn Risk Analysis

Created a customer risk framework using multiple behavioral indicators.

The analysis considered factors such as:

- Product usage
- Customer engagement
- Revenue
- Support activity
- Other customer-level indicators

A Risk Score was created to help identify customers requiring further investigation.

---

## Module 10 — SQL Analysis

Performed SQL-based analysis using SQL Server.

SQL analysis included:

- Customer analysis
- Subscription analysis
- Revenue analysis
- Churn analysis
- Usage analysis
- Support-ticket analysis
- Referential integrity checks
- Orphan-record checks

---

## Module 11 — Excel Analysis

Created an Excel-based KPI analysis.

Key metrics included:

- Total MRR
- Churn Rate
- Average Revenue per Account
- Average Tenure

Excel was used as an additional validation and reporting layer.

---

## Module 12 — Power BI Dashboard

Created a one-page Power BI dashboard using a structured data model.

### Dashboard components included:

- KPI cards
- Churn analysis
- Revenue metrics
- Usage analysis
- Customer segmentation
- Multiple visualizations
- Interactive slicers
- DAX measures

The Power BI results were cross-checked against the Python analysis to validate the reported metrics.

---

## Module 13 — Executive Summary

Created a one-page leadership summary focused on business findings rather than technical implementation.

The executive summary includes:

- Major churn findings
- Key customer behavior patterns
- Supporting figures
- Business implications
- Recommended actions
- Estimated revenue at stake

---

# 📈 Key Findings

The analysis identified several important patterns.

### Customer Churn

Subscription status analysis showed:

- Active customers: **301**
- Churned customers: **126**
- Paused customers: **10**

### Product Usage

Churned customers showed lower average product engagement than active customers.

For example:

| Metric | Active | Churned |
|---|---:|---:|
| Average Logins | 11.18 | 7.21 |
| Average Active Users | 6.20 | 3.84 |
| Average Session Minutes | 253.63 | 161.67 |

Statistical testing showed strong evidence of differences in these usage metrics between the groups.

These results indicate an association between lower product engagement and churn; they should not be interpreted as proof that lower usage itself causes churn.

### Industry Churn

The analysis identified churn counts across industries, including:

- Logistics
- Finance
- Manufacturing
- Retail
- Healthcare
- Media
- Education

These differences were further examined as part of the segmentation and churn analysis.

### Usage Relationships

A strong positive relationship was observed between:

- Logins and Active Users

The correlation was approximately **0.88**.

This indicates that customers with more active users generally also had more login activity.

Correlation represents association and does not establish causation.


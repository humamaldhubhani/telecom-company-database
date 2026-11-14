<div align="center">

<img src="docs/logo.svg" alt="Telecom Company Database logo" width="130"/>

# Telecom Company Database

**A complete database design for a telecommunications company: requirements, ER model and Oracle schema.**

![Oracle](https://img.shields.io/badge/Oracle-SQL-F80000?logo=oracle&logoColor=white)
![Course](https://img.shields.io/badge/Course-Database%20Systems-1E9C91)
![Year](https://img.shields.io/badge/Year-2-FFB347)
![Entities](https://img.shields.io/badge/Entities-21-3DD6C6)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

</div>

---

## Overview

This is the final project for the **Database Systems** course (2nd year, Cyber Security, Ar-Rasheed University). It isn't an application. It's the **design work that comes before one**:

1. Gather the business requirements of a telecom operator.
2. Model them as an **Enhanced ER diagram**, with entities, relationships, cardinalities and specialization.
3. Map the ER model to a **relational schema** and implement it in **Oracle SQL**.

## The business domain

The company sells **services and subscriptions** to **customers** through **branches**, runs a **network** of nodes and equipment, buys hardware from **vendors**, and keeps **employees** trained. Customer-facing departments handle **trouble tickets** and **sales leads**.

## ER diagram

![ER diagram](docs/er-diagram.png)

Notable modeling decisions:

| Decision | Why |
|---|---|
| **Customer → VIP / Normal** (disjoint specialization) | VIP customers carry a *commercial guarantee number* and submit invoices and subscriptions differently |
| **Department → Service Center / IT / Sales** (disjoint specialization) | Each department type owns different work: tickets, sales leads, and so on |
| **Employee *supervises* Employee** (recursive 1:M) | Models the management hierarchy without a separate table |
| **Employee ↔ Training** (M:N) | One employee takes many trainings, and each training has many attendees |
| **Customer ↔ Service** (M:N *order*) | Customers order many services, and each service has many customers |

## Relational schema

```mermaid
erDiagram
    VENDOR ||--o{ PURCHASE_ORDER : places
    CUSTOMERS ||--o{ INVOICES : billed
    CUSTOMERS ||--o{ PAYMENTS : makes
    INVOICES ||--o{ PAYMENTS : "paid by"
    SERVICES ||--o{ PAYMENTS : "for"
    NETWORK_NODE ||--o{ NETWORK_EQUIPMENTS : contains
    BRANCH ||--o{ EMPLOYEES : employs
    DEPARTMENT ||--o{ EMPLOYEES : has
    CUSTOMERS ||--o{ TROUBLE_TICKET : opens
    CUSTOMERS ||--o{ SALES_LEAD : "becomes"
    CUSTOMERS ||--o| VIP_CUSTOMERS : "is"

    VENDOR {
        number vendor_id PK
        varchar2 Name
        varchar2 Email
    }
    PURCHASE_ORDER {
        number Order_ID PK
        number vendor_id FK
        number Total_Amount
        date purchase_date
    }
    CUSTOMERS {
        number customer_id PK
        varchar2 full_name
        number phone_number UK
    }
    SERVICES {
        number Service_ID PK
        varchar Service_Name
        number Price
        number Validity_days
    }
    INVOICES {
        number Invoice_ID PK
        date release_Date
        number Amount
        number customer_id FK
    }
    PAYMENTS {
        number Payment_ID PK
        varchar2 Method
        number Amount
    }
    EMPLOYEES {
        number Employee_ID PK
        varchar2 first_name
        number salary
    }
```

The full DDL is in [`sql/schema.sql`](sql/schema.sql) and has 16 tables.

## Repository contents

```text
telecom-company-database/
├── sql/
│   └── schema.sql                          # Oracle DDL: tables, PKs, FKs, constraints
└── docs/
    ├── requirements.pdf                    # the assignment brief
    ├── description-ar.docx                 # domain description (Arabic)
    ├── telecom-company-database-project.pdf  # ER diagram (original)
    ├── telecom-company-database-project.docx
    └── er-diagram.png                      # ER diagram rendered for this README
```

## Try it

Run the schema in **Oracle Database XE** (or [Oracle Live SQL](https://livesql.oracle.com/), which is free and runs in the browser):

```sql
@sql/schema.sql
```

## What I learned

- Turning vague business sentences into entities, attributes and cardinalities.
- When to use **specialization** instead of a type column.
- Mapping M:N relationships and recursive relationships to tables.
- **Oracle syntax is strict.** Two typos in my original DDL (`date(30)` and a trailing comma) stopped the script from running. They're fixed in a later commit.

### Known gaps (kept as designed)

- `Invoices.Subscription_id` has no foreign key to `Subscription`.
- `Feedback`, `Service Center`, `IT` and `Sales` appear in the ER diagram but were not implemented as tables.

## Author

**Humam Al-Dhubhani** · [GitHub](https://github.com/humamaldhubhani)

<sub>Released under the [MIT License](LICENSE).</sub>

# 💾 DATABASE - PostgreSQL (Supabase)

This directory contains all essential artifacts required to initialize and document the PostgreSQL database hosted on the cloud service, **Supabase**.

The data model is specifically engineered to support a Laboratory Information Management System (LIMS) with a robust university hierarchy and a critical **Many-to-Many (M:M)** relationship between Academic Programs and Laboratories.

---

## 📊 Entity-Relationship (E-R) Model

The database schema consists of **7 primary tables** that define the core hierarchy and the inventory management system.

| File | Description |
| :--- | :--- |
| **`er_diagram.png`** | The visual representation of the seven-table relational model, highlighting all Primary Keys (PKs), Foreign Keys (FKs), and the complex M:M join between Programs and Labs. |

---

## ⚙️ Initialization Script

The `schema.sql` script was executed in the **Supabase SQL Editor** to create the entire database structure.

### File: `schema.sql`

This script contains the Data Definition Language (DDL) commands used to build the schema. The following structural elements and constraints have been implemented:

1.  **Hierarchy Tables (University Structure):**
    * `faculties` (1)
    * `academic_programs` (2)
    * `laboratories` (3)

2.  **Many-to-Many (M:M) Relationship Table:**
    * `program_lab_relationship` (4): This junction table is key to the system's complexity, allowing multiple Programs to utilize multiple Labs.

3.  **Inventory and Context Tables:**
    * `locations` (5): Defines the physical storage location for samples.
    * `research_projects` (6): Provides the research context for each sample.
    * `samples` (7): The central inventory table, linking to both `locations` and `research_projects`.

### Key SQL Constraints and Commands:

* **`SERIAL PRIMARY KEY`**: Used for auto-incrementing, unique identifiers (standard PostgreSQL practice).
* **`REFERENCES ... ON DELETE CASCADE`**: Enforces **referential integrity**. Specifically used in the M:M junction table to automatically clean up relationships when a parent record (Program or Lab) is deleted.
* **`UNIQUE` Constraints**: Ensures data consistency on critical fields like names and location codes.
* **`CREATE INDEX`**: Optimizes read performance (fast `JOIN` operations) on frequently queried Foreign Keys.

---

**Note:** The backend application (Spring Boot) uses the JPA framework to seamlessly map these 7 PostgreSQL tables to Java Entity classes, enabling secure and efficient RESTful API development.

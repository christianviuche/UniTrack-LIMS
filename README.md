# 🧪 UniTrack LIMS: University Laboratory Information Management System

## 📜 Project Overview
**UniTrack LIMS** is a comprehensive **Full-Stack application** designed to centralize and manage scientific resources across an academic institution.

This system provides a structured framework for tracking samples, projects, and inventory based on the university's hierarchical structure, linking **Faculties**, **Academic Programs**, and **Shared Laboratories**.

By managing complex **Many-to-Many relationships** (e.g., one Program utilizes multiple Labs, and one Lab serves multiple Programs), UniTrack LIMS ensures **data integrity** and facilitates advanced querying for resource allocation and scientific research management across the entire university.

---

## 🛠️ Tech Stack (Enterprise-Ready)
| Component | Technology | Rationale |
| :--- | :--- | :--- |
| **Backend API** | **Spring Boot (Java)** | Used for building robust, scalable RESTful APIs and managing complex business logic. |
| **Database** | **Supabase (PostgreSQL)** | Cloud-hosted relational database for high data integrity and modern cloud deployment. |
| **Frontend UI** | **React + Vite** | Standard choice for building fast, scalable, and dynamic user interfaces. |

---

## 📊 Data Model: Advanced Hierarchical Entity-Relationship (7 Tables)

The system is built on a **seven-table relational model** that accurately reflects the university's resource structure and the core inventory management. This design highlights the project's complexity by enforcing a hierarchical structure and managing shared resources through a **Many-to-Many (M:M)** relationship.

### Core Structure:
1.  **FACULTIES (1:M) -> ACADEMIC_PROGRAMS**
2.  **ACADEMIC_PROGRAMS (M:M) <-> LABORATORIES** *(Uses a junction table)*
3.  **LABORATORIES (1:M) -> LOCATIONS (1:M) -> SAMPLES**
4.  **RESEARCH_PROJECTS (1:M) -> SAMPLES**



### Key Entities:

| Entity | Purpose | Engineering Highlight |
| :--- | :--- | :--- |
| **ACADEMIC_PROGRAMS** | Defines the academic entity (e.g., Computer Science Program). | Models the university's organizational structure. |
| **LABORATORIES** | The shared physical resource. | **M:M Relationship** with Programs via a junction table. |
| **SAMPLES** | The core inventory item, linked to its physical storage **LOCATION**. | The focus of the system's core CRUD logic. |

---

## 🚀 Setup and Installation

### A. Database Initialization (Supabase/PostgreSQL)
1.  Create a new project on **Supabase** (or any PostgreSQL hosting service).
2.  In the Supabase SQL Editor, execute the provided database schema creation script (`database/schema.sql`).
3.  Retrieve your database connection URL for use in the Spring Boot application configuration.

### B. Backend API Setup (Spring Boot)
1.  Navigate to the `backend/` directory.
2.  **Configure Environment:** Update the database connection details in `application.properties` (or `application.yml`) using the URL retrieved from Supabase.
3.  Build and run the Spring Boot application:
    ```bash
    # Build the project (e.g., using Maven or Gradle)
    ./mvnw clean install
    # Run the application
    java -jar target/uni-track-lims.jar
    ```

### C. Frontend Application Setup (React + Vite)
1.  Navigate to the `frontend/` directory.
2.  Install dependencies:
    ```bash
    npm install 
    # or yarn install
    ```
3.  Start the development server:
    ```bash
    npm run dev
    # or yarn dev
    ```
The application will be accessible at `http://localhost:5173` (or similar).

---

## 📌 Core API Endpoints

The API is structured to handle all CRUD operations and complex queries requiring multiple joins across the hierarchy.

| Method | Endpoint | Purpose |
| :--- | :--- | :--- |
| `GET` | `/api/v1/samples` | Lists all samples. |
| `POST` | `/api/v1/samples` | Registers a new sample (requires `location_id` and `project_id`). |
| `PUT` | `/api/v1/samples/{id}` | Updates all attributes of a specific sample. |
| `GET` | `/api/v1/programs/{id}/samples` | **Complex Query:** Retrieves all samples accessible by a specific Academic Program (requires traversing the M:M relationship). |
| `DELETE` | `/api/v1/locations/{id}` | Deletes a location and manages cascade/restriction rules. |

---

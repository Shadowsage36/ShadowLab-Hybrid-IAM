# ShadowLab-Hybrid-IAM
A production-ready Hybrid IAM environment featuring automated AD provisioning, Entra ID synchronization, and security hardening
# ShadowLab: Hybrid IAM & Enterprise Identity Architecture

##  Overview
ShadowLab is a "Company-in-a-Box" infrastructure project designed to demonstrate advanced **Identity and Access Management (IAM)**. This project simulates a professional greenfield deployment, bridging on-premises Active Directory with **Microsoft Entra ID** to create a secure, scalable, and automated hybrid identity perimeter.

##  Core Technology Stack
* **Identity:** Windows Server 2022 (Active Directory Domain Services)
* **Cloud:** Microsoft Entra ID (Hybrid Sync via Entra Connect)
* **Automation:** PowerShell (Identity Lifecycle Management)
* **Security:** TLS 1.2 Enforcement, Password Hash Synchronization (PHS)
* **Management:** Azure Arc (Cloud-to-On-Prem visibility)

##  Architectural Design Decisions

### 1. Identity as the Perimeter
Instead of focusing on traditional networking (VLANs/Routing), this project treats **Identity** as the primary security boundary. 
* **Hardened Baseline:** Manually provisioned Windows Server 2022 with **TLS 1.2 enforced** to ensure secure transport for the Entra Connect agent.
* **Attribute Enrichment:** Users were provisioned via PowerShell with full metadata (Department, Manager, Job Title) to support **Attribute-Based Access Control (ABAC)**.

### 2. Automated Lifecycle Management
Leveraging my professional background in **MECM/SCCM and PXE deployment**, I architected the directory to be "deployment-ready":
* **User-Device Affinity:** Designed logic to link primary users to specific machine groups, mimicking a production zero-touch imaging environment.
* **Dynamic Group Membership:** Structured OUs and Security Groups to automatically trigger GPOs and software deployments based on department.

### 3. Hybrid Synchronization & Remediation
* **Security:** Implemented **Password Hash Sync** to enable leaked credential detection in the cloud.
* **Troubleshooting:** Documented and validated remediation paths for **UPN synchronization conflicts**, utilizing "Hard-Match" techniques to resolve identity collisions between AD and Entra ID.

##  Project Contents
* `/Scripts`: PowerShell automation for bulk user/group creation.
* `/Documentation`: Step-by-step logic for Entra ID configuration.
* `/Screenshots`: Evidence of successful Hybrid Sync and Identity verification.

---
*Developed by ShadowSage36 — Focused on modernizing enterprise identity and bridging the gap between legacy infrastructure and the cloud.*

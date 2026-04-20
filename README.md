# 🛡️ ShadowLab: Hybrid Identity & Access Management (IAM)
**An Enterprise-Grade Identity Perimeter bridging On-Premises AD, Okta, and Microsoft Entra ID.**

---

## 🏗️ 01. The Architecture
ShadowLab is a "Company-in-a-Box" project designed to demonstrate advanced **Identity Lifecycle Management**. This project simulates a professional greenfield deployment, treating **Identity as the primary security boundary.**

* **Source of Truth:** Windows Server 2022 (Active Directory DS)
* **Identity Provider (IdP):** Okta (SAML/SSO Integration)
* **Governance Layer:** SailPoint IdentityIQ
* **Cloud Bridge:** Microsoft Entra ID (Hybrid Sync via Entra Connect)

---

## 🔒 02. Security Hardening (GPO Baseline)
A major focus of this project was enforcing a NIST-aligned security posture while navigating platform-specific constraints.

### The "Grey-Box" Challenge & Resolution
During the hardening phase, I encountered the standard Windows limitation where **Account Policies** are non-editable at the Organizational Unit (OU) level. 
* **The Fix:** I modified the **Default Domain Policy** at the root to ensure the Security Accounts Manager (SAM) properly enforced complexity and lockout rules across the entire forest.

### Implemented Policies:
| Setting | Configuration | Logic |
| :--- | :--- | :--- |
| **Min. Password Length** | 12 Characters | Balanced entropy vs. user friction. |
| **Account Lockout** | 5 Attempts / 30 Mins | Mitigation of brute-force dictionary attacks. |
| **Interactive Logons** | Denied for Svc Accts | Preventing lateral movement of privileged credentials. |

---

## ⚙️ 03. Identity Lifecycle Automation
Leveraging **PowerShell**, I automated the "Day 1" provisioning process to ensure data integrity for downstream systems (Okta/SailPoint).

* **Attribute Enrichment:** Users are provisioned with full metadata (Dept, Manager, Title) to support **Attribute-Based Access Control (ABAC)**.
* **UPN Remediation:** Documented "Hard-Match" techniques to resolve identity collisions between local AD and Entra ID.
* **MECM Integration:** Structured OUs to support automated software deployment and User-Device Affinity (UDA).

---

## 🧠 04. Engineering Philosophy
> *"A 14-character password policy is only effective if the user doesn't write it on a sticky note."*

My design assumes the use of **Enterprise Password Managers (EPM)**. By pairing 12-character passwords with **Okta MFA**, ShadowLab achieves a high security posture without overwhelming the Help Desk with password reset tickets.

---

## 📸 05. Evidence & Documentation
* **[Folder: /Screenshots]** - AD structures, GPO results, and Okta Sync proof.
* **[Folder: /Scripts]** - PowerShell automation used for bulk provisioning.
* **[Folder: /Policies]** - Exported GPO reports.

---
**Developed by ShadowSage36** *Modernizing Enterprise Identity from the Ground Up.*

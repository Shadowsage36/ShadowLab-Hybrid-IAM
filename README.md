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

## 🔒 02. Security Hardening & GPO Baselines
A major focus of this project was enforcing a NIST-aligned security posture. Beyond standard configurations, I implemented specific Group Policy Objects (GPOs) to protect the "Tier 0" infrastructure.

### The "Grey-Box" Challenge & Resolution
During the hardening phase, I addressed the standard Windows limitation where **Account Policies** (Password/Lockout) are non-editable at the Organizational Unit (OU) level. 
* **The Fix:** I modified the **Default Domain Policy** at the root to ensure the Security Accounts Manager (SAM) properly enforced complexity and lockout rules globally.

### Security Policy Breakdown:
| Policy Area | Setting | Logic / Defense Strategy |
| :--- | :--- | :--- |
| **Password Complexity** | 12 Characters | Balanced entropy vs. user friction; supports EPM usage. |
| **Account Lockout** | 5 Attempts / 30 Mins | Thwarts automated brute-force and dictionary attacks. |
| **User Rights** | Deny Local Logon | Applied to Service Accounts to prevent credential harvesting. |
| **Audit Policy** | Logon/Logoff Events | Configured success/failure logging for SIEM ingestion. |
| **Lateral Movement** | Restrict RDP Access | Limits administrative surface area to specific jump boxes. |

---

## ⚙️ 03. Identity Lifecycle Automation
Leveraging [PowerShell](Scripts/Provision-ShadowLab.ps1), I automated the "Day 1" provisioning process to ensure data integrity for downstream systems (Okta/SailPoint).

* **Attribute Enrichment:** Users are provisioned with full metadata (Dept, Manager, Title) to support **Attribute-Based Access Control (ABAC)**.
* **UPN Remediation:** Documented "Hard-Match" techniques to resolve identity collisions between local AD and Entra ID.
* **MECM Integration:** Structured OUs to support automated software deployment and User-Device Affinity (UDA).

---

## 🧠 04. Engineering Philosophy
> *"A 14-character password policy is only effective if the user doesn't write it on a sticky note."*

My design assumes the use of **Enterprise Password Managers (EPM)**. By pairing 12-character passwords with **Okta MFA**, ShadowLab achieves a high security posture without overwhelming the Help Desk with password reset tickets.

---

## 📸 05. Evidence & Documentation

### Identity Federation & SSO Dashboard
![Okta SSO Dashboard](Screenshots/Okta%20applications%20SSO.png)
*Figure 1: Okta integration showing SailPoint IIQ and enterprise applications configured for SAML 2.0.*

### SailPoint SAML Configuration
![SailPoint SAML 2.0](Screenshots/Sailpoint%20SAML%202.0.png)
*Figure 2: Federation metadata and ACS configuration for the SailPoint identity governance layer.*

### Troubleshooting: Identity Sync Remediation
![Okta Sync Conflict](Screenshots/Otka%20error.png)
![Okta Sync Resolution](Screenshots/Otka%20user%20fix.png)
*Figure 3 & 4: Demonstrating the identification and resolution of a synchronization mismatch.*

### Active Directory Group Push
![Okta Groups](Screenshots/Otka%20Groups.png)
*Figure 5: Successful mapping of On-Premises Security Groups to Okta Cloud Groups.*

---

**Developed by ShadowSage36** *Modernizing Enterprise Identity from the Ground Up.*

# Software Requirements Specification (SRS)
## IoT Smart Home Controller System (SHCS)

| Field | Details |
|---|---|
| **Version** | 1.0 |
| **Course** | Software Verification & Validation Lab |
| **University** | Lahore Garrison University, Lahore |
| **Semester** | 6th Semester — Spring 2026 |
| **Domain** | IoT Smart Home Controller System (Advanced) |
| **Deadline** | May 15, 2026 |

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [Overall System Description](#2-overall-system-description)
3. [Functional Requirements](#3-functional-requirements)
4. [Non-Functional Requirements](#4-non-functional-requirements)
5. [System States](#5-system-states)
6. [Formal System Invariants](#6-formal-system-invariants)
7. [Requirements Traceability Matrix](#7-requirements-traceability-matrix)
8. [GitHub Issues Tracking Setup](#8-github-issues-tracking-setup)
9. [Conclusion](#9-conclusion)

---

## 1. Introduction

### 1.1 Purpose

This Software Requirements Specification (SRS) formally defines the functional and non-functional requirements for the **IoT Smart Home Controller System (SHCS)**. It serves as the foundational artifact for all subsequent formal verification stages:

- **Z Notation** — state and invariant modeling
- **VDM** — functional specification with pre/postconditions
- **Alloy** — structural relational verification
- **Validation** — checklist derivation and CI pipeline

### 1.2 Scope

The SHCS is a software platform that manages, monitors, and automates IoT devices within a residential smart home environment. It supports:

- User authentication and role-based access control (Admin / Resident / Guest)
- Device registration, activation, and deactivation
- Real-time monitoring of sensor data (temperature, motion, smoke, door lock)
- Automated rule execution based on sensor thresholds and schedules
- Alert generation and notification dispatch
- Energy usage tracking and immutable audit logging

**Out of scope:** Physical device firmware, ISP/network infrastructure, third-party cloud provider APIs.

### 1.3 Definitions, Acronyms & Abbreviations

| Term | Definition |
|---|---|
| **SHCS** | Smart Home Controller System — the system being specified |
| **IoT** | Internet of Things — networked physical devices |
| **FR** | Functional Requirement |
| **NFR** | Non-Functional Requirement |
| **RBAC** | Role-Based Access Control |
| **Admin** | System administrator with full device and user management rights |
| **Resident** | Registered household member with device control permissions |
| **Guest** | Temporary user with read-only or limited device access |
| **Rule Engine** | Component that evaluates automation rules against live sensor data |
| **SRS** | Software Requirements Specification (this document) |
| **SVV** | Software Verification & Validation |
| **MQTT** | Message Queuing Telemetry Transport — IoT communication protocol |

### 1.4 Document Overview

| Section | Content |
|---|---|
| §2 | Overall system description, users, assumptions |
| §3 | Functional requirements (29 FRs across 6 modules) |
| §4 | Non-functional requirements (7 NFRs) |
| §5 | System states (Device, Session, Security, Alert) |
| §6 | Formal invariants (5 invariants in predicate logic) |
| §7 | Requirements traceability matrix |
| §8 | GitHub Issues tracking setup guide |
| §9 | Conclusion |

---

## 2. Overall System Description

### 2.1 Product Perspective

The SHCS operates as a centralized controller within a local home network. It interfaces with heterogeneous IoT devices via standard communication protocols (MQTT, HTTP/REST) and exposes a user interface through a web/mobile dashboard. The system maintains a persistent state model of all registered devices and users.

### 2.2 User Classes and Characteristics

| Role | Frequency of Use | Permissions |
|---|---|---|
| **Admin** | Daily | Register/remove devices and users; configure automation rules; view full audit log; set security policies |
| **Resident** | Multiple times daily | Control assigned devices; view sensor data; create personal automation rules; receive alerts |
| **Guest** | Occasional | View sensor readings only; limited device control only if explicitly granted by Admin |

### 2.3 Assumptions and Dependencies

- Stable local network connectivity is assumed between devices and the SHCS hub.
- All IoT devices implement MQTT or REST communication interfaces.
- The system runs on a dedicated hub device (Raspberry Pi class or above).
- Clock synchronisation (NTP) is maintained for scheduling accuracy.
- No two devices may share the same `deviceID` within the system.

### 2.4 Constraints

- System must operate with low latency (< 500 ms for device command execution).
- All sensitive data (credentials, logs) must be encrypted at rest.
- The system must maintain ≥ 99.5% availability (excluding scheduled maintenance).

---

## 3. Functional Requirements

> Requirements are tagged by module and priority:
> - **P1** = Critical (must have for system correctness)
> - **P2** = High (required for full functionality)
> - **P3** = Medium (enhances usability)

---

### 3.1 User Authentication & Access Control

| Req ID | Priority | Requirement Description |
|---|:---:|---|
| FR-AUTH-01 | P1 | The system shall authenticate users with a unique username and password before granting any access. |
| FR-AUTH-02 | P1 | The system shall enforce role-based access control: Admin, Resident, and Guest roles with distinct, non-overlapping permission sets. |
| FR-AUTH-03 | P1 | The system shall lock a user account after **5 consecutive** failed login attempts. Unlocking requires Admin intervention. |
| FR-AUTH-04 | P2 | The system shall expire user sessions after **30 minutes** of inactivity and require re-authentication. |
| FR-AUTH-05 | P2 | The system shall log every login attempt (success or failure) with a timestamp and IP address. |

---

### 3.2 Device Management

| Req ID | Priority | Requirement Description |
|---|:---:|---|
| FR-DEV-01 | P1 | The system shall allow Admin to register a new IoT device with a unique `deviceID`, type, and location label. |
| FR-DEV-02 | P1 | The system shall reject device registration if the `deviceID` already exists in the system. |
| FR-DEV-03 | P1 | The system shall allow Residents and Admins to toggle device state between `ON` and `OFF`. |
| FR-DEV-04 | P1 | The system shall allow Admin to decommission (permanently remove) a registered device; this must also invalidate all automation rules targeting that device. |
| FR-DEV-05 | P2 | The system shall display real-time device status (`Online`, `Offline`, `Error`) and last heartbeat timestamp. |
| FR-DEV-06 | P2 | The system shall mark a device as `Offline` if no heartbeat is received within a configurable timeout (default: **60 seconds**). |

---

### 3.3 Sensor Monitoring & Data Collection

| Req ID | Priority | Requirement Description |
|---|:---:|---|
| FR-SEN-01 | P1 | The system shall continuously receive and store sensor readings (temperature, motion, smoke level, door state) from all registered devices. |
| FR-SEN-02 | P1 | The system shall reject and log sensor readings that fall outside the valid range defined per sensor type. |
| FR-SEN-03 | P2 | The system shall display the most recent sensor reading for each device on the monitoring dashboard. |
| FR-SEN-04 | P2 | The system shall retain sensor history for a configurable duration (default: **30 days**) and allow historical data export in CSV format. |

---

### 3.4 Automation Rule Engine

| Req ID | Priority | Requirement Description |
|---|:---:|---|
| FR-RULE-01 | P1 | The system shall allow Residents and Admins to define automation rules in the form: `IF <sensor_condition> THEN <device_action>`. |
| FR-RULE-02 | P1 | Each automation rule must reference exactly one valid registered sensor condition and one valid registered device action at creation time. |
| FR-RULE-03 | P1 | The system shall evaluate all enabled rules against incoming sensor data and execute the associated device action when the condition is satisfied. |
| FR-RULE-04 | P2 | The system shall allow enabling and disabling individual rules without deletion. |
| FR-RULE-05 | P2 | The system shall support time-based scheduling: rules may optionally define an active time window (e.g., `22:00–06:00`). |
| FR-RULE-06 | P2 | The system shall reject rule creation if two rules target the same device with contradictory actions under the same triggering condition. |

---

### 3.5 Alert & Notification System

| Req ID | Priority | Requirement Description |
|---|:---:|---|
| FR-ALRT-01 | P1 | The system shall generate a `CRITICAL` alert when a smoke sensor reading exceeds the defined safety threshold. |
| FR-ALRT-02 | P1 | The system shall generate a `SECURITY` alert when motion is detected and the system security mode is `ARMED`. |
| FR-ALRT-03 | P2 | The system shall notify all Admin and Resident users via in-app notification (and optional email) upon any critical alert. |
| FR-ALRT-04 | P2 | The system shall record all generated alerts with: severity, timestamp, triggering sensor ID, and resolution status. |
| FR-ALRT-05 | P3 | Admin shall be able to acknowledge and resolve alerts, transitioning their status from `ACTIVE` to `RESOLVED`. |

---

### 3.6 Audit Logging & Energy Tracking

| Req ID | Priority | Requirement Description |
|---|:---:|---|
| FR-AUD-01 | P1 | The system shall maintain an immutable audit log recording every device state change, user action, and rule execution — with actor identity and timestamp. |
| FR-AUD-02 | P1 | Audit logs must not be deletable by any role, including Admin. Minimum retention period is **90 days**. |
| FR-AUD-03 | P2 | The system shall track cumulative energy consumption per device and generate monthly usage reports. |

---

## 4. Non-Functional Requirements

| Req ID | Category | Requirement Description |
|---|---|---|
| NFR-01 | Performance | Device command execution shall complete within **500 ms** under normal load conditions. |
| NFR-02 | Availability | System uptime shall be **≥ 99.5%** (excluding scheduled maintenance windows). |
| NFR-03 | Security | All network communication shall use **TLS 1.2+**. Passwords shall be hashed with bcrypt (min cost factor 12). |
| NFR-04 | Scalability | The system shall support up to **100 concurrently registered devices** without performance degradation. |
| NFR-05 | Usability | New Resident users shall complete basic device control tasks within **5 minutes** of first login without prior training. |
| NFR-06 | Maintainability | The system shall use a modular architecture allowing Auth, Rule Engine, and Sensor modules to be updated independently. |
| NFR-07 | Reliability | Critical alert generation (smoke, intrusion) shall function **independently** of the automation rule engine to prevent single-point failure. |

---

## 5. System States

> These states form the basis of the Z Notation state schema in Phase 2.

### 5.1 Device States

| State | Description | Transitions To |
|---|---|---|
| `UNREGISTERED` | Device not yet added to the system | → `REGISTERED` |
| `REGISTERED` | Registered by Admin; not yet connected | → `ONLINE`, `DECOMMISSIONED` |
| `ONLINE` | Active, connected, heartbeat received | → `OFFLINE`, `ERROR`, `DECOMMISSIONED` |
| `OFFLINE` | Heartbeat timeout exceeded | → `ONLINE`, `DECOMMISSIONED` |
| `ERROR` | Reports malfunction or out-of-range readings | → `ONLINE`, `DECOMMISSIONED` |
| `DECOMMISSIONED` | Permanently removed. **Terminal state.** | (none) |

### 5.2 User Account & Session States

| State | Applies To | Description |
|---|---|---|
| `ACTIVE` | Session | User is authenticated; session is valid |
| `EXPIRED` | Session | Session ended due to 30-minute inactivity timeout |
| `LOCKED` | Account | Locked after 5 consecutive failed login attempts |

### 5.3 Security Mode States

| State | Description |
|---|---|
| `ARMED` | Security active; motion detection generates `SECURITY` alerts |
| `DISARMED` | Security inactive; motion does not generate alerts |

### 5.4 Alert States

| State | Description |
|---|---|
| `ACTIVE` | Alert generated but not yet acknowledged/resolved |
| `RESOLVED` | Alert acknowledged and resolved by Admin |

---

## 6. Formal System Invariants

> These invariants must hold in **all valid system states**. They are directly used in Z Notation schemas (Phase 2) and Alloy constraints (Phase 4).

---

### INV-1: Device ID Uniqueness

No two registered devices may share the same `deviceID`. The mapping from `deviceID` to device instance is injective.

```
∀ d1, d2 ∈ RegisteredDevices •
    d1 ≠ d2  ⟹  d1.deviceID ≠ d2.deviceID
```

---

### INV-2: Role Integrity

Every user in the system must be assigned **exactly one** role from `{Admin, Resident, Guest}`. No user may exist with no role or multiple roles simultaneously.

```
∀ u ∈ Users •
    u.role ∈ {Admin, Resident, Guest}  ∧  |u.role| = 1
```

---

### INV-3: Session Authenticity

No active session may exist for a user whose account is in a `LOCKED` or `DELETED` state.

```
∀ s ∈ ActiveSessions •
    s.user.state ∉ {LOCKED, DELETED}
```

---

### INV-4: Rule Referential Integrity

Every automation rule must reference a currently registered, non-decommissioned device. Decommissioning a device must invalidate all rules targeting that device.

```
∀ r ∈ AutomationRules •
    r.targetDevice ∈ (RegisteredDevices \ DecommissionedDevices)
```

---

### INV-5: Alert Causality

Every `ACTIVE` alert must have a traceable triggering sensor event. Alerts without a causal event are invalid system states.

```
∀ a ∈ ActiveAlerts •
    ∃ e ∈ SensorEvents • a.cause = e
```

---

## 7. Requirements Traceability Matrix

| Req ID | Z Model | VDM Spec | Alloy | Test Case | GitHub Issue |
|---|:---:|:---:|:---:|:---:|:---:|
| FR-AUTH-01 | Planned | Planned | Planned | Planned | — |
| FR-AUTH-02 | Planned | Planned | Planned | Planned | — |
| FR-AUTH-03 | Planned | Planned | Planned | Planned | #1 |
| FR-AUTH-04 | Planned | Planned | — | Planned | #2 |
| FR-AUTH-05 | — | Planned | — | Planned | — |
| FR-DEV-01 | Planned | Planned | Planned | Planned | — |
| FR-DEV-02 | Planned | Planned | Planned | Planned | — |
| FR-DEV-03 | Planned | Planned | Planned | Planned | #5 |
| FR-DEV-04 | Planned | Planned | Planned | Planned | #5 |
| FR-DEV-05 | Planned | — | — | Planned | — |
| FR-DEV-06 | Planned | Planned | — | Planned | #3 |
| FR-SEN-01 | Planned | Planned | Planned | Planned | — |
| FR-SEN-02 | Planned | Planned | — | Planned | — |
| FR-SEN-03 | — | — | — | Planned | — |
| FR-SEN-04 | — | Planned | — | Planned | #10 |
| FR-RULE-01 | Planned | Planned | Planned | Planned | — |
| FR-RULE-02 | Planned | Planned | Planned | Planned | #7 |
| FR-RULE-03 | Planned | Planned | Planned | Planned | — |
| FR-RULE-04 | Planned | Planned | — | Planned | — |
| FR-RULE-05 | — | Planned | — | Planned | — |
| FR-RULE-06 | Planned | Planned | Planned | Planned | #7 |
| FR-ALRT-01 | Planned | Planned | Planned | Planned | #4 |
| FR-ALRT-02 | Planned | Planned | Planned | Planned | #4 |
| FR-ALRT-03 | — | Planned | — | Planned | — |
| FR-ALRT-04 | Planned | — | — | Planned | — |
| FR-ALRT-05 | Planned | Planned | — | Planned | — |
| FR-AUD-01 | Planned | Planned | Planned | Planned | #6 |
| FR-AUD-02 | Planned | Planned | Planned | Planned | #6 |
| FR-AUD-03 | — | Planned | — | Planned | — |

---

## 8. GitHub Issues Tracking Setup

### 8.1 Repository Structure

```
iot-smarthome-svv/
├── requirements/
│   ├── SRS_IoT_SmartHome_v1.0.md          ← this file
│   └── Defect_Taxonomy_Table.md           ← separate file
├── z-model/
├── vdm-spec/
├── alloy-model/
├── validation/
└── ci-pipeline/
```

### 8.2 Labels to Create

| Label Name | Color | Used For |
|---|---|---|
| `bug:ambiguity` | Yellow `#FBCA04` | Requirements with vague or unmeasurable language |
| `bug:inconsistency` | Red `#D93F0B` | Contradictions between requirements |
| `bug:non-verifiable` | Green `#0E8A16` | Requirements that cannot be tested |
| `enhancement` | Blue `#1D76DB` | Additions to improve the specification |
| `documentation` | Gray `#CCCCCC` | SRS updates and traceability fixes |

### 8.3 Milestone

Create a GitHub Milestone: **`Phase-1-Requirements`** with deadline = Week 3.

### 8.4 Step-by-Step GitHub Setup

1. Create the repository `iot-smarthome-svv` with the folder structure shown in §8.1.
2. Upload `SRS_IoT_SmartHome_v1.0.md` to `/requirements/`.
3. Upload `Defect_Taxonomy_Table.md` to `/requirements/`.
4. Create all 5 labels from the table above.
5. Create the **`Phase-1-Requirements`** milestone and assign all issues to it.
6. Open Issues #1–#10 using titles and labels from the Defect Taxonomy file.
7. Close each issue with a comment: `Closes #N — [resolution summary]` linked to a commit.

---

## 9. Conclusion

This SRS provides the complete, verified requirement baseline for the IoT Smart Home Controller System. Summary of deliverables:

| Artifact | Count |
|---|---|
| Functional Requirements (FRs) | 29 across 6 modules |
| Non-Functional Requirements (NFRs) | 7 |
| System States defined | 13 |
| Formal Invariants | 5 |
| Requirement Defects identified & resolved | 10 (see Defect Taxonomy file) |
| GitHub Issues to be created | 10 |

This document feeds directly into all remaining SVV pipeline phases:

- **Phase 2 →** Z Notation Formal Modeling (use §5 states and §6 invariants)
- **Phase 3 →** VDM Functional Specification (use §3 FRs for operations)
- **Phase 4 →** Alloy Structural Verification (use device/user/rule schemas)
- **Phase 5 →** Validation Checklist + CI Pipeline (derived from all FRs and NFRs)

All requirements are: **complete** (no TBDs), **consistent** (all defects resolved), **verifiable** (measurable criteria), and **traceable** (GitHub Issues log maintained).

---

*Document prepared for SVV Lab — Lahore Garrison University — Spring 2026*
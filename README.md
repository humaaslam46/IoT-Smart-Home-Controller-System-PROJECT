<div align="center">

# 🏠 IoT Smart Home Controller System

### Software Verification & Validation — Formal Methods Project

[![Z Notation](https://img.shields.io/badge/Z%20Notation-Formal%20Model-1F3864?style=for-the-badge)](./z-model)
[![VDM-SL](https://img.shields.io/badge/VDM--SL-Functional%20Spec-6A0DAD?style=for-the-badge)](./vdm-specifications)
[![Alloy](https://img.shields.io/badge/Alloy-Structural%20Verify-E05C00?style=for-the-badge)](./Requirements/alloy-model)
[![CI](https://img.shields.io/badge/GitHub%20Actions-CI%20Pipeline-2088FF?style=for-the-badge)](./.github/workflows/project-CI.yml)
[![License](https://img.shields.io/badge/License-MIT-brightgreen?style=for-the-badge)](./LICENSE)

> A formally verified IoT smart home management system modeled using **Z Notation**, **VDM-SL**, and **Alloy Analyzer** as part of the SVV Lab pipeline at Lahore Garrison University.

</div>

---

## 📌 Project Info

| Field | Detail |
|---|---|
| 🏛️ **University** | Lahore Garrison University, Lahore |
| 📚 **Course** | Software Verification & Validation Lab |
| 🎓 **Semester** | 6th Semester — Spring 2026 |
| 👩‍💻 **Author** | Huma Aslam |
| 🔗 **Domain** | IoT Smart Home Controller System *(Advanced)* |

---

## 🧠 What This Project Does

The **IoT Smart Home Controller System** allows authenticated users to monitor and control smart home devices through a centralized hub. The project focuses on **formal verification** of the system's correctness — not just implementation.

**Devices managed:** Smart lights · Door locks · Temperature sensors · Alarms

**Users supported:** Admin · Resident · Guest

---

## 🗂️ Repository Structure

```
📦 IoT-Smart-Home-Controller-System-PROJECT
│
├── 📁 .github/
│   └── 📁 workflows/
│       └── project-CI.yml              ← GitHub Actions CI pipeline
│
├── 📁 Requirements/
│   ├── 📁 alloy-model/                 ← Alloy structural verification files
│   ├── Defects.md                      ← Requirement Defect Taxonomy Table
│   └── SRS.md                          ← Software Requirements Specification
│
├── 📁 Validation-Checklist/            ← Validation checklist (15 items)
│
├── 📁 vdm-specifications/              ← VDM-SL functional specification
│   └── SmartHome.vdmsl
│
├── 📁 z-model/                         ← Z Notation formal model (CZT Eclipse)
│   ├── SmartHomeSystem.zed
│   ├── Z-Initialization-Schema.md
│   └── Z-Operations.md
│
├── LICENSE
└── README.md
```

---

## 🔬 SVV Pipeline

| Phase | Method | Tool | Status |
|:---:|---|---|:---:|
| 1️⃣ | Requirement Engineering + Defect Taxonomy | Git & GitHub Issues | ✅ |
| 2️⃣ | Formal State Modeling + Operations | Z Notation · CZT Eclipse | ✅ |
| 3️⃣ | Functional Specification | VDM-SL · Overture | ✅ |
| 4️⃣ | Structural Verification + Counterexamples | Alloy Analyzer | ✅ |
| 5️⃣ | Validation Checklist + CI Pipeline | GitHub Actions | ✅ |

---

## 🔒 Formal Invariants

| # | Invariant |
|:---:|---|
| INV-1 | `authenticatedUsers ⊆ registeredUsers` — only registered users can log in |
| INV-2 | `dom deviceStatus = registeredDevices` — every device has a status |
| INV-3 | `dom doorState ⊆ registeredDevices` — door states apply to registered devices only |
| INV-4 | Only registered devices can receive commands |

---

## ⚙️ Key Operations

| Operation | Precondition | Effect |
|---|---|---|
| `RegisterDevice` | Device not already registered | Adds device with `online` status |
| `LoginUser` | User exists in `registeredUsers` | Adds user to `authenticatedUsers` |
| `LockDoor` | User authenticated · device online | Sets `doorState` to `locked` |
| `ActivateAlarm` | `alarmState = inactive` | Sets `alarmState` to `active` |
| `DeactivateAlarm` | `alarmState = active` | Sets `alarmState` to `inactive` |

---

## 🐛 Requirement Defects Identified

| ID | Type | Fixed |
|:---:|---|:---:|
| D1 | 🟡 Ambiguity — vague response time | ✅ |
| D2 | 🔴 Inconsistency — door unlock permissions | ✅ |
| D3 | 🟢 Non-Verifiable — "user friendly" | ✅ |
| D4 | 🟡 Ambiguity — device availability | ✅ |
| D5 | 🟢 Non-Verifiable — "instantly" | ✅ |

> See [`Requirements/Defects.md`](./Requirements/Defects.md) for full analysis.

---

## 🛠️ Tools Used

| Tool | Purpose |
|---|---|
| [CZT — Eclipse IDE](http://czt.sourceforge.net) | Z Notation modeling (`.zed` files) |
| [Overture VDMTools](http://overturetool.org) | VDM-SL functional specification |
| [Alloy Analyzer](http://alloytools.org) | Structural verification & counterexample analysis |
| GitHub Actions | CI pipeline — `project-CI.yml` |

---

<div align="center">

*SVV Lab · Lahore Garrison University · Spring 2026*

</div>

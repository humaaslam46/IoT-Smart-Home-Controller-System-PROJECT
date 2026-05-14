# 🐛 Requirement Defect Taxonomy Table

<div align="center">

## IoT Smart Home Controller System

![Phase](https://img.shields.io/badge/Phase-1%20Requirement%20Engineering-blue?style=for-the-badge)
![Defects](https://img.shields.io/badge/Total%20Defects-5-red?style=for-the-badge)
![Status](https://img.shields.io/badge/All%20Defects-Resolved-brightgreen?style=for-the-badge)

---

## 📖 Defect Type Legend

| Symbol | Type | Definition |
|:---:|---|---|
| 🟡 | **Ambiguity** | Requirement uses vague or subjective language that can be interpreted in multiple ways — not implementable or testable as written |
| 🔴 | **Inconsistency** | Two or more requirements **directly contradict** each other — both cannot be satisfied simultaneously |
| 🟢 | **Non-Verifiability** | Requirement **cannot be measured** or tested with a clear pass/fail criterion — no acceptance threshold defined |

---

## 📊 Summary

| Defect Type | Count | Status |
|---|:---:|:---:|
| 🟡 Ambiguity | 2 | ✅ Resolved |
| 🔴 Inconsistency | 1 | ✅ Resolved |
| 🟢 Non-Verifiability | 2 | ✅ Resolved |
| **Total** | **5** | ✅ **All Resolved** |

---

## 🔍 Full Defect Table

| ID | Defect Type | Defective Requirement | Problem | ✅ Corrected Requirement |
|:---:|:---:|---|---|---|
| **D1** | 🟡 Ambiguity | *"System should respond quickly."* | `quickly` is subjective — 1ms and 10 minutes are both "quick" to someone | **"System shall respond within 2 seconds."** |
| **D2** | 🔴 Inconsistency | *"Only admins can unlock doors."* **AND** *"Users can unlock doors."* | Direct contradiction — both statements cannot be true at the same time | **"Authorized authenticated users can unlock doors."** |
| **D3** | 🟢 Non-Verifiable | *"System should be user friendly."* | `user friendly` has no measurable criterion — impossible to write a pass/fail test | **"Users shall perform device control within 3 interface steps."** |
| **D4** | 🟡 Ambiguity | *"Devices usually remain online."* | `usually` is vague — provides no implementable threshold or testable condition | **"Devices shall report their status every 30 seconds."** |
| **D5** | 🟢 Non-Verifiable | *"Alarm activates instantly."* | `instantly` is not a measurable time unit — cannot be verified during testing | **"Alarm shall activate within 1 second of trigger."** |

---

## 🔬 Detailed Defect Analysis

---

### D1 — 🟡 Ambiguity: Vague Response Time

| Field | Detail |
|---|---|
| **Req ID** | D1 |
| **Defect Type** | Ambiguity |
| **GitHub Issue** | #3 |

**❌ Original (Defective):**
> *"System should respond quickly."*

**🔎 Why It Is Defective:**
The word `quickly` is entirely subjective. A response of 2 seconds may be considered "quick" by one developer and unacceptably slow by another. This makes the requirement impossible to implement consistently and impossible to test with a pass/fail result.

**✅ Corrected Requirement:**
> *"System shall respond within **2 seconds** for all user-initiated device commands."*

---

### D2 — 🔴 Inconsistency: Contradictory Door Unlock Permissions

| Field | Detail |
|---|---|
| **Req ID** | D2 |
| **Defect Type** | Inconsistency |
| **GitHub Issue** | #5 |

**❌ Original (Defective):**
> - *"Only admins can unlock doors."*
> - *"Users can unlock doors."*

**🔎 Why It Is Defective:**
These two requirements are in direct logical contradiction. If only admins can unlock doors, then regular users cannot — and vice versa. A system cannot satisfy both simultaneously. In formal modeling (Z/Alloy), this creates an unsatisfiable invariant.

**✅ Corrected Requirement:**
> *"**Authorized, authenticated users** (including Admins and permitted Residents) can unlock doors."*

---

### D3 — 🟢 Non-Verifiable: Unmeasurable Usability Claim

| Field | Detail |
|---|---|
| **Req ID** | D3 |
| **Defect Type** | Non-Verifiability |
| **GitHub Issue** | #8 |

**❌ Original (Defective):**
> *"System should be user friendly."*

**🔎 Why It Is Defective:**
`User friendly` cannot be measured. There is no test that produces a pass or fail result for "friendliness." This requirement provides no implementation guidance and cannot appear in a validation checklist.

**✅ Corrected Requirement:**
> *"Users shall be able to perform any basic device control action within **3 interface steps** from the main dashboard."*

---

### D4 — 🟡 Ambiguity: Undefined Device Availability

| Field | Detail |
|---|---|
| **Req ID** | D4 |
| **Defect Type** | Ambiguity |
| **GitHub Issue** | #3 |

**❌ Original (Defective):**
> *"Devices usually remain online."*

**🔎 Why It Is Defective:**
`Usually` is a probabilistic, undefined qualifier. It gives no threshold for acceptable downtime and no implementation guidance for how the system should detect or handle offline devices.

**✅ Corrected Requirement:**
> *"Devices shall report their connectivity status to the controller every **30 seconds**. A device is marked `Offline` if no status report is received within 60 seconds."*

---

### D5 — 🟢 Non-Verifiable: Unmeasurable Alarm Speed

| Field | Detail |
|---|---|
| **Req ID** | D5 |
| **Defect Type** | Non-Verifiability |
| **GitHub Issue** | #4 |

**❌ Original (Defective):**
> *"Alarm activates instantly."*

**🔎 Why It Is Defective:**
`Instantly` is not a defined unit of time. In engineering and testing, every timing requirement must have a concrete measurable bound. Without one, no test case can be written and no benchmark can be set during validation.

**✅ Corrected Requirement:**
> *"The alarm shall activate within **1 second** of the triggering emergency condition being detected."*

---

## 📌 Traceability to GitHub Issues

| Defect ID | Defect Type | GitHub Issue | Status |
|:---:|---|:---:|:---:|
| D1 | 🟡 Ambiguity — Response time | #3 | ✅ Closed |
| D2 | 🔴 Inconsistency — Door permissions | #5 | ✅ Closed |
| D3 | 🟢 Non-Verifiable — Usability | #8 | ✅ Closed |
| D4 | 🟡 Ambiguity — Device availability | #3 | ✅ Closed |
| D5 | 🟢 Non-Verifiable — Alarm speed | #4 | ✅ Closed |

---

## 📌 SVV Pipeline Context

> These defects were identified and resolved during **Phase 1 — Requirement Engineering**.
> The corrected requirements feed directly into subsequent pipeline phases:

| Phase | How These Defects Are Used |
|---|---|
| **Phase 2 — Z Notation** | Corrected requirements → precise state invariants |
| **Phase 3 — VDM** | Corrected requirements → measurable pre/postconditions |
| **Phase 4 — Alloy** | Corrected requirements → verifiable relational constraints |
| **Phase 5 — Validation** | Corrected requirements → pass/fail test checklist items |

---

<div align="center">

*SVV Lab — Lahore Garrison University — Spring 2026*

</div>

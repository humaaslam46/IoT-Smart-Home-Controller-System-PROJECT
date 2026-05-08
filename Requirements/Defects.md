# Requirement Defect Taxonomy Table
## IoT Smart Home Controller System — SVV Lab Phase 1

| Field | Details |
|---|---|
| **Project** | IoT Smart Home Controller System |
| **Phase** | Phase 1 — Requirement Engineering |
| **University** | Lahore Garrison University |
| **Linked SRS** | `requirements/SRS_IoT_SmartHome_v1.0.md` |

---

## Defect Classification Legend

| Defect Type | Definition |
|---|---|
| 🟡 **Ambiguity** | Requirement uses vague, subjective, or unmeasurable language that can be interpreted in multiple ways |
| 🔴 **Inconsistency** | Two or more requirements contradict each other, creating a logical conflict |
| 🟢 **Non-Verifiability** | Requirement cannot be objectively tested or measured against a pass/fail criterion |

---

## Summary

| Defect Type | Count | Status |
|---|:---:|:---:|
| 🟡 Ambiguity | 4 | ✅ All Resolved |
| 🔴 Inconsistency | 3 | ✅ All Resolved |
| 🟢 Non-Verifiability | 3 | ✅ All Resolved |
| **Total** | **10** | **✅ All Resolved** |

---

## 🟡 Ambiguity Defects

### DEFECT-01 — Ambiguous Account Lockout Threshold

| Field | Detail |
|---|---|
| **GitHub Issue** | #1 |
| **Draft Req ID** | FR-AUTH-03 (draft) |
| **Defect Type** | Ambiguity |
| **Label** | `bug:ambiguity` |
| **Status** | ✅ CLOSED |

**Original Defective Requirement:**
> *"The system should lock accounts after several failed attempts."*

**Why It Is Defective:**
The word `several` is subjective and non-measurable. Different stakeholders may interpret it as 3, 5, 10, or any other number. This makes the requirement unverifiable during testing and creates inconsistent implementation behavior.

**Resolution:**
Replaced `several` with an exact, testable threshold.

**Resolved Requirement (FR-AUTH-03 final):**
> *"The system shall lock a user account after **5 consecutive** failed login attempts. Unlocking requires Admin intervention."*

---

### DEFECT-02 — Undefined Session Inactivity Period

| Field | Detail |
|---|---|
| **GitHub Issue** | #2 |
| **Draft Req ID** | FR-AUTH-04 (draft) |
| **Defect Type** | Ambiguity |
| **Label** | `bug:ambiguity` |
| **Status** | ✅ CLOSED |

**Original Defective Requirement:**
> *"Sessions should expire after being idle for a long time."*

**Why It Is Defective:**
`A long time` is completely subjective. It provides no testable boundary. A developer cannot implement this, and a tester cannot write a pass/fail test case for it.

**Resolution:**
Defined as an exact, configurable time value.

**Resolved Requirement (FR-AUTH-04 final):**
> *"The system shall expire user sessions after **30 minutes** of inactivity and require re-authentication."*

---

### DEFECT-03 — Offline Detection Has No Time Boundary

| Field | Detail |
|---|---|
| **GitHub Issue** | #3 |
| **Draft Req ID** | FR-DEV-06 (draft) |
| **Defect Type** | Ambiguity |
| **Label** | `bug:ambiguity` |
| **Status** | ✅ CLOSED |

**Original Defective Requirement:**
> *"Devices should be considered offline if they stop responding."*

**Why It Is Defective:**
`Stop responding` has no time bound. A device that misses one heartbeat could be interpreted as offline, or it might require hours of silence. This makes implementation and testing impossible without a concrete threshold.

**Resolution:**
Defined a configurable timeout with a concrete default value.

**Resolved Requirement (FR-DEV-06 final):**
> *"The system shall mark a device as `Offline` if no heartbeat is received within a configurable timeout (default: **60 seconds**)."*

---

### DEFECT-04 — Alert Thresholds Undefined by Sensor Type

| Field | Detail |
|---|---|
| **GitHub Issue** | #4 |
| **Draft Req ID** | FR-ALRT-01 (draft) |
| **Defect Type** | Ambiguity |
| **Label** | `bug:ambiguity` |
| **Status** | ✅ CLOSED |

**Original Defective Requirement:**
> *"Alerts should be generated for dangerous sensor readings."*

**Why It Is Defective:**
`Dangerous` is undefined and not quantified per sensor type. A temperature of 35°C is not dangerous, but smoke at any detectable level may be critical. Without sensor-specific thresholds and conditions, this requirement cannot be implemented or tested.

**Resolution:**
Decomposed into sensor-specific alert requirements, each with an explicit triggering condition.

**Resolved Requirements:**
- **FR-ALRT-01:** *"The system shall generate a `CRITICAL` alert when a smoke sensor reading exceeds the defined safety threshold."*
- **FR-ALRT-02:** *"The system shall generate a `SECURITY` alert when motion is detected and the security mode is `ARMED`."*

---

## 🔴 Inconsistency Defects

### DEFECT-05 — Contradictory Device Access Permissions

| Field | Detail |
|---|---|
| **GitHub Issue** | #5 |
| **Draft Req IDs** | FR-DEV-03 (draft) vs FR-DEV-04 (draft) |
| **Defect Type** | Inconsistency |
| **Label** | `bug:inconsistency` |
| **Status** | ✅ CLOSED |

**Original Defective Requirements:**
> - FR-DEV-03 (draft): *"All users can toggle devices."*
> - FR-DEV-04 (draft): *"Only Admin can modify devices."*

**Why It Is Defective:**
These two requirements directly contradict each other. FR-DEV-03 grants all users device modification rights, while FR-DEV-04 restricts those rights to Admin only. A system cannot satisfy both simultaneously — this is a logical contradiction that makes formal verification impossible.

**Resolution:**
Decomposed device operations by type and scoped roles appropriately so they no longer overlap.

**Resolved Requirements:**
- **FR-DEV-03 final:** *"The system shall allow **Residents and Admins** to toggle device state between `ON` and `OFF`."* (control operation)
- **FR-DEV-04 final:** *"The system shall allow **Admin only** to decommission a device."* (destructive operation)

---

### DEFECT-06 — Admin "Manage Records" Conflicts With Audit Immutability

| Field | Detail |
|---|---|
| **GitHub Issue** | #6 |
| **Draft Req IDs** | FR-AUD-01 (draft) vs FR-AUD-02 (draft) |
| **Defect Type** | Inconsistency |
| **Label** | `bug:inconsistency` |
| **Status** | ✅ CLOSED |

**Original Defective Requirements:**
> - FR-AUD-01 (draft): *"Admins can manage all system records."*
> - FR-AUD-02 (draft): *"Logs cannot be deleted by anyone."*

**Why It Is Defective:**
`Manage all system records` implicitly includes the ability to delete records, which is directly contradicted by FR-AUD-02. This creates an inconsistency: the Admin role both can and cannot delete audit logs. In formal modeling, this would produce an unsatisfiable invariant.

**Resolution:**
FR-AUD-01 clarified to exclude deletion. FR-AUD-02 made explicit and absolute for all roles.

**Resolved Requirements:**
- **FR-AUD-01 final:** *"The system shall maintain an immutable audit log recording every device state change, user action, and rule execution — with actor identity and timestamp."*
- **FR-AUD-02 final:** *"Audit logs must not be deletable by any role, including Admin. Minimum retention: 90 days."*

---

### DEFECT-07 — Rule Conflict Detection Gap

| Field | Detail |
|---|---|
| **GitHub Issue** | #7 |
| **Draft Req IDs** | FR-RULE-02 (draft) — FR-RULE-06 missing entirely |
| **Defect Type** | Inconsistency |
| **Label** | `bug:inconsistency` |
| **Status** | ✅ CLOSED |

**Original Defective Requirements:**
> - FR-RULE-02 (draft): *"Rules are validated at creation time."*
> - (No rule existed for conflict detection)

**Why It Is Defective:**
FR-RULE-02 implied validation exists at creation, but no requirement defined what constitutes a conflict between rules. This gap allowed two contradictory rules (e.g., `IF smoke THEN turn fan ON` and `IF smoke THEN turn fan OFF`) to coexist in the system — an inconsistency that breaks system behavior and makes formal invariants unsatisfiable.

**Resolution:**
Added FR-RULE-06 to explicitly handle the missing conflict constraint.

**Resolved Requirement (FR-RULE-06 final):**
> *"The system shall reject rule creation if two rules target the same device with contradictory actions under the same triggering condition."*

---

## 🟢 Non-Verifiability Defects

### DEFECT-08 — Usability Criterion Not Measurable

| Field | Detail |
|---|---|
| **GitHub Issue** | #8 |
| **Draft Req ID** | NFR-05 (draft) |
| **Defect Type** | Non-Verifiability |
| **Label** | `bug:non-verifiable` |
| **Status** | ✅ CLOSED |

**Original Defective Requirement:**
> *"The system should be easy to use for everyone."*

**Why It Is Defective:**
`Easy to use` and `everyone` are entirely subjective. There is no test you can run to determine if a system is "easy." A requirement without an acceptance criterion cannot be verified, cannot be included in a validation checklist, and cannot be formally specified.

**Resolution:**
Replaced with a concrete usability acceptance criterion based on measurable task completion.

**Resolved Requirement (NFR-05 final):**
> *"New Resident users shall complete basic device control tasks within **5 minutes** of first login without prior training."*

---

### DEFECT-09 — Availability Not Quantified

| Field | Detail |
|---|---|
| **GitHub Issue** | #9 |
| **Draft Req ID** | NFR-02 (draft) |
| **Defect Type** | Non-Verifiability |
| **Label** | `bug:non-verifiable` |
| **Status** | ✅ CLOSED |

**Original Defective Requirement:**
> *"The system shall be highly available."*

**Why It Is Defective:**
`Highly available` is a design aspiration, not a verifiable requirement. Without a specific uptime percentage, maintenance exclusions, and measurement method, this requirement cannot produce a pass/fail test result. It also cannot be expressed as a formal postcondition in VDM.

**Resolution:**
Defined a specific, industry-standard uptime metric.

**Resolved Requirement (NFR-02 final):**
> *"System uptime shall be **≥ 99.5%** (excluding scheduled maintenance windows)."*

---

### DEFECT-10 — Sensor Data Retention Period Unspecified

| Field | Detail |
|---|---|
| **GitHub Issue** | #10 |
| **Draft Req ID** | FR-SEN-04 (draft) |
| **Defect Type** | Non-Verifiability |
| **Label** | `bug:non-verifiable` |
| **Status** | ✅ CLOSED |

**Original Defective Requirement:**
> *"The system shall store sensor data for future use."*

**Why It Is Defective:**
`Future use` is not testable. No duration is defined (1 day? 1 year?). No output format is specified. A tester cannot verify this requirement because there is no criterion for success. Additionally, `future use` provides no guidance for implementation.

**Resolution:**
Added a default retention period and a concrete export format.

**Resolved Requirement (FR-SEN-04 final):**
> *"The system shall retain sensor history for a configurable duration (default: **30 days**) and allow historical data export in **CSV format**."*

---

## GitHub Issues Quick Reference

| # | Issue Title | Label | Linked Req |
|:---:|---|---|---|
| 1 | `[DEFECT] Ambiguous account lockout threshold` | `bug:ambiguity` | FR-AUTH-03 |
| 2 | `[DEFECT] Undefined session inactivity period` | `bug:ambiguity` | FR-AUTH-04 |
| 3 | `[DEFECT] Offline detection has no time bound` | `bug:ambiguity` | FR-DEV-06 |
| 4 | `[DEFECT] Alert thresholds undefined by sensor type` | `bug:ambiguity` | FR-ALRT-01/02 |
| 5 | `[DEFECT] Contradictory device access permissions` | `bug:inconsistency` | FR-DEV-03/04 |
| 6 | `[DEFECT] Admin manage records conflicts with audit immutability` | `bug:inconsistency` | FR-AUD-01/02 |
| 7 | `[DEFECT] Rule conflict detection gap` | `bug:inconsistency` | FR-RULE-02/06 |
| 8 | `[DEFECT] Usability criterion not measurable` | `bug:non-verifiable` | NFR-05 |
| 9 | `[DEFECT] Availability requirement not quantified` | `bug:non-verifiable` | NFR-02 |
| 10 | `[DEFECT] Sensor data retention period unspecified` | `bug:non-verifiable` | FR-SEN-04 |

---

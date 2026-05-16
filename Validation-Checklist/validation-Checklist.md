# ✅ Validation Checklist
## IoT Smart Home Controller System

<div align="center">

![Course](https://img.shields.io/badge/Course-SVV%20Lab-blue?style=for-the-badge)
![Items](https://img.shields.io/badge/Checked-15%2F15-brightgreen?style=for-the-badge)
![Result](https://img.shields.io/badge/Overall-PASS-brightgreen?style=for-the-badge)

| Field | Details |
|---|---|
| 🔬 **Methods** | Z Notation · VDM-SL · Alloy Analyzer · GitHub Actions |
| 🏛️ **University** | Lahore Garrison University — Spring 2026 |

</div>

---

## 📋 Checklist

| # | Requirement | 🔧 Method | 📄 Artifact | Result |
|:---:|---|---|---|:---:|
| R1 | System supports multiple users | Z state + Alloy signatures | Z state schema, `User` sig | ✅ |
| R2 | All devices belong to the system | Alloy facts | `DeviceOwnership` fact | ✅ |
| R3 | System maintains device states (ON/OFF) | VDM state + Alloy | VDM `DeviceState`, Alloy `state` | ✅ |
| R4 | System maintains door lock states | Alloy assertions + VDM ops | Alloy `DoorState`, VDM `LockDoor` | ✅ |
| R5 | Doors auto-lock in Away mode | Alloy invariant | `AwayModeSafety` fact | ✅ |
| R6 | Lights/fans turn OFF in Away mode | Alloy assertion | `NoDeviceOnInAwayMode` | ✅ |
| R7 | Alarm activates in Away mode | Alloy invariant | `AwayModeSafety` fact | ✅ |
| R8 | Registered users can authenticate | VDM pre/post conditions | `LoginUser` operation | ✅ |
| R9 | New devices can be registered | VDM operation contracts | `RegisterDevice` operation | ✅ |
| R10 | Door ops apply to registered devices only | VDM preconditions | `LockDoor` precondition | ✅ |
| R11 | Invariants hold during all operations | Z schemas + Alloy facts | Z invariants, Alloy facts | ✅ |
| R12 | Invalid assumptions generate counterexamples | Alloy Analyzer | Counterexample report | ✅ |
| R13 | Repository structure is valid | GitHub Actions CI | CI execution logs | ✅ |
| R14 | Formal artifacts exist in repository | CI validation steps | GitHub Actions workflow | ✅ |
| R15 | Documentation artifacts are maintained | Markdown checks in CI | `.md` validation in CI | ✅ |

---

## 📊 Validation Summary

| Phase | Area | Status |
|:---:|---|:---:|
| 1️⃣ | Requirement Engineering | ✅ Done |
| 2️⃣ | Z Formal Modeling | ✅ Done |
| 3️⃣ | VDM Functional Specification | ✅ Done |
| 4️⃣ | Alloy Structural Verification | ✅ Done |
| 4️⃣ | Counterexample Analysis | ✅ Done |
| 5️⃣ | GitHub CI Pipeline | ✅ Done |

---

## 🏁 Overall Result

> **15 / 15 requirements verified** — all formal methods applied, CI pipeline passed, artifacts present in repository.
> The IoT Smart Home Controller System satisfies all defined verification and validation requirements. ✅

---

<div align="center">

*SVV Lab — Lahore Garrison University — Spring 2026*

</div>

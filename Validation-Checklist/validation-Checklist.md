# Validation Checklist – IoT Smart Home Controller System

## Project Information

| Field | Details |
|---|---|
| Course | Software Verification & Validation Lab |
| Project Title | IoT Smart Home Controller System |
| Verification Method | Z Notation, VDM-SL, Alloy Analyzer, GitHub Actions |
| Repository | GitHub Project Repository |

---

# Validation Checklist

| Req ID | Requirement Description | Validation Method | Evidence / Artifact | Status |
|---|---|---|---|---|
| R1 | The smart home system shall support multiple users | Verified through Alloy signatures and Z state modeling | Alloy `User` signatures, Z state schema | ✅ Pass |
| R2 | All devices must belong to the smart home system | Alloy structural verification using facts | `DeviceOwnership` fact in Alloy | ✅ Pass |
| R3 | The system shall maintain device states (ON/OFF) | Verified in VDM state definitions and Alloy relations | VDM `DeviceState`, Alloy `state` relation | ✅ Pass |
| R4 | The system shall maintain door lock states | Verified using Alloy assertions and VDM operations | Alloy `DoorState`, VDM `LockDoor` operation | ✅ Pass |
| R5 | Doors must lock automatically in Away mode | Alloy invariant verification | `AwayModeSafety` fact and `DoorsLockedInAway` assertion | ✅ Pass |
| R6 | Lights and fans must turn OFF in Away mode | Alloy safety assertion verification | `NoDeviceOnInAwayMode` assertion | ✅ Pass |
| R7 | Alarm must activate in Away mode | Alloy invariant validation | `AwayModeSafety` fact | ✅ Pass |
| R8 | Registered users can authenticate into the system | Verified using VDM pre/post conditions | `LoginUser` operation in VDM-SL | ✅ Pass |
| R9 | New devices can be registered into the system | Verified using VDM operation contracts | `RegisterDevice` operation | ✅ Pass |
| R10 | Door operations must only apply to registered devices | Verified through VDM preconditions | `LockDoor` precondition validation | ✅ Pass |
| R11 | System invariants must remain consistent during operations | Verified in Z schemas and Alloy facts | Z invariants and Alloy facts | ✅ Pass |
| R12 | Invalid system assumptions should generate counterexamples | Verified using Alloy Analyzer assertions | Counterexample analysis report | ✅ Pass |
| R13 | Repository structure must remain valid | Verified using GitHub Actions CI pipeline | CI pipeline execution logs | ✅ Pass |
| R14 | Formal specification artifacts must exist in repository | Verified through CI validation steps | GitHub Actions workflow | ✅ Pass |
| R15 | Documentation and verification reports must be maintained | Verified through markdown artifact checks | `.md` validation in CI pipeline | ✅ Pass |

---

# Validation Summary

| Validation Area | Status |
|---|---|
| Requirement Engineering | ✅ Completed |
| Z Formal Modeling | ✅ Completed |
| VDM Functional Specification | ✅ Completed |
| Alloy Structural Verification | ✅ Completed |
| Counterexample Analysis | ✅ Completed |
| GitHub CI Pipeline Validation | ✅ Completed |

---

# Overall Result

The IoT Smart Home Controller System satisfies the defined verification and validation requirements through formal specification, structural verification, contract-based validation, and automated CI pipeline checks.

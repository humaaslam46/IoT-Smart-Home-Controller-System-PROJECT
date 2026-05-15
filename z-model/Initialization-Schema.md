# 🔰 Z Notation — Initialization Schema

<div align="center">

![Phase](https://img.shields.io/badge/Phase-2%20Z%20Notation-blue?style=for-the-badge)
![Schema](https://img.shields.io/badge/Schema-InitSmartHomeSystem-purple?style=for-the-badge)
![Status](https://img.shields.io/badge/State-Empty%20%2F%20Safe-brightgreen?style=for-the-badge)

> Defines the **initial valid state** of the IoT Smart Home Controller System
> before any users, devices, or operations are introduced.

</div>

---

## 📌 What Is an Initialization Schema?

In Z Notation, the **initialization schema** defines the starting point of the system.
It must satisfy all invariants defined in the main state schema (`SmartHomeSystem`).
All invariants hold trivially here because every set starts **empty** — there are no violations possible on empty collections.

---

## 📐 Schema

```
InitSmartHomeSystem
───────────────────────────────
SmartHomeSystem
───────────────────────────────
registeredUsers    = ∅
authenticatedUsers = ∅
registeredDevices  = ∅
deviceStatus       = ∅
doorState          = ∅
alarmState         = inactive
```

---

## 🔎 Component Breakdown

| Component | Initial Value | Reason |
|---|:---:|---|
| `registeredUsers` | `∅` | No users have been registered yet |
| `authenticatedUsers` | `∅` | No users are logged in at startup |
| `registeredDevices` | `∅` | No IoT devices have been added yet |
| `deviceStatus` | `∅` | No device mappings exist — empty map |
| `doorState` | `∅` | No door states assigned — empty map |
| `alarmState` | `inactive` | Alarm is off by default at system start |

---

## ✅ Invariant Satisfaction at Init

| Invariant | Holds at Init? | Why |
|---|:---:|---|
| `authenticatedUsers ⊆ registeredUsers` | ✅ Yes | `∅ ⊆ ∅` is always true |
| `dom deviceStatus = registeredDevices` | ✅ Yes | `∅ = ∅` is always true |
| `dom doorState ⊆ registeredDevices` | ✅ Yes | `∅ ⊆ ∅` is always true |

> All invariants from `SmartHomeSystem` are satisfied at initialization.
> The system starts in a **legal, consistent state**.

---

<div align="center">

*SVV Lab — Lahore Garrison University — Spring 2026*

</div>

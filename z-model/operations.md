# ⚙️ Z Notation — Operations

<div align="center">

![Phase](https://img.shields.io/badge/Phase-2%20Z%20Notation-blue?style=for-the-badge)
![Schema](https://img.shields.io/badge/Type-Δ%20Operations-purple?style=for-the-badge)
![Ops](https://img.shields.io/badge/Operations-4%20Defined-orange?style=for-the-badge)

> Formal operation schemas for the **IoT Smart Home Controller System**
> Each operation uses **Δ SmartHomeSystem** — meaning the system state changes.
> Preconditions appear **above** the predicate line, postconditions **below**.

</div>

---

## 📌 Reading These Schemas

| Symbol | Meaning |
|---|---|
| `Δ SmartHomeSystem` | State **before and after** are both present — something changes |
| `var?` | **Input** to the operation |
| `var'` | **After-state** of a variable (what it becomes) |
| `∉` | Not a member of a set |
| `∈` | Is a member of a set |
| `∪` | Set union |
| `⊕` | Override — updates a mapping at a specific key |
| `↦` | Maplet — maps one value to another |

---

## 1. 📥 RegisterDevice

> Registers a new IoT device into the system and sets its status to `online`.

**Precondition:** The device must not already be registered.
**Postcondition:** The device is added to `registeredDevices` and mapped to `online` in `deviceStatus`.

```
RegisterDevice
───────────────────────────────────────────
Δ SmartHomeSystem
newDevice? : DEVICE
───────────────────────────────────────────
newDevice? ∉ registeredDevices

registeredDevices' = registeredDevices ∪ {newDevice?}
deviceStatus'      = deviceStatus ∪ {newDevice? ↦ online}

registeredUsers'   = registeredUsers
authenticatedUsers' = authenticatedUsers
doorState'         = doorState
alarmState'        = alarmState
```

---

## 2. 🔑 LoginUser

> Authenticates a registered user, granting them access to control devices.

**Precondition:** The user must already exist in `registeredUsers`.
**Postcondition:** The user is added to `authenticatedUsers`.

```
LoginUser
───────────────────────────────────────────
Δ SmartHomeSystem
user? : USER
───────────────────────────────────────────
user? ∈ registeredUsers

authenticatedUsers' = authenticatedUsers ∪ {user?}

registeredUsers'    = registeredUsers
registeredDevices'  = registeredDevices
deviceStatus'       = deviceStatus
doorState'          = doorState
alarmState'         = alarmState
```

---

## 3. 🔐 LockDoor

> Locks a registered smart door device. Only authenticated users can perform this operation.

**Precondition:** The user must be authenticated, the door must be registered, and the device must be `online`.
**Postcondition:** The door's state is updated to `locked` in `doorState`.

```
LockDoor
───────────────────────────────────────────
Δ SmartHomeSystem
user? : USER
door? : DEVICE
───────────────────────────────────────────
user? ∈ authenticatedUsers
door? ∈ registeredDevices
deviceStatus(door?) = online

doorState' = doorState ⊕ {door? ↦ locked}

registeredUsers'    = registeredUsers
authenticatedUsers' = authenticatedUsers
registeredDevices'  = registeredDevices
deviceStatus'       = deviceStatus
alarmState'         = alarmState
```

---

## 4. 🚨 ActivateAlarm

> Activates the smart home alarm system in response to an emergency condition.

**Precondition:** The alarm must currently be `inactive`.
**Postcondition:** The alarm state becomes `active`.

```
ActivateAlarm
───────────────────────────────────────────
Δ SmartHomeSystem
───────────────────────────────────────────
alarmState = inactive

alarmState' = active

registeredUsers'    = registeredUsers
authenticatedUsers' = authenticatedUsers
registeredDevices'  = registeredDevices
deviceStatus'       = deviceStatus
doorState'          = doorState
```

---

## 5. 🚨 DeactivateAlarm

> Activates the smart home alarm system in response to an emergency condition.

**Precondition:** The alarm must currently be `active`.
**Postcondition:** The alarm state becomes `inactive`.

```
DeactivateAlarm
───────────────────────────────────────────
Δ SmartHomeSystem
───────────────────────────────────────────
alarmState = active

alarmState' = inactive

registeredUsers'    = registeredUsers
authenticatedUsers' = authenticatedUsers
registeredDevices'  = registeredDevices
deviceStatus'       = deviceStatus
doorState'          = doorState
```

---

## 📊 Operations Summary

| Operation | Inputs | Precondition | What Changes |
|---|---|---|---|
| `RegisterDevice` | `newDevice?` | Device not already registered | `registeredDevices`, `deviceStatus` |
| `LoginUser` | `user?` | User exists in `registeredUsers` | `authenticatedUsers` |
| `LockDoor` | `user?`, `door?` | User authenticated, door online | `doorState` |
| `ActivateAlarm` | — | `alarmState = inactive` | `alarmState` |
| `DeactivateAlarm` | — | `alarmState = active` | `alarmState` |


---

## 🔗 Traceability to Requirements

| Operation | Linked FR | Linked Invariant |
|---|---|---|
| `RegisterDevice` | FR-2 Device Registration | INV-2, INV-3 |
| `LoginUser` | FR-1 User Authentication | INV-1 |
| `LockDoor` | FR-4 Door Lock Control | INV-1, INV-2 |
| `ActivateAlarm` | FR-6 Alarm Activation | — |
| `DeactivateAlarm` | FR-6 Alarm Activation | — |


---

<div align="center">

*SVV Lab — Lahore Garrison University — Spring 2026*

</div>

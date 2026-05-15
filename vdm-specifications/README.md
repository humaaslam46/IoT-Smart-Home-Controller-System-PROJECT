# 📐 VDM Functional Specification

<div align="center">

![Phase](https://img.shields.io/badge/Phase-3%20VDM%20Specification-blue?style=for-the-badge)
![Tool](https://img.shields.io/badge/Tool-Overture%20VDMTools-purple?style=for-the-badge)
![Language](https://img.shields.io/badge/Language-VDM--SL-orange?style=for-the-badge)

> Formal functional specification for the **IoT Smart Home Controller System**
> using **VDM-SL (Vienna Development Method — Specification Language)**

</div>

---

## 📁 Folder Contents

| File | Description |
|---|---|
| `SmartHome.vdmsl` | Main VDM-SL specification file |
| `README.md` | This documentation file |

---

## 🗂️ What This Specification Covers

- ✅ **Type definitions** for all system entities
- ✅ **System state** with registered users, devices, and alarm
- ✅ **State invariants** that must hold at all times
- ✅ **Initial state** of the system
- ✅ **Operations** with preconditions and postconditions

---

## 🧱 Type Definitions

| Type | Description |
|---|---|
| `USER` | Represents an authorized system user (token) |
| `DEVICE` | Represents a registered smart home device (token) |
| `DEVICESTATUS` | `online` · `offline` · `fault` |
| `DOORSTATE` | `locked` · `unlocked` |
| `ALARMSTATE` | `active` · `inactive` |

---

## 🗄️ System State

The `SmartHomeSystem` state holds six components:

| Component | Type | Description |
|---|---|---|
| `registeredUsers` | `set of USER` | All users registered in the system |
| `authenticatedUsers` | `set of USER` | Users currently logged in |
| `registeredDevices` | `set of DEVICE` | All registered smart devices |
| `deviceStatus` | `map DEVICE → DEVICESTATUS` | Current status of each device |
| `doorState` | `map DEVICE → DOORSTATE` | Lock state of door devices |
| `alarmState` | `ALARMSTATE` | Current alarm state |

---

## 🔒 State Invariants

Three invariants must hold true at all times:

| # | Invariant | Meaning |
|:---:|---|---|
| INV-1 | `authenticatedUsers ⊆ registeredUsers` | Only registered users can be authenticated |
| INV-2 | `dom deviceStatus = registeredDevices` | Every registered device must have a status |
| INV-3 | `dom doorState ⊆ registeredDevices` | Door states only apply to registered devices |

---

## ⚙️ Operations

### 1. `RegisterDevice(d)`

> Registers a new smart device and assigns it `online` status by default.

| | |
|---|---|
| **Pre** | Device `d` must not already exist in `registeredDevices` |
| **Post** | `d ∈ registeredDevices` and `deviceStatus(d) = online` |

---

### 2. `LoginUser(u)`

> Authenticates a registered user into the system.

| | |
|---|---|
| **Pre** | User `u` must exist in `registeredUsers` |
| **Post** | `u ∈ authenticatedUsers` |

---

### 3. `LockDoor(d)`

> Locks a registered smart door device.

| | |
|---|---|
| **Pre** | Device `d` is registered AND `deviceStatus(d) = online` |
| **Post** | `doorState(d) = locked` |

---

### 4. `ActivateAlarm()`

> Activates the smart home alarm system.

| | |
|---|---|
| **Pre** | `alarmState = inactive` |
| **Post** | `alarmState = active` |

---

### 5. `DeactivateAlarm()`

> Deactivates the smart home alarm system.

| | |
|---|---|
| **Pre** | `alarmState = active` |
| **Post** | `alarmState = inactive` |

---

## 🔧 Tool Used

**Overture VDMTools** — open-source IDE for VDM-SL specification and validation.
Download: [overturetool.org](http://overturetool.org)

---

<div align="center">

*SVV Lab — Lahore Garrison University — Spring 2026*

</div>

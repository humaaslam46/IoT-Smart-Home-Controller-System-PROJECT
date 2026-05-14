# 🏠 Software Requirements Specification (SRS)

<div align="center">

## IoT Smart Home Controller System

![Version](https://img.shields.io/badge/Version-1.0-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Phase%201%20Complete-brightgreen?style=for-the-badge)
![Course](https://img.shields.io/badge/Course-SVV%20Lab-purple?style=for-the-badge)
![University](https://img.shields.io/badge/University-LGU-orange?style=for-the-badge)

</div>

---

## 📋 Table of Contents

| # | Section |
|:---:|---|
| 1 | [Introduction](#1-introduction) |
| 2 | [System Overview](#2-system-overview) |
| 3 | [Functional Requirements](#3-functional-requirements) |
| 4 | [Non-Functional Requirements](#4-non-functional-requirements) |
| 5 | [System Constraints](#5-system-constraints) |
| 6 | [Assumptions](#6-assumptions) |
| 7 | [System States](#7-system-states) |
| 8 | [Preliminary Invariants](#8-preliminary-invariants) |

---

## 1. Introduction

### 1.1 Purpose

> The purpose of the **IoT Smart Home Controller System** is to allow users to monitor and control smart home devices remotely through a centralized controller.

The system improves:
- 🛋️ **Convenience** — control all devices from one interface
- ⚙️ **Automation** — rule-based device management
- 🔒 **Home Security** — unauthorized access prevention and alarm control

---

### 1.2 Scope

#### ✅ In Scope

| Feature | Description |
|---|---|
| 💡 Smart Lights | Remote ON/OFF control |
| 🔐 Smart Doors | Remote lock and unlock |
| 🌡️ Temperature | Real-time room monitoring |
| 🚨 Alarms | Emergency activation/deactivation |
| 👤 User Management | Authorized user registration and access |
| 📡 Device Monitoring | Online/Offline/Fault status tracking |

#### ❌ Out of Scope

> The following are **intentionally excluded** to keep the project manageable within SVV lab scope:

- 🤖 AI-based automation
- 🎙️ Voice assistant integration
- 📹 Real-time video surveillance
- ☁️ Cloud synchronization

---

### 1.3 Intended Users

| Role | Description |
|---|---|
| 🏠 **Home Owner** | Primary user; controls all devices and views system status |
| 👨‍👩‍👧 **Authorized Family Member** | Secondary user with device control permissions |
| 🛠️ **System Administrator** | Manages device registration and user authorization |

---

## 2. System Overview

```
┌─────────────────────────────────────────────────────┐
│              Mobile / Web Interface                  │
└────────────────────┬────────────────────────────────┘
                     │  User Commands
                     ▼
┌─────────────────────────────────────────────────────┐
│          IoT Smart Home Controller (Hub)             │
│   [ Auth ] [ Rule Engine ] [ Device Manager ]        │
└──────┬──────────┬───────────┬──────────┬────────────┘
       │          │           │          │
       ▼          ▼           ▼          ▼
   💡 Lights   🔐 Doors   🌡️ Sensors  🚨 Alarms
```

The smart home controller communicates with IoT devices through a **local network**. Users interact with the system using a **mobile or web interface** that sends commands to the central hub, which then forwards them to the appropriate registered device.

---

## 3. Functional Requirements

> 🏷️ Priority: **P1** = Critical &nbsp;|&nbsp; **P2** = High &nbsp;|&nbsp; **P3** = Medium

---

### 🔐 Authentication & Access

| ID | Priority | Requirement |
|---|:---:|---|
| **FR-1** | `P1` | The system shall allow registered users to log into the controller system using valid credentials. |
| **FR-8** | `P1` | The system shall deny all operations from unauthorized or unauthenticated users. |

---

### ⚙️ Device Management

| ID | Priority | Requirement |
|---|:---:|---|
| **FR-2** | `P1` | The administrator shall register smart devices into the system before they can receive commands. |
| **FR-7** | `P2` | The system shall display whether each device is **Online**, **Offline**, or **Faulty** in real time. |

---

### 🏡 Device Control

| ID | Priority | Requirement |
|---|:---:|---|
| **FR-3** | `P2` | The user shall turn smart lights **ON** or **OFF** remotely through the interface. |
| **FR-4** | `P2` | The user shall **lock** or **unlock** smart doors remotely. |
| **FR-5** | `P2` | The system shall display the **current room temperature** from connected sensors. |
| **FR-6** | `P1` | The system shall activate alarms during detected **emergency situations**. |

---

## 4. Non-Functional Requirements

| ID | Category | Requirement |
|---|---|---|
| **NFR-1** | 🔒 Security | Only authenticated and authorized users may send control commands to devices. |
| **NFR-2** | ✅ Reliability | The system shall maintain correct and consistent device states during all operations. |
| **NFR-3** | ⏱️ Availability | The controller shall remain operational **24/7** without unplanned downtime. |
| **NFR-4** | 🖥️ Usability | The interface shall provide simple, intuitive control options accessible to non-technical users. |
| **NFR-5** | 🔧 Maintainability | The system shall support the addition of new device types without modifying existing components. |

---

## 5. System Constraints

> ⚠️ These constraints define the boundaries under which the system must correctly operate.

```
⚡ Internet connection may be unavailable at times
📴 Registered devices may go offline unexpectedly
🚫 Only registered devices can receive commands from the controller
```

---

## 6. Assumptions

> ✅ The following are assumed to be true for the system to function as specified.

- 🔑 Users possess **valid login credentials** prior to first use
- 📶 All IoT devices **support standard network communication** protocols
- 🌐 The **local network is operational** and stable during system use

---

## 7. System States

> These states form the basis of the **Z Notation state schema** in Phase 2 of the SVV pipeline.

| Component | Possible States | Notes |
|---|---|---|
| 📡 **Device** | `Online` \| `Offline` \| `Fault` | Cannot be Online and Offline simultaneously |
| 🔐 **Door Lock** | `Locked` \| `Unlocked` | Must always be in one of these two states |
| 🚨 **Alarm** | `Active` \| `Inactive` | Activated only during emergency conditions |
| 👤 **User Session** | `LoggedIn` \| `LoggedOut` | Commands only accepted in LoggedIn state |

### State Transition Summary

```
Device:      Offline ──► Online ──► Fault ──► Offline
Door:        Locked ◄──────────────────────► Unlocked
Alarm:       Inactive ──────────────────────► Active
Session:     LoggedOut ──► LoggedIn ──► LoggedOut
```

---

## 8. Preliminary Invariants

> 🔬 These invariants are **critical** for Phase 2 (Z Notation) and Phase 4 (Alloy Verification).
> They must hold true in **every valid system state**.

---

### INV-1 — Device State Mutual Exclusivity

```
A device cannot be both Online and Offline simultaneously.
```

> In formal notation:
> ```
> ∀ d ∈ Devices • d.state = Online ⟹ d.state ≠ Offline
> ```

---

### INV-2 — Authenticated Control Only

```
Only authenticated users can issue control commands to devices.
```

> In formal notation:
> ```
> ∀ cmd ∈ Commands • cmd.issuer.session = LoggedIn
> ```

---

### INV-3 — Door Lock State Completeness

```
A smart door must always be either Locked or Unlocked — no undefined state.
```

> In formal notation:
> ```
> ∀ d ∈ Doors • d.state ∈ {Locked, Unlocked}
> ```

---

### INV-4 — Registered Devices Only

```
Only devices that are registered in the system can receive commands.
```

> In formal notation:
> ```
> ∀ cmd ∈ Commands • cmd.target ∈ RegisteredDevices
> ```

---

## 📌 SVV Pipeline Progress

| Phase | Deliverable | Status |
|---|---|---|
| **Phase 1** | Requirements Engineering (this SRS) | ✅ Complete |
| **Phase 2** | Z Notation Formal Modeling | 🔄 In Progress |
| **Phase 3** | VDM Functional Specification | ⏳ Pending |
| **Phase 4** | Alloy Structural Verification | ⏳ Pending |
| **Phase 5** | Validation & CI Pipeline | ⏳ Pending |

---

<div align="center">

*SVV Lab — Lahore Garrison University — Spring 2026*

</div>

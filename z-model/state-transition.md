# State Transition Model
## IoT Smart Home Controller System

---

# Device State Transitions

| Current State | Event | Next State |
|---|---|---|
| registered | device activated | online |
| offline | reconnect device | online |
| online | device malfunction | error |
| error | device repaired | online |
| registered | remove device | decommissioned |
| offline | remove device | decommissioned |
| error | remove device | decommissioned |

---

# Alert State Transitions

| Current State | Event | Next State |
|---|---|---|
| active | admin resolves alert | resolved |

---

# User Access State Transitions

| Current State | Event | Next State |
|---|---|---|
| active | multiple failed logins | locked |
| locked | admin unlocks account | active |

---

# Formal Transition Schema

```z
ΔSmartHomeSystem
----------------------------------------------
newDeviceStatus? : DEVICE ↔ DEVICESTATUS
newDoorState? : DEVICE ↔ DOORSTATE
newAlarmState? : ALARMSTATE

deviceStatus' = newDeviceStatus?
doorState' = newDoorState?
alarmState' = newAlarmState?

∀ d : DEVICE •
    d ∈ dom newDeviceStatus? ⇒ d ∈ registeredDevices
    
∀ d : DEVICE •
    newDeviceStatus?(d) ∈ {online, offline, fault}
```
---

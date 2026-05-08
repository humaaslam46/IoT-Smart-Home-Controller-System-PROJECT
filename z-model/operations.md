# Z Operations
## IoT Smart Home Controller System

---

## 1. RegisterDevice

```z
RegisterDevice
Δ SmartHomeSystem

newDevice? : DEVICE

--------------------------------------------

newDevice? ∉ devices

devices' = devices ∪ {newDevice?}

deviceState' =
deviceState ∪ {newDevice? ↦ REGISTERED}

users' = users
rules' = rules
alerts' = alerts
userRole' = userRole
userState' = userState
ruleTarget' = ruleTarget
alertState' = alertState
```

---

## 2. ActivateDevice

```z
ActivateDevice
Δ SmartHomeSystem

device? : DEVICE

--------------------------------------------

device? ∈ devices

deviceState(device?) = REGISTERED

deviceState' =
deviceState ⨁ {device? ↦ ONLINE}

devices' = devices
users' = users
rules' = rules
alerts' = alerts
userRole' = userRole
userState' = userState
ruleTarget' = ruleTarget
alertState' = alertState
```

---

## 3. ResolveAlert

```z
ResolveAlert
Δ SmartHomeSystem

alert? : ALERT

--------------------------------------------

alert? ∈ alerts

alertState(alert?) = ACTIVE

alertState' =
alertState ⨁ {alert? ↦ RESOLVED}

devices' = devices
users' = users
rules' = rules
alerts' = alerts
userRole' = userRole
userState' = userState
deviceState' = deviceState
ruleTarget' = ruleTarget
```

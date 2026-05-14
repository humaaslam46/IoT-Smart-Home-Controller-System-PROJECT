# Z State Schema
## IoT Smart Home Controller System

### Given Sets

```z
[USER, DEVICE]
```

---

### Enumerated Types

```z
[USER, DEVICE]

DEVICESTATUS ::= online | offline | fault

DOORSTATE ::= locked | unlocked

ALARMSTATE ::= active | inactive

SESSIONSTATE ::= loggedIn | loggedOut

```

---

### Main System State Schema

```z
SmartHomeSystem
-------------------------------
registeredUsers : ℙ USER
authenticatedUsers : ℙ USER
registeredDevices : ℙ DEVICE

deviceStatus : DEVICE ↔ DEVICESTATUS
doorState : DEVICE ↔ DOORSTATE
alarmState : ALARMSTATE

```

# Z State Schema
## IoT Smart Home Controller System

### Given Sets

```z
[USER, DEVICE, RULE, ALERT]
```

---

### Enumerated Types

```z
ROLE ::= Admin | Resident | Guest

DEVSTATE ::= REGISTERED | ONLINE | OFFLINE | ERROR | DECOMMISSIONED

ALERTSTATE ::= ACTIVE | RESOLVED

USERSTATE ::= ACTIVE | LOCKED
```

---

### Main System State Schema

```z
SmartHomeSystem

users : ℙ USER
devices : ℙ DEVICE
rules : ℙ RULE
alerts : ℙ ALERT

userRole : USER ↔ ROLE
userState : USER ↔ USERSTATE

deviceState : DEVICE ↔ DEVSTATE

ruleTarget : RULE ↔ DEVICE

alertState : ALERT ↔ ALERTSTATE

--------------------------------------------------

dom userRole = users

dom userState = users

dom deviceState = devices

dom ruleTarget = rules

dom alertState = alerts
```

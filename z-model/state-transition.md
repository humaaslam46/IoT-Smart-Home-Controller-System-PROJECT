# State Transition Model
## IoT Smart Home Controller System

---

# Device State Transitions

| Current State | Event | Next State |
|---|---|---|
| registered | device activated | online |
| online | heartbeat timeout | offline |
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

# Formal Transition Constraints

```z
∀ d : DEVICE •
    deviceState(d) = decommissioned ⇒
    deviceState'(d) = decommissioned
```

A decommissioned device cannot return to another state.

---

```z
∀ a : ALERT •
    alertState(a) = resolved ⇒
    alertState'(a) = resolved
```

A resolved alert cannot become active again.

---

```z
∀ d1, d2 : DEVICE •
    d1 ≠ d2 ∧
    deviceState(d1) = online ⇒
    deviceState(d2) ∈ {registered, offline, error, decommissioned, online}
```
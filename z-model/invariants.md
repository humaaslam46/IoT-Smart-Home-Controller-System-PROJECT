# Z Invariants
 ---
 
Only registered users can log in.
---

```z
authenticatedUsers ⊆ registeredUsers


```

Every registered device must have exactly one status.
---

```z
dom deviceStatus = registeredDevices

```

Only registered devices may behave as smart doors.
---

```z
∀ d : DEVICE • d ∈ dom doorState ⇒ d ∈ registeredDevices
```

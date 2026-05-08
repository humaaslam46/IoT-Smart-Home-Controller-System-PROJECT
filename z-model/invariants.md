# Z Invariants

```z
∀ r : rules •
ruleTarget(r) ∈ devices
```

Every rule must target an existing device.

---

```z
∀ d : devices •
deviceState(d) ≠ DECOMMISSIONED
∨ deviceState(d) = DECOMMISSIONED
```

Every device must always have a valid state.

---

```z
∀ u : users •
userRole(u) ∈ {Admin, Resident, Guest}
```

Every user must have exactly one valid role.

---

```z
∀ a : alerts •
alertState(a) ∈ {ACTIVE, RESOLVED}
```

Every alert must exist in a valid alert state.
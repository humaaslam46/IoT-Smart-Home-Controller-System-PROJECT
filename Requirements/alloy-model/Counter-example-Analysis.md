# Alloy Model – Structural Verification

**Tool:** Alloy Analyzer  
**System:** IoT Smart Home Controller  

---

## 1. Relational Model (Signatures + Relations)

The model represents the smart home as a set of relations:

| Signature | Relations | Purpose |
|-----------|-----------|---------|
| `User` | `Owner`, `Guest`, `Resident` | User roles |
| `Room` | `LivingRoom`, `Bedroom`, `Kitchen`, `Garage` | Physical locations |
| `Device` | `state` (On/Off), `locatedIn` (Room) | Abstract device |
| `Light`, `Fan`, `AC`, `Sensor` | extend `Device` | Concrete device types |
| `Door` | `doorState` (Locked/Unlocked), `connects` (Room) | Door with lock state |
| `Alarm` | `alarmState` (Active/Inactive) | Security alarm |
| `SmartHome` | `users`, `devices`, `doors`, `mode` (Home/Away) | System container |

**Key relations:**
- `Device -> DeviceState` (total function)
- `Door -> DoorState`
- `SmartHome -> HomeMode`

---

## 2. Constraint Verification (Invariants)

We defined a **fact** (invariant) that must always hold:

```alloy
fact AwayModeSafety {
    SmartHome.mode = Away implies {
        all l : Light | l.state = Off
        all f : Fan | f.state = Off
        all d : Door | d.doorState = Locked
        Alarm.alarmState = Active
    }
}
````
---

## 3. Counterexample Analysis

We intentionally created three faulty assertions to generate counterexamples.

---

### CE 1: All Lights Always Off

**Description:**  
This assertion claims that every light is always Off. However, when the system is in Home mode, lights can be turned On. Alloy finds a counterexample where `SmartHome.mode = Home` and a light `Light0` has `state = On`. This shows the system does not unnecessarily force lights off.

**Code:**

```alloy
assert AllLightsAlwaysOff {
    all l : Light | l.state = Off
}
```
---
### CE 2: All Doors Always Unlocked

**Description:**  
This assertion claims every door is always Unlocked. In Away mode, the invariant forces all doors to be Locked. Alloy finds a counterexample with `SmartHome.mode = Away` and a door Door0 having `doorState = Locked`. The counterexample confirms the security rule works correctly.

**Code:**
```alloy
assert AllDoorsAlwaysUnlocked {
    all d : Door | d.doorState = Unlocked
}

check AllDoorsAlwaysUnlocked for 15
```
---

### CE 3: Alarms Alway Inactive

**Description:**  
This assertion claims the alarm is always Inactive. But when the system switches to Away mode, the invariant activates the alarm. Alloy finds a counterexample with`mode = Away` and `Alarm.alarmState = Active.` This verifies the alarm behavior is correctly tied to home mode.

**Code:**
```alloy
assert AlarmAlwaysInactive {
    Alarm.alarmState = Inactive
}

check AlarmAlwaysInactive for 15
```
---


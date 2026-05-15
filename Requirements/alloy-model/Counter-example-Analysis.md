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

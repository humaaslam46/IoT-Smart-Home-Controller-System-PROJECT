module IoTSmartHome

// =====================================================
// USERS
// =====================================================

abstract sig User {}

one sig Owner, Guest, Resident extends User {}

// =====================================================
// ROOMS
// =====================================================

abstract sig Room {}

one sig LivingRoom, Bedroom, Kitchen, Garage extends Room {}

// =====================================================
// DEVICE STATES
// =====================================================

abstract sig DeviceState {}

one sig On, Off extends DeviceState {}

abstract sig DoorState {}

one sig Locked, Unlocked extends DoorState {}

abstract sig AlarmState {}

one sig Active, Inactive extends AlarmState {}

abstract sig HomeMode {}

one sig Home, Away extends HomeMode {}

// =====================================================
// DEVICES
// =====================================================

abstract sig Device {
    state : one DeviceState,
    locatedIn : one Room
}

sig Light extends Device {}
sig Fan extends Device {}
sig AC extends Device {}
sig Sensor extends Device {}

// =====================================================
// DOORS
// =====================================================

sig Door {
    doorState : one DoorState,
    connects : one Room
}

// =====================================================
// ALARM SYSTEM
// =====================================================

one sig Alarm {
    alarmState : one AlarmState
}

// =====================================================
// MAIN SMART HOME SYSTEM
// =====================================================

one sig SmartHome {
    users : set User,
    devices : set Device,
    doors : set Door,
    mode : one HomeMode
}

// =====================================================
// SYSTEM FACTS / INVARIANTS
// =====================================================

fact DeviceOwnership {
    SmartHome.devices = Device
}

fact DoorOwnership {
    SmartHome.doors = Door
}

fact UserOwnership {
    SmartHome.users = User
}

// Safety Rule:
// If mode = Away, all ACs, Fans, Lights must be OFF, doors locked, alarm active
fact AwayModeSafety {
    SmartHome.mode = Away implies {
        all l : Light | l.state = Off
        all f : Fan | f.state = Off
        all d : Door | d.doorState = Locked
        Alarm.alarmState = Active
    }
}

// =====================================================
// REALISTIC VISUALIZATION SCENARIO
// =====================================================

pred ShowInstance {
    SmartHome.mode = Home
    Alarm.alarmState = Inactive
    // 5 Lights
    #Light = 5
    // 3 ON, 2 OFF
    #{ l : Light | l.state = On } = 3
    #{ l : Light | l.state = Off } = 2
    // 4 Doors
    #Door = 4
    // 2 unlocked, 2 locked
    #{ d : Door | d.doorState = Unlocked } = 2
    #{ d : Door | d.doorState = Locked } = 2
    // Multiple devices
    #Fan = 3
    #Sensor = 2
}


// =====================================================
// ASSERTIONS THAT HOLD (no counterexample)
// =====================================================

assert NoDeviceOnInAwayMode {
    SmartHome.mode = Away implies {
        all l : Light | l.state = Off
        all f : Fan | f.state = Off
    }
}
check NoDeviceOnInAwayMode for 15

assert DoorsLockedInAway {
    SmartHome.mode = Away implies all d : Door | d.doorState = Locked
}
check DoorsLockedInAway for 15

// =====================================================
// 3 INTENTIONAL COUNTEREXAMPLES
// =====================================================

// Counterexample 1: Claims all lights are always OFF
// But in Home mode, lights can be ON → counterexample
assert AllLightsAlwaysOff {
    all l : Light | l.state = Off
}
check AllLightsAlwaysOff for 15

// Counterexample 2: Claims all doors are always UNLOCKED

assert AllDoorsAlwaysUnlocked {
    all d : Door | d.doorState = Unlocked
}
check AllDoorsAlwaysUnlocked for 15

// Counterexample 3: Claims alarm is always INACTIVE

assert AlarmAlwaysInactive {
    Alarm.alarmState = Inactive
}
check AlarmAlwaysInactive for 15

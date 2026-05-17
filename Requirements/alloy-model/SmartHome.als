module IoTSmartHome
//--------------------------------
// USERS
//--------------------------------

abstract sig User {}

one sig Owner, Guest, Resident extends User {}

// ROOMS
abstract sig Room {}

one sig LivingRoom, Bedroom, Kitchen, Garage extends Room {}
//--------------------------------
// DEVICE STATES
//--------------------------------

abstract sig DeviceState {}

one sig On, Off extends DeviceState {}

abstract sig DoorState {}

one sig Locked, Unlocked extends DoorState {}

abstract sig AlarmState {}

one sig Active, Inactive extends AlarmState {}

abstract sig HomeMode {}

one sig Home, Away extends HomeMode {}

//--------------------------------
// DEVICES
//--------------------------------

abstract sig Device {
    state : one DeviceState,
    locatedIn : one Room
}


// Different device categories
sig Light extends Device {}

sig Fan extends Device {}

sig AC extends Device {}

sig Sensor extends Device {}


//--------------------------------
// DOORS
//--------------------------------

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

//--------------------------------
// MAIN SMART HOME SYSTEM
//--------------------------------

one sig SmartHome {

    users : set User,

    devices : set Device,

    doors : set Door,

    mode : one HomeMode
}


//--------------------------------
// SYSTEM FACTS / INVARIANTS
//--------------------------------

// All devices belong to home
fact DeviceOwnership {
    SmartHome.devices = Device
}


// All doors belong to home
fact DoorOwnership {
    SmartHome.doors = Door
}


// Home must contain all users
fact UserOwnership {
    SmartHome.users = User
}
//--------------------------------
// Safety Rule:
// If mode = Away,
// all ACs, Fans, and Lights must be OFF
fact AwayModeSafety {

    SmartHome.mode = Away implies {

        all l : Light | l.state = Off

        all f : Fan | f.state = Off

        all d : Door | d.doorState = Locked

        Alarm.alarmState = Active
    }
}



//--------------------------------
//  VISUALIZATION 
//--------------------------------

pred ShowInstance {

    SmartHome.mode = Home

    Alarm.alarmState = Inactive


    // 7 Lights
    #Light = 5

    // 5 ON
    # { l : Light | l.state = On } = 4

    // 2 OFF
    # { l : Light | l.state = Off } = 1


    // Doors
    #Door = 4

    // 3 unlocked
    # { d : Door | d.doorState = Unlocked } = 2

    // 2 locked
    # { d : Door | d.doorState = Locked } = 2


    // Multiple devices
    #Fan = 3
    #Sensor = 2
}


// RUN COMMAND

run ShowInstance for 15


//--------------------------------
// ASSERTIONS
//--------------------------------

// Safety property
assert NoDeviceOnInAwayMode {

    SmartHome.mode = Away implies {

        all l : Light | l.state = Off

        all f : Fan | f.state = Off
    }
}

check NoDeviceOnInAwayMode for 15


// Door security property
assert DoorsLockedInAway {

    SmartHome.mode = Away implies
        all d : Door | d.doorState = Locked
}

check DoorsLockedInAway for 15
//--------------------------------
// COUNTEREXAMPLE
//--------------------------------

assert AllDoorsAlwaysLocked {

    all d : Door |
        d.doorState = Locked
}

check AllDoorsAlwaysLocked for 15

import QtQuick 2.0

Item {
    id: root
    width: 20
    height: root.width

    property bool lit
    property color colorOff
    property color colorOn

    Rectangle {
        id: diode
        width: root.width
        height: root.height
        radius: 100
        border.width: 2

        states: [
            State {
                name: "off"
                when: !lit

                PropertyChanges {
                    target: diode;
                    color: colorOff
                }
            },
            State {
                name: "on"
                when: lit

                PropertyChanges {
                    target: diode;
                    color: colorOn
                }
            }
        ]

        transitions: [
            Transition {
                from: "off"
                to: "on"
                ColorAnimation {
                    target: diode;
                    alwaysRunToEnd: true
                    duration: 2000;
                    easing.type: Easing.InOutQuad
                }
            },
            Transition {
                from: "on"
                to: "off"
                ColorAnimation {
                    target: diode;
                    alwaysRunToEnd: true
                    duration: 1000;
                    easing.type: Easing.InOutQuad
                }
            }
        ]
    }
}



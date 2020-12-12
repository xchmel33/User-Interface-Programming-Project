import QtQuick 2.0

Item {
    id: root
    width: 20
    height: root.width

    property color colorOff: "#222"
    property color colorOn: "#666"
    property int blinkDuration: 50

    signal blink()

    Rectangle {
        id: diode
        width: root.width
        height: root.height
        color: root.colorOff
        radius: this.width / 2
        border.width: 2

        Rectangle {
            id: diodeLightArea
            width: parent.width * 1.5
            height: parent.height * 1.5
            color: root.colorOff
            opacity: 0
            radius: this.width / 2
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    SequentialAnimation {
        id: blinkAnimation

        ParallelAnimation {
            alwaysRunToEnd: true

            PropertyAnimation {
                target: diode
                property: "color"
                to: root.colorOn
                duration: root.blinkDuration
            }
            PropertyAnimation {
                target: diodeLightArea
                property: "color"
                to: root.colorOn
                duration: root.blinkDuration
            }
            PropertyAnimation {
                target: diodeLightArea
                property: "opacity"
                to: 0.4
                duration: root.blinkDuration
            }
        }

        ParallelAnimation {
            id: offAnimation
            alwaysRunToEnd: true

            PropertyAnimation {
                target: diode
                property: "color"
                to: root.colorOff
                duration: root.blinkDuration
            }
            PropertyAnimation {
                target: diodeLightArea
                property: "color"
                to: root.colorOff
                duration: root.blinkDuration
            }
            PropertyAnimation {
                target: diodeLightArea
                property: "opacity"
                to: 0
                duration: root.blinkDuration
            }
        }
    }

    onBlink: {
        blinkAnimation.start();
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:4}
}
##^##*/

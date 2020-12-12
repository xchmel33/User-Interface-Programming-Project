import QtQuick 2.8
import QtQuick.Timeline 1.0
import QtQuick.Controls 2.3

Item {
    id: sideMenu
    width: parent.width
    height: parent.height;
    state: "closed"

    function setState(state) {
        sideMenu.state = state
    }

    Rectangle {
        id: sideMenuArea
        width: 250
        height: parent.height
        color: "#595959"
        border.width: 0

        Rectangle {
            id: menuButton
            x: -22
            y: 215
            width: 50
            height: 50
            color: "#595959"
            radius: 25
            anchors.verticalCenter: parent.verticalCenter

            MouseArea {
                id: menuButtonArea
                anchors.fill: parent
                onClicked: function flipIcon()
                {
                    if(sideMenuIcon.mirror) {
                        sideMenuIcon.x += 10
                    } else {
                        sideMenuIcon.x -= 10
                    }

                    sideMenuIcon.mirror = !sideMenuIcon.mirror
                }

                Image {
                    id: sideMenuIcon
                    x: 0
                    y: 10
                    width: 20
                    height: 31
                    source: "components/sideMenuIcon.svg"
                    mirror: true
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

        TextEdit {
            id: labelTempo
            width: 80
            height: 20
            text: qsTr("Tempo:")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.topMargin: 11
            anchors.leftMargin: 7
        }
    }

    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: timelineAnimationOpen
                onFinished: sideMenu.state = "opened"
                duration: 300
                loops: 1
                running: false
                to: 1000
                from: 0
            },
            TimelineAnimation {
                id: timelineAnimationClose
                onFinished: sideMenu.state = "closed"
                duration: 700
                loops: 1
                running: false
                to: 0
                from: 1000
            }
        ]
        enabled: true
        endFrame: 1000
        startFrame: 0

        KeyframeGroup {
            target: sideMenuArea
            property: 'x'
            Keyframe {
                easing.bezierCurve: [0.337, 0.229, 0.758, 0.282, 1, 1]
                frame: 1000
                value: 390
            }

            Keyframe {
                frame: 0
                value: 640
            }
        }
    }

    Connections {
        target: menuButtonArea
        enabled: sideMenu.state === "opened"
        function onClicked() { setState("closing") }
    }

    Connections {
        target: menuButtonArea
        enabled: sideMenu.state === "closed"
        function onClicked() { setState("opening") }
    }

    states: [
        State {
            name: "opening"

            PropertyChanges {
                target: timelineAnimationOpen
                running: true
            }
        },
        State {
            name: "opened"
        },
        State {
            name: "closing"

            PropertyChanges {
                target: timelineAnimationClose
                running: true
            }
        },
        State {
            name: "closed"
        }
    ]
}



/*##^##
Designer {
    D{i:0;formeditorZoom:2}D{i:7}
}
##^##*/

import QtQuick 2.0
import QtQuick.Timeline 5.15

Item {
    id: item1
    width: 700
    state: "closed"
    Rectangle {
        id: sidemenu
        x: 450
        y: 0
        width: 250
        height: 480
        color: "#595959"
    }

    Timeline {
        id: timeline
        currentFrame: -1
        animations: [
            TimelineAnimation {
                id: timelineAnimation
                onFinished: item1.state = "opened"
                duration: 300
                loops: 1
                running: false
                to: 1000
                from: 0
            }
        ]
        enabled: true
        endFrame: 1000
        startFrame: 0
    }
    states: [
        State {
            name: "opening"

            PropertyChanges {
            }

            PropertyChanges {
            }
        },
        State {
            name: "opened"
        },
        State {
            name: "closing"
        },
        State {
            name: "closed"
        }
    ]

}

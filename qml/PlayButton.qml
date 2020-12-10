import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    id: playButton

    signal clicked()
    property bool running

    width: 100
    height: 100
    state: running ? "pause" : "play"

    RoundButton {
        id: button
        width: playButton.width
        height: playButton.height
        text: ""
        padding: 24
        state: "pause"
        highlighted: false
        flat: true
        display: AbstractButton.IconOnly
        icon.source: "play.svg"
        icon.color: "green"
        icon.height: parent.height - this.padding * (this.padding / parent.height)
        icon.width: parent.width - this.padding * (this.padding / parent.width)
        onClicked: playButton.clicked()
    }

    states: [
        State {
            name: "play"
            PropertyChanges {
                target: button;
                icon.color: "green";
                icon.source: "play.svg"
            }
        },
        State {
            name: "pause"
            PropertyChanges {
                target: button;
                icon.color: "orange";
                icon.source: "pause.svg"
            }
        }
    ]
}



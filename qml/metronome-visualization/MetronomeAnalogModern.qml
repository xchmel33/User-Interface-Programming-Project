import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQml.Models 2.1

Item {
    id: metronomeAnalogModern
    width: 480
    height: parent.height
    state: "idle"

    property int tempo
    property string tempoName
    property bool running

    readonly property int minTempo: 12
    readonly property int maxTempo: 240

    signal tempoChange(int newTempo);

    QtObject {
        id: internal
        property int swingDuration: 60000 / tempo
        property int widthScale: metronomeAnalogModern.width / 480
        property int heightScale: metronomeAnalogModern.height / 680
    }

    TempoIndicators {
        id: tempoIndicators
        height: 128
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.leftMargin: 0
        tempo: metronomeAnalogModern.tempo
        tempoName: metronomeAnalogModern.tempoName
    }

    Image {
        id: metronomBase
        width: metronomeAnalogModern.width / 2
        anchors.bottom: parent.bottom
        source: "metronome_base_larger.svg"
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        z: 10

        Image {
            id: needlePick
            height: 26
            anchors.horizontalCenter: parent.horizontalCenter
            source: "needle_small.svg"
            z: 20
            fillMode: Image.PreserveAspectFit
            sourceSize.width: 47
            sourceSize.height: 188
        }

        Image {
            id: needle
            y: 0
            height: (metronomeAnalogModern.height / 5) * 4
            visible: true
            anchors.bottom: parent.bottom
            source: "needle.svg"
            anchors.bottomMargin: 16
            anchors.horizontalCenter: parent.horizontalCenter
            z: -10
            transformOrigin: Item.Bottom
            sourceSize.height: 520
            sourceSize.width: 20
            fillMode: Image.PreserveAspectFit
            rotation: 0
        }

        PlayButton {
            id: playButton
            x: 53
            y: 8
            width: 80
            height: 80
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            running: metronomeAnalogModern.running
            z: 20
            onClicked: {
                metronomeAnalogModern.running = !metronomeAnalogModern.running
            }
        }
    }

    Timer {
        interval: internal.swingDuration
        running: metronomeAnalogModern.running
        repeat: true
        onTriggered: {
            console.info(metronomeAnalogModern.state)
            switch (metronomeAnalogModern.state) {
            case "idle":
                metronomeAnalogModern.state = "right";
                break;
            case "right":
                metronomeAnalogModern.state = "left";
                break;
            case "left":
                metronomeAnalogModern.state = "right";
                break;
            }
        }
    }

    states: [
        State {
            name: "idle"
            PropertyChanges {
                target: needle;
                rotation: 0
            }
        },
        State {
            name: "left"
            PropertyChanges {
                target: needle;
                rotation: -20
            }
        },
        State {
            name: "right"
            PropertyChanges {
                target: needle;
                rotation: 20
            }
        }
    ]

    transitions: [
        Transition {
            from: "idle"
            to: "right"
            RotationAnimation {
                target: needle;
                alwaysRunToEnd: false
                direction: RotationAnimation.Clockwise;
                duration: internal.swingDuration / 2;
                easing.type: Easing.InOutQuad
            }
        },
        Transition {
            from: "right"
            to: "left"
            RotationAnimation {
                target: needle;
                alwaysRunToEnd: false
                direction: RotationAnimation.Counterclockwise;
                duration: internal.swingDuration;
                easing.type: Easing.InOutQuad
            }
        },
        Transition {
            from: "left"
            to: "right"
            RotationAnimation {
                target: needle;
                alwaysRunToEnd: false
                direction: RotationAnimation.Clockwise;
                duration: internal.swingDuration;
                easing.type: Easing.InOutQuad
            }
        },
        Transition {
            from: "left"
            to: "idle"
            RotationAnimation {
                target: needle;
                alwaysRunToEnd: false
                direction: RotationAnimation.Counterclockwise;
                duration: internal.swingDuration;
                easing.type: Easing.InOutQuad
            }
        },
        Transition {
            from: "right"
            to: "idle"
            RotationAnimation {
                target: needle;
                alwaysRunToEnd: false
                direction: RotationAnimation.Clockwise;
                duration: internal.swingDuration;
                easing.type: Easing.InOutQuad
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;annotation:"1 //;;//  //;;// Ondřej Míchal //;;// <!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'Sans Serif'; font-size:9pt; font-weight:400; font-style:normal;\">\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><br /></p></body></html> //;;// 1605282090";customId:"";formeditorZoom:6}
}
##^##*/

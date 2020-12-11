import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQml.Models 2.1

MetronomeVisualization {
    id: metronomeAnalogClassic
    width: 480
    height: 680
    state: "idle"

    QtObject {
        id: internal
        property int swingDuration: 60000 / tempo
        property int widthScale: metronomeAnalogClassic.width / 480
        property int heightScale: metronomeAnalogClassic.height / 680
    }

    TempoIndicators {
        id: tempoIndicators
        height: 128
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.leftMargin: 0
        tempo: metronomeAnalogClassic.tempo
        tempoName: metronomeAnalogClassic.tempoName
    }

    Image {
        id: metronomBase
        width: metronomeAnalogClassic.width / 2
        anchors.bottom: parent.bottom
        source: "metronome_base.svg"
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        z: 10

        Image {
            id: needle
            y: 0
            height: (metronomeAnalogClassic.height / 5) * 4
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

            Rectangle {
                id: slider
                y: 30
                width: 45
                height: 60
                color: "darkgray"
                anchors.horizontalCenter: parent.horizontalCenter

                onYChanged: {
                    let maxTempo = metronomeAnalogClassic.maxTempo;
                    let minTempo = metronomeAnalogClassic.minTempo;
                    let maxY = sliderMouseArea.drag.maximumY;
                    let minY = sliderMouseArea.drag.minimumY;

                    let newTempo = Math.floor((slider.y - minY) / (maxY - minY) * (maxTempo - minTempo) + minTempo);
                    metronomeAnalogClassic.tempoChange(newTempo);
                }

                MouseArea {
                    id: sliderMouseArea
                    width: slider.width
                    height: slider.height
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    enabled: metronomeAnalogClassic.state == "idle" ? true : false
                    drag.target: slider
                    drag.axis: Drag.YAxis
                    drag.minimumY: 20
                    drag.maximumY: needle.height - metronomBase.height - slider.height
                }
            }
        }

        PlayButton {
            id: playButton
            x: 53
            y: 8
            width: 80
            height: 80
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            running: metronomeAnalogClassic.running
            z: 20
            onClicked: {
                metronomeAnalogClassic.running = !metronomeAnalogClassic.running
            }
        }
    }

    Timer {
        interval: internal.swingDuration
        running: metronomeAnalogClassic.running
        repeat: true
        onTriggered: {
            console.info(metronomeAnalogClassic.state)
            switch (metronomeAnalogClassic.state) {
            case "idle":
                metronomeAnalogClassic.state = "right";
                break;
            case "right":
                metronomeAnalogClassic.state = "left";
                break;
            case "left":
                metronomeAnalogClassic.state = "right";
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
    D{i:0;annotation:"1 //;;//  //;;// Ondřej Míchal //;;// <!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'Sans Serif'; font-size:9pt; font-weight:400; font-style:normal;\">\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><br /></p></body></html> //;;// 1605282090";customId:""}
}
##^##*/

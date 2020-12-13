import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import QtQml.Models 2.1

import "../components"

MetronomeVisualization {
    id: metronomeAnalogClassic
    width: 9 * (this.height / 16)
    height: parent !== null ? parent.height : 680
    state: "idle"

    TempoIndicators {
        id: tempoIndicators
        height: parent.height / 6
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.leftMargin: 15
        tempo: metronomeAnalogClassic.tempo
        tempoName: metronomeAnalogClassic.tempoName
    }

    QtObject {
        id: internal
        property bool sliderEnabled: true
    }

    RowLayout {
        id: row
        height: parent.height / 7
        spacing: 6
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0

        Item {
            id: leftItem
            width: 200
            height: 200
            Layout.fillWidth: true
            Layout.fillHeight: true

            RoundButton {
                id: tapButton
                height: 3 * (parent.height / 4)
                width: this.height
                text: qsTr("TAP")
                anchors.verticalCenter: parent.verticalCenter
                display: AbstractButton.TextOnly
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: (16 * (this.width / 78)) <= 0 ? 16 : (16 * (this.width / 78))
                hoverEnabled: true
                flat: false
                highlighted: true
                autoRepeatDelay: 0
                onPressed: {
                    metronomeAnalogClassic.tap();
                }
            }
        }

        Image {
            id: metronomBase
            source: "metronome_base.svg"
            sourceSize.height: this.height
            Layout.preferredHeight: parent.height
            Layout.preferredWidth: this.height * 2
            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            fillMode: Image.PreserveAspectFit
            z: 10

            Image {
                id: needle
                height: (metronomeAnalogClassic.height / 4) * 3
                visible: true
                anchors.bottom: parent.bottom
                source: "needle.svg"
                mirror: false
                anchors.bottomMargin: 16
                anchors.horizontalCenter: parent.horizontalCenter
                z: -10
                transformOrigin: Item.Bottom
                sourceSize.height: this.height
                fillMode: Image.PreserveAspectFit
                rotation: 0

                Rectangle {
                    id: slider
                    y: 30
                    width: parent.width * 1.5
                    height: this.width * 1.5
                    color: "darkgray"
                    anchors.horizontalCenter: parent.horizontalCenter

                    onYChanged: {
                        if (internal.sliderEnabled) {
                            let maxTempo = metronomeAnalogClassic.maxTempo;
                            let minTempo = metronomeAnalogClassic.minTempo;
                            let maxY = sliderMouseArea.drag.maximumY;
                            let minY = sliderMouseArea.drag.minimumY;

                            let newTempo = ((slider.y - minY) * (maxTempo - minTempo)) / (maxY - minY) + minTempo;
                            metronomeAnalogClassic.tempoChange(newTempo);
                        }
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
                    metronomeAnalogClassic.runningChange(!metronomeAnalogClassic.running);
                }
            }
        }

        Item {
            id: rightItem
            width: 200
            height: 200
            Layout.fillWidth: true
            Layout.fillHeight: true
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
                duration: metronomeAnalogClassic.tempoMs;
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
                duration: metronomeAnalogClassic.tempoMs;
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
                duration: metronomeAnalogClassic.tempoMs;
                easing.type: Easing.InOutQuad
            }
        },
        Transition {
            from: "left"
            to: "idle"
            RotationAnimation {
                target: needle;
                alwaysRunToEnd: false
                direction: RotationAnimation.Clockwise;
                duration: 500;
                easing.type: Easing.InOutQuad
            }
        },
        Transition {
            from: "right"
            to: "idle"
            RotationAnimation {
                target: needle;
                alwaysRunToEnd: false
                direction: RotationAnimation.Counterclockwise;
                duration: 500;
                easing.type: Easing.InOutQuad
            }
        }
    ]

    onBeat: {
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

    onRunningChanged: {
        if (!metronomeAnalogClassic.running) {
            metronomeAnalogClassic.state = "idle";
        }
    }

    onTempoChanged: {
        metronomeAnalogClassic.syncSliders();
    }

    onHeightChanged: {
        metronomeAnalogClassic.syncSliders();
    }

    onSyncSliders: {
        let maxTempo = metronomeAnalogClassic.maxTempo;
        let minTempo = metronomeAnalogClassic.minTempo;
        let maxY = sliderMouseArea.drag.maximumY;
        let minY = sliderMouseArea.drag.minimumY;

        internal.sliderEnabled = false;

        slider.y = ((tempo - minTempo) * (maxY - minY)) / (maxTempo - minTempo) + minY;

        internal.sliderEnabled = true;
    }
}

/*##^##
Designer {
    D{i:0;annotation:"1 //;;//  //;;// Ondřej Míchal //;;// <!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'Sans Serif'; font-size:9pt; font-weight:400; font-style:normal;\">\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><br /></p></body></html> //;;// 1605282090";customId:""}
D{i:5}
}
##^##*/

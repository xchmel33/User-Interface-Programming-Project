import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    id: metronomeAnalogClassic
    width: 480
    height: 680

    property int tempo
    property string tempoName
    property bool running

    QtObject {
        id: internal
        property int swingDuration: 60000 / tempo
    }

    Column {
        id: tempoIndicators
        height: 80
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 8
        spacing: 8

        Text {
            id: tempoNumber
            text: tempo
            anchors.left: parent.left
            font.pixelSize: 28
            maximumLineCount: 0
            anchors.leftMargin: 16
        }

        Text {
            id: tempoText
            text: tempoName
            anchors.left: parent.left
            font.pixelSize: 12
            anchors.leftMargin: 16
            maximumLineCount: 0
        }
    }


    Column {
        id: metronomBaseContainer
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0

        Image {
            id: metronomBase
            width: 200
            height: 100
            anchors.bottom: parent.bottom
            source: "metronome_base.svg"
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.Stretch
            anchors.bottomMargin: 0
            z: 10

            Image {
                id: play
                x: 79
                y: 34
                anchors.verticalCenter: parent.verticalCenter
                source: "play.svg"
                z: 10
                anchors.verticalCenterOffset: 5
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.Stretch
            }

            Image {
                id: needle
                x: 230
                y: -416
                width: 20
                height: 490
                visible: true
                anchors.bottom: metronomBase.bottom
                source: "needle.svg"
                anchors.horizontalCenter: parent.horizontalCenter
                z: -10
                transformOrigin: Item.Bottom
                anchors.bottomMargin: 26
                sourceSize.height: 490
                sourceSize.width: 40
                fillMode: Image.Stretch
                rotation: 0
                state: ""

                states: [
                    State {
                        name: "left"
                        PropertyChanges { target: needle; rotation: 20}
                    },
                    State {
                        name: "right"
                        PropertyChanges { target: needle; rotation: -20}
                    }
                ]

                transitions: [
                    Transition {
                        from: "NORMAL"
                        to: "right"
                        RotationAnimation {
                            target: needle;
                            alwaysRunToEnd: false
                            direction: RotationAnimation.Counterclockwise;
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
                            direction: RotationAnimation.Clockwise;
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
                            direction: RotationAnimation.Counterclockwise;
                            duration: internal.swingDuration;
                            easing.type: Easing.InOutQuad
                        }
                    },
                    Transition {
                        from: "left"
                        to: ""
                        RotationAnimation {
                            target: needle;
                            alwaysRunToEnd: false
                            direction: RotationAnimation.Clockwise;
                            duration: internal.swingDuration;
                            easing.type: Easing.InOutQuad
                        }
                    },
                    Transition {
                        from: "right"
                        to: ""
                        RotationAnimation {
                            target: needle;
                            alwaysRunToEnd: false
                            direction: RotationAnimation.Counterclockwise;
                            duration: internal.swingDuration;
                            easing.type: Easing.InOutQuad
                        }
                    }
                ]

                NumberAnimation {
                    id: numberAnimation
                    target: needle
                }
            }
        }

    }

    Timer {
        interval: internal.swingDuration;
        running: metronomeAnalogClassic.running;
        repeat: true;
        onTriggered: {
            switch (needle.state) {
            case "":
                needle.state = "right";
                break;
            case "right":
                needle.state = "left";
                break;
            case "left":
                needle.state = "right";
                break;
            }
        }
    }


}

/*##^##
Designer {
    D{i:0;annotation:"1 //;;//  //;;// Ondřej Míchal //;;// <!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'Sans Serif'; font-size:9pt; font-weight:400; font-style:normal;\">\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><br /></p></body></html> //;;// 1605282090";customId:"";formeditorZoom:1.3300000429153442}
}
##^##*/

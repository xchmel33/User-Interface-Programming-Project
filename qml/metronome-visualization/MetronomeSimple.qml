import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15

MetronomeVisualization {
    id: metronomeSimple
    width: 480
    height: 680

    ColumnLayout {
        id: root
        anchors.fill: parent
        anchors.bottomMargin: 16
        anchors.rightMargin: 0
        anchors.topMargin: 16
        spacing: 32

        ColumnLayout {
            id: dataRow
            spacing: 16
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.fillHeight: true
            Layout.fillWidth: true

            RowLayout {
                id: diodeRow
                Layout.fillHeight: false
                spacing: 16
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                Diode {
                    id: redDiode
                    lit: false
                    colorOn: "#ee3737"
                    colorOff: "#ffd1d1"
                }

                Diode {
                    id: greenDiode
                    lit: false
                    colorOn: "#4ee610"
                    colorOff: "#d8ffc8"
                }
            }

            TempoIndicators {
                id: tempoIndicators
                width: root.width
                height: 128
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                tempo: metronomeSimple.tempo
                tempoName: metronomeSimple.tempoName
                centered: true
            }
        }

        ColumnLayout {
            id: controlsRow
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            spacing: 16

            FilledSlider {
                id: filledSlider
                height: 55
                fillColor: "#76ccfc"
                handleColor: "#24a5ec"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                minValue: metronomeSimple.minTempo
                maxValue: metronomeSimple.maxTempo
                onValueChanged: {
                    metronomeSimple.tempoChange(newValue);
                }
            }

            RowLayout {
                id: rowLayout
                width: 100
                height: 100
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                spacing: 64

                Rectangle {
                    id: minusButton
                    height: parent.height
                    width: this.height
                    radius: this.width / 2
                    border.width: 2
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: false
                    color: "#ffffff"

                    Rectangle {
                        id: minusSign
                        width: parent.width / 3
                        height: this.width / 5
                        color: "#000"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            metronomeSimple.tempoChange(metronomeSimple.tempo - 1)
                        }
                    }
                }

                Rectangle {
                    id: plusButton
                    height: parent.height
                    width: this.height
                    radius: this.width / 2
                    border.width: 2
                    Layout.fillHeight: true
                    Layout.fillWidth: false
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    color: "#ffffff"

                    Rectangle {
                        id: plusSign1
                        width: parent.width / 3
                        height: this.width / 5
                        color: "#000"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Rectangle {
                        id: plusSign2
                        width: this.height / 5
                        height: parent.height / 3
                        color: "#000"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            metronomeSimple.tempoChange(metronomeSimple.tempo + 1)
                        }
                    }
                }
            }

            PlayButton {
                id: playButton
                Layout.fillWidth: false
                running: metronomeSimple.running
                Layout.fillHeight: false
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                onClicked: {
                    metronomeSimple.runningChange(!metronomeSimple.running);
                }
            }
        }
    }

    QtObject {
        id: internal
        property int widthScale: metronomeSimple.width / 480
        property int heightScale: metronomeSimple.height / 680
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}
}
##^##*/

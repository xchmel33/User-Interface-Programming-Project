import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15

import "../components"

MetronomeVisualization {
    id: metronomeSimple
    width: 480
    height: 680

    ColumnLayout {
        id: root
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.bottomMargin: 16
        anchors.rightMargin: 16
        anchors.topMargin: 16
        spacing: 32

        ColumnLayout {
            id: dataRow
            spacing: 16
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: (parent / 2) - (32 / 2)

            RowLayout {
                id: diodeRow
                Layout.fillHeight: false
                spacing: 16
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                Diode {
                    id: redDiode
                    colorOn: "#ee3737"
                    colorOff: "#ffd1d1"
                }

                Diode {
                    id: greenDiode
                    colorOn: "#4ee610"
                    colorOff: "#d8ffc8"
                }
            }

            TempoIndicators {
                id: tempoIndicators
                width: root.width
                height: 128
                Layout.minimumHeight: 200
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
            Layout.minimumHeight: (parent.height / 2) - (32 / 2)
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            spacing: 16

            TempoControllers {
                id: tempoControllers
                height: 200
                fillColor: "#76ccfc"
                handleColor: "#24a5ec"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                enabled: !metronomeSimple.running
                minValue: metronomeSimple.minTempo
                maxValue: metronomeSimple.maxTempo
                value: metronomeSimple.tempo
                onValueChange: {
                    metronomeSimple.tempoChange(newValue);
                }
            }

            RowLayout {
                spacing: 32
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                RoundButton {
                    id: tapButton
                    text: qsTr("TAP")
                    font.pointSize: 16
                    hoverEnabled: true
                    flat: false
                    highlighted: true
                    autoRepeatDelay: 0
                    Layout.preferredWidth: 70
                    Layout.preferredHeight: 70
                    Layout.fillHeight: false
                    Layout.fillWidth: false
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    onPressed: {
                        metronomeSimple.tap();
                    }
                }

                PlayButton {
                    id: playButton
                    running: metronomeSimple.running
                    Layout.fillWidth: false
                    Layout.fillHeight: false
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    onClicked: {
                        metronomeSimple.runningChange(!metronomeSimple.running);
                    }
                }
            }
        }
    }

    onBeat: {
        greenDiode.blink();
    }

    QtObject {
        id: internal
        property int widthScale: metronomeSimple.width / 480
        property int heightScale: metronomeSimple.height / 680
    }
}



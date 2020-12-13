import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15

import "../components"

MetronomeVisualization {
    id: metronomeSimple
    height: parent !== null ? parent.height : 680
    width: (this.height / 16) * 9

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
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.preferredHeight: parent.height / 12
                Layout.fillHeight: false
                spacing: 16

                Diode {
                    id: redDiode
                    Layout.preferredWidth: this.height
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    colorOn: "#ee3737"
                    colorOff: "#ffd1d1"
                }

                Diode {
                    id: greenDiode
                    Layout.preferredWidth: this.height
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
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
            Layout.maximumHeight: (parent.height / 2)
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            spacing: 16

            TempoControllers {
                id: tempoControllers
                fillColor: "#76ccfc"
                handleColor: "#24a5ec"
                Layout.preferredHeight: parent.height / 2
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
                Layout.minimumHeight: 100
                Layout.fillHeight: false
                Layout.fillWidth: false
                Layout.preferredHeight: parent.height / 3
                spacing: 32
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                RoundButton {
                    id: tapButton
                    text: qsTr("TAP")
                    font.pointSize: (16 * (this.width / 78)) <= 0 ? 16 : (16 * (this.width / 78))
                    enabled: !metronomeSimple.running
                    hoverEnabled: true
                    flat: false
                    highlighted: true
                    autoRepeatDelay: 0
                    Layout.preferredHeight: 2 * (parent.height / 3)
                    Layout.preferredWidth: 2 * (parent.height / 3)
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    onPressed: {
                        metronomeSimple.tap();
                    }
                }

                PlayButton {
                    id: playButton
                    running: metronomeSimple.running
                    Layout.preferredHeight: parent.height
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

    onSyncSliders: {
        tempoControllers.syncSliders();
    }

    QtObject {
        id: internal
        property int widthScale: metronomeSimple.width / 480
        property int heightScale: metronomeSimple.height / 680
    }
}


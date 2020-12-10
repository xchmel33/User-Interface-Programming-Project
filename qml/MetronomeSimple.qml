import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15

Item {
    id: metronomeSimple
    width: 480
    height: 680

    property int tempo
    property string tempoName
    property bool running

    ColumnLayout {
        id: root
        anchors.fill: parent
        spacing: 8

        RowLayout {
            id: diodeRow
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
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            tempo: metronomeSimple.tempo
            tempoName: metronomeSimple.tempoName
        }

        FilledSlider {
            id: filledSlider
            height: 45
            fillColor: "#76ccfc"
            handleColor: "#24a5ec"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        PlayButton {
            id: playButton
            Layout.fillHeight: false
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

    }

    QtObject {
        id: internal
        property int swingDuration: 60000 / tempo
        property int widthScale: metronomeSimple.width / 480
        property int heightScale: metronomeSimple.height / 680
    }
}

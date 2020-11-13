import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("FIT Metronome")

    MetronomeAnalogClassic {
        id: metronomeAnalogClassic
        x: 105
        y: -157
        width: 468
        height: 685
        tempo: 120
        running: true
    }
}

import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: window
    width: 480
    height: 560
    visible: true
    title: qsTr("FIT Metronome")

    MetronomePage {
        id: metronomePage
        anchors.fill: parent
    }
}

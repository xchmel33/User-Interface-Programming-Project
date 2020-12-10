import QtQuick 2.0
import QtQml.Models 2.12
import QtQuick.Controls 2.15

Item {
    id: metronomePage
    width: 480
    height: 560

    function updateTempo(newTempo) {
        metronomeAnalogClassic.tempo = newTempo;
    }

    StackView {
        id: stackView
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        initialItem: metronomeAnalogClassic

        MetronomeAnalogClassic {
            id: metronomeAnalogClassic
            x: 0
            y: 0
            width: 480
            height: 558
            tempoName: "Adagio"
            tempo: 80
            running: false
            onTempoChange: updateTempo(newTempo)
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorColor:"#4c4e50";formeditorZoom:0.8999999761581421}
}
##^##*/

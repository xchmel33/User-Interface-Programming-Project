import QtQuick 2.0
import QtQml.Models 2.12
import QtQuick.Controls 2.15
import Qt.labs.settings 1.0

Item {
    id: metronomePage
    width: 480
    height: 560

    property int tempo: 80
    property string tempoName: "Adagio"
    property bool running: false

    function updateTempo(newTempo) {
        metronomePage.tempo = newTempo;
    }

    ObjectModel {
        id: itemModel

        MetronomeSimple { tempo: metronomePage.tempo; tempoName: metronomePage.tempoName; running: metronomePage.running; onTempoChange: updateTempo(newTempo) }
        MetronomeAnalogClassic { tempo: metronomePage.tempo; tempoName: metronomePage.tempoName; running: metronomePage.running; onTempoChange: updateTempo(newTempo) }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: itemModel.get(1)

        Settings {
            property alias currentVisualiation: stackView.initialItem
        }
    }

    Settings {
        property alias tempo: metronomePage.tempo
        property alias tempoName: metronomePage.tempoName
    }
}


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


    function setView(viewNo) {
        let newViewModel = itemModel.get(viewNo)
        let currViewModel = stackView.currentItem
        if(newViewModel !== currViewModel) {
            stackView.replace(newViewModel)
        }
    }

    ObjectModel {
        id: itemModel

        MetronomeSimple { tempo: metronomePage.tempo; tempoName: metronomePage.tempoName }
        MetronomeAnalogClassic { tempo: metronomePage.tempo; tempoName: metronomePage.tempoName }
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


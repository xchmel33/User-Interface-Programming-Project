import QtQuick 2.0
import QtQml.Models 2.12
import QtQuick.Controls 2.15
import Qt.labs.settings 1.0

import "../metronome-visualization"

Item {
    id: metronomePage
    width: 480
    height: 560

    property int tempo: 80
    property string tempoName: "Adagio"
    property int currentViewModelID: 0

    function setView(viewNo) {
        let newViewModel = itemModel.get(viewNo)
        let currViewModel = stackView.currentItem
        if (newViewModel !== currViewModel) {
            stackView.replace(newViewModel)
        }
        metronomePage.currentViewModelID = viewNo
    }

    ObjectModel {
        id: itemModel

        MetronomeSimple { tempo: metronomePage.tempo; tempoName: metronomePage.tempoName }
        MetronomeAnalogClassic { tempo: metronomePage.tempo; tempoName: metronomePage.tempoName }
    }

    StackView {
        id: stackView
        initialItem: itemModel.get(currentViewModelID)
    }

    Settings {
        property alias tempo: metronomePage.tempo
        property alias tempoName: metronomePage.tempoName
        property alias currentViewModelID: metronomePage.currentViewModelID
    }
}


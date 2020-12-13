import QtQuick 2.0
import QtQml.Models 2.12
import QtQuick.Controls 2.15
import Qt.labs.settings 1.0
import QtMultimedia 5.12

import "../metronome-visualization"

Item {
    id: metronomePage
    width: parent.width
    height: parent.height

    property int tempo: 80
    property string tempoName: "Adagio"
    property string beatSound: "/sound/classic-click.wav"
    property string currentProfile: "Default"

    property int currentViewModelID: 0

    function setBeatSound(newBeatSound) {
        metronomePage.beatSound = newBeatSound
    }

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

        MetronomeSimple { tempo: metronomePage.tempo; tempoName: metronomePage.tempoName; beatSound: metronomePage.beatSound }
        MetronomeAnalogClassic { tempo: metronomePage.tempo; tempoName: metronomePage.tempoName; beatSound: metronomePage.beatSound }
    }

    StackView {
        id: stackView
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        width: itemModel.get(currentViewModelID).width
        initialItem: itemModel.get(currentViewModelID)
    }

    Settings {
        property alias tempo: metronomePage.tempo
        property alias tempoName: metronomePage.tempoName
        property alias beatSound: metronomePage.beatSound
        property alias currentViewModelID: metronomePage.currentViewModelID
    }
}


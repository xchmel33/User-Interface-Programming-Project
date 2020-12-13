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

    property string beatSound: "/sounds/classic-click.wav"
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

        MetronomeSimple {
            beatSound: metronomePage.beatSound
        }
        MetronomeAnalogClassic {
            beatSound: metronomePage.beatSound
        }
    }

    StackView {
        id: stackView
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        width: itemModel.get(currentViewModelID).width
        initialItem: itemModel.get(currentViewModelID)
    }

    Settings {
        property alias beatSound: metronomePage.beatSound
        property alias currentViewModelID: metronomePage.currentViewModelID
    }
}


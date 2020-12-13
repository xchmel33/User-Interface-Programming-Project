import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQml.Models 2.12
import QtMultimedia 5.12
import Qt.labs.settings 1.0
import WebLauncher 1.0

import "./pages"

ApplicationWindow {
    id: window
    width: 700
    height: 560
    minimumWidth: metronomePage.width + drawerInteractArea.width
    minimumHeight: metronomePage.height
    visible: true
    title: qsTr("FIT Metronome")

    MetronomePage {
        id: metronomePage
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        Component.onCompleted: themeSelect.currentIndex = metronomePage.currentViewModelID
    }

    Rectangle {
        id: drawerInteractArea
        height: window.height
        border.width: 0
        width: window.width / 20
        opacity: 0.5
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop {
                position: 1
                color: "#b3b3b3"
            }

            GradientStop {
                position: 0
                color: "#00000000"
            }
        }
    }

    Drawer {
        id: drawer
        modal: true
        interactive: true
        height: window.height
        width: window.width / 1.5
        position: 0
        edge: Qt.RightEdge
        dragMargin: window.width / 20

        Label {
            id: labelTheme
            text: qsTr("Select your theme:")
            font.pixelSize: 20
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 10
            anchors.leftMargin: 10
        }

        ComboBox {
            id: themeSelect
            editable: false
            height: 30
            width: parent.width * 0.9
            anchors.top: labelTheme.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10
            model: ListModel {
                id: themeSelectModel
                ListElement {
                    text: qsTr("Simple")
                    //metronomePage.itemModel.idx == 0
                }

                ListElement {
                    text: qsTr("Analog Classic")
                    //metronomePage.itemModel.idx == 1
                }
            }

            onActivated: metronomePage.setView(index)
        }

        Label {
            id: labelSound
            text: qsTr("Select your sound:")
            font.pixelSize: 20
            anchors.top: themeSelect.bottom
            anchors.left: parent.left
            anchors.topMargin: 10
            anchors.leftMargin: 10
        }

        ComboBox {
            id: soundSelect
            editable: false
            height: 30
            width: parent.width * 0.9
            anchors.top: labelSound.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10
            model: beatSoundModel
            textRole: "soundName"

            onActivated: {
                let sound = beatSoundModel.get(index)
                metronomePage.setBeatSound(sound.source)
            }
        }

        Label {
            id: labelProfile
            text: qsTr("Profile:")
            font.pixelSize: 20
            anchors.top: soundSelect.bottom
            anchors.left: parent.left
            anchors.topMargin: 10
            anchors.leftMargin: 10
        }

        ComboBox {
            id: profileSelect
            editable: false
            displayText: metronomePage.currentProfile
            height: 30
            width: parent.width * 0.9
            anchors.top: labelProfile.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10
            model: ListModel {
                id: profileSelectModel
                ListElement { text: qsTr("New") }
                ListElement { text: qsTr("Save") }
                ListElement { text: qsTr("Save As") }
                ListElement { text: qsTr("Load") }
                ListElement { text: qsTr("Delete") }
            }

            //onActivated: metronomePage.setView(index)
        }


        Button {
            id: donateButton
            flat: true
            height: 30
            width: parent.width * 0.3
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.bottomMargin: 10
            text: qsTr("Donate")

            onClicked: donationPage.launch()
        }
    }

    ListModel {
        id: beatSoundModel

        ListElement { soundName: "Classic click" ; source: "/sounds/classic-click.wav" }
        ListElement { soundName: "Arcade Bleep" ; source: "/sounds/arcade-game-jump-coin.wav" }
        ListElement { soundName: "Kiss" ; source: "/sounds/little-cute-kiss.wav" }
        ListElement { soundName: "Countdown Bleep" ; source: "/sounds/clock-countdown-bleeps.wav" }
    }

    DonationPage {
        id: donationPage
    }

    Settings {
        property alias x: window.x
        property alias y: window.y
        property alias width: window.width
        property alias height: window.height
    }
}

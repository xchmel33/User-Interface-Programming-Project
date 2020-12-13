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
    visible: true
    title: qsTr("FIT Metronome")

    MetronomePage {
        id: metronomePage
        anchors.fill: parent
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("&Profile")
            Action { text: qsTr("&New") }
            Action { text: qsTr("&Save") }
            Action { text: qsTr("&Save As") }
            Action { text: qsTr("&Load") }
            Action { text: qsTr("&Delete") }
        }

        Menu {
            title: qsTr("&View")
            Action {
                text: qsTr("&Analog Classic")
                onTriggered: metronomePage.setView(1)
            }
            Action {
                text: qsTr("&Simple")
                onTriggered: metronomePage.setView(0)
            }
        }

        Menu {
            title: qsTr("&Sound")
            Repeater {
                   model: beatSoundModel
                   MenuItem {
                      text: model.soundName
                      onTriggered: metronomePage.setBeatSound(model.source)
                   }
               }
        }

        Menu {
            title: qsTr("&Donate")
            Action {
                //text: qsTr("&Donate")
                onTriggered: donationPage.launch()
            }
        }
    }

    Rectangle {
        id: drawerInteractArea
        height: window.height - window.menuBar.height
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
        height: window.height - window.menuBar.height
        width: window.width / 1.5
        position: 0
        edge: Qt.RightEdge
        dragMargin: window.width / 20
        topMargin: window.menuBar.height
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

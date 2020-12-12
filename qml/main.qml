import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import Qt.labs.settings 1.0
import WebLauncher 1.0
import TempoLut 1.0

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
            title: qsTr("&Donate")
            Action {
                //text: qsTr("&Donate")
                onTriggered: donationPage.launch()
            }
        }
    }

    SideMenu {
        id: sidemenu
        width: window.width
    }

    Settings {
        property alias x: window.x
        property alias y: window.y
        property alias width: window.width
        property alias height: window.height
    }

    LUT {
        id: lut
    }

    DonationPage {
        id: donationPage
    }
}

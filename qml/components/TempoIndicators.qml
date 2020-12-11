import QtQuick 2.0
import QtQuick.Layouts 1.11

Item {
    id: tempoIndicators

    property int tempo: 0
    property string tempoName: "Default"
    property bool centered: false

    width: 180
    height: 60

    ColumnLayout {
        id: column
        width: parent.width
        height: parent.height
        spacing: 8

        Text {
            id: tempoNumber
            text: tempoIndicators.tempo
            font.pixelSize: 28 * (parent.height / 60)
            horizontalAlignment: tempoIndicators.centered ? Text.AlignHCenter : Text.AlignLeft
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            fontSizeMode: Text.VerticalFit
            maximumLineCount: 1
        }

        Text {
            id: tempoText
            text: tempoIndicators.tempoName
            font.pixelSize: 12 * (parent.height / 60)
            horizontalAlignment: tempoIndicators.centered ? Text.AlignHCenter : Text.AlignLeft
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            fontSizeMode: Text.VerticalFit
            maximumLineCount: 1
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.5}
}
##^##*/

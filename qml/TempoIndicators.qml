import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    id: tempoIndicators

    property int tempo
    property string tempoName

    width: column.width
    height: column.height

    Column {
        id: column
        width: 180
        height: 60
        spacing: 8

        Text {
            id: tempoNumber
            text: tempoIndicators.tempo
            anchors.left: parent.left
            font.pixelSize: 28 * (tempoIndicators.height / 60)
            fontSizeMode: Text.VerticalFit
            maximumLineCount: 0
            anchors.leftMargin: 16
        }

        Text {
            id: tempoText
            text: tempoIndicators.tempoName
            anchors.left: parent.left
            font.pixelSize: 12 * (tempoIndicators.height / 60)
            fontSizeMode: Text.VerticalFit
            anchors.leftMargin: 16
            maximumLineCount: 0
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.5}
}
##^##*/

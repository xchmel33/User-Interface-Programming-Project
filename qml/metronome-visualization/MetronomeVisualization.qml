import QtQuick 2.0

Item {
    property int tempo: 80
    property string tempoName: "Adagio"
    property bool running: false

    readonly property int minTempo: 12
    readonly property int maxTempo: 240

    signal tempoChange(int newTempo);
}

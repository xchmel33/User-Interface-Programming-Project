import QtQuick 2.0

Item {
    id: metronomeVisualization
    property int tempo: 80
    property string tempoName: "Adagio"
    property bool running: false

    // tempo == beats per second; 60000 is a minute in ms
    readonly property int tempoMs: 60000 / this.tempo
    readonly property int minTempo: 12
    readonly property int maxTempo: 260

    signal runningChange(bool newState)
    signal tempoChange(int newTempo)
    signal beat();

    Connections {
        target: metronomeVisualization

        function onTempoChange(newTempo) {
            metronomeVisualization.tempo = newTempo;
        }

        function onRunningChange() {
            metronomeVisualization.running = !metronomeVisualization.running;
        }
    }

    Timer {
        interval: metronomeVisualization.tempoMs
        running: metronomeVisualization.running
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            metronomeVisualization.beat();
        }
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

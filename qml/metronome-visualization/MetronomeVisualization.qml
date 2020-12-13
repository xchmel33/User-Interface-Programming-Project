import QtQuick 2.0
import QtMultimedia 5.12
import TempoLUT 1.0

Item {
    id: metronomeVisualization
    property int tempo: 80
    property string tempoName: "Adagio"
    property bool running: false
    property string beatSound: "/sounds/classic-click.wav"
    property var tapPerSecondStart: 0
    property var tapPerSecondEnd: 0

    // tempo == beats per second; 60000 is a minute in ms
    readonly property int tempoMs: 60000 / this.tempo
    readonly property int minTempo: 12
    readonly property int maxTempo: 260

    signal runningChange(bool newState)
    signal tempoChange(int newTempo)
    signal beat();
    signal tap();
    signal syncSliders();

    Connections {
        target: metronomeVisualization

        function onTempoChange(newTempo) {
            if (newTempo >= metronomeVisualization.minTempo && newTempo <= metronomeVisualization.maxTempo) {
                metronomeVisualization.tempo = newTempo;
                metronomeVisualization.tempoName = tempoLUT.getName(newTempo);
            }
        }

        function onRunningChange() {
            metronomeVisualization.running = !metronomeVisualization.running;
            if (metronomeVisualization.running === false)
                beatSoundPlayer.stop();
        }

        function onBeat() {
            if (beatSoundPlayer !== null && beatSoundPlayer.status === SoundEffect.Ready)
                beatSoundPlayer.play();
        }

        function onTap() {
            metronomeVisualization.tapPerSecondStart = metronomeVisualization.tapPerSecondEnd;
            metronomeVisualization.tapPerSecondEnd = new Date().getTime()

            if (metronomeVisualization.tapPerSecondStart !== 0) {
                // Date.now() returns time in milliseconds
                let elapsedTime = metronomeVisualization.tapPerSecondEnd - metronomeVisualization.tapPerSecondStart;
                let newTempo = 60000 / elapsedTime;
                metronomeVisualization.tempoChange(newTempo);
            }
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

    SoundEffect {
        id: beatSoundPlayer
        source: metronomeVisualization.beatSound
    }

    TempoLUT {
        id: tempoLUT
    }

    Component.onCompleted: syncSliders()
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

QT += \
    quick \
    svg \
    xml

QTPLUGIN += qsvg


CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
        misc/temponamelut.cpp

RESOURCES += qml.qrc

OTHER_FILES += qml/main.qml \
               qml/MetronomeAnalogClassic.qml

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    misc/donatePage.html \
    qml/components/Diode.qml \
    qml/components/PlayButton.qml \
    qml/components/TempoControllers.qml \
    qml/components/TempoIndicators.qml \
    qml/components/sideMenuIcon.svg \
    qml/metronome-visualization/MetronomeAnalogClassic.qml \
    qml/metronome-visualization/MetronomeAnalogModern.qml \
    qml/metronome-visualization/MetronomeSimple.qml \
    qml/metronome-visualization/MetronomeVisualization.qml \
    qml/metronome-visualization/metronome_base.svg \
    qml/metronome-visualization/metronome_base_larger.svg \
    qml/metronome-visualization/needle.svg \
    qml/metronome-visualization/needle_small.svg \
    qml/metronome-visualization/pause.svg \
    qml/metronome-visualization/play.svg \
    qml/pages/MetronomePage.qml \
    sounds/classic-click.wav \

HEADERS += \
    misc/temponamelut.h \
    misc/webLauncher.h

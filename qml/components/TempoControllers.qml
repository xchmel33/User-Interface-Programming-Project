import QtQuick 2.0
import QtQuick.Layouts 1.12

ColumnLayout {
    id: root
    width: 400
    height: 300
    spacing: 32

    property bool enabled: true
    property double minValue
    property double maxValue
    property double value
    property color fillColor: "#444"
    property color handleColor: "#666"

    signal valueChange(int newValue)

    Rectangle {
        id: slider
        color: "white"
        radius: root.height / 2
        border.width: 2
        Layout.preferredHeight: root.height / 3
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        Layout.fillWidth: true
        Layout.fillHeight: true

        Rectangle {
            id: sliderFill
            width: handle.x + handle.width - 2 * slider.border.width
            height: slider.height - 2 * slider.border.width
            radius: slider.radius
            border.width: 0
            anchors.verticalCenter: parent.verticalCenter
            color: root.fillColor
            anchors.left: parent.left
            anchors.leftMargin: slider.border.width
        }

        Rectangle {
            id: handle
            width: slider.height
            height: slider.height - 2 * slider.border.width
            color: root.handleColor
            radius: slider.radius
            border.width: 1
            anchors.verticalCenter: parent.verticalCenter
            transformOrigin: Item.Center

            onXChanged: {
                if (internal.sliderEnabled) {
                    let newValue = handle.x / (slider.width - slider.border.width - handle.width) * (root.maxValue - root.minValue) + root.minValue;
                    root.valueChange(newValue);
                }
            }

            MouseArea {
                id: handleMouseArea
                anchors.fill: parent
                transformOrigin: Item.Center
                enabled: root.enabled
                drag.target: parent
                drag.axis: Drag.XAxis
                drag.minimumX: 0
                drag.maximumX: slider.width - slider.border.width - handle.width
            }
        }

        // Allow moving of the slider while touching the bar itself, not just by
        // touching the handle
        MouseArea {
            anchors.fill: parent
            anchors.bottomMargin: 0
            enabled: root.enabled
            drag.target: handle
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: slider.width - slider.border.width - handle.width
        }
    }

    RowLayout {
        id: buttonRow
        Layout.rightMargin: 16
        Layout.leftMargin: 16
        Layout.preferredHeight: 2 * (root.height / 3) - parent.spacing
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        spacing: 32

        Item {
            id: item1
            width: (parent.width / 2) - parent.spacing / 2
            height: parent.height
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                id: minusButton
                width: parent.height
                height: this.width
                radius: this.width / 2
                border.width: 2
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: false
                color: "#ffffff"

                Rectangle {
                    id: minusSign
                    width: parent.width / 3
                    height: this.width / 5
                    color: "#000"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MouseArea {
                    anchors.fill: parent
                    enabled: root.enabled
                    onClicked: {
                        let newValue = root.value - 1;
                        root.valueChange(newValue);
                    }
                }
            }
        }

        Item {
            id: item2
            width: (parent.width / 2) - parent.spacing / 2
            height: parent.height
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

            Rectangle {
                id: plusButton
                width: parent.height
                height: this.width
                radius: this.width / 2
                border.width: 2
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                color: "#ffffff"

                Rectangle {
                    id: plusSign1
                    width: parent.width / 3
                    height: this.width / 5
                    color: "#000"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Rectangle {
                    id: plusSign2
                    width: this.height / 5
                    height: parent.height / 3
                    color: "#000"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MouseArea {
                    anchors.fill: parent
                    enabled: root.enabled
                    onClicked: {
                        let newValue = root.value + 1;
                        root.valueChange(newValue);
                    }
                }
            }
        }
    }

    onValueChanged: {
        let maxX = handleMouseArea.drag.maximumX;
        let minX = handleMouseArea.drag.minimumX;

        internal.sliderEnabled = false;

        handle.x = ((root.value - root.minValue) * (maxX - minX)) / (root.maxValue - root.minValue) + minX;

        internal.sliderEnabled = true;
    }

    QtObject {
        id: internal
        property bool sliderEnabled: true
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.659999966621399}
}
##^##*/

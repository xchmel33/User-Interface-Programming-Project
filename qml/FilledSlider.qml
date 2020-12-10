import QtQuick 2.0

Item {
    id: root
    width: 400
    height: 35

    property double minValue
    property double maxValue
    property color fillColor: "#444"
    property color handleColor: "#666"

    signal valueChanged(int newValue)

    Rectangle {
        id: slider
        color: "white"
        radius: root.height / 2
        border.width: 2
        anchors.fill: parent

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
            width: slider.radius * 2
            height: slider.height - 2 * slider.border.width
            color: root.handleColor
            radius: slider.radius
            border.width: 1
            anchors.verticalCenter: parent.verticalCenter
            transformOrigin: Item.Right

            onXChanged: {
                let newValue = handle.x / (slider.width - handle.width) * (maxValue - minValue) + minValue
                root.valueChanged(newValue)
            }

            MouseArea {
                anchors.fill: parent
                transformOrigin: Item.Center
                drag.target: handle
                drag.axis: Drag.XAxis
                drag.minimumX: 0
                drag.maximumX: slider.width - slider.border.width - handle.width
            }
        }

        // Allow moving of the slider while touching the bar itself, not just by
        // touching the handle
        MouseArea {
            anchors.fill: parent
            drag.target: handle
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: slider.width - slider.border.width - handle.width
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:2}
}
##^##*/

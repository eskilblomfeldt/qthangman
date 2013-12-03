import QtQuick 2.2

Item {
    id: keyItem
    property bool available: true
    property bool purchasable: false
    property string text: ""

    property color buttonColor: "white"
    property color textColor: "black"

    signal keyActivated(string letter)

    Rectangle {
        anchors.fill: parent
        radius: 10
        color: buttonColor
        border.color: textColor
        visible: keyItem.available
        Text {
            anchors.fill: parent
            anchors.rightMargin: parent.width * 0.05
            anchors.leftMargin: parent.width * 0.05
            anchors.bottomMargin: parent.height * 0.20
            anchors.topMargin: parent.height * 0.20
            text: keyItem.text
            color: textColor
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            minimumPointSize: 8
            font.pointSize: 128
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (available) {
                keyActivated(text);
            }
        }
    }
}

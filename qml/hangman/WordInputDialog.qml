import QtQuick 2.0

Item {
    id: dialog
    height: 480
    width: 320

    Rectangle {
        id: backgroundRect
        opacity: 0.5
        color: "black"
        anchors.fill: parent
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.25
        width: parent.width / 1.5
        height: parent.height / 4
        color: "white"
        radius: 10

        Column {
            id: column
            anchors.fill: parent
            anchors.rightMargin: parent.width * 0.05
            anchors.leftMargin: parent.width * 0.05
            anchors.bottomMargin: parent.height * 0.05
            anchors.topMargin: parent.height * 0.05

            spacing: 4
            property real subComponentHeight: (height - (spacing * 2)) / 3

            Text {
                id: label

                text: "What's the word?"
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                minimumPointSize: 8
                font.pointSize: 128
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                height: column.subComponentHeight
                color: "black"
            }

            Rectangle {
                id: inputRect
                anchors.left: parent.left
                width: parent.width
                height: column.subComponentHeight
                color: "lightgray"

                TextInput {
                    id: input
                    font.pixelSize: topLevel.height / 20
                    font.capitalization: Font.AllUppercase
                    inputMethodHints: Qt.ImhLatinOnly | Qt.ImhUppercaseOnly | Qt.ImhNoPredictiveText
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    anchors.topMargin: 2
                    color: "black"
                    maximumLength: applicationData.word.length
                    onAccepted: okButton.keyActivated("");
                    focus: dialog.visible
                }
            }
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                height: column.subComponentHeight
                spacing: 8
                Key {
                    id: okButton
                    text: "Ok"
                    buttonColor: "black"
                    textColor: "white"
                    height: parent.height
                    width: height * 1.5
                    onKeyActivated: {
                        applicationData.guessWord(input.text)
                        input.text = ""
                        Qt.inputMethod.hide();
                        dialog.visible = false
                    }
                }
                Key {
                    id: cancelButton
                    text: "Cancel"
                    buttonColor: "black"
                    textColor: "white"
                    height: parent.height
                    width: height * 2.5
                    onKeyActivated: {
                        input.text = ""
                        Qt.inputMethod.hide();
                        dialog.visible = false
                    }
                }
            }
        }
    }
}

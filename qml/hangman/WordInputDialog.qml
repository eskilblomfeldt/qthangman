import QtQuick 2.0

Item {
    id: dialog
    Rectangle {
        opacity: 0.5
        color: "black"
        anchors.fill: parent
    }

    Rectangle {
        anchors.centerIn: parent
        width: parent.width / 1.5
        height: parent.height / 2
        color: "white"

        Item {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            height: label.implicitHeight + inputRect.height + okButton.height + okButton.anchors.topMargin

            Text {
                id: label
                text: "What's the word?"
                font.pixelSize: topLevel.height / 20
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                color: "black"
            }

            Rectangle {
                id: inputRect
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: parent.width / 20
                anchors.rightMargin: anchors.leftMargin
                anchors.top: label.bottom
                height: input.implicitHeight + topLevel.height / 50
                color: "lightgray"
            }

            TextInput {
                id: input
                font.pixelSize: topLevel.height / 20
                font.capitalization: Font.AllUppercase
                inputMethodHints: Qt.ImhLatinOnly | Qt.ImhUppercaseOnly | Qt.ImhNoPredictiveText
                anchors.fill: inputRect
                color: "black"
                maximumLength: applicationData.word.length
                onAccepted: okButton.triggered()
            }

            SmallButton {
                id: okButton
                text: "Ok"
                font.pixelSize: topLevel.height / 20
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: input.bottom
                anchors.topMargin: topLevel.height / 50
                onTriggered: {
                    applicationData.guessWord(input.text)
                    input.text = ""
                    Qt.inputMethod.hide()
                    dialog.visible = false
                }
            }
        }

    }
}

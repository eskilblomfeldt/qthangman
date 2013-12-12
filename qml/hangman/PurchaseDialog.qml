import QtQuick 2.0

Item {
    id: dialog
    height: 480
    width: 320

    property string letter: ""

    state: "INITIAL"

    Rectangle {
        id: backgroundRect
        opacity: 0.5
        color: "black"
        anchors.fill: parent
        MouseArea {
            anchors.fill: backgroundRect
        }
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

                text: "Purchase Vowel " + letter +"?"
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

            Text {
                id: priceLable

                text: applicationData.localizedPriceForLetter(letter);
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                minimumPointSize: 8
                font.pointSize: 64
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                height: column.subComponentHeight
                color: "black"
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                height: column.subComponentHeight
                spacing: 8
                BusyButton {
                    id: okButton
                    text: "Buy"
                    buttonColor: "black"
                    textColor: "white"
                    height: parent.height
                    width: height * 1.5
                    onClicked: {
                        if (available) {
                            applicationData.requestLetter(letter.charAt(0));
                            dialog.state = "WAITING"
                        }
                    }
                }
                SimpleButton {
                    id: cancelButton
                    text: "Cancel"
                    buttonColor: "black"
                    textColor: "white"
                    height: parent.height
                    width: height * 2.5
                    onClicked: {
                        dialog.state = "CANCLED"
                    }
                }
            }
        }
    }

    states: [
        State {
            name: "INITIAL"
            PropertyChanges {
                target: okButton
                available: true;
            }
        },
        State {
            name: "WAITING"
            PropertyChanges {
                target: okButton
                available: false;
            }
        },
        State {
            name: "CANCLED"
            PropertyChanges {
                target: dialog
                visible: false;
            }
        },
        State {
            name: "FAILED"
            PropertyChanges {
                target: dialog
                visible: false
            }
            PropertyChanges {
                target: okButton
                available: true
            }
        },
        State {
            name: "SUCCESS"
            PropertyChanges {
                target: dialog
                visible: false
            }
        }
    ]

    Connections {
        target: applicationData
        onPurchaseWasSuccessful: {
            if (wasSuccessful) {
                state = "SUCCESS";
            } else {
                state = "FAILED";
            }
        }
    }

}

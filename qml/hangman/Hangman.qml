import QtQuick 2.0

Rectangle {
    id: hangman
    color: "black"
    border.color: "white"
    border.width: width / 100

    property int errorCount: applicationData.errorCount

    Rectangle {
        id: pole
        anchors.top: parent.top
        anchors.topMargin: parent.height / 50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height / 50
        anchors.left: parent.left
        anchors.leftMargin: parent.height / 50
        width: parent.width / 10

        opacity: errorCount > 0 ? 1.0 : 0.0
        visible: opacity > 0.0
        Behavior on opacity {
            NumberAnimation {
                duration: 300
            }
        }

        color: "white"
    }

    Rectangle {
        id: horizontalPole
        anchors.top: pole.top
        anchors.left: pole.right
        anchors.right: parent.right
        anchors.rightMargin: parent.height / 50
        height: parent.height / 10

        color: "white"

        opacity: errorCount > 1 ? 1.0 : 0.0
        visible: opacity > 0.0
        Behavior on opacity {
            NumberAnimation {
                duration: 300
            }
        }
    }

    Rectangle {
        id: rope
        anchors.top: horizontalPole.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width / 100
        height: parent.height / 5

        opacity: errorCount > 2 ? 1.0 : 0.0
        visible: opacity > 0.0
        Behavior on opacity {
            NumberAnimation {
                duration: 300
            }
        }
        color: "white"
    }

    Item {
        id: dude
        anchors.top: rope.bottom
        anchors.horizontalCenter: rope.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height / 10

        Rectangle {
            id: head
            anchors.top: parent.top
            anchors.topMargin: -1
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height * 0.146
            width: height

            radius: width * 0.5
            color: "black"
            border.width: width / 10
            border.color: "white"
            opacity: errorCount > 3 ? 1.0 : 0.0
            visible: opacity > 0.0
            Behavior on opacity {
                NumberAnimation {
                    duration: 300
                }
            }
        }

        Rectangle {
            id: body
            anchors.top: head.bottom
            anchors.topMargin: -1
            anchors.horizontalCenter: head.horizontalCenter
            height: head.height * 3
            width: head.border.width

            opacity: errorCount > 4 ? 1.0 : 0.0
            visible: opacity > 0.0
            Behavior on opacity {
                NumberAnimation {
                    duration: 300
                }
            }
        }

        Rectangle {
            id: arm1
            anchors.top: body.top
            anchors.topMargin: head.height * 0.25
            anchors.horizontalCenter: body.horizontalCenter
            height: body.height
            width: head.border.width
            transform: Rotation {
                origin.x: arm1.width / 2
                origin.y: 0
                angle: 30
            }
            opacity: errorCount > 5 ? 1.0 : 0.0
            visible: opacity > 0.0
            Behavior on opacity {
                NumberAnimation {
                    duration: 300
                }
            }
        }

        Rectangle {
            id: arm2
            anchors.top: body.top
            anchors.topMargin: head.height * 0.25
            anchors.horizontalCenter: body.horizontalCenter
            height: body.height
            width: head.border.width
            transform: Rotation {
                origin.x: arm1.width / 2
                origin.y: 0
                angle: -30
            }
            opacity: errorCount > 6 ? 1.0 : 0.0
            visible: opacity > 0.0
            Behavior on opacity {
                NumberAnimation {
                    duration: 300
                }
            }
        }


        Rectangle {
            id: leg1
            anchors.top: body.bottom
            anchors.horizontalCenter: body.horizontalCenter
            height: head.height * 3
            width: head.border.width
            transform: Rotation {
                origin.x: leg1.width / 2
                origin.y: 0
                angle: 30
            }
            opacity: errorCount > 7 ? 1.0 : 0.0
            visible: opacity > 0.0
            Behavior on opacity {
                NumberAnimation {
                    duration: 300
                }
            }
        }

        Rectangle {
            id: leg2
            anchors.top: body.bottom
            anchors.horizontalCenter: body.horizontalCenter
            height: head.height * 3
            width: head.border.width
            transform: Rotation {
                origin.x: leg2.width / 2
                origin.y: 0
                angle: -30
            }

            opacity: errorCount > 8 ? 1.0 : 0.0
            visible: opacity > 0.0
            Behavior on opacity {
                NumberAnimation {
                    duration: 300
                }
            }
        }
    }

    Text {
        text: "Game Over"
        anchors.centerIn: parent
        opacity: topLevel.gameOver ? 1.0 : 0.0
        visible: opacity > 0.0
        color: "red"
        font.pixelSize: parent.width / 10
        font.bold: true
        style: Text.Outline
        styleColor: "white"
        scale: visible ? 1.0 : 30.0
        Behavior on opacity {
            NumberAnimation {
                duration: 500
            }
        }
        Behavior on scale {
            NumberAnimation {
                duration: 2000
            }
        }
    }

    Text {
        text: "SUCCESS"
        anchors.centerIn: parent
        opacity: topLevel.success ? 1.0 : 0.0
        visible: opacity > 0.0
        color: "green"
        style: Text.Outline
        styleColor: "white"
        font.pixelSize: parent.width / 10
        scale: visible ? 1.0 : 30.0
        Behavior on opacity {
            NumberAnimation {
                duration: 500
            }
        }
        Behavior on scale {
            NumberAnimation {
                duration: 2000
            }
        }
    }
}

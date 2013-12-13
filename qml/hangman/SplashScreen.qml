import QtQuick 2.0
import QtQuick.Window 2.1

Rectangle {
    id: topLevel
    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: "#87E0FD"
        }
        GradientStop {
            position: 0.4
            color: "#53CBF1"
        }
        GradientStop {
            position: 1.0
            color: "#05ABE0"
        }
    }

    Image {
        id: logo

        property bool isRetina: Screen.pixelDensity / 2 > Screen.logicalPixelDensity

        source: isRetina ? "images/Hangman_logo@x2.png" : "images/Hangman_logo.png"
        anchors.centerIn: parent
        height: 262
        width: 268

    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: logo.bottom
        anchors.topMargin: 10
        text: "Qt Hangman"
        font.family: ".Helvetica Neue Interface -M3"
        color: "white"
        font.pointSize: 24
    }
}

import QtQuick 2.0
import QtQuick.Controls 1.1

Rectangle {
    id: mainRect
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

    height: 480
    width: 320

    Loader {
        id: gameLoader
        asynchronous: true
        visible: status == Loader.Ready
        anchors.fill: parent
    }

    Loader {
        id: splashLoader
        anchors.fill: parent
        source: "SplashScreen.qml"
        onLoaded: gameLoader.source = "MainView.qml";
    }

    Connections {
        target: gameLoader.item
        onIsReadyChanged: {
            splashLoader.source = "";
        }
    }

}

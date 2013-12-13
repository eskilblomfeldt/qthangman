import QtQuick 2.0
import QtQuick.Controls 1.1

SimpleButton {
    BusyIndicator {
        id: busyIndicator
        anchors.fill: parent
        visible: !parent.available
        running: visible
    }
}

import QtQuick 2.2

SimpleButton {
    id: keyItem

    property bool purchasable: false

    signal keyActivated(string letter)

    onClicked: {
        if (available) {
            keyActivated(text);
        }
    }

}

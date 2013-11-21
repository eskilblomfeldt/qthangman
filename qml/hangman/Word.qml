import QtQuick 2.1
import QtQuick.Controls 1.0

Item {
    id: word
    property string text: ""

    Row {
        id: row
        spacing: topLevel.width / 100
        anchors.fill: parent
        Repeater {
            model: text.length

            Letter {
                id: letter
                text: word.text.charAt(index)
                width: (word.width / word.text.length) - row.spacing
                height: word.height
            }
        }
    }

    Menu {
        id: letterMenu

        MenuItem {
            text: "Guess word!"
            onTriggered: wordInputDialog.visible = true
        }

        Menu {
            id: vowelMenu
            title: "Buy a vowel!"

            Instantiator {
                model: applicationData.vowels.length
                MenuItem {
                    id: vowelItem
                    text: applicationData.vowels.charAt(index)
                    onTriggered: applicationData.requestLetter(text.charAt(0))
                    visible: !(applicationData.lettersOwned.indexOf(text) >= 0)
                }
                onObjectAdded: vowelMenu.insertItem(index, object)
            }
        }

        Instantiator {
            model: applicationData.consonants.length
            MenuItem {
                id: consonantItem
                text: applicationData.consonants.charAt(index)
                onTriggered: applicationData.requestLetter(text.charAt(0))
                visible: !(applicationData.lettersOwned.indexOf(text) >= 0)
            }
            onObjectAdded: letterMenu.insertItem(index, object)
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (!topLevel.gameOver && !topLevel.success) letterMenu.popup()
        }
    }
}

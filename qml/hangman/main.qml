import QtQuick 2.0
import QtQuick.Controls 1.1

Rectangle {
    id: topLevel
    color: "black"

    height: 480
    width: 320

    function allContained(owned, word)
    {
        for (var i=0; i<word.length; ++i) {
            if (owned.indexOf(word.charAt(i)) < 0)
                return false
        }
        return true
    }

    property bool gameOver: applicationData.errorCount > 8
    property bool success: applicationData.word.length > 0 && !gameOver && allContained(applicationData.lettersOwned, applicationData.word)

    onGameOverChanged: {
        if (gameOver)
            applicationData.gameOverReveal();
    }

    Item {
        id: gameScreen
        visible: applicationData.word.length > 0
        anchors.fill: parent

        Text {
            id: title
            color: "white"
            text: qsTr("Qt Hangman")
            font.pixelSize: Math.min(parent.width, parent.height) / 15
            anchors.right: parent.right
            anchors.rightMargin: topLevel.width / 100
        }

        Text {
            id: copyrightNotice
            color: "white"
            anchors.left: parent.horizontalCenter
            anchors.right: parent.right
            anchors.rightMargin: topLevel.width / 100
            anchors.top: title.bottom
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: Math.max(8, title.font.pixelSize / 3)
            horizontalAlignment: Text.AlignRight
            text: qsTr("Uses The Enhanced North American Benchmark LExicon (ENABLE) by M. Cooper and Alan Beale")
        }

        Item {
            anchors.top: title.bottom
            anchors.bottom: word.top
            anchors.left: parent.left
            anchors.right: parent.right

            Hangman {
                anchors.centerIn: parent
                width: Math.min(parent.width, parent.height) * 0.75
                height: width
            }
        }

        Word {
            id: word
            text: applicationData.word
            anchors.bottom: letterSelector.top
            anchors.bottomMargin: parent.height * 0.05
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.8
            height: parent.height * 0.1
        }

        LetterSelector {
            id: letterSelector
            locked: gameOver || success
            anchors.margins: 8
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height * 0.25
            onLetterSelected: {
                applicationData.requestLetter(letter.charAt(0));
            }
            onResetPressed: {
                letterSelector.reset();
                applicationData.reset();
            }
            onRevealPressed: {
                applicationData.reveal();
            }
            onGuessWordPressed: {
                wordInputDialog.visible = true;
            }
        }
    }

    Rectangle {
        id: loadingScreen
        visible: !gameScreen.visible
        anchors.fill: parent
        color: "black"

        BusyIndicator {
            id: busyIndicator
            running: true
            anchors.centerIn: parent
        }
    }

    WordInputDialog {
        id: wordInputDialog
        visible: false
        anchors.fill: parent
    }

    Connections {
        target: applicationData
        onVowelBought: {
            letterSelector.vowelPurchased(vowel);
        }
    }
}

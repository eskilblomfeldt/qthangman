import QtQuick 2.0
import QtQuick.Controls 1.1

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

    property bool isReady: gameScreen.visible

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
            font.pixelSize: Math.min(parent.width, parent.height) / 10
            anchors.right: parent.right
            anchors.rightMargin: topLevel.width / 100
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
                if (applicationData.isVowel(letter) && Qt.platform.os === "ios") {
                    showPurchaseDialog(letter);
                } else {
                    applicationData.requestLetter(letter.charAt(0));
                }
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

    function showPurchaseDialog(letter) {
        purchaseDialog.letter = letter;
        purchaseDialog.state = "INITIAL";
        purchaseDialog.visible = true;
    }

    WordInputDialog {
        id: wordInputDialog
        visible: false
        anchors.fill: parent
    }

    PurchaseDialog {
        id: purchaseDialog
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

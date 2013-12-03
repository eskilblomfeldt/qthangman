import QtQuick 2.0

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
    property bool success: !gameOver && allContained(applicationData.lettersOwned, applicationData.word)

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

    WordInputDialog {
        id: wordInputDialog
        visible: false
        anchors.fill: parent
    }

    LetterSelector {
        id: letterSelector
        locked: gameOver
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

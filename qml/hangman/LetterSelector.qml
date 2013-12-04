import QtQuick 2.2

Item {
    id: keyView
    property real keyWidth: (width - (horizontalSpacing * 9)) / 10
    property real keyHeight: (height - (verticalSpacing * 3)) / 4
    property real horizontalSpacing: 2
    property real verticalSpacing: 4
    property bool locked: false

    property var keys: [keyA, keyB, keyC, keyD, keyE, keyF, keyG, keyH, keyI, keyJ,
            keyH, keyJ, keyK, keyL, keyM, keyN, keyO, keyP, keyQ, keyR, keyS,
            keyT, keyU, keyV, keyW, keyX, keyY, keyZ, keyGuess, keyReveal];

    function reset() {
        //Resets all key values to their default state
        for(var i = 0; i < keys.length; ++i)
            keys[i].available = true;
    }

    function vowelPurchased(vowel) {
        if (vowel === 65) {
            keyA.available = false;
        } else if (vowel === 69) {
            keyE.available = false;
        } else if (vowel === 73) {
            keyI.available = false;
        } else if (vowel === 79) {
            keyO.available = false;
        } else if (vowel === 85) {
            keyU.available = false;
        }
    }

    onLockedChanged: {
        if (locked) {
            for(var i = 0; i < keys.length; ++i)
                keys[i].available = false;
        }
    }



    signal letterSelected(string letter)
    signal guessWordPressed()
    signal resetPressed()
    signal revealPressed()

    //Qwerty layout
    Column {
        spacing: keyView.verticalSpacing
        anchors.fill: parent
        Row {
            spacing: keyView.horizontalSpacing
            Key {
                id: keyQ
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "Q";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
            Key {
                id: keyW
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "W";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
            Key {
                id: keyE
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "E";
                available: true
                purchasable: true
                onKeyActivated: {
                    letterSelected(letter);

                }
            }
            Key {
                id: keyR
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "R";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
            Key {
                id: keyT
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "T";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
            Key {
                id: keyY
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "Y";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
            Key {
                id: keyU
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "U";
                available: true
                purchasable: true
                onKeyActivated: {
                    letterSelected(letter);
                }
            }
            Key {
                id: keyI
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "I";
                available: true
                purchasable: true
                onKeyActivated: {
                    letterSelected(letter);
                }
            }
            Key {
                id: keyO
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "O";
                available: true
                purchasable: true
                onKeyActivated: {
                    letterSelected(letter);
                }
            }
            Key {
                id: keyP
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "P";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
        }
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: keyView.horizontalSpacing
            Key {
                id: keyA
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "A";
                available: true
                purchasable: true
                onKeyActivated: {
                    letterSelected(letter);
                }
            }
            Key {
                id: keyS
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "S";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
            Key {
                id: keyD
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "D";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
            Key {
                id: keyF
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "F";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
            Key {
                id: keyG
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "G";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
            Key {
                id: keyH
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "H";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
            Key {
                id: keyJ
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "J";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
            Key {
                id: keyK
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "K";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
            Key {
                id: keyL
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "L";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
        }
        Row {
            spacing: keyView.horizontalSpacing
            anchors.horizontalCenter: parent.horizontalCenter
            Key {
                id: keyZ
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "Z";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
            Key {
                id: keyX
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "X";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
            Key {
                id: keyC
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "C";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
            Key {
                id: keyV
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "V";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
            Key {
                id: keyB
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "B";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
            Key {
                id: keyN
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "N";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
            Key {
                id: keyM
                height: keyView.keyHeight
                width: keyView.keyWidth
                text: "M";
                available: true
                purchasable: false
                onKeyActivated: {
                    letterSelected(letter);
                    available = false;
                }
            }
        }
        Row {
            spacing: keyView.horizontalSpacing
            anchors.horizontalCenter: parent.horizontalCenter
            Key {
                id: keyReveal
                height: keyView.keyHeight
                width: keyView.keyWidth * 2
                text: "Reveal"
                available: true
                onKeyActivated: {
                    revealPressed();
                }
            }

            Key {
                id: keyGuess
                height: keyView.keyHeight
                width: keyView.keyWidth * 3
                text: "Guess Word"
                available: true
                onKeyActivated: {
                    guessWordPressed();
                }
            }

            Key {
               id: keyReset
               height: keyView.keyHeight
               width: keyView.keyWidth * 2
               text: "Reset"
               available: true
               onKeyActivated: {
                    resetPressed();
               }
            }
        }
    }
}

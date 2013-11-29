import QtQuick 2.2

Item {
    id: keyView
    property real keyWidth: (width - (horizontalSpacing * 9)) / 10
    property real keyHeight: (height - (verticalSpacing * 2)) / 3
    property real horizontalSpacing: 2
    property real verticalSpacing: 4

    function reset() {
        //Resets all key values to their default state
        var keys = [keyA, keyB, keyC, keyD, keyE, keyF, keyG, keyH, keyI, keyJ,
                keyH, keyJ, keyK, keyL, keyM, keyN, keyO, keyP, keyQ, keyR, keyS,
                keyT, keyU, keyV, keyW, keyX, keyY, keyZ];
        for(var i = 0; i < keys.length; ++i)
            keys[i].available = true;
    }

    signal letterSelected(string letter)

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
                }
            }
        }
    }
//    MouseArea {
//        id: mouseCapture
//        anchors.fill: parent
//        enabled: true
//        onClicked: {
//            //Do nothing
//            console.log("touched");
//        }

//    }
}

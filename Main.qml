import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
    id: container
    width: 1920
    height: 1080
    color: "#000000"

    property int sessionIndex: session.index

    TextConstants { id: textConstants }

    Connections {
        target: sddm
        onLoginSucceeded: {}
        onLoginFailed: {
            password.text = ""
            errorMessage.visible = true
            errorTimer.restart()
        }
    }

    Timer {
        id: errorTimer
        interval: 3000
        onTriggered: errorMessage.visible = false
    }

    Text {
        id: asciiLogo
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.15
        
        text: "⠀⠀⢀⣤⡶⣾⠛⠛⠛⢻⡷⢶⣤⣀⠀⠀⠀⠀⠀⠀⣠⣾⠋⠁⣀⡼⠇⢰⡶⠾⠇⣀⠈⢙⣷⣄⠀⠀⠀\n⣴⠏⠉⣿⠂⠹⣆⠀⢸⡇⠀⣰⠏⠛⠞⠁⠹⣧⠀⣸⣏⣀⡘⠳⣤⣠⡾⣿⢻⡟⣿⢷⣄⣤⠾⢷⣀⣽⣇⣿⠉⢹⣇\n⣀⣠⣿⣛⣾⣿⣿⣷⣛⣿⣄⣀⣈⡉⠀⣿⣿⠀⣈⡉⠉⠙⣿⣭⢿⣿⣿⡿⣭⣿⠋⠉⢹⣇⣀⣿⢹⣟⠉⢷⡶⠛⠙⢷\n⣿⣼⣧⣿⡾⠋⠛⢦⡌⠉⣹⡏⠀⢻⣆⠀⣴⣤⣠⠟⠀⢸⡇⠀⠹⣆⠠⣿⣀⣰⡟⠀⠀⠀⠙⢿⣅⡀⠉⢰⡶⠾⠇\n⢰⡞⠉⢀⣠⡿⠋⠀⠀⠀⠀⠀⠀⠈⠛⠷⢾⣧⣤⣤⣤⡿⠾⠛⠁⠀⠀⠀⠀"
        
        color: "#8B0000"
        font.family: "Monospace"
        font.pixelSize: 14
        lineHeight: 0.85
        horizontalAlignment: Text.AlignHCenter
    }

    Rectangle {
        id: loginBox
        width: 420
        height: 320
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 80
        color: "#000000"
        border.color: "#333333"
        border.width: 2

        Column {
            anchors.fill: parent
            anchors.margins: 30
            spacing: 18

            Rectangle {
                width: parent.width
                height: 35
                color: "#000000"
                border.color: "#333333"
                border.width: 1
                Text {
                    anchors.centerIn: parent
                    text: "[ SYSTEM LOGIN ]"
                    color: "#8B0000"
                    font.family: "Monospace"
                    font.pixelSize: 16
                    font.bold: true
                }
            }

            Column {
                width: parent.width
                spacing: 8
                Text {
                    text: "> USERNAME"
                    color: "#666666"
                    font.family: "Monospace"
                    font.pixelSize: 12
                }
                Rectangle {
                    width: parent.width
                    height: 40
                    color: "#000000"
                    border.color: username.activeFocus ? "#8B0000" : "#333333"
                    border.width: 2
                    TextInput {
                        id: username
                        anchors.fill: parent
                        anchors.margins: 10
                        text: userModel.lastUser
                        color: "#CCCCCC"
                        font.family: "Monospace"
                        font.pixelSize: 14
                        verticalAlignment: TextInput.AlignVCenter
                        focus: true
                        Keys.onReturnPressed: password.forceActiveFocus()
                        Keys.onEnterPressed: password.forceActiveFocus()
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: username.forceActiveFocus()
                    }
                }
            }

            Column {
                width: parent.width
                spacing: 8
                Text {
                    text: "> PASSWORD"
                    color: "#666666"
                    font.family: "Monospace"
                    font.pixelSize: 12
                }
                Rectangle {
                    width: parent.width
                    height: 40
                    color: "#000000"
                    border.color: password.activeFocus ? "#8B0000" : "#333333"
                    border.width: 2
                    TextInput {
                        id: password
                        anchors.fill: parent
                        anchors.margins: 10
                        color: "#CCCCCC"
                        font.family: "Monospace"
                        font.pixelSize: 14
                        echoMode: TextInput.Password
                        verticalAlignment: TextInput.AlignVCenter
                        Keys.onReturnPressed: sddm.login(username.text, password.text, sessionIndex)
                        Keys.onEnterPressed: sddm.login(username.text, password.text, sessionIndex)
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: password.forceActiveFocus()
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 45
                color: loginButtonArea.pressed ? "#8B0000" : "#000000"
                border.color: "#8B0000"
                border.width: 2
                Text {
                    anchors.centerIn: parent
                    text: "[ ENTER ]"
                    color: "#8B0000"
                    font.family: "Monospace"
                    font.pixelSize: 14
                    font.bold: true
                }
                MouseArea {
                    id: loginButtonArea
                    anchors.fill: parent
                    onClicked: sddm.login(username.text, password.text, sessionIndex)
                }
            }
        }
    }

    Text {
        id: errorMessage
        anchors.top: loginBox.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        text: "[ ! ] LOGIN FAILED [ ! ]"
        color: "#8B0000"
        font.family: "Monospace"
        font.pixelSize: 13
        visible: false
    }

    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 30
        color: "#000000"
        border.color: "#333333"
        border.width: 1
        Row {
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            spacing: 20
            Rectangle {
                width: sessionCycleLabel.width + 20
                height: 22
                color: "#000000"
                border.color: sessionCycleArea.containsMouse ? "#8B0000" : "#333333"
                border.width: 1
                Text {
                    id: sessionCycleLabel
                    anchors.centerIn: parent
                    text: "[SESSION: " + session.currentText + "]"
                    color: sessionCycleArea.containsMouse ? "#CCCCCC" : "#666666"
                    font.family: "Monospace"
                    font.pixelSize: 11
                }
                MouseArea {
                    id: sessionCycleArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        session.index = (session.index + 1) % sessionModel.count
                    }
                }
            }
            Text {
                id: timeLabel
                color: "#666666"
                font.family: "Monospace"
                font.pixelSize: 11
                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: timeLabel.text = Qt.formatDateTime(new Date(), "yyyy.MM.dd // hh:mm:ss")
                }
                Component.onCompleted: timeLabel.text = Qt.formatDateTime(new Date(), "yyyy.MM.dd // hh:mm:ss")
            }
        }
        Row {
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10
            Rectangle {
                width: 80
                height: 22
                color: "#000000"
                border.color: "#333333"
                border.width: 1
                Text {
                    anchors.centerIn: parent
                    text: "[REBOOT]"
                    color: "#666666"
                    font.family: "Monospace"
                    font.pixelSize: 10
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: sddm.reboot()
                }
            }
            Rectangle {
                width: 90
                height: 22
                color: "#000000"
                border.color: "#333333"
                border.width: 1
                Text {
                    anchors.centerIn: parent
                    text: "[SHUTDOWN]"
                    color: "#666666"
                    font.family: "Monospace"
                    font.pixelSize: 10
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: sddm.powerOff()
                }
            }
        }
    }

    ComboBox {
        id: session
        visible: false
        model: sessionModel
        index: sessionModel.lastIndex
    }

    Component.onCompleted: username.forceActiveFocus()
}

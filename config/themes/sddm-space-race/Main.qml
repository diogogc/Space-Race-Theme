import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
    id: container
    width: 1920
    height: 1080
    color: "#0b0d11"

    TextConstants { id: textConstants }

    Connections {
        target: sddm

        onLoginSucceeded: {
            statusText.color = "#2ef788"
            statusText.text = "[ AUTH NOMINAL // LAUNCHING MISSION SESSION ]"
        }

        onLoginFailed: {
            passwordBox.text = ""
            statusText.color = "#ff3333"
            statusText.text = "[ 1202 ALARM: INVALID OPERATOR CREDENTIALS ]"
        }

        onInformationMessage: {
            statusText.color = "#ffb000"
            statusText.text = message
        }
    }

    // --- BACKGROUND WALLPAPER ---
    Image {
        id: bgImage
        anchors.fill: parent
        source: config.background || "background.jpg"
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }

    // --- RETRO VIGNETTE / CRT SCANLINE OVERLAY ---
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.45
    }

    // --- TOP TELEMETRY BANNER ---
    Rectangle {
        id: topBanner
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 48
        color: "#14171d"
        opacity: 0.92

        Rectangle {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: 2
            color: "#ffb000"
        }

        Text {
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.verticalCenter: parent.verticalCenter
            text: "🚀 NASA // MANNED SPACECRAFT CENTER // HOUSTON FLIGHT CONTROL"
            color: "#ffb000"
            font.pixelSize: 13
            font.bold: true
            font.family: "JetBrainsMono Nerd Font, monospace"
        }

        Text {
            id: clockDisplay
            anchors.right: parent.right
            anchors.rightMargin: 24
            anchors.verticalCenter: parent.verticalCenter
            color: "#2ef788"
            font.pixelSize: 14
            font.family: "JetBrainsMono Nerd Font, monospace"
            font.bold: true

            Timer {
                interval: 1000
                running: true
                repeat: true
                triggeredOnStart: true
                onTriggered: {
                    var now = new Date();
                    clockDisplay.text = "SYS: OK | UTC " + now.toUTCString().substr(17, 8) + " | LOCAL " + Qt.formatDateTime(now, "hh:mm:ss");
                }
            }
        }
    }

    // --- CENTER MISSION OPERATIONS LOGIN CONSOLE ---
    Rectangle {
        id: loginCard
        anchors.centerIn: parent
        width: 440
        height: 380
        color: "#14171d"
        radius: 6
        border.color: "#ffb000"
        border.width: 2
        opacity: 0.95

        Column {
            anchors.fill: parent
            anchors.margins: 28
            spacing: 16

            Text {
                text: "MISSION OPERATOR LOGIN"
                color: "#ffb000"
                font.pixelSize: 15
                font.bold: true
                font.family: "JetBrainsMono Nerd Font, monospace"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "FLIGHT DIRECTOR & GUIDANCE TELEMETRY ACCESS"
                color: "#8c9ba5"
                font.pixelSize: 10
                font.family: "JetBrainsMono Nerd Font, monospace"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                width: parent.width
                height: 1
                color: "#2e3846"
            }

            // USER SELECTION / NAME
            Column {
                width: parent.width
                spacing: 6

                Text {
                    text: "OPERATOR / CALLSIGN:"
                    color: "#f4eedb"
                    font.pixelSize: 11
                    font.family: "JetBrainsMono Nerd Font, monospace"
                }

                TextBox {
                    id: userName
                    width: parent.width
                    height: 38
                    text: userModel.lastUser
                    font.pixelSize: 12
                    font.family: "JetBrainsMono Nerd Font, monospace"
                    color: "#1a1f26"
                    textColor: "#f4eedb"
                    borderColor: "#3a4659"
                    focusColor: "#ffb000"
                    radius: 3

                    KeyNavigation.tab: passwordBox
                    Keys.onReturnPressed: passwordBox.focus = true
                }
            }

            // PASSCODE / AGC NOUN 21
            Column {
                width: parent.width
                spacing: 6

                Text {
                    text: "PASSCODE [ AGC VERB 21 ]:"
                    color: "#f4eedb"
                    font.pixelSize: 11
                    font.family: "JetBrainsMono Nerd Font, monospace"
                }

                PasswordBox {
                    id: passwordBox
                    width: parent.width
                    height: 38
                    font.pixelSize: 12
                    font.family: "JetBrainsMono Nerd Font, monospace"
                    color: "#1a1f26"
                    textColor: "#ffb000"
                    borderColor: "#3a4659"
                    focusColor: "#ffb000"
                    radius: 3
                    focus: true

                    KeyNavigation.tab: sessionList
                    Keys.onReturnPressed: sddm.login(userName.text, passwordBox.text, sessionList.index)
                }
            }

            // STATUS & ALARM MESSAGE
            Text {
                id: statusText
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                text: "[ STANDBY FOR OPERATOR AUTHORIZATION ]"
                color: "#8c9ba5"
                font.pixelSize: 10
                font.family: "JetBrainsMono Nerd Font, monospace"
                wrapMode: Text.WordWrap
            }

            // LOGIN SUBMIT BUTTON
            Button {
                id: loginButton
                width: parent.width
                height: 36
                text: "⚡ ENGAGE MISSION PROFILE"
                color: "#ffb000"
                activeColor: "#ffc233"
                pressedColor: "#e69e00"
                textColor: "#14171d"
                font.pixelSize: 12
                font.bold: true
                font.family: "JetBrainsMono Nerd Font, monospace"
                radius: 3

                onClicked: sddm.login(userName.text, passwordBox.text, sessionList.index)
            }
        }
    }

    // --- BOTTOM BAR: SESSION & POWER TELEMETRY ---
    Rectangle {
        id: bottomBanner
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 44
        color: "#14171d"
        opacity: 0.92

        Rectangle {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 1
            color: "#2e3846"
        }

        Row {
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.verticalCenter: parent.verticalCenter
            spacing: 12

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "ENVIRONMENT:"
                color: "#8c9ba5"
                font.pixelSize: 11
                font.family: "JetBrainsMono Nerd Font, monospace"
            }

            ComboBox {
                id: sessionList
                width: 160
                height: 30
                font.pixelSize: 11
                font.family: "JetBrainsMono Nerd Font, monospace"
                model: sessionModel
                index: sessionModel.lastIndex
                color: "#1a1f26"
                textColor: "#f4eedb"
                borderColor: "#3a4659"
                arrowColor: "#ffb000"
            }
        }

        Row {
            anchors.right: parent.right
            anchors.rightMargin: 24
            anchors.verticalCenter: parent.verticalCenter
            spacing: 14

            Button {
                height: 28
                text: "⏸ SUSPEND"
                font.pixelSize: 10
                font.family: "JetBrainsMono Nerd Font, monospace"
                color: "#1a1f26"
                textColor: "#8c9ba5"
                radius: 2
                onClicked: sddm.suspend()
            }

            Button {
                height: 28
                text: "🔄 REBOOT"
                font.pixelSize: 10
                font.family: "JetBrainsMono Nerd Font, monospace"
                color: "#1a1f26"
                textColor: "#ffb000"
                radius: 2
                onClicked: sddm.reboot()
            }

            Button {
                height: 28
                text: "🛑 POWER OFF"
                font.pixelSize: 10
                font.family: "JetBrainsMono Nerd Font, monospace"
                color: "#1a1f26"
                textColor: "#ff3333"
                radius: 2
                onClicked: sddm.powerOff()
            }
        }
    }
}

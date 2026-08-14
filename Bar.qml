import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Scope {
    property color col
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            color: col

            implicitHeight: 30

            RowLayout {
                id: layout
                layoutDirection: Qt.LeftToRight
                spacing: 80
                anchors.fill: parent
                anchors.margins: 8

                ClockWidget {
                    color: '#a9b1d6'

                    Layout.fillWidth: true
                    Layout.minimumWidth: 100
                    Layout.preferredWidth: 125
                    Layout.maximumWidth: 125
                }

                Rectangle { width: 1; height: 16; color: "#444b6a" }

                CpuWidget {}

                Rectangle { width: 1; height: 16; color: "#444b6a" }

                MemWidget {}


                Rectangle { width: 1; height: 16; color: "#444b6a" }

                Repeater {
                    model: 9

                    Text {
                        property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                        property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                        text: index + 1
                        color: isActive ? "#0db9d7" : (ws ? "#7aa2f7" : "#444b6a")
                        font { pixelSize: 14; bold: true }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = "${index + 1}" })`)
                        }
                    }
                }

                Item { Layout.fillWidth: true }
            }
        }
    }
}
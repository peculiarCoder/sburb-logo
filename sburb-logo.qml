import QtQuick 2.0

Rectangle {
    id: rec
    width: 360
    height: 360

    MouseArea {
        id: mouseArea
        anchors.fill: parent


    }
    Image {
        id: chimney
        x: parent.width/2 - 72-(chimney.width-topleft.width)
        y: topleft.y-chimney.height
        z: 1
        source : "chm"
    }
    Image {
        id: roof
        x: parent.width/2
        y: splitted.y -  roof.height
        z: 1
        source: "mrf"
    }

    Image {
        id: topleft
        x: parent.width/2 - 72
        y: parent.height/2 - 72
        z: 1
        source: "bsq"
    }

    Image {
        id: bottomright
        x: parent.width/2
        y: parent.height/2
        z: 1
        source: "bsq"
    }
    Image {
        id: bottomleft
        x: parent.width/2 - 72
        y: parent.height/2
        z: 1
        source: "bsq"
    }
    Image {
        id: small
        x: parent.width/2
        y: parent.height/2 - 36
        z: 1
        source: "sq"
    }
    Image {
        id: splitted
        x: parent.width/2
        y: parent.height/2 - 72
        source: "ssq"
    }

    states: [
        State {
            name: "opened"


            PropertyChanges {
                target: small
                x: parent.width/2+5
                y: parent.height/2 - 36-5
                rotation: 360
            }

            PropertyChanges {
                target: topleft
                x: parent.width/2 - 72 - 9
                y: parent.height/2 - 72 - 9
            }

            PropertyChanges {
                target: bottomleft
                x: parent.width/2 - 72-9
                y: parent.height/2+9
                opacity: 1
            }

            PropertyChanges {
                target: bottomright
                x: parent.width/2+9
                y: parent.height/2+9
            }

            PropertyChanges {
                target: splitted
                x: parent.width/2+14
                y: parent.height/2 - 72-15
            }

            PropertyChanges {
                target: chimney
                y: topleft.y-chimney.height - 11
            }

            PropertyChanges {
                target: roof
                //x: splitted.x - 9
                y: splitted.y -  roof.height - 11

            }
        }



    ]
    transitions: [
        Transition {
            from: ""; to: "opened"
            SequentialAnimation {
                PauseAnimation { id: pause; duration: 400 }
                NumberAnimation {
                    id: open
                    properties: "x,y"
                    duration: 200
                }
                SmoothedAnimation {
                    id: rotate
                    target: small
                    properties: "rotation"
                    from: small.rotation
                    to: small.rotation+360
                    duration: 300
                }



            }
        },
        Transition {
            from: "opened"; to: ""
            SequentialAnimation {
                SmoothedAnimation {
                    target: small
                    properties: "rotation"
                    from: small.rotation
                    to: small.rotation-360
                    duration: rotate.duration
                }
                NumberAnimation {
                    properties: "x,y"
                    duration: open.duration
                }

            }
        }

    ]
    Timer {
        id: ticktock
        interval: open.duration+rotate.duration+pause.duration+90
        running: true; repeat: true
        onTriggered: {
            if (rec.state == "")  {

                rec.state='opened' ;

            }
            else {
                rec.state="";

            }
        }

    }
}

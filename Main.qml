import QtQuick 2.0
import Ubuntu.Components 1.1
import "jsonparser.js" as API

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    id: root

    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "baidutranslator.liu-xiao-guo"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(60)
    height: units.gu(85)

    function update(json) {
        console.log("json: " + JSON.stringify(json));

        mymodel.clear();

        if ( json.trans_result !== undefined && json.trans_result.length !== undefined ) {
            for ( var idx = 0; idx < json.trans_result.length; idx++ ) {
                if ( json.trans_result[ idx ].dst ) {
                    console.log( 'meaning: ' + json.trans_result[ idx ].dst);
                    mymodel.append( {"meaning": json.trans_result[ idx ].dst });
                }
            }
        } else {
            mymodel.clear();
        }
    }

    Page {
        title: i18n.tr("Baidu translator")

        ListModel {
            id: mymodel
        }

        Column {
            spacing: units.gu(1)
            anchors {
                margins: units.gu(2)
                fill: parent
            }

            TextField {
                id: input
                placeholderText: "Please input a word"
                width: parent.width
                text: "你好"

                onTextChanged: {
                    mymodel.clear();
                    var json = API.startParse(input.text, root);
                }
            }

            Button {
                id: doit
                width: parent.width

                text: i18n.tr("Translate")

                onClicked: {
                    var json = API.startParse(input.text, root);
                }
            }

            ListView {
                id: listview
                width: parent.width
                height: parent.height - input.height - doit.height
                model: mymodel

                delegate: Text {
                    text: modelData
                }

            }
        }
    }
}


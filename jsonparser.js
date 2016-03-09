var URL = "http://openapi.baidu.com/public/2.0/bmt/translate?client_id=2hG67S2yRm5chkr62j2IEmYL&from=auto&to=auto&q=";

function startParse(keyword, callback) {
    var doc = new XMLHttpRequest();
    doc.onreadystatechange = function() {
        if (doc.readyState == XMLHttpRequest.HEADERS_RECEIVED) {
        } else if (doc.readyState === XMLHttpRequest.DONE) {
            if(doc.status != 200) {
                console.log("!!!Network connection failed!")
            }
            else {
                console.log("got some results!");
                if(doc.responseText == null) {
                }
                else {
                    console.log("result: ", doc.responseText)
                    var json = JSON.parse('' + doc.responseText+ '');
                    json["status"] = "OK";
                    callback.update(json);
                }
            }
        }
    }

    doc.open("GET", URL + keyword);
    doc.send();
}

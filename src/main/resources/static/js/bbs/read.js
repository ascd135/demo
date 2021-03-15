function xhr(method, url, callback, fallback, formData){
    let xhr= new XMLHttpRequest();
    xhr.open(method,url);
    xhr.onreadystatechange = function (){
        if(xhr.readyState === XMLHttpRequest.DONE) {
            if(xhr.status >= 200 && xhr.status < 300){
                callback(xhr.responseText);
            } else {
                fallback();
            }
        }
    };
    if (typeof formData === "undefined") {
        xhr.send();
    } else {
        xhr.send(formData);
    }
}

let upButton=window.document.body.querySelector("#js-up");
upButton.addEventListener("click", function () {
    function callback(response){
        getHit();
    }
    function fallback(){
    }
    let url = new URL(window.location.href);
    let id = url.searchParams.get("articleId");
    xhr("GET", `/hit?articleId=${id}`, callback, fallback);
});

function getHit(){
    let hit = window.document.body.querySelector("#js-hit");
    function callback(response){
        hit.innerText=response;
    }
    function fallback(){
        hit.innerText="e";
    }
    let url= new URL(window.location.href);
    let id= url.searchParams.get("articleId");
    xhr("GET", `/get-hit?articleId=${id}`, callback, fallback);
}

getHit();
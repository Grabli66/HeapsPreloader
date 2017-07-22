function loadGame () {    
    var loaderCanvas = document.getElementById('loader'); 
    var ctx = loaderCanvas.getContext ('2d');
    var isLoading = true;
    var width = loaderCanvas.width;
    var height = loaderCanvas.height;

    function drawAnimation () {        
        if (!isLoading) return;
        ctx.fillStyle = "#337AAA";
        ctx.fillRect(0,0,width,height);

        window.requestAnimationFrame(drawAnimation);
    }

    drawAnimation ();

    var req = new XMLHttpRequest();
    req.open("GET", "/pack.zip", true);
    req.responseType = "arraybuffer";

    req.onload = function (e) {
        var resp = req.response;
        document.packCache = {
            name : "pack.zip",
            data : resp
        }

        var script = document.createElement('script');
        script.src = "main.js";
        script.async = true;
        script.onload = function () { 
            isLoading = false;           
            //loaderCanvas.remove ();
           /* var game = document.getElementById("webgl");    
            game.style.display = "block";        */
        };        

        document.head.appendChild(script);
    };

    req.send ();
}

document.addEventListener("DOMContentLoaded", function () {
    loadGame ();
});
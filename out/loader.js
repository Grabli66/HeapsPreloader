function loadGame () {
    var loaderCanvas = document.getElementById('loader'); 
    loaderCanvas.width = loaderCanvas.parentElement.clientWidth;
    loaderCanvas.height = loaderCanvas.parentElement.clientHeight;
    var ctx = loaderCanvas.getContext ('2d');
    var isLoading = true;
    var width = loaderCanvas.width;
    var height = loaderCanvas.height;
    var centerx = width / 2;
    var centery = height / 2;

    var angle = 0.0;
    var pos = 0;
    var kpos = 1;

    function drawAnimation () {
        if (!isLoading) return;
        ctx.fillStyle = "#000000";
        ctx.fillRect(0,0,width,height);

        ctx.save();
        ctx.translate (centerx, centery);
        ctx.rotate (angle * 3.14 / 180);
        ctx.fillStyle = "#00BB99";
        ctx.fillRect(pos / 5, 30, 30, 30);        
        ctx.restore ();

        ctx.save();
        ctx.translate (centerx, centery);
        ctx.rotate ((angle - 20) * 3.14 / 180);
        ctx.fillStyle = "#00BB99";
        ctx.fillRect(pos, 80, 40, 40);        
        ctx.restore ();


        ctx.save();
        ctx.translate (centerx, centery);
        ctx.rotate ((angle + 60) * 3.14 / 180);
        ctx.fillStyle = "#00BBAA";
        ctx.fillRect(pos / 5, 30, 30, 30);        
        ctx.restore ();

        ctx.save();
        ctx.translate (centerx, centery);
        ctx.rotate ((angle + 40) * 3.14 / 180);
        ctx.fillStyle = "#00BBAA";
        ctx.fillRect(pos, 80, 40, 40);        
        ctx.restore ();


        ctx.save();
        ctx.translate (centerx, centery);
        ctx.rotate ((angle + 120) * 3.14 / 180);
        ctx.fillStyle = "#00BBBB";
        ctx.fillRect(pos / 5, 30, 30, 30);        
        ctx.restore ();

        ctx.save();
        ctx.translate (centerx, centery);
        ctx.rotate ((angle + 100) * 3.14 / 180);
        ctx.fillStyle = "#00BBBB";
        ctx.fillRect(pos, 80, 40, 40);        
        ctx.restore ();


        ctx.save();
        ctx.translate (centerx, centery);
        ctx.rotate ((angle + 180) * 3.14 / 180);
        ctx.fillStyle = "#00BBCC";
        ctx.fillRect(pos / 5, 30, 30, 30);        
        ctx.restore ();

        ctx.save();
        ctx.translate (centerx, centery);
        ctx.rotate ((angle + 160) * 3.14 / 180);
        ctx.fillStyle = "#00BBCC";
        ctx.fillRect(pos, 80, 40, 40);        
        ctx.restore ();


        ctx.save();
        ctx.translate (centerx, centery);
        ctx.rotate ((angle + 240) * 3.14 / 180);
        ctx.fillStyle = "#00BBEE";
        ctx.fillRect(pos / 5, 30, 30, 30);        
        ctx.restore ();

        ctx.save();
        ctx.translate (centerx, centery);
        ctx.rotate ((angle + 220) * 3.14 / 180);
        ctx.fillStyle = "#00BBEE";
        ctx.fillRect(pos, 80, 40, 40);        
        ctx.restore ();


        ctx.save();
        ctx.translate (centerx, centery);
        ctx.rotate ((angle + 300) * 3.14 / 180);
        ctx.fillStyle = "#0088FF";
        ctx.fillRect(pos / 5, 30, 30, 30);        
        ctx.restore ();

        ctx.save();
        ctx.translate (centerx, centery);
        ctx.rotate ((angle + 280) * 3.14 / 180);
        ctx.fillStyle = "#0088FF";
        ctx.fillRect(pos, 80, 40, 40);        
        ctx.restore ();
        
        pos += kpos;
        if (pos > 100) kpos = -1;
        if (pos < 0) kpos = 1;

        angle += 1;
        if (angle > 360) angle = 0;

        window.requestAnimationFrame(drawAnimation);
    }

    function loadAll () {
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
                window.setTimeout (function() {
                    isLoading = false;
                    loaderCanvas.remove ();
                    var game = document.getElementById("webgl");    
                    game.style.display = "block";
                }, 4000);                
            };        

            document.head.appendChild(script);
        };

        req.send ();
    }

    drawAnimation ();
    loadAll ();
}

document.addEventListener("DOMContentLoaded", function () {
    loadGame ();
});
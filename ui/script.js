
let grades = 2
let blipadded = 0
var blip = false

let search = 0
let handcuff = 0
let vehinfo = 0
let identity = 0
let obj = 0
let alerts = 0
let bill = 0
let shop = 0

$(function(){
    $("#all").draggable();
    setInterval(() => {
        if($('input[value="blipyes"]').is(":checked") && blip == false) {
            const element = document.getElementById("principal-container")
            const htmlString = `<input id="bliptext"  class="bliptext" type="text" placeholder="Nombre del blip"> <input id="blipsprite"  class="blipsprite" type="number" placeholder="Sprite del blip"> <input id="blipcolor"  class="blipcolor" type="number" placeholder="Color del job">`
            const insertAfter = (element, htmlString) => element.insertAdjacentHTML("afterend", htmlString)
            insertAfter(element, htmlString)
            blip = true
            blipadded = 1
        }
        else if (!$('input[value="blipyes"]').is(":checked") && blip == true ) {
            const text = document.getElementById("bliptext")
            text.remove();
            const sprite = document.getElementById("blipsprite")
            sprite.remove();
            const color = document.getElementById("blipcolor")
            color.remove();
            blip = false
        }
        if($('input[value="searchyes"]').is(":checked")) {
            search = 1
        }
        else if (!$('input[value="searchyes"]').is(":checked")) {
            search = 0
        }
        if($('input[value="handcuffyes"]').is(":checked")) {
            handcuff = 1
        }
        else if (!$('input[value="handcuffyes"]').is(":checked")) {
            handcuff = 0
        }
        if($('input[value="vehinfoyes"]').is(":checked")) {
            vehinfo = 1
        }
        else if (!$('input[value="vehinfoyes"]').is(":checked")) {
            vehinfo = 0
        }
        if($('input[value="identityyes"]').is(":checked")) {
            identity = 1
        }
        else if (!$('input[value="identityyes"]').is(":checked")) {
            identity = 0
        }
        if($('input[value="objyes"]').is(":checked")) {
            obj = 1
        }
        else if (!$('input[value="objyes"]').is(":checked")) {
            obj = 0
        }
        if($('input[value="alertsyes"]').is(":checked")) {
            alerts = 1
        }
        else if (!$('input[value="alertsyes"]').is(":checked")) {
            alerts = 0
        }
        if($('input[value="billyes"]').is(":checked")) {
            bill = 1
        }
        else if (!$('input[value="billyes"]').is(":checked")) {
            bill = 0
        }
        if($('input[value="shopyes"]').is(":checked")) {
            shop = 1
        }
        else if (!$('input[value="shopyes"]').is(":checked")) {
            shop = 0
        }
    }, 0);

    $(".button-moregrades").on('click', function() {
        const element = document.getElementById("principal-container")
        grades = grades + 1;
        if (grades == 3) {
            const htmlString = `<input id="grade3"  class="grade3" type="text" placeholder="Nombre del grado 3"> <input id="grade3mon"  class="grade3mon" type="text" placeholder="Sueldo del grado 3">`
            const insertAfter = (element, htmlString) => element.insertAdjacentHTML("afterend", htmlString)
            insertAfter(element, htmlString)
        }
        else if (grades == 4) {
            const htmlString = `<input id="grade4"  class="grade4" type="text" placeholder="Nombre del grado 4"> <input id="grade4mon"  class="grade4mon" type="text" placeholder="Sueldo del grado 4">`
            const insertAfter = (element, htmlString) => element.insertAdjacentHTML("afterend", htmlString)
            insertAfter(element, htmlString)
        }
        else if (grades == 5) {
            const htmlString = `<input id="grade5"  class="grade5" type="text" placeholder="Nombre del grado 5"> <input id="grade5mon"  class="grade5mon" type="text" placeholder="Sueldo del grado 5">`
            const insertAfter = (element, htmlString) => element.insertAdjacentHTML("afterend", htmlString)
            insertAfter(element, htmlString)
        }
        else if (grades == 6) {
            const htmlString = `<input id="grade6"  class="grade6" type="text" placeholder="Nombre del grado 6"> <input id="grade6mon"  class="grade6mon" type="text" placeholder="Sueldo del grado 6">`
            const insertAfter = (element, htmlString) => element.insertAdjacentHTML("afterend", htmlString)
            insertAfter(element, htmlString)
        }
    });

    $("#button-validate").on('click', function() {
        $.post(`https://${GetParentResourceName()}/create`, JSON.stringify({
            job : $("#jobname").val(),
            joblabel : $("#joblabel").val(),
            grade1 : $("#grade1").val(),
            grade1mon : $("#grade1mon").val(),
            grade2 : $("#grade2").val(),
            grade2mon : $("#grade2mon").val(),
            grade3 : $("#grade3").val(),
            grade3mon : $("#grade3mon").val(),
            grade4 : $("#grade4").val(),
            grade4mon : $("#grade4mon").val(),
            grade5 : $("#grade5").val(),
            grade5mon : $("#grade5mon").val(),
            grade6 : $("#grade6").val(),
            grade6mon : $("#grade6mon").val(),
            blipadded : blipadded,
            bliptext : $("#bliptext").val(),
            blipsprite : $("#blipsprite").val(),
            blipcolor : $("#blipcolor").val(),
            search : search,
            handcuff : handcuff,
            vehinfo : vehinfo,
            identity : identity,
            obj : obj,
            alerts : alerts,
            bill : bill,
            shop : shop
        }));
        blipadded = 0
        var selector = document.querySelector("html")
        selector.style = "display:none;"
    });

    window.addEventListener("message", function(event){
        if (event.data.startCreation) {
            var selector = document.querySelector("html")
            selector.style = "display:block;"

        }
    })
})




document.addEventListener('keypress', logKey);

function logKey(e) {
    if (e.keyCode == 290) {
        var selector = document.querySelector("html")
        selector.style = "display:none;"
        $.post(`https://${GetParentResourceName()}/exit`, JSON.stringify({}));
    }
}

document.addEventListener("DOMContentLoaded", () => {
    console.log("NUI page of [guille_jobcreator] loaded")
    var selector = document.querySelector("html")
    selector.style = "display:none;"
});


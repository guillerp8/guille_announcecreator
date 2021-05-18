

$(function(){
    window.addEventListener("message", function(event){
        const element = document.getElementById("all")
        if (event.data.content) {
            const htmlString = `
            <div class="container" style="background: rgb(${event.data.color});">
                <div class="drawline" style="background: rgb(${event.data.colorbar});">
                    <span class="title" style="color: rgb(${event.data.titlecolor});" id="title">${event.data.name}</span>
                </div>
                <span class="text-content" id="content">${event.data.content}</span>
                <img class="picture" src="${event.data.pic}"></img>
            </div>`
            const insertAfter = (element, htmlString) => element.insertAdjacentHTML("afterend", htmlString)
            insertAfter(element, htmlString)
        }
    
        if (event.data.democolorbar) {
            $( ".democontainer" ).remove();
            const htmlString = `
            <div class="democontainer" style="background: rgb(${event.data.democolor});">
                <div class="drawline" style="background: rgb(${event.data.democolorbar});">
                    <span class="title" style="color: rgb(${event.data.demotitlecolor});" id="title">${event.data.demoname}</span>
                </div>
                <span class="text-content" id="content">¡Esto es un test de creación de anuncio!</span>
                <img class="picture" src="${event.data.demopic}"></img>
            </div>`
            const insertAfter = (element, htmlString) => element.insertAdjacentHTML("afterend", htmlString)
            insertAfter(element, htmlString)
        }

        if (event.data.restartdemo) {
            $( ".democontainer" ).remove();
        }
    })
})
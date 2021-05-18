var queue = [];
let notifs = false

$(function(){
    window.addEventListener("message", function(event){
        
        if (notifs && !event.data.democolor && !event.data.demotitlecolor && !event.data.restartdemo && !event.data.demoname && !event.data.democolorbar && !event.data.demotitlecolor) {
            
            queue.push(event.data);
        }
        else if (!event.data.democolor && !event.data.demotitlecolor && !event.data.restartdemo && !event.data.demoname && !event.data.democolorbar && !event.data.demopic && !event.data.demotitlecolor && !notifs)
        {
            notif(event.data);
        }
    
        if (event.data.democolorbar) {
            const element = document.getElementById("all")
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
    setInterval(function() {
        if (!notifs) {
            for (var i = 0; i < queue.length; i++) {
                console.log(i)
                notif(queue[i]);
                queue.splice(i,1);                        
            };
        }
    }, 1); 
})

function notif(queued) {
    notifs = true
    const element = document.getElementById("all")
    const htmlString = `
    <div class="container" style="background: rgb(${queued.color});">
        <div class="drawline" style="background: rgb(${queued.colorbar});">
            <span class="title" style="color: rgb(${queued.titlecolor});" id="title">${queued.name}</span>
        </div>
        <span class="text-content" id="content">${queued.content}</span>
        <img class="picture" src="${queued.pic}"></img>
    </div>`
    const insertAfter = (element, htmlString) => element.insertAdjacentHTML("afterend", htmlString)
    insertAfter(element, htmlString)
    setTimeout(() => {
        notifs = false
    }, 18000);
}
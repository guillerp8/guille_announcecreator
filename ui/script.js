

$(function(){
    window.addEventListener("message", function(event){
        const element = document.getElementById("all")
        if (event.data.content) {
            const htmlString = `
            <div class="container" style="background: rgb(${event.data.color});">
                <div class="drawline">
                    <span class="title" id="title">${event.data.name}</span>
                </div>
                <span class="text-content" id="content">${event.data.content}</span>
                <img class="picture" src="${event.data.pic}"></img>
            </div>`
            const insertAfter = (element, htmlString) => element.insertAdjacentHTML("afterend", htmlString)
            insertAfter(element, htmlString)
        }
        if (event.data.demopic) {
            const htmlString = `<img class="picturedemo" src="${event.data.demopic}"></img>`
            const insertAfter = (element, htmlString) => element.insertAdjacentHTML("afterend", htmlString)
            insertAfter(element, htmlString)
        }
    })
})
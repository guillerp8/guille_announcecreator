

$(function(){
    window.addEventListener("message", function(event){
        const element = document.getElementById("all")
        
        const htmlString = `
        <div class="container">
            <div class="drawline">
                <span class="title" id="title">Police departament</span>
            </div>
            <span class="text-content" id="content">hola buenas sda dasasdsa as dsa saijasid jasi0jd aisjd oasjd ioasjid asjid asjiod jasiod jsaijd asoijd ioasjd ioasjd ioasjid oasjiod jasid ia d jasi0jd aisjd oasjd ioasjid asjid asjiod jasiod jsaijd asoijd ioasjd ioasjd ioasjid oasjiod jasid ia d jasi0jd aisjd oasjd ioasjid asjid asjiod jasiod jsaijd asoijd ioasjd ioasjd ioasjid oasjiod jasid ia</span>
            <img class="picture" src="srcs/losantos.png"></img>
        </div>`
        const insertAfter = (element, htmlString) => element.insertAdjacentHTML("afterend", htmlString)
        insertAfter(element, htmlString)
    })
})
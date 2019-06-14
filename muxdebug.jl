using WebIO, Mux, Interact

ui = button()
on(n -> println("Hello!"), ui)
display(ui)

WebIO.webio_serve(page("/", req -> ui), 9000)

@app testapp = (Mux.defaults, ui)
serve(testapp)

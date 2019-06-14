using CSV, DataFrames, Interact, Plots
loadbutton = filepicker()
columnbuttons = Observable{Any}(dom"div"())
data = Observable{Any}(DataFrame)
plt = Observable{Any}(plot())
map!(CSV.read, data, loadbutton)

function makebuttons(df)
    buttons = button.(string.(names(df)))
    for (btn, name) in zip(buttons, names(df))
        map!(t -> histogram(df[name]), plt, btn)
    end
    dom"div"(hbox(buttons))
end

map!(makebuttons, columnbuttons, data)

ui = dom"div"(loadbutton, columnbuttons, plt)

using Blink
w = Window()
body!(w, ui)

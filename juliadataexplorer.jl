#### Packages Loading
using CSV
using DataFrames
using WebIO, Mux, Interact
using TableView

#### Data Loading
filedirs = String[]
for (root, dirs, files) in walkdir(pwd()*"/datasets/")
    for file in files
        #println(joinpath(root,file))
        push!(filedirs,joinpath(root,file))
    end
end

datafile = filedirs[2]

#### Code

data = CSV.File(datafile,
                # File Layout Options
                header = 1:2, # Int for row to parse for col names, or range for a span of rows to be concat for col names
                normalizenames = true, # Normalize col names to Julia-sane symbols
                delim = ',' # Char or String which indicates a delimiter, if none provided, will detect the most consistent one after first 10 rows
                # Parsing Options
                # Column Type Options
                )

#testDF = data |> DataFrame
#showtable(data)

#### Frontend
loadfile = filepicker();
function loadfilepage(req)
    page = node(
                :div,
                node(:h1, "Upload Data"),
                node(:br),
                node(:p, loadfile)
    )
    return page
end
@app julex = (
            Mux.defaults,
            page(respond("<h1>Landing Page</h1>")),
            page("/upload",
                req -> loadfilepage(req)),
            page("/upload2",
                respond("<h1>Data Upload Page</h1>"),
                req->loadfile),
            page("/about",
                respond("<h1>About Page</h1>")),
            page("/table",
                respond(showtable(data))),
            Mux.notfound())
settheme!(:nativehtml)

serve(julex)

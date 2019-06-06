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
function loadfilepageold(req)
    page = node(
    :container,
    node(:h1, "Upload Data"),
    node(:br),
    node(:p, loadfile)
    )
    return page
end

navbar = vbox(
                hbox(
                    node(:a, pad(1em, "Home"),
                                attributes=Dict(:href=>"..")),
                    node(:a, pad(1em, "Upload"),
                                attributes=Dict(:href=>"../upload")),
                    node(:a, pad(1em, "Table View"),
                                attributes=Dict(:href=>"../table")),
                    node(:a, pad(1em, "Explore"),
                                attributes=Dict(:href=>"../explore"))
                    ),
                hline()
                )

landingpage = vbox(
                navbar,
                node(:h1, "Landing Page")
                )

                loadfilepage = vbox(
                navbar,
                loadfile
                )

tablepage = vbox(
                navbar,
                showtable(data))

@app julex = (
            Mux.defaults,
            page(landingpage),
            page("/upload",
                loadfilepage
                ),
            page("/table",
                tablepage
                ),
            page("/explore",
                respond("nothing here yet")),
            Mux.notfound())
settheme!(:nativehtml)

serve(julex)

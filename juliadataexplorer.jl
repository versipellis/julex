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
                ## File Layout Options
                header = 1:2, # Int for row to parse for col names, or range for a span of rows to be concat for col names
                normalizenames = true, # Normalize col names to Julia-sane symbols
                delim = ',', # Char or String which indicates a delimiter, if none provided, will detect the most consistent one after first 10 rows
                ## Parsing Options
                #missingstring = "\"\""
                ## Column Type Options
                )

#testDF = data |> DataFrame
#showtable(data)

data = CSV.read(datafile)

#### Frontend
loadfilebutton = filepicker(label="Choose a CSV file...",
                        accept=".csv");
#datafile = Observable{Any}(DataFrame)
#map!(CSV.read, datafile, loadfilebutton)

showtablegenerate = button("Generate showtable")
showtableresults = Observable{Any}(dom"div"())
map!(showtable, showtableresults, data)
on(n -> println("Hello!"), showtablegenerate)

describegenerate = button("Generate describe")
describeresults = Observable{Any}(dom"div"())

navbar = vbox(
                hbox(
                    node(:a, pad(1em, "Home"),
                                attributes=Dict(:href=>"..")),
                    node(:a, pad(1em, "Upload"),
                                attributes=Dict(:href=>"../upload")),
                    node(:a, pad(1em, "Table View"),
                                attributes=Dict(:href=>"../table")),
                    node(:a, pad(1em, "Explore"),
                                attributes=Dict(:href=>"../explore/describe"))
                    ),
                pad(1em, hline())
                )

landingpage = vbox(
                navbar,
                node(:h1, "Landing Page")
                )


loadfilepage = vbox(
                navbar,
                loadfilebutton,
                showtablegenerate, #debug
                showtableresults #debug
                )

tablepage = vbox(
                navbar,
                showtablegenerate,
                showtableresults
                )

explorepagevnav = hbox(
                    pad(("left","right"), 1em,
                        vbox(
                            pad(("top","bottom"),5px, node(:a, "Describe",
                                    attributes=Dict(:href=>"../explore/describe")
                                    )
                                    ),
                            pad(("top","bottom"),5px, node(:a, "moar",
                                    attributes=Dict(:href=>"../explore/describe")
                                    )
                                    ),
                            pad(("top","bottom"),5px, node(:a, "buttons",
                                    attributes=Dict(:href=>"../explore/describe")
                                    )
                                    ),
                            pad(("top","bottom"),5px, node(:a, "here",
                                    attributes=Dict(:href=>"../explore/describe")
                                    )
                                    ),
                        )
                    ),
                    vline()
                    )

explorepage = vbox(
                navbar,
                hbox(
                    pad("right", 1em, explorepagevnav),
                    describegenerate,
                    describeresults
                    )
                )

@app julex = (
            Mux.defaults,
            page(landingpage),
            page("/upload",
                loadfilepage
                ),
            page("/table",
                tablepage
                ),
            page("/explore/describe",
                explorepage,
                ),
            Mux.notfound())
#settheme!(:nativehtml)

serve(julex)

#### Packages Loading
using CSV
using WebIO, TableView
using DataFrames

#### Data Loading
filedirs = String[]
for (root, dirs, files) in walkdir(pwd()*"/testcode/datasets/")
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

testDF = data |> DataFrame
showtable(data)

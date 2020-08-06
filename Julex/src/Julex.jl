module Julex

using Genie, Genie.Router, Genie.Renderer, Genie.AppServer

function main()
  Base.eval(Main, :(const UserApp = Julex))

  include("../genie.jl")

  Base.eval(Main, :(const Genie = Julex.Genie))
  Base.eval(Main, :(using Genie))
end

main()

end

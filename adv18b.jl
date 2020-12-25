function parsemath(str)
    function swapops!(ast)
        typeof(ast) != Expr && return ast
        ast.args[1] = ast.args[1] == :+ ? :* : :+
        foreach(swapops!, ast.args[2:end])
        ast
    end
    ast = Meta.parse(replace(str, "*" => "M") |>
                     s -> replace(s, "+" => "*") |>
                     s -> replace(s, "M" => "+"))
    eval(swapops!(ast))
end

# sum(parsemath, eachline("adv18.txt"))

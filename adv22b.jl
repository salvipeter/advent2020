score(pack) = mapreduce(prod, +, enumerate(pack), init=0)

function game(pack1, pack2)
    seen = Set{Tuple{Int,Int}}() # should be Set{Tuple{Vector{Int},Vector{Int}}} but this also works
    pack1, pack2 = copy(pack1), copy(pack2)
    while true
        id = (score(pack1), score(pack2))
        (id in seen || isempty(pack2)) && return (1, id[1])
        isempty(pack1) && return (2, id[2])
        push!(seen, id)
        card1, card2 = pop!(pack1), pop!(pack2)
        if card1 <= length(pack1) && card2 <= length(pack2)
            (winner, _) = game(pack1[end-card1+1:end], pack2[end-card2+1:end])
        else
            winner = card1 > card2 ? 1 : 2
        end
        if winner == 1
            pushfirst!(pack1, card2, card1)
        else
            pushfirst!(pack2, card1, card2)
        end
    end
end

function adv22(filename)
    player1 = true
    pack1::Vector{Int}, pack2::Vector{Int} = [], []
    for line in eachline(filename)
        findfirst("Player", line) != nothing && continue
        if line == ""
            player1 = false
            continue
        end
        pushfirst!(player1 ? pack1 : pack2, parse(Int, line))
    end
    game(pack1, pack2)[2]
end

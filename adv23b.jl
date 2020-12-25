function init(cups, ncups)
    next = collect(2:ncups+1)
    next[ncups] = cups[1]
    for (i, cup) in enumerate(cups)
        next[cup] = i == length(cups) ? i + 1 : cups[i+1]
    end
    next
end

function adv23(cups, ncups, niter)
    current = cups[1]
    next = init(cups, ncups)
    taken = zeros(Int, 3)
    for _ in 1:niter
        taken[1] = next[current]
        taken[2] = next[taken[1]]
        taken[3] = next[taken[2]]
        dest = current
        while true
            dest = dest == 1 ? ncups : dest - 1
            !(dest in taken) && break
        end
        next[current] = next[taken[3]]
        next[taken[3]] = next[dest]
        next[dest] = taken[1]
        current = next[current]
    end
    star1 = next[1]
    star2 = next[star1]
    star1 * star2
end

# adv23([3, 6, 4, 2, 8, 9, 7, 1, 5], 1000000, 10000000)

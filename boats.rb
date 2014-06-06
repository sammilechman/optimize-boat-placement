def solution(r, x, m)
    #Handles impossible case
    if (m < r.count * 2 * x)
        return -1
    end

    #Best case scenario
    boats = r.dup

    #Move boats one step at a time until legality is achieved
    illegal_boats = false

    until illegal_boats
        illegal_boats = true
        boat_test = 0
        test_v = 0

        until test_v == boats.length - 2
            boats[test_v], boats[test_v + 1] = two_legal_boats(boats[test_v], boats[test_v + 1], x, m, 1)
            test_v += 1
        end

        until boat_test == boats.length - 2
            if !(test_legality(boats[boat_test], boats[boat_test+1], x))
                illegal_boats = false
            end
            boat_test += 1
        end
    end
    biggest_dist(r, boats)
end

def two_legal_boats(a,b,x,m,switch)
    switch *= -1

    if ((b-a).abs < 2*x)
        if (a-x) >= 0 && switch < 0
            return two_legal_boats(a-1, b, x, m, switch)
        elsif (b+x) <= m && switch > 0
            return two_legal_boats(a, b+1, x, m, switch)
        else
            return two_legal_boats(a, b, x, m, switch)
        end
    else
        if (a-x) < 0
          return two_legal_boats(a+1, b, x, m, switch)
        elsif (b+x) > m
          return two_legal_boats(a, b-1, x, m, switch)
        end
        return [a,b]
    end
end

def test_legality(a,b,x)
    if ((b-a).abs > (2*x))
        return false
    else
        return true
    end
end

def biggest_dist(r, boats)
    largest = 0
   r.each_index do |i|
       if boats[i]-r[i] > largest
           largest = boats[i]-r[i]
       end
   end
   return largest
end

puts solution([1,3,14],2,16)
